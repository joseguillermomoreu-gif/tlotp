#!/bin/bash
# ═══════════════════════════════════════════════════════════════
#   smoke-test-local.sh — Smoke test de URLs públicas de TLOTP
#
#   Lee scripts/smoke-urls.txt y comprueba que cada URL devuelve
#   HTTP 200. Uso local para validar el sitio desplegado antes
#   de un merge a master (opcional) o para diagnosticar fallos
#   post-deploy sin esperar al CI.
#
#   Exit code:
#     0 → todas las URLs responden 200
#     1 → alguna URL falló (status != 200 tras reintentos)
# ═══════════════════════════════════════════════════════════════
set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
URLS_FILE="$SCRIPT_DIR/smoke-urls.txt"

if [ ! -f "$URLS_FILE" ]; then
  echo "ERROR: $URLS_FILE not found"
  exit 2
fi

MAX_RETRIES=3
RETRY_WAIT=5
TIMEOUT=20

errors=0
total=0

echo "=== TLOTP Smoke Test (local) ==="
echo ""

while IFS= read -r url; do
  # Skip comments and blank lines
  case "$url" in
    ''|\#*) continue ;;
  esac

  total=$((total + 1))
  code=""
  attempt=0
  while [ "$attempt" -lt "$MAX_RETRIES" ]; do
    attempt=$((attempt + 1))
    code=$(curl -s -L -o /dev/null -w '%{http_code}' \
      --max-time "$TIMEOUT" "$url" 2>/dev/null || echo "000")
    if [ "$code" = "200" ]; then
      break
    fi
    if [ "$attempt" -lt "$MAX_RETRIES" ]; then
      sleep "$RETRY_WAIT"
    fi
  done

  if [ "$code" = "200" ]; then
    echo "  [OK]    $code  $url"
  else
    echo "  ERROR   $code  $url  (after $attempt attempts)"
    errors=$((errors + 1))
  fi
done < "$URLS_FILE"

echo ""
if [ "$errors" -gt 0 ]; then
  echo "FAILED: $errors/$total URL(s) did not return 200"
  exit 1
else
  echo "OK: $total URL(s) verified"
fi
