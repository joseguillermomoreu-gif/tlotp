# 🪝 Sistema de Hooks - Palantír

## Misión

Inspeccionar hooks configurados, analizar su efectividad y asistir al usuario en la creación de nuevos hooks de forma guiada.

---

## 📖 Documentación Oficial (Live)

**ANTES de ejecutar este módulo**, obtener documentación actualizada:

> **WebFetch 1**: https://code.claude.com/docs/en/hooks-guide
> **Extraer**:
> - Tabla completa de eventos con matchers y cuándo se disparan
> - 3 tipos de hooks: command, prompt, agent
> - Formato JSON de configuración en settings.json
> - Patrones de input/output (stdin JSON, exit codes)
> - Ubicaciones de configuración (user, project, local)
> - Ejemplos prácticos (notifications, auto-format, block files, re-inject context)

> **WebFetch 2** (suplemento en español): https://wmedia.es/es/articulos/claude-code-hooks-guia-practica
> **Extraer**: Casos de uso prácticos y tips adicionales no cubiertos por docs oficiales.

**Índice completo de fuentes**: `@prompts/docs-sources.md`

---

## 🎯 Submenu de Hooks

Al entrar en este módulo, mostrar submenu con **AskUserQuestion**:

```json
{
  "questions": [
    {
      "header": "Hooks",
      "question": "¿Qué deseas hacer con los Hooks de Claude Code?",
      "multiSelect": false,
      "options": [
        {
          "label": "Inspeccionar hooks existentes",
          "description": "Ver todos los hooks configurados, analizar y sugerir mejoras"
        },
        {
          "label": "Crear nuevo hook",
          "description": "Asistente guiado para crear un hook según lo que necesites automatizar"
        },
        {
          "label": "¿Necesito un hook o algo mejor?",
          "description": "Te ayudo a decidir entre hook, skill, rule o CLAUDE.md"
        },
        {
          "label": "Volver al menú de Palantír",
          "description": "Volver al menú principal"
        }
      ]
    }
  ]
}
```

---

## 🔍 Opción 1: Inspeccionar Hooks Existentes

### Paso 1: Leer hooks de los 3 niveles

**Leer los 3 ficheros de settings.json** y extraer la clave `"hooks"`:

```bash
# Global (todos los proyectos)
cat ~/.claude/settings.json

# Proyecto (compartible vía repo)
cat .claude/settings.json

# Proyecto privado (no en git)
cat .claude/settings.local.json
```

**Para cada fichero**:
- Si no existe: marcar como ❌ No existe
- Si existe pero no tiene `"hooks"`: marcar como ⚠️ Sin hooks
- Si tiene hooks: extraer y parsear

### Paso 2: Mostrar resumen visual

```
═══════════════════════════════════════════════════════════
🪝 Inspección de Hooks
═══════════════════════════════════════════════════════════

📍 Global (~/.claude/settings.json)
   ✅ 2 hooks configurados
   • Notification (matcher: *) → command: notify-send
   • PostToolUse (matcher: Edit|Write) → command: prettier --write

📍 Proyecto (.claude/settings.json)
   ✅ 1 hook configurado
   • PreToolUse (matcher: Bash) → command: ./scripts/validate.sh

📍 Local (.claude/settings.local.json)
   ❌ No existe

───────────────────────────────────────────────────────────
📊 Resumen: 3 hooks totales en 2 niveles
═══════════════════════════════════════════════════════════
```

### Paso 3: Análisis basado en documentación oficial

**DESPUÉS del resumen**, realizar análisis profundo usando la documentación oficial obtenida via WebFetch.

**OBLIGATORIO**: El análisis debe estar basado EXCLUSIVAMENTE en la información obtenida de la documentación oficial. NO inventar reglas o best practices que no estén en la docs.

#### 3.1: Validar configuración contra docs oficiales

Para CADA hook encontrado, verificar contra la documentación:

