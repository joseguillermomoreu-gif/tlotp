# 🔮 Palantír - Mini-guía inicial

## Bloque informativo (mostrar sin interacción)

```
🔮 El Ojo que Todo lo Ve, Palantír

"Desde las profundidades de Isengar, Saruman lo veía todo:
movimientos de ejércitos, secretos de reyes, planes de enemigos.
El Palantír era su poder."

Palantír es el guardián de las configuraciones de Claude Code.
Como la piedra vidente, observa y controla todo lo que define
cómo Claude piensa y actúa en tu entorno.

📄 CLAUDE.md       — Las leyes que Claude debe obedecer
                     global: ~/.claude/  ·  proyecto: .claude/

⚙️  settings.json  — El mecanismo interno: permisos, modelo,
                     herramientas y variables de entorno

📁 rules/          — Mandatos activados por path o contexto
                     global: ~/.claude/rules/  ·  proyecto: .claude/rules/

🪝 hooks           — Los centinelas que vigilan en las sombras
                     (PreToolUse, PostCommit, SessionStart...)

🧠 MEMORY.md       — La memoria persistente entre batallas

⚔️ ¿Qué puede hacer Palantír?
  🔍 Inspeccionar — leer el estado actual de toda tu configuración
  ➕ Añadir       — crear nuevos registros con asistencia inteligente
  📦 Gestionar    — importar, exportar y modificar o borrar registros

══════════════════════════════════════════════════════
```

## Solicitar Permisos

Para todo lo anterior, Palantír necesita permisos de tu entorno.

> **Nota sobre el modelo de permisos**: Esta elección configura cómo Palantír gestiona sus confirmaciones en este prompt.
> Claude Code mantiene una capa de permisos propia en runtime — independientemente de tu elección aquí, puede seguir solicitando confirmación por herramienta según el modo de sesión activo (incluyendo `--dangerously-skip-permissions` si lo has configurado).

