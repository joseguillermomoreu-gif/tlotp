#!/usr/bin/env bash
# TLOTP statusline-command.sh · v1.0.0 · Linux/macOS/Git-Bash
# Fuente versionada: prompts/palantir/templates/statusline-command.sh
# Claude Code status line — 2 líneas
# Línea 1: dir · branch · modelo · coste
# Línea 2: barra contexto · barra 5h (tiempo restante) · tiempo restante 7d

input=$(cat)

# ---------------------------------------------------------------------------
# Datos
# ---------------------------------------------------------------------------
model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // ""')
if [[ "$cwd" == "$HOME"* ]]; then
  cwd_short="~${cwd#$HOME}"
else
  cwd_short="$cwd"
fi

git_branch=""
if git -C "${cwd}" rev-parse --git-dir >/dev/null 2>&1; then
  git_branch=$(git -C "${cwd}" branch --show-current 2>/dev/null)
fi

# Coste: usar cost.total_cost_usd si existe, sino calcular desde tokens
cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
if [ -z "$cost_usd" ]; then
  total_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
  total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
  cache_w=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
  cache_r=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
  cost_usd=$(echo "$total_in $total_out $cache_w $cache_r" | awk '{
    printf "%.4f", ($1*3.00 + $2*15.00 + $3*3.75 + $4*0.30) / 1000000
  }')
fi
cost_fmt=$(printf '$%.4f' "$cost_usd")

ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
five_h=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_h_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_d=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_d_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

# Formatear tiempo restante a partir de un timestamp Unix
format_remaining() {
  local reset_ts=$1 now remaining
  now=$(date +%s)
  remaining=$(( reset_ts - now ))
  if [ "$remaining" -le 0 ]; then
    printf 'reset'
    return
  fi
  local d=$(( remaining / 86400 ))
  local h=$(( (remaining % 86400) / 3600 ))
  local m=$(( (remaining % 3600) / 60 ))
  if [ "$d" -gt 0 ]; then
    printf '%dd%dh' "$d" "$h"
  elif [ "$h" -gt 0 ]; then
    printf '%dh%dm' "$h" "$m"
  else
    printf '%dm' "$m"
  fi
}

# ---------------------------------------------------------------------------
# Colores
# ---------------------------------------------------------------------------
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
CYAN='\033[36m'
BLUE='\033[34m'
DIM='\033[2m'
RESET='\033[0m'

# ---------------------------------------------------------------------------
# Funciones auxiliares
# ---------------------------------------------------------------------------
make_bar() {
  local pct=$1 width=${2:-10} filled empty bar f e
  filled=$(( pct * width / 100 ))
  empty=$(( width - filled ))
  bar=""
  [ "$filled" -gt 0 ] && printf -v f "%${filled}s" && bar="${f// /█}"
  [ "$empty" -gt 0 ] && printf -v e "%${empty}s" && bar="${bar}${e// /░}"
  printf '%s' "$bar"
}

bar_color() {
  local pct=$1
  if   [ "$pct" -ge 80 ]; then printf '%s' "$RED"
  elif [ "$pct" -ge 50 ]; then printf '%s' "$YELLOW"
  else                         printf '%s' "$GREEN"
  fi
}

SEP="${DIM} · ${RESET}"

# ---------------------------------------------------------------------------
# Línea 1: dir  ·  branch  ·  modelo  ·  coste
# ---------------------------------------------------------------------------
dir_s="${GREEN}${cwd_short}${RESET}"
model_s="${CYAN}${model}${RESET}"
cost_s="${BLUE}${cost_fmt}${RESET}"

if [ -n "$git_branch" ]; then
  branch_s="${YELLOW}$(printf '\ue0a0') ${git_branch}${RESET}"
  line1="${dir_s}${SEP}${branch_s}${SEP}${model_s}${SEP}${cost_s}"
else
  line1="${dir_s}${SEP}${model_s}${SEP}${cost_s}"
fi

# ---------------------------------------------------------------------------
# Línea 2: barra ctx  ·  barra 5h (tiempo restante)  ·  tiempo restante 7d
# ---------------------------------------------------------------------------
ctx_bar=$(make_bar "$ctx_pct")
ctx_color=$(bar_color "$ctx_pct")
line2="${ctx_color}${ctx_bar}${RESET} ${ctx_pct}% ctx"

if [ -n "$five_h" ]; then
  five_h_int=$(printf '%.0f' "$five_h")
  fh_bar=$(make_bar "$five_h_int")
  fh_color=$(bar_color "$five_h_int")
  if [ -n "$five_h_reset" ]; then
    fh_label=$(format_remaining "$five_h_reset")
  else
    fh_label="${five_h_int}%"
  fi
  line2="${line2}${SEP}${fh_color}${fh_bar}${RESET} ${five_h_int}% ${fh_label}"
fi

if [ -n "$seven_d" ]; then
  seven_d_int=$(printf '%.0f' "$seven_d")
  sd_bar=$(make_bar "$seven_d_int")
  sd_color=$(bar_color "$seven_d_int")
  if [ -n "$seven_d_reset" ]; then
    sd_label=$(format_remaining "$seven_d_reset")
  else
    sd_label="${seven_d_int}%"
  fi
  line2="${line2}${SEP}${sd_color}${sd_bar}${RESET} ${seven_d_int}% ${sd_label}"
fi

# ---------------------------------------------------------------------------
# Salida
# ---------------------------------------------------------------------------
printf '%b\n' "${line1}"
printf '%b\n' "${line2}"
