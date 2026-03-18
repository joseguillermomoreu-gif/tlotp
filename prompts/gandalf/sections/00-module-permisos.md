## Permisos Requeridos

**Mostrar antes del menú** con `AskUserQuestion`:

```
╔═══════════════════════════════════════════════════════════════╗
║  ⚡ GANDALF — Permisos Requeridos                             ║
╚═══════════════════════════════════════════════════════════════╝

  Para trazar el mapa antes de la aventura, Gandalf necesita:

  🔧 Bash
     • Detectar stack del proyecto (package.json, composer.json...)
     • Buscar ficheros SDD existentes (requirements.md, design.md...)
     • Detectar arquitectura y estructura de carpetas

  📖 Read / Glob / Grep
     • Explorar ficheros clave del proyecto (sin leer lógica profunda)
     • Leer SDD existentes para continuar donde se dejó

  🤖 Agent
     • Desplegar los 5 Exploradores Rohirrim en paralelo
     • Cada Rohirrim es un agente Claude Code independiente

  ✏️  Write
     • Crear requirements.md, design.md, tasks.md
     • Guardar la especificación de la aventura

  🌐 WebFetch
     • Documentación oficial: Plan Mode, Kiro/Spec-Kit (on-the-fly)

  ⚠️  Claude Code puede mostrar confirmaciones de herramientas.
      Responde Sí a todas — hacen parte del flujo de Gandalf.
```

```json
{
  "questions": [{
    "header": "Gandalf — Permisos",
    "question": "⚡ ¿Autorizas a Gandalf a explorar tu reino antes de trazar el mapa?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Sí, el Mago Blanco puede explorar libremente",
        "description": "Los Rohirrim cabalgan — el mapa se traza antes de la aventura"
      },
      {
        "label": "🔙 Volver a La Comunidad del Código",
        "description": ""
      }
    ]
  }]
}
```

Si elige volver: cargar `@prompts/tlotp-main.md`.
