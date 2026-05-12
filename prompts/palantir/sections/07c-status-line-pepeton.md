# 🥔 Status Line — Preset de Pépeton, Señor de las Tierras Paletas (Caso C)

> **IMPORTADO POR**: `palantir-main.md`
>
> Instalación asistida de un Status Line preconfigurado: 2 líneas, barras
> de contexto, ventana de 5h y uso semanal 7d. Forjado por Pépeton hijo de
> Móreuton. Compatible con Linux/macOS/Git-Bash y Windows PowerShell 5.1+
> (ambas variantes mantenidas como templates versionados en el repo).

---

# ═══════════════════════════════════════════════════
# CASO C · Preset de Pépeton
# ═══════════════════════════════════════════════════

> **Cuándo ejecutar**: cuando el usuario elige `🥔 Usar el status line de
> Pépeton, hijo de Móreuton` desde `07a` (creación) o `07b` (gestión).

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
  · Requiere: bash + jq + git (Linux/macOS/Git-Bash) ó PowerShell 5.1+ (Windows)
  · Barras 5h/7d solo visibles en Pro/Max (se ocultan si no aplica)
══════════════════════════════════════════════════════════════════
```

---

## PASO P3 — Detectar scope

**Leer silenciosamente** ambos `settings.json` y construir matriz:

- `~/.claude/settings.json` → `GLOBAL_HAS_STATUSLINE`
- `.claude/settings.json` (proyecto) → `PROJECT_HAS_STATUSLINE`

| Global | Proyecto | Opciones a ofrecer |
|--------|----------|---------------------|
| ❌     | ❌       | Instalar en **Global** / Instalar en **Proyecto** / Cancelar |
| ✅     | ❌       | Reemplazar Global / Instalar Proyecto / Cancelar |
| ❌     | ✅       | Instalar Global / Reemplazar Proyecto / Cancelar |
| ✅     | ✅       | Reemplazar Global / Reemplazar Proyecto / Cancelar |

**AskUserQuestion** con las opciones que apliquen. Si elige reemplazar,
mostrar el valor actual antes de confirmar. Guardar `INSTALL_SCOPE` en contexto.

---

## PASO P3.5 — Detección de shell objetivo

> 🆕 Añadido en #478 para soportar Windows PowerShell 5.1+.

Leer `OS_DETECTED` propagado desde `tlotp-main.md` PASO 0.5.

- **`OS_DETECTED ∈ {Linux, Darwin}`** → `SHELL_TARGET = "bash"` · continuar a P2.
- **`OS_DETECTED == Windows`** → ejecutar silenciosamente:

```bash
powershell -NoProfile -Command "$PSVersionTable.PSVersion.Major" 2>/dev/null
```

- Si retorna entero ≥ 5 → `SHELL_TARGET = "powershell"`, `PS_VERSION = N`,
  mostrar info: `ℹ️ Detectado PowerShell v{N} — variante .ps1`.
- Si falla (stderr, exit ≠ 0, no entero) → AskUserQuestion:

```json
{
  "questions": [{
    "header": "Status Line · Shell objetivo",
    "question": "¿Qué shell ejecutará el status line?",
    "multiSelect": false,
    "options": [
      { "label": "🪟 PowerShell 5.1 (default Windows)", "description": "Variante .ps1 compatible PS 5.1+" },
      { "label": "🪟 PowerShell 7+ (pwsh)", "description": "Misma variante .ps1 (compat hacia adelante)" },
      { "label": "🐧 Git Bash (.sh)", "description": "Variante bash · requiere jq en PATH" },
      { "label": "🚫 Cancelar", "description": "Volver al menú de Palantír" }
    ]
  }]
}
```

Mapeo: PowerShell 5.1/7+ → `"powershell"` · Git Bash → `"bash"` · Cancelar → menú.

> ⚠️ Si `SHELL_TARGET == "powershell"`, el script generado **SOLO** usa
> sintaxis compatible PS 5.1. **Prohibido** improvisar con `??`, `?.`,
> `?[]`, `` `e ``, `Get-Error`, `ForEach-Object -Parallel`, `&&`/`||`.
> El template `prompts/palantir/templates/statusline-command.ps1` ya
> cumple estas restricciones — **NO regenerarlo a mano**, solo leerlo.

---

## PASO P2 — Verificar dependencias

**`SHELL_TARGET == "bash"`** → ejecutar `jq --version` y `git --version`.

- Si `jq` falta: advertir y preguntar (✅ Continuar / 🚫 Cancelar):
  `⚠️ jq no detectado · instalación: apt install jq · brew install jq · choco install jq`.
- Si `git` falta: avisar (no bloqueante), la rama se omitirá.

**`SHELL_TARGET == "powershell"`** → no requiere `jq` (parseo JSON nativo
con `ConvertFrom-Json`). Verificar `git` (opcional) via
`powershell -NoProfile -Command "git --version"`; si falta, se omite la rama.

