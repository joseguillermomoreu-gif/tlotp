#!/bin/bash
# ═══════════════════════════════════════════════════════════════
#   verify-compile.sh — Verificar compilacion TLOTP
#   Comprueba que dist/ contiene las 7 epicas, .md limpios por
#   epica, index.html por epica y no hay imports sin resolver.
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
for epic in palantir ents celebrimbor bardo aragorn gandalf tom-bombadil; do
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
for epic in palantir ents celebrimbor bardo aragorn gandalf tom-bombadil; do
  if [ -f "$DIST_DIR/$epic/$epic-main.html" ]; then
    echo "  [OK] $epic/$epic-main.html exists"
  else
    echo "  ERROR: $epic/$epic-main.html not found"
    errors=$((errors + 1))
  fi
done

# 7. Verify epic .md files exist and are clean (no @prompts/ refs, no HTML wrapper)
for epic in palantir ents celebrimbor bardo aragorn gandalf tom-bombadil; do
  epic_md="$DIST_DIR/$epic/$epic-main.md"
  if [ -f "$epic_md" ]; then
    echo "  [OK] $epic/$epic-main.md exists"

    # Check no @prompts/ references remain (outside fenced code blocks)
    md_unresolved=0
    md_in_fenced=false
    while IFS= read -r line; do
      if echo "$line" | grep -qP '^```'; then
        if [ "$md_in_fenced" = true ]; then
          md_in_fenced=false
        else
          md_in_fenced=true
        fi
        continue
      fi
      if [ "$md_in_fenced" = false ] && echo "$line" | grep -qP '@prompts/'; then
        echo "  ERROR: @prompts/ ref in $epic/$epic-main.md: $line"
        md_unresolved=$((md_unresolved + 1))
      fi
    done < "$epic_md"

    if [ "$md_unresolved" -gt 0 ]; then
      errors=$((errors + md_unresolved))
    else
      echo "  [OK] $epic/$epic-main.md has no @prompts/ refs"
    fi

    # Check no HTML wrapper
    if grep -qi '<!DOCTYPE\|<html\|<head\|<body' "$epic_md" 2>/dev/null; then
      echo "  ERROR: $epic/$epic-main.md contains HTML wrapper"
      errors=$((errors + 1))
    else
      echo "  [OK] $epic/$epic-main.md has no HTML wrapper"
    fi
  else
    echo "  ERROR: $epic/$epic-main.md not found"
    errors=$((errors + 1))
  fi
done

# 8. Verify epic index.html files exist
for epic in palantir ents celebrimbor bardo aragorn gandalf tom-bombadil; do
  if [ -f "$DIST_DIR/$epic/index.html" ]; then
    echo "  [OK] $epic/index.html exists"
  else
    echo "  ERROR: $epic/index.html not found"
    errors=$((errors + 1))
  fi
done