1. **¿El evento existe?** — Comparar contra la tabla oficial de eventos del WebFetch
2. **¿El matcher es válido?** — Verificar que el matcher corresponde al tipo de dato que filtra ese evento (nombre de herramienta, tipo de sesión, etc.)
3. **¿El tipo es correcto?** — Verificar que el `type` es `command`, `prompt` o `agent`
4. **¿El formato JSON es correcto?** — Verificar estructura: `{ "hooks": { "Evento": [{ "matcher": "...", "hooks": [{ "type": "...", "command": "..." }] }] } }`
5. **¿El exit code se usa bien?** — Si es PreToolUse, ¿el script usa exit 2 para bloquear?
6. **¿Stop hook tiene protección anti-loop?** — Si es Stop hook, ¿verifica `stop_hook_active`?

**Mostrar resultado por hook**:
```
🪝 Hook: PostToolUse > Edit|Write
   Tipo: command
   Comando: jq -r '.tool_input.file_path' | xargs npx prettier --write
   Scope: Global

   📖 Validación contra documentación oficial:
   ✅ Evento PostToolUse existe (se dispara tras uso exitoso de herramienta)
   ✅ Matcher Edit|Write es válido (filtra por nombre de herramienta)
   ✅ Tipo command es correcto
   ✅ El comando lee tool_input.file_path de stdin JSON (patrón documentado)

   Veredicto: ✅ Correctamente configurado según docs oficiales
```

#### 3.2: Detectar conflictos entre niveles

Buscar hooks que puedan interferir:
- Mismo evento + mismo matcher en global Y proyecto → **conflicto potencial**
- Según docs: "Where you add a hook determines its scope" — hooks en niveles distintos se acumulan
- Informar: cuál se ejecuta primero, si pueden interferir

#### 3.3: Analizar oportunidades basadas en docs oficiales

**IMPORTANTE**: Las oportunidades deben extraerse de los patrones documentados oficialmente en la guía de hooks obtenida via WebFetch.

La documentación oficial describe estos patrones principales (verificar que siguen en la docs live):
1. **Notifications** — Alertar cuando Claude necesita input
2. **Auto-format** — Formatear tras ediciones
3. **Block protected files** — Proteger archivos sensibles
4. **Re-inject context** — Re-inyectar tras compaction
5. **Audit config changes** — Auditar cambios de configuración

**Para cada patrón de la documentación**:
- ¿El usuario tiene un hook que lo cubra?
- Si **sí**: marcar ✅ y verificar que está bien configurado
- Si **no**: marcar como oportunidad y explicar QUÉ hace y POR QUÉ es útil

**Mostrar análisis**:
```
💡 Análisis basado en documentación oficial de Claude Code:

📖 Patrones recomendados en la guía oficial:

✅ Auto-format tras ediciones
   → Ya tienes: PostToolUse > Edit|Write → prettier
   → Correctamente configurado

✅ Validación de comandos
   → Ya tienes: PreToolUse > Bash → validate.sh

⚠️ Notificaciones (NO configurado)
   → La documentación recomienda un hook Notification para
     recibir alertas cuando Claude termine o necesite tu input.
   → Impacto: No te enteras si Claude está esperando tu respuesta
   → Docs: "Get notified when Claude needs input"

⚠️ Protección de archivos sensibles (NO configurado)
   → La documentación incluye un patrón PreToolUse para bloquear
     ediciones a .env, package-lock.json, .git/
   → Impacto: Claude podría editar accidentalmente archivos sensibles
   → Docs: "Block edits to protected files"

⚠️ Re-inyección post-compact (NO configurado)
   → La documentación recomienda SessionStart(compact) para
     re-inyectar contexto crítico tras compactación
   → Impacto: Si Claude compacta, puede perder instrucciones clave
   → Docs: "Re-inject context after compaction"

───────────────────────────────────────────────────────────
📊 Cobertura: 2/5 patrones recomendados implementados (40%)
───────────────────────────────────────────────────────────
```

#### 3.4: Ofrecer acciones

**Usar AskUserQuestion**:
```json
{
  "questions": [
    {
      "header": "Acciones",
      "question": "¿Qué deseas hacer tras el análisis?",
      "multiSelect": false,
      "options": [
        {
          "label": "Crear hooks recomendados",
          "description": "Crear los hooks que faltan según las recomendaciones"
        },
        {
          "label": "Corregir hooks con problemas",
          "description": "Arreglar hooks que tienen errores de configuración"
        },
        {
          "label": "Volver al menú de Hooks",
          "description": "Volver al submenu de hooks"
        },
        {
          "label": "Volver a Palantír",
          "description": "Volver al menú principal de Palantír"
        }
      ]
    }
  ]
}
```