---

## PASO P4 — Escribir el script de status line

**Ruta destino** según `INSTALL_SCOPE` y `SHELL_TARGET`:

| Scope    | bash                                  | powershell                              |
|----------|---------------------------------------|------------------------------------------|
| global   | `$HOME/.claude/statusline-command.sh` | `$HOME/.claude/statusline-command.ps1`   |
| project  | `.claude/statusline-command.sh`       | `.claude/statusline-command.ps1`         |

Si la carpeta `.claude/` no existe en el scope elegido, crearla con `mkdir -p`.

### Leer template versionado y escribir

Según `SHELL_TARGET`:

- **bash** → `Read prompts/palantir/templates/statusline-command.sh`
- **powershell** → `Read prompts/palantir/templates/statusline-command.ps1`

**Escribir** el contenido leído tal cual en la ruta destino con `Write` tool.

> 🚫 **Prohibido** duplicar el cuerpo del script en este markdown. La fuente
> de verdad es exclusivamente el fichero versionado del repo. Si necesitas
> modificar el script, hazlo en `prompts/palantir/templates/` vía PR.

### Permisos ejecutables (solo bash)

```bash
chmod +x <ruta destino>/statusline-command.sh
```

(En Windows + PowerShell el bit ejecutable no aplica: el comando registrado
invoca `powershell -File ...` directamente.)

---

## PASO P5 — Actualizar `settings.json`

### Valor del campo `statusLine` según `SHELL_TARGET` × `INSTALL_SCOPE`

**bash · global**:

```json
"statusLine": { "type": "command", "command": "bash ~/.claude/statusline-command.sh" }
```

**bash · proyecto**:

```json
"statusLine": { "type": "command", "command": "bash .claude/statusline-command.sh" }
```

**powershell · global**:

```json
"statusLine": { "type": "command", "command": "powershell -ExecutionPolicy Bypass -File %USERPROFILE%\\.claude\\statusline-command.ps1" }
```

**powershell · proyecto**:

```json
"statusLine": { "type": "command", "command": "powershell -ExecutionPolicy Bypass -File .claude\\statusline-command.ps1" }
```

> ⚠️ El flag `-ExecutionPolicy Bypass` aplica **solo al proceso del comando**;
> no modifica la policy global. Nunca usar `Set-ExecutionPolicy`.

### Proceso de escritura (seguro, preserva el resto del JSON)

1. **Read** el `settings.json` elegido.
2. Si no existe → base = `{}`.
3. Si existe → parsear el JSON tal cual (no perder campos).
4. **Actualizar** (o crear) la clave `statusLine` con el objeto anterior.
5. **Serializar** preservando indentación (2 espacios).
6. **Write** el contenido completo resultante.

> ⚠️ **Prohibido**: `sed`/`awk` sobre el JSON. Sólo Read → parse → Write.

---

## PASO P6 — Confirmación final con lore

Mostrar sin interacción (sustituir `<ruta>` y `<config>` según scope/shell):

```
══════════════════════════════════════════════════════════════════
🥔 ¡El Status Line de Pépeton ha sido instalado!

  📜 Script:  <ruta del statusline-command.{sh|ps1}>
  ⚙️  Config:  <ruta del settings.json> → statusLine
  🐚 Shell:   <SHELL_TARGET>

  Haz cualquier interacción con Claude Code para verlo en acción.
  Si no ves las barras de 5h/7d, es normal hasta la primera respuesta
  de la sesión (son datos Pro/Max).

  "Que el código fluya limpio y los prompts encuentren
   siempre su camino de vuelta."
        — Pépeton hijo de Móreuton
══════════════════════════════════════════════════════════════════
```

Volver al **menú principal de Palantír** (`00-menu-principal.md` PASO 2).

---

## ⚠️ Reglas globales del módulo

1. **Nunca escribir** sin confirmación explícita del usuario (PASO P3).
2. **Preservar** todos los campos del `settings.json` al actualizar.
3. **Usar solo** Read + Write sobre JSON, nunca `sed`/`awk`/text-replace.
4. **Fuente de verdad del script** = ficheros en `prompts/palantir/templates/`.
   Nunca duplicar el cuerpo del script en este markdown.
5. **PS 5.1 floor de compat**: ningún `.ps1` puede usar `??`, `?.`, `?[]`,
   `` `e ``, `Get-Error` ni paralelismo PS 7+.
6. **Idempotencia**: ejecutar el preset dos veces seguidas debe dejar el
   sistema en el mismo estado final.
7. **Si el usuario cancela** en cualquier AskUserQuestion → no tocar nada
   y volver al menú principal.

---

*Status Line — Preset de Pépeton · Palantír Módulo 07c v2.0 · 🥔*