# 9. Verify internal hrefs in compiled HTML resolve to existing files in dist/
#    (see SDD .claude/sdd/423-ci-verify-internal-links/ · issue #423)
#
#    For each href="..." in any dist/**/*.html:
#      - Ignore fragments (#...), mailto:, javascript:, data:
#      - Ignore external URLs (http(s):// to another domain)
#      - URLs to own site (https://josemoreupeso.es/tlotp/PATH) → check dist/PATH
#      - Relative paths → resolve against the HTML's own directory
#      - Strip query (?...) and fragment (#...) before checking
#      - Trailing '/' or directory → require <path>/index.html
check_internal_hrefs() {
  local total=0
  local files=0
  local href_errors=0
  local html
  local href
  local target
  local html_dir
  local rel_from_dist

  while IFS= read -r html; do
    files=$((files + 1))
    html_dir="$(dirname "$html")"
    while IFS= read -r href; do
      total=$((total + 1))

      # Skip non-navigational schemes and fragments
      case "$href" in
        \#*|mailto:*|javascript:*|data:*|tel:*)
          continue
          ;;
      esac

      # Strip fragment and query
      href="${href%%#*}"
      href="${href%%\?*}"
      [ -z "$href" ] && continue

      # Classify
      case "$href" in
        https://josemoreupeso.es/tlotp/*)
          target="$DIST_DIR/${href#https://josemoreupeso.es/tlotp/}"
          ;;
        http://*|https://*|//*)
          # External → ignore
          continue
          ;;
        /*)
          # Absolute path on host (unexpected in TLOTP; treat as dist-root)
          target="$DIST_DIR${href}"
          ;;
        *)
          # Relative → resolve against html_dir
          target="$html_dir/$href"
          ;;
      esac

      # Directory or trailing slash → require index.html
      if [ -d "$target" ] || [ "${target: -1}" = "/" ]; then
        target="${target%/}/index.html"
      fi

      if [ ! -f "$target" ]; then
        rel_from_dist="${html#$DIST_DIR/}"
        echo "  ERROR: broken href in ${rel_from_dist} -> ${href}"
        href_errors=$((href_errors + 1))
      fi
    done < <(grep -oE 'href="[^"]+"' "$html" 2>/dev/null | sed -E 's/^href="([^"]+)"$/\1/' || true)
  done < <(find "$DIST_DIR" -name '*.html' -type f)

  echo "  Checked $total href(s) across $files html file(s)"
  if [ "$href_errors" -gt 0 ]; then
    echo "::error::$href_errors broken internal href(s) found in dist/"
    errors=$((errors + href_errors))
  else
    echo "  [OK] All internal hrefs resolve in dist/"
  fi
}

check_internal_hrefs

# 10-13. Verify AI .md pipeline (issue #461)
#  10) Parity 1:1 prompts/**/*.md ↔ dist/**/*.md
#  11) Sentinel present in every dist/**/*.md
#  12) No unresolved @prompts/ refs (outside fenced) in any dist/**/*.md
#  13) No HTML structural wrapper in any dist/**/*.md
check_ai_md_pipeline() {
  local prompts_dir
  prompts_dir="$(cd "$SCRIPT_DIR/.." && pwd)/prompts"
  local md_count=0
  local missing=0
  local sentinel_missing=0
  local unresolved_total=0
  local wrapper_count=0
  local md_file rel_path expected sentinel_re

  sentinel_re='TLOTP - The Lord of the Prompt'

  while IFS= read -r md_file; do
    md_count=$((md_count + 1))
    rel_path="${md_file#$prompts_dir/}"
    expected="$DIST_DIR/$rel_path"

    # Check 10: existence
    if [ ! -f "$expected" ]; then
      echo "  ERROR: missing AI .md output: dist/$rel_path"
      missing=$((missing + 1))
      continue
    fi

    # Check 11: sentinel present in first 12 lines (HTML-comment header)
    if ! head -n 12 "$expected" | grep -q "$sentinel_re"; then
      echo "  ERROR: sentinel missing in dist/$rel_path"
      sentinel_missing=$((sentinel_missing + 1))
    fi

    # Check 12: no @prompts/ refs outside fenced blocks
    local md_unresolved=0
    local md_in_fenced=false
    while IFS= read -r line; do
      if echo "$line" | grep -qP '^```'; then
        if [ "$md_in_fenced" = true ]; then
          md_in_fenced=false
        else
          md_in_fenced=true
        fi
        continue
      fi
      if [ "$md_in_fenced" = false ] && echo "$line" | grep -qP '@prompts/'; then
        echo "  ERROR: @prompts/ ref in dist/$rel_path: $line"
        md_unresolved=$((md_unresolved + 1))
      fi
    done < "$expected"
    unresolved_total=$((unresolved_total + md_unresolved))

    # Check 13: no HTML structural wrapper
    if grep -qiE '<!DOCTYPE|<html[ >]|<head[ >]|<body[ >]|<style[ >]|<script[ >]' "$expected" 2>/dev/null; then
      echo "  ERROR: HTML wrapper in dist/$rel_path"
      wrapper_count=$((wrapper_count + 1))
    fi
  done < <(find "$prompts_dir" -name "*.md" -type f | sort)

  echo "  Checked $md_count source .md file(s) for AI pipeline parity"

  if [ "$missing" -gt 0 ]; then
    echo "::error::$missing AI .md output(s) missing"
    errors=$((errors + missing))
  else
    echo "  [OK] AI .md parity 1:1 with prompts/"
  fi

  if [ "$sentinel_missing" -gt 0 ]; then
    echo "::error::$sentinel_missing AI .md file(s) without sentinel"
    errors=$((errors + sentinel_missing))
  else
    echo "  [OK] All AI .md files have sentinel"
  fi

  if [ "$unresolved_total" -gt 0 ]; then
    errors=$((errors + unresolved_total))
  else
    echo "  [OK] No unresolved @prompts/ refs in AI .md files"
  fi

  if [ "$wrapper_count" -gt 0 ]; then
    echo "::error::$wrapper_count AI .md file(s) contain HTML wrapper"
    errors=$((errors + wrapper_count))
  else
    echo "  [OK] No HTML wrappers in AI .md files"
  fi
}

check_ai_md_pipeline

echo ""
if [ "$errors" -gt 0 ]; then
  echo "FAILED: $errors error(s) detected"
  exit 1
else
  echo "OK: Compilation verified successfully"
fi
