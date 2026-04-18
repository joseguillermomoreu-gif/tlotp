# 🥔 Status Line — Preset de Pépeton, Señor de las Tierras Paletas (Caso C)

> **IMPORTADO POR**: `palantir-main.md`
>
> Módulo de instalación asistida de un Status Line preconfigurado: 2 líneas,
> barras de contexto, ventana de 5h y uso semanal 7d. Forjado por Pépeton
> hijo de Móreuton.

---

# ═══════════════════════════════════════════════════
# CASO C · Preset de Pépeton
# ═══════════════════════════════════════════════════

> **Cuándo ejecutar**: cuando el usuario elige la opción
> `🥔 Usar el status line de Pépeton, hijo de Móreuton` desde el menú de
> creación (`07a`) o de gestión (`07b`).

---

## PASO P1 — Lore y descripción del preset

Mostrar sin interacción:

```
══════════════════════════════════════════════════════════════════
🥔 El Status Line de Pépeton, Señor de las Tierras Paletas

  Forjado en las profundidades del código por Pépeton hijo de Móreuton,
  este status line de 2 líneas lo tiene todo:

  Línea 1 (identidad):
    ~/dir  ·   branch  ·  Modelo  ·  $coste

  Línea 2 (límites):
    ████░░░░░░ 38% ctx  ·  ██░░░░░░░░ 22% 5h  ·  9% 7d

  · Colores adaptativos: verde (<50%) · amarillo (50-79%) · rojo (≥80%)
  · Requiere: jq, git, bash
  · Barras de 5h y 7d solo visibles en cuentas Pro/Max (se ocultan si no aplica)
══════════════════════════════════════════════════════════════════
```

---

## PASO P2 — Verificar dependencias

Ejecutar silenciosamente:

```bash
jq --version 2>/dev/null
git --version 2>/dev/null
```

**Capturar** si cada comando existe:
- `JQ_OK`  = true/false
- `GIT_OK` = true/false

### Si `JQ_OK == false`

Mostrar advertencia y preguntar:

```
⚠️  Atención — jq no detectado

  El status line de Pépeton usa `jq` para parsear el JSON que Claude Code
  le pasa por stdin en cada actualización. Sin `jq`, el statusline
  no funcionará aunque lo instalemos ahora.

  💡 Instalación sugerida:
     · 🐧 Linux/WSL:  sudo apt install jq
     · 🍎 macOS:      brew install jq
     · 🪟 Windows:    choco install jq  (o scoop install jq)
```

**AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Dependencia · jq",
    "question": "¿Cómo quieres proceder?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Continuar igualmente",
        "description": "Instalaré jq más tarde; procede con el preset"
      },
      {
        "label": "🚫 Cancelar",
        "description": "Vuelve al menú de Palantír, instalaré jq primero"
      }
    ]
  }]
}
```

Si elige cancelar → volver al menú principal de Palantír.

### Si `GIT_OK == false`

Avisar (no bloqueante): el statusline ocultará la rama git si no hay git
disponible. No preguntar; sólo mostrar:

```
ℹ️  git no detectado — la línea 1 no incluirá rama (el resto funciona).
```

---

## PASO P3 — Detectar scope

**Leer silenciosamente** ambos `settings.json`:

- `~/.claude/settings.json` → `GLOBAL_HAS_STATUSLINE`
- `.claude/settings.json` del proyecto actual → `PROJECT_HAS_STATUSLINE`

### Matriz de decisión

| Global | Proyecto | Opciones a ofrecer |
|--------|----------|---------------------|
| ❌     | ❌       | Instalar en **Global** / Instalar en **Proyecto** / Cancelar |
| ✅     | ❌       | Reemplazar Global / Instalar Proyecto (prevalece) / Cancelar |
| ❌     | ✅       | Instalar Global / Reemplazar Proyecto / Cancelar |
| ✅     | ✅       | Reemplazar Global / Reemplazar Proyecto / Cancelar |

**AskUserQuestion** con las opciones que apliquen (máximo 4 incluyendo cancelar).

Si el usuario elige reemplazar algo existente, mostrar el valor actual antes
de la confirmación final:

```
📊 Configuración actual ([scope])
══════════════════════════════════════════════════════
"statusLine": [valor exacto]
══════════════════════════════════════════════════════

Esta configuración será reemplazada por el preset de Pépeton.
```

**AskUserQuestion** de confirmación:

```json
{
  "questions": [{
    "header": "Confirmar reemplazo",
    "question": "¿Procedemos con el reemplazo?",
    "multiSelect": false,
    "options": [
      { "label": "✅ Sí, instalar preset de Pépeton", "description": "Escribir script + actualizar settings.json" },
      { "label": "🚫 Cancelar", "description": "No tocar nada" }
    ]
  }]
}
```

**Guardar en contexto**: `INSTALL_SCOPE` = `"global"` o `"project"`.

---

## PASO P4 — Escribir el script `statusline-command.sh`

**Ruta destino** según scope:

- `INSTALL_SCOPE == "global"`  → `$HOME/.claude/statusline-command.sh`
- `INSTALL_SCOPE == "project"` → `.claude/statusline-command.sh`

**Antes de escribir**: si la carpeta `.claude/` no existe en el scope elegido,
crearla con Bash (`mkdir -p`).

**Escribir con Write tool** exactamente este contenido:

```bash
#!/usr/bin/env bash
# Claude Code status line — 2 líneas
# Línea 1: dir · branch · modelo · coste
# Línea 2: barra contexto · barra 5h · porcentaje 7d

