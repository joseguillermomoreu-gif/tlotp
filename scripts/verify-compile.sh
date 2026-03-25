#!/bin/bash
# ═══════════════════════════════════════════════════════════════
#   verify-compile.sh — Verificar compilacion TLOTP
#   Comprueba que dist/ contiene las 6 epicas y no hay imports
#   sin resolver.
# ═══════════════════════════════════════════════════════════════
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DIST_DIR="$(cd "$SCRIPT_DIR/.." && pwd)/dist"
FULL_MD="$DIST_DIR/tlotp-full.md"
errors=0

echo "=== TLOTP Compile Verification ==="
echo ""

# 1. Verify tlotp-full.md exists and has content
if [ ! -s "$FULL_MD" ]; then
  echo "ERROR: tlotp-full.md is empty or does not exist"
  errors=$((errors + 1))
else
  echo "  [OK] tlotp-full.md exists ($(wc -l < "$FULL_MD") lines)"
fi

# 2. Verify 6 epics are present
for epic in palantir ents celebrimbor bardo aragorn gandalf; do
  if grep -qi "$epic" "$FULL_MD" 2>/dev/null; then
    echo "  [OK] Epic '$epic' found in tlotp-full.md"
  else
    echo "  ERROR: Epic '$epic' NOT found in tlotp-full.md"
    errors=$((errors + 1))
  fi
done

# 3. Verify no unresolved @imports (outside fenced code blocks)
unresolved=0
in_fenced=false
while IFS= read -r line; do
  if echo "$line" | grep -qP '^```'; then
    if [ "$in_fenced" = true ]; then
      in_fenced=false
    else
      in_fenced=true
    fi
    continue
  fi
  if [ "$in_fenced" = false ] && echo "$line" | grep -qP '^@prompts/'; then
    echo "  ERROR: unresolved @import: $line"
    unresolved=$((unresolved + 1))
  fi
done < "$FULL_MD"

if [ "$unresolved" -gt 0 ]; then
  echo "  ERROR: $unresolved unresolved @import(s) in tlotp-full.md"
  errors=$((errors + 1))
else
  echo "  [OK] No unresolved @imports"
fi

# 4. Verify index.html exists
if [ ! -s "$DIST_DIR/index.html" ]; then
  echo "  ERROR: index.html is empty or does not exist"
  errors=$((errors + 1))
else
  echo "  [OK] index.html exists"
fi

# 5. Verify no backtick-literal @prompts/ references in HTML output
backtick_errors=0
while IFS= read -r html_file; do
  while IFS= read -r match; do
    line_num="$(echo "$match" | cut -d: -f1)"
    echo "  ERROR: backtick literal @prompts/ in $(basename "$html_file"):${line_num}"
    backtick_errors=$((backtick_errors + 1))
  done < <(grep -n '`@prompts/' "$html_file" 2>/dev/null || true)
done < <(find "$DIST_DIR" -name "*.html" -type f)

if [ "$backtick_errors" -gt 0 ]; then
  echo "  ERROR: $backtick_errors backtick-literal @prompts/ reference(s) found in HTML"
  errors=$((errors + backtick_errors))
else
  echo "  [OK] No backtick-literal @prompts/ references in HTML"
fi

# 6. Verify at least one HTML module per epic
for epic in palantir ents celebrimbor bardo aragorn gandalf; do
  if [ -f "$DIST_DIR/$epic/$epic-main.html" ]; then
    echo "  [OK] $epic/$epic-main.html exists"
  else
    echo "  ERROR: $epic/$epic-main.html not found"
    errors=$((errors + 1))
  fi
done

echo ""
if [ "$errors" -gt 0 ]; then
  echo "FAILED: $errors error(s) detected"
  exit 1
else
  echo "OK: Compilation verified successfully"
fi
