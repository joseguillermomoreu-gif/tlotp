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
        "description": "Palantír actuará sin interrupciones durante la sesión"
      },
      {
        "label": "🔄 Saltar",
        "description": "Palantír solicitará los permisos según los necesite"
      }
    ]
  }]
}
```

Tras la respuesta, continuar automáticamente al PASO 2 (menú principal).
