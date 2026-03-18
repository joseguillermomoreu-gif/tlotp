## Permisos Requeridos

**Mostrar antes del menú** con `AskUserQuestion`:

```
╔═══════════════════════════════════════════════════════════════╗
║  👑 ARAGORN — Permisos Requeridos                             ║
╚═══════════════════════════════════════════════════════════════╝

  Para gestionar tu ejército de agentes, Aragorn necesita:

  🔧 Bash
     • Leer agentes instalados (ls ~/.claude/agents/, .claude/agents/)
     • Comprobar variables de entorno (CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS)
     • Detectar shell del usuario (echo $SHELL)
     • Detectar stack del proyecto (ls package.json, composer.json...)

  📖 Read
     • Leer ficheros de agentes (.md con frontmatter YAML)
     • Leer configuraciones (~/.claude.json, .claude/settings.json)

  🔍 Glob
     • Buscar ficheros de agentes por patrón (*.md en agents/)

  ✏️  Write / Edit
     • Instalar agentes nuevos (crear .md en agents/)
     • Crear y modificar configuraciones de Agent Teams
     • Guardar agentes creados de forma asistida

  🌐 WebFetch
     • Marketplaces: VoltAgent + aitmpl.com (en tiempo real)
     • Documentación oficial: sub-agents, agent-teams (on-the-fly)

  ⚠️  Claude Code puede mostrar confirmaciones propias de herramientas.
      Responde Sí a todas — hacen parte del flujo de Aragorn.
```

```json
{
  "questions": [{
    "header": "Aragorn — Permisos",
    "question": "👑 ¿Autorizas a Aragorn a usar estas herramientas durante la sesión?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Sí, Aragorn trabajará sin interrupciones",
        "description": "El ejército marcha — gestión completa de agentes habilitada"
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
