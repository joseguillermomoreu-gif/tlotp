#!/bin/bash
# ═══════════════════════════════════════════════════════════════
#   import-lint.sh — Detector de ciclos en @imports
#   Construye el grafo de @imports y detecta back edges (ciclos)
#   usando DFS iterativo.
# ═══════════════════════════════════════════════════════════════
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROMPTS_DIR="$PROJECT_ROOT/prompts"

errors=0

echo "=== TLOTP Import Lint ==="
echo ""

# Temporary files for DFS state
VISITING=$(mktemp)
VISITED=$(mktemp)
CYCLE_LOG=$(mktemp)
trap 'rm -f "$VISITING" "$VISITED" "$CYCLE_LOG"' EXIT

# Extract compilable @imports from a file (outside fenced code blocks)
get_imports() {
  local file="$1"
  local in_fenced=false

  while IFS= read -r line || [ -n "$line" ]; do
    if echo "$line" | grep -qP '^```'; then
      if [ "$in_fenced" = true ]; then
        in_fenced=false
      else
        in_fenced=true
      fi
      continue
    fi

    if [ "$in_fenced" = false ]; then
      if echo "$line" | grep -qP '^@prompts/.+$'; then
        local import_path
        import_path="$(echo "$line" | sed 's/^@//')"
        echo "$import_path"
      fi
    fi
  done < "$file"
}

# DFS cycle detection
# Args: $1=file path (relative to PROJECT_ROOT), $2=chain string for reporting
check_cycles() {
  local rel_path="$1"
  local chain="$2"
  local full_path="$PROJECT_ROOT/$rel_path"

  # Already fully visited — no cycle through this node
  if grep -qFx "$rel_path" "$VISITED" 2>/dev/null; then
    return
  fi

  # Currently visiting — cycle detected
  if grep -qFx "$rel_path" "$VISITING" 2>/dev/null; then
    echo "CYCLE DETECTED: $chain -> $rel_path" >> "$CYCLE_LOG"
    errors=$((errors + 1))
    return
  fi

  # File does not exist — skip (broken link, handled by CI link checker)
  if [ ! -f "$full_path" ]; then
    return
  fi

  # Mark as visiting
  echo "$rel_path" >> "$VISITING"

  # Process imports
  while IFS= read -r import; do
    [ -z "$import" ] && continue
    check_cycles "$import" "$chain -> $import"
  done < <(get_imports "$full_path")

  # Mark as visited, remove from visiting
  echo "$rel_path" >> "$VISITED"
  local tmp
  tmp=$(mktemp)
  grep -vFx "$rel_path" "$VISITING" > "$tmp" 2>/dev/null || true
  mv "$tmp" "$VISITING"
}

# Run DFS from every .md file in prompts/
echo "  Scanning import graph..."
file_count=0
while IFS= read -r md_file; do
  rel_path="${md_file#$PROJECT_ROOT/}"
  check_cycles "$rel_path" "$rel_path"
  file_count=$((file_count + 1))
done < <(find "$PROMPTS_DIR" -name "*.md" -type f | sort)

echo "  Scanned $file_count files"
echo ""

if [ -s "$CYCLE_LOG" ]; then
  echo "FAILED: Circular @import chains detected:"
  echo ""
  cat "$CYCLE_LOG"
  echo ""
  exit 1
else
  echo "OK: No circular @imports detected"
fi