**Usar AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Permisos",
    "question": "¿Cómo deseas gestionar los permisos de Palantír?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aprobar todos",
        "description": "Palantír indica su intención de actuar libremente. Claude Code puede seguir solicitando confirmación por herramienta según el modo de sesión activo."
      },
      {
        "label": "🔄 Saltar",
        "description": "Palantír solicitará tu confirmación antes de cada acción relevante"
      }
    ]
  }]
}
```

### Si elige "🔄 Saltar"

Continuar automáticamente al PASO 2 (menú principal).

### Si elige "✅ Aprobar todos"

Ejecutar el flujo de **pre-autorización de permisos en settings.json** (pasos P1–P4).

---

## P1 — Mostrar lista de permisos de TLOTP

Mostrar al usuario la lista completa de permisos que TLOTP necesita para funcionar
sin interrupciones. Estos permisos cubren todas las épicas (Palantír, Bardo,
Celebrimbor, Ents, Aragorn, Gandalf):

```
🔮 PALANTÍR — Pre-autorización de Permisos
══════════════════════════════════════════════════════════════

  "Quien controla el Palantír, controla el flujo del poder.
   Pero solo un Istari sabio otorga acceso con conocimiento."

  TLOTP necesita estos permisos para operar sin interrupciones.
  Se escribirán en settings.json — puedes revocarlos en cualquier momento.

  📖 Read (8 permisos)
     ~/.claude/**  ·  .claude/**  ·  CLAUDE.md  ·  CLAUDE.local.md
     ~/.claude.json  ·  .mcp.json  ·  package.json  ·  composer.json

  ⚡ Bash (20 permisos)
     uname *  ·  node --version  ·  npm --version  ·  npx --version
     npx skills *  ·  ls *  ·  cat ~/.claude*  ·  cat .claude*
     cat .mcp.json  ·  cat ~/.claude.json  ·  cat package.json*
     cat composer.json*  ·  cat CLAUDE*  ·  wc -l *  ·  echo *
     timeout *  ·  curl -s *  ·  mkdir -p */.claude/*
     mkdir -p ~/.claude/*  ·  mkdir -p .github/*

  ✏️  Write (7 permisos)
     ~/.claude/**  ·  .claude/**  ·  CLAUDE.md  ·  CLAUDE.local.md
     ~/.claude.json  ·  .mcp.json  ·  .github/workflows/*

  🔧 Edit (7 permisos)
     ~/.claude/**  ·  .claude/**  ·  CLAUDE.md  ·  CLAUDE.local.md
     ~/.claude.json  ·  .mcp.json  ·  .github/workflows/*

  🔍 Glob (3 permisos)
     ~/.claude/**  ·  .claude/**  ·  .github/**

  🌐 WebFetch (5 permisos)
     code.claude.com/*  ·  docs.github.com/*
     github.com/vercel-labs/*  ·  raw.githubusercontent.com/*
     aitmpl.com/*

  🗑️  Bash — eliminación controlada (3 permisos)
     rm ~/.claude/skills/*  ·  rm .claude/skills/*
     rm .claude/teams/*

  ───────────────────────────────────────────────────────────
  Total: 53 permisos · Solo afectan a configuración de Claude Code
  No modifican código fuente ni acceden a datos sensibles
══════════════════════════════════════════════════════════════
```

---

## P2 — Elegir scope

**Usar AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Palantír — Scope de permisos",
    "question": "🔮 ¿Dónde quieres escribir los permisos pre-autorizados?",
    "multiSelect": false,
    "options": [
      {
        "label": "📂 Local (.claude/settings.json)",
        "description": "Solo para este proyecto — recomendado"
      },
      {
        "label": "🌍 Global (~/.claude/settings.json)",
        "description": "Para todos los proyectos donde uses TLOTP"
      },
      {
        "label": "🚫 Cancelar",
        "description": "No escribir permisos, continuar al menú"
      }
    ]
  }]
}
```

- Si elige **Cancelar**: continuar al PASO 2 (menú principal) sin escribir nada.
- Si elige **Local**: `SCOPE_PATH=.claude/settings.json`
- Si elige **Global**: `SCOPE_PATH=~/.claude/settings.json`

---

## P3 — Escritura merge-intelligent

**Lista completa de permisos a escribir**:

```json
[
  "Read(~/.claude/**)", "Read(.claude/**)", "Read(CLAUDE.md)", "Read(CLAUDE.local.md)",
  "Read(~/.claude.json)", "Read(.mcp.json)", "Read(package.json)", "Read(composer.json)",
  "Bash(uname *)", "Bash(node --version)", "Bash(npm --version)", "Bash(npx --version)",
  "Bash(npx skills *)", "Bash(ls *)", "Bash(cat ~/.claude*)", "Bash(cat .claude*)",
  "Bash(cat .mcp.json)", "Bash(cat ~/.claude.json)", "Bash(cat package.json*)",
  "Bash(cat composer.json*)", "Bash(cat CLAUDE*)", "Bash(wc -l *)", "Bash(echo *)",
  "Bash(timeout *)", "Bash(curl -s *)", "Bash(mkdir -p */.claude/*)",
  "Bash(mkdir -p ~/.claude/*)", "Bash(mkdir -p .github/*)",
  "Bash(rm ~/.claude/skills/*)", "Bash(rm .claude/skills/*)", "Bash(rm .claude/teams/*)",
  "Bash(echo $SHELL)",
  "Write(~/.claude/**)", "Write(.claude/**)", "Write(CLAUDE.md)", "Write(CLAUDE.local.md)",
  "Write(~/.claude.json)", "Write(.mcp.json)", "Write(.github/workflows/*)",
  "Edit(~/.claude/**)", "Edit(.claude/**)", "Edit(CLAUDE.md)", "Edit(CLAUDE.local.md)",
  "Edit(~/.claude.json)", "Edit(.mcp.json)", "Edit(.github/workflows/*)",
  "Glob(~/.claude/**)", "Glob(.claude/**)", "Glob(.github/**)",
  "WebFetch(code.claude.com/*)", "WebFetch(docs.github.com/*)",
  "WebFetch(github.com/vercel-labs/*)", "WebFetch(raw.githubusercontent.com/*)",
  "WebFetch(aitmpl.com/*)"
]
```

**Lógica de escritura** (ejecutar con Bash + Read + Write):

1. Leer el fichero `SCOPE_PATH` si existe (con Read). Si no existe, partir de `{}`.
2. Parsear el JSON existente.
3. Extraer el array `permissions.allow` existente (puede no existir → array vacío).
4. Para cada permiso de la lista TLOTP: añadirlo **solo si no existe ya** en el array.
5. Escribir el JSON resultante con Write, manteniendo todas las claves existentes intactas.

**Ejemplo de lógica Bash** (referencia para el ejecutor):

```bash
# Leer settings existente o crear vacío
SETTINGS_FILE="SCOPE_PATH"
if [ -f "$SETTINGS_FILE" ]; then
  EXISTING=$(cat "$SETTINGS_FILE")
else
  mkdir -p "$(dirname "$SETTINGS_FILE")"
  EXISTING='{}'
fi
```

Luego usar Read para obtener el contenido, parsear con lógica JSON, y Write para
escribir el resultado final. **Nunca sobreescribir** claves existentes fuera de
`permissions.allow`.

---

## P4 — Confirmación épica

Tras escribir correctamente, mostrar:

```
══════════════════════════════════════════════════════════════
🔮 PERMISOS PRE-AUTORIZADOS CORRECTAMENTE
══════════════════════════════════════════════════════════════

  Scope:    [Local/Global]
  Fichero:  [ruta completa]
  Nuevos:   [N] permisos añadidos
  Ya existían: [M] permisos (sin duplicar)
  Total:    [T] permisos en permissions.allow

  💡 Puedes revocar permisos en cualquier momento editando
     el fichero settings.json o usando Palantír → Gestionar.

══════════════════════════════════════════════════════════════
  "El Palantír ha sido calibrado. Las piedras videntes
   responden a tu voluntad, Señor de las Configuraciones."
══════════════════════════════════════════════════════════════
```

Si la escritura falla, mostrar error y ofrecer AskUserQuestion:
- 🔄 Reintentar
- 🚫 Continuar sin permisos

Tras P4 (éxito o cancelación), continuar automáticamente al PASO 2 (menú principal).