input=$(cat)

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
seven_d=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

GREEN='\033[32m'; YELLOW='\033[33m'; RED='\033[31m'
CYAN='\033[36m'; BLUE='\033[34m'; DIM='\033[2m'; RESET='\033[0m'

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

dir_s="${GREEN}${cwd_short}${RESET}"
model_s="${CYAN}${model}${RESET}"
cost_s="${BLUE}${cost_fmt}${RESET}"

if [ -n "$git_branch" ]; then
  branch_s="${YELLOW}$(printf '\ue0a0') ${git_branch}${RESET}"
  line1="${dir_s}${SEP}${branch_s}${SEP}${model_s}${SEP}${cost_s}"
else
  line1="${dir_s}${SEP}${model_s}${SEP}${cost_s}"
fi

ctx_bar=$(make_bar "$ctx_pct")
ctx_color=$(bar_color "$ctx_pct")
line2="${ctx_color}${ctx_bar}${RESET} ${ctx_pct}% ctx"

if [ -n "$five_h" ]; then
  five_h_int=$(printf '%.0f' "$five_h")
  fh_bar=$(make_bar "$five_h_int")
  fh_color=$(bar_color "$five_h_int")
  line2="${line2}${SEP}${fh_color}${fh_bar}${RESET} ${five_h_int}% 5h"
fi

if [ -n "$seven_d" ]; then
  seven_d_int=$(printf '%.0f' "$seven_d")
  sd_color=$(bar_color "$seven_d_int")
  line2="${line2}${SEP}${sd_color}${seven_d_int}%${RESET} 7d"
fi

printf '%b\n' "${line1}"
printf '%b\n' "${line2}"
```

**Hacer ejecutable**:

```bash
chmod +x <ruta elegida>/statusline-command.sh
```

---

## PASO P5 — Actualizar `settings.json`

### Definir el valor a escribir

El campo `statusLine` que se añadirá/reemplazará en el JSON es:

**Scope global** (`~/.claude/settings.json`):

```json
"statusLine": {
  "type": "command",
  "command": "bash ~/.claude/statusline-command.sh"
}
```

**Scope proyecto** (`.claude/settings.json`):

```json
"statusLine": {
  "type": "command",
  "command": "bash .claude/statusline-command.sh"
}
```

### Proceso de escritura (seguro, preserva el resto del JSON)

1. **Read tool** sobre el `settings.json` elegido.
2. Si el fichero no existe → base = `{}`.
3. Si existe → parsear el JSON tal cual (no perder campos ni comentarios-no-JSON).
4. **Actualizar** (o crear) la clave `statusLine` con el objeto anterior.
5. **Serializar** preservando indentación (2 espacios, igual que el existente).
6. **Write tool** con el contenido completo resultante.

> ⚠️ **Prohibido**: usar `sed`/`awk` sobre el JSON o reemplazos de texto.
> Sólo Read → parse → Write.

> ⚠️ **Preservar** todos los demás campos del fichero (hooks, permissions,
> preferences, etc.). Si el JSON es inválido o tiene comentarios no
> estándar, parar y mostrar el fichero al usuario sin modificar.

---

## PASO P6 — Confirmación final con lore

Mostrar sin interacción (sustituir `<ruta>` y `<config>` según scope):

```
══════════════════════════════════════════════════════════════════
🥔 ¡El Status Line de Pépeton ha sido instalado!

  📜 Script:  <ruta del statusline-command.sh>
  ⚙️  Config:  <ruta del settings.json> → statusLine

  Haz cualquier interacción con Claude Code para verlo en acción.
  Si no ves las barras de 5h/7d, es normal hasta la primera
  respuesta de la sesión (son datos Pro/Max).

  "Que el código fluya limpio y los prompts encuentren
   siempre su camino de vuelta."
        — Pépeton hijo de Móreuton
══════════════════════════════════════════════════════════════════
```

Volver al **menú principal de Palantír** (`00-menu-principal.md`, PASO 2).

---

## ⚠️ Reglas globales del módulo

1. **Nunca escribir** sin confirmación explícita del usuario (PASO P3).
2. **Preservar** todos los campos del `settings.json` al actualizar.
3. **Usar solo** Read + Write tools sobre JSON, nunca `sed`/`awk`/text-replace.
4. **No contaminar** `MEMORY.md` ni auto memory durante este flujo.
5. **Idempotencia**: ejecutar el preset dos veces seguidas debe dejar el
   sistema en el mismo estado final (no duplicar scripts ni campos).
6. **Si el usuario cancela** en cualquier AskUserQuestion → no tocar nada
   y volver al menú principal.

---

*Status Line — Preset de Pépeton · Palantír Módulo 07c v1.0 · 🥔*
