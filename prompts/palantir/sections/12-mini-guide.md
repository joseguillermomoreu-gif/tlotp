# 🔮 Palantír - Mini-guía inicial

## Instrucción de ejecución

Antes de mostrar el bloque informativo, consultar documentación oficial:

> **WebFetch**: https://code.claude.com/docs/en/memory
> **Extraer**: tipos de memoria (CLAUDE.md, rules, settings, hooks, MEMORY.md),
> ubicaciones (global/proyecto) y jerarquía de precedencia

> **WebFetch**: https://code.claude.com/docs/en/settings
> **Extraer**: qué gestiona settings.json (permisos, modelo, herramientas, hooks)

> **WebFetch**: https://code.claude.com/docs/en/how-claude-code-works
> **Extraer**: arquitectura de Claude Code, cómo procesa el contexto, flujo de ejecución

Usar la información obtenida para que las descripciones sean precisas y actualizadas.

---

## Bloque informativo (mostrar sin interacción)

Mostrar exactamente esto, rellenando con los datos obtenidos de las docs:

```
🔮 ¿QUÉ ES PALANTÍR?
══════════════════════════════════════════════════════

Palantír gestiona las configuraciones de Claude Code.

📄 CLAUDE.md       — Instrucciones persistentes para Claude
                     global: ~/.claude/  ·  proyecto: .claude/

⚙️  settings.json  — Configuración técnica: permisos, modelo,
                     herramientas, variables de entorno

📁 rules/          — Reglas modulares activadas por path
                     global: ~/.claude/rules/  ·  proyecto: .claude/rules/

🪝 hooks           — Scripts automáticos en eventos del lifecycle
                     (PreToolUse, PostCommit, SessionStart...)

🧠 MEMORY.md       — Memoria persistente entre sesiones

¿Qué puedes hacer aquí?
  🔍 Inspeccionar — ver el estado actual de tu configuración
  ➕ Añadir       — crear nuevos registros con asistencia inteligente
  📦 Gestionar    — exportar, importar y resetear

══════════════════════════════════════════════════════
```

Tras mostrar el bloque, continuar automáticamente al siguiente paso (permisos).