**Si elige "Crear hooks recomendados"**: Ir a la Opción 2 (Crear Nuevo Hook) con el patrón recomendado ya pre-seleccionado.

**Si elige "Corregir hooks con problemas"**: Para cada hook con problemas, mostrar el error y la corrección propuesta basada en la documentación, con preview antes de aplicar.

---

## ✨ Opción 2: Crear Nuevo Hook (Asistente Guiado)

### Paso 1: Preguntar QUÉ quiere automatizar (lenguaje natural)

**IMPORTANTE**: El usuario NO sabe qué es un evento, tipo o scope. No usar jerga técnica.

**Usar AskUserQuestion**:

```json
{
  "questions": [
    {
      "header": "Automatizar",
      "question": "¿Qué te gustaría automatizar en Claude Code?",
      "multiSelect": false,
      "options": [
        {
          "label": "Recibir notificaciones",
          "description": "Que me avise cuando Claude termine o necesite mi atención"
        },
        {
          "label": "Formatear código automáticamente",
          "description": "Que pase un formatter (Prettier, Black, etc.) tras cada edición"
        },
        {
          "label": "Bloquear acciones peligrosas",
          "description": "Que impida tocar ciertos archivos o ejecutar ciertos comandos"
        },
        {
          "label": "Otra cosa",
          "description": "Describir qué quiero automatizar"
        }
      ]
    }
  ]
}
```

### Paso 2: Determinar configuración usando documentación oficial

**OBLIGATORIO**: Consultar la documentación oficial obtenida via WebFetch para determinar el evento, tipo y scope correctos. NO usar valores inventados o recordados — siempre verificar contra la docs live.

**Proceso**:
1. Analizar qué quiere automatizar el usuario
2. Buscar en la tabla de eventos de la docs oficial cuál encaja
3. Verificar qué matchers acepta ese evento
4. Determinar el tipo más adecuado (command para scripts, prompt para evaluaciones LLM, agent para verificaciones complejas)
5. Recomendar scope según el caso de uso

#### Tabla de referencia rápida (verificar contra docs live)

Esta tabla es orientativa. SIEMPRE verificar contra la documentación oficial obtenida via WebFetch antes de recomendar:

| Lo que quiere el usuario | Evento probable | Tipo probable | Scope recomendado |
|--------------------------|----------------|--------------|-------------------|
| Recibir notificaciones | `Notification` | `command` | Global |
| Formatear tras edición | `PostToolUse` (matcher: `Edit\|Write`) | `command` | Proyecto |
| Bloquear archivos sensibles | `PreToolUse` (matcher: `Edit\|Write`) | `command` | Proyecto |
| Validar comandos peligrosos | `PreToolUse` (matcher: `Bash`) | `command` | Global |
| Re-inyectar contexto tras compact | `SessionStart` (matcher: `compact`) | `command` | Proyecto |
| Verificar calidad antes de terminar | `Stop` | `prompt` o `agent` | Proyecto |
| Auditar cambios de config | `ConfigChange` | `command` | Global |
| Ejecutar algo al empezar sesión | `SessionStart` (matcher: `startup`) | `command` | Global o Proyecto |

**Si el usuario elige "Otra cosa"**: Analizar su descripción contra la tabla COMPLETA de eventos de la documentación oficial (que tiene más eventos que esta tabla) y recomendar la combinación adecuada. Los docs oficiales tienen eventos adicionales como `UserPromptSubmit`, `PermissionRequest`, `SubagentStart/Stop`, `TeammateIdle`, `TaskCompleted`, `WorktreeCreate/Remove`, `SessionEnd`, etc.

### Paso 3: Presentar recomendación

**Mostrar al usuario** nuestra recomendación de forma clara:

```
💡 Para automatizar: "Formatear código tras cada edición"

Recomendación de Palantír:

  📍 Cuándo se ejecuta: Después de cada edición de archivo
  🔧 Cómo funciona: Ejecuta tu formatter automáticamente
  📂 Dónde se guarda: En la config del proyecto (.claude/settings.json)
                       Así cada proyecto puede tener su formatter

  Configuración que se generará:
  ┌──────────────────────────────────────────────────────┐
  │ Evento: PostToolUse                                  │
  │ Matcher: Edit|Write                                  │
  │ Tipo: command                                        │
  │ Comando: [se preguntará a continuación]              │
  └──────────────────────────────────────────────────────┘
```

**Usar AskUserQuestion** para confirmar:
1. ✅ Aceptar recomendación
2. ✏️ Modificar algo (cambiar scope, evento, etc.)
3. 🚫 Cancelar

### Paso 4: Configurar detalles específicos

**Si el usuario acepta**, preguntar los detalles que faltan:

Para **auto-format**: "¿Qué formatter usas?"
- Prettier (JS/TS)
- Black (Python)
- php-cs-fixer (PHP)
- Otro (indicar comando)

Para **bloquear archivos**: "¿Qué archivos quieres proteger?"
- .env y secrets
- package-lock.json
- Archivos en .git/
- Otros (indicar patrones)

Para **notificaciones**: Detectar OS y sugerir comando:
- macOS: `osascript -e 'display notification...'`
- Linux: `notify-send 'Claude Code' '...'`

### Paso 5: Generar configuración JSON basada en docs oficiales

**OBLIGATORIO**: Generar el JSON usando el formato EXACTO documentado en la guía oficial.

**Verificar contra docs**:
- Estructura correcta: `{ "hooks": { "Evento": [{ "matcher": "...", "hooks": [{ "type": "...", "command": "..." }] }] } }`
- Si el evento soporta matchers (verificar tabla de docs)
- Si el tipo es válido (`command`, `prompt`, `agent`)
- Si es tipo `prompt`: usar formato `{ "type": "prompt", "prompt": "..." }`
- Si es tipo `agent`: usar formato `{ "type": "agent", "prompt": "...", "timeout": N }`
- Si es `Stop` hook: incluir verificación de `stop_hook_active` para evitar loops infinitos

**Ejemplo de JSON generado** (auto-format):

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.file_path' | xargs npx prettier --write"
          }
        ]
      }
    ]
  }
}
```

**Si genera un Stop hook**, incluir SIEMPRE la verificación anti-loop (documentada oficialmente):
```bash
#!/bin/bash
INPUT=$(cat)
if [ "$(echo "$INPUT" | jq -r '.stop_hook_active')" = "true" ]; then
  exit 0  # Permitir que Claude pare, evitar loop infinito
fi
# ... resto de la lógica del hook
```

### Paso 6: Insertar en settings.json

**Verificar si el fichero existe**:
```bash
# Según scope elegido
cat ~/.claude/settings.json       # Global
cat .claude/settings.json         # Proyecto
cat .claude/settings.local.json   # Local
```

**Si el fichero no existe**: Crearlo con la configuración del hook.

**Si el fichero existe**:
1. Leer contenido actual
2. Parsear JSON
3. Añadir el nuevo hook SIN sobrescribir hooks existentes
4. Si ya hay hooks en el mismo evento: añadir al array existente
5. Escribir fichero actualizado

**Mostrar preview** antes de escribir:
```
📝 Se va a modificar: .claude/settings.json

Cambios:
  + Nuevo hook: PostToolUse > Edit|Write → prettier --write

¿Confirmar?
```

### Paso 7: Confirmar e informar

```
═══════════════════════════════════════════════════════════
✅ Hook Creado Exitosamente
═══════════════════════════════════════════════════════════

Evento: PostToolUse
Matcher: Edit|Write
Tipo: command
Comando: jq -r '.tool_input.file_path' | xargs npx prettier --write
Guardado en: .claude/settings.json

El hook se activará en la próxima sesión de Claude Code
o al recargar la configuración.

💡 Tip: Usa /hooks en Claude Code para ver y gestionar
         todos tus hooks de forma interactiva.
═══════════════════════════════════════════════════════════
```

---

## 🤔 Opción 3: ¿Necesito un Hook o Algo Mejor?

### Árbol de decisión interactivo

**Usar AskUserQuestion**:

```json
{
  "questions": [
    {
      "header": "Objetivo",
      "question": "¿Qué necesitas que Claude Code haga?",
      "multiSelect": false,
      "options": [
        {
          "label": "Ejecutar algo SIEMPRE que ocurra X",
          "description": "Ej: formatear tras editar, bloquear comandos peligrosos, notificarme"
        },
        {
          "label": "Seguir instrucciones cuando trabaje con ciertos archivos",
          "description": "Ej: usar convenciones TypeScript solo en ficheros .ts"
        },
        {
          "label": "Dar instrucciones generales a Claude",
          "description": "Ej: usar 2 espacios de indentación, preferir funciones puras"
        },
        {
          "label": "Conectar con herramientas externas",
          "description": "Ej: consultar una base de datos, usar una API, acceder a Slack"
        }
      ]
    }
  ]
}
```

### Respuestas y recomendaciones

**"Ejecutar algo SIEMPRE que ocurra X"** → **🪝 Hook**
```
✅ Recomendación: Hook

Los hooks son la opción correcta porque:
• Se ejecutan SIEMPRE (determinista, no depende de Claude)
• Coste cero de contexto hasta que se activan
• Pueden bloquear acciones (exit code 2)
• Se configuran en settings.json

→ ¿Quieres crear uno? (ir a Opción 2: Crear hook)
```

**"Seguir instrucciones cuando trabaje con ciertos archivos"** → **📐 Rule con paths**
```
✅ Recomendación: Rule con paths (.claude/rules/)

Las rules con paths son la opción correcta porque:
• Se activan SOLO al tocar archivos que matchean el patrón
• Zero coste de contexto hasta activación
• Claude las sigue como instrucciones (no son scripts)
• Se versionan con el repo

Ejemplo: .claude/rules/typescript.md con paths: ["src/**/*.ts"]

→ Celebrimbor puede ayudarte a crear rules tras instalar skills
```

**"Dar instrucciones generales a Claude"** → **📝 CLAUDE.md**
```
✅ Recomendación: CLAUDE.md

CLAUDE.md es la opción correcta porque:
• Instrucciones que Claude lee al inicio de cada sesión
• Aplica a todo el trabajo en el proyecto
• Se versiona con el repo (compartible con equipo)
• Soporta @imports para organizar

→ Palantír "Configurar característica" puede ayudarte
```

**"Conectar con herramientas externas"** → **🔌 MCP Server**
```
✅ Recomendación: MCP Server

Los MCP servers son la opción correcta porque:
• Conectan Claude con APIs y servicios externos
• Proporcionan herramientas nuevas a Claude
• Más potentes que hooks para integraciones complejas

→ Esto está fuera del alcance actual de Palantír
   Consulta: https://code.claude.com/docs/en/mcp
```

---

## 📊 Tabla Comparativa (Mostrar si hay dudas)

| Mecanismo | Cuándo se activa | Determinista | Coste contexto | Puede bloquear |
|-----------|-----------------|-------------|----------------|---------------|
| **Hook** | Evento del ciclo de vida | ✅ Siempre | Zero | ✅ Sí (exit 2) |
| **Rule con paths** | Al tocar ficheros que matchean | ✅ Siempre (por path) | Zero hasta activar | ❌ No |
| **Skill** | Claude decide o `/invoke` | ❌ Claude decide | Descripción siempre | ❌ No |
| **CLAUDE.md** | Cada sesión (siempre) | ❌ Claude interpreta | Alto (siempre cargado) | ❌ No |
| **MCP Server** | Claude lo usa como herramienta | ❌ Claude decide | Medio | ❌ No |

---

## 🎯 Reglas de Ejecución

1. **SIEMPRE consultar docs live** antes de ejecutar (WebFetch a hooks-guide)
2. **NO asumir que el usuario sabe** de eventos, tipos o scopes → usar lenguaje natural
3. **Analizar configuración** tras inspección → aportar valor con recomendaciones
4. **Preview SIEMPRE** antes de escribir en settings.json
5. **Detectar OS** para comandos de notificación (macOS vs Linux)
6. **Mergear hooks** sin sobrescribir existentes al insertar en settings.json
7. **Informar sobre /hooks** del CLI como alternativa interactiva

---

**Módulo**: 11-hooks-system.md
**Épica**: Palantír
**Tarea**: #52
