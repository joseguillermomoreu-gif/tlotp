# ⚔️ Módulo: Agent Teams — Ver Teams y FAQ

> **Listado de teams configurados + preguntas frecuentes** (pestañas, Teams vs Subagents).
> Invocado desde el menú del Team Builder.

---

## Opción B — Ver teams configurados

### Paso B1 — Escanear teams

```bash
ls .claude/teams/ 2>/dev/null
```

Si no hay ninguno:

```
📋 No hay teams configurados todavía.
💡 Usa "Crear nuevo team" para configurar tu primer equipo.
```

### Paso B2 — Mostrar inventario

Para cada fichero `.yml` encontrado, leerlo con Read y mostrar:

```
📋 TEAMS CONFIGURADOS
══════════════════════════════════════════════════════════════

  1. full-stack-review
     📝 Revisión completa: calidad + seguridad
     ⚔️  Agentes: code-reviewer, symfony-expert
     📍 .claude/teams/full-stack-review.yml

══════════════════════════════════════════════════════════════
📊 Total: [N] teams configurados
```

AskUserQuestion:
- 🆕 Crear nuevo team
- 🔧 Editar un team (pedir cuál → reescribir configuración)
- 🗑️ Eliminar un team (pedir cuál → confirmar → `rm .claude/teams/[nombre].yml`)
- 🔙 Volver al menú de Aragorn

---

## Opción C — ¿Cómo ver cada agente en su propia pestaña?

**CRÍTICO**: El contenido de esta sección debe extraerse de las docs oficiales obtenidas
en el Paso 0 (`agent-teams`). Si las docs no mencionan display modes o pestañas,
mostrar solo lo que aparezca en las docs + las instrucciones prácticas de abajo.

Mostrar:

```
🪟 AGENTES EN PESTAÑAS SEPARADAS
══════════════════════════════════════════════════════════════

Cada agente de un Agent Team es una instancia de Claude Code
independiente. Para verlos en pestañas separadas:

📖 Según las docs oficiales:
   [insertar aquí el contenido relevante de las docs sobre
    display modes, cómo se visualizan los agentes paralelos,
    output de cada instancia — extraído del WebFetch]

💡 Guía práctica:
   1. Abre Claude Code en modo terminal
   2. Invoca tu team: "@[nombre-team] [tu tarea]"
   3. Cada agente del team abre su propio proceso
   4. Si tu terminal lo soporta (tmux, iTerm2, WezTerm...):
      - Claude Code puede sugerir abrir cada instancia
        en un panel/pestaña diferente automáticamente
   5. Los resultados de cada agente aparecen por separado
      con su nombre como prefijo

🔧 Configuración recomendada para ver tabs:
   - Terminal con soporte de splits: tmux, WezTerm, iTerm2
   - O abre múltiples ventanas de terminal manualmente
   - Cada agente del team = una pestaña dedicada
══════════════════════════════════════════════════════════════
```

AskUserQuestion:
- 🆕 Crear un team ahora
- 📋 Ver mis teams configurados
- 🔙 Volver al menú de Aragorn

---

## Opción E — ¿Cuándo usar Agent Teams vs Subagents?

**CRÍTICO**: Mostrar EXCLUSIVAMENTE el contenido extraído de las docs oficiales
en el Paso 0. NO usar conocimiento interno para generar la comparativa.

Mostrar con esta estructura (contenido 100% de WebFetch):

```
══════════════════════════════════════════════════════════════
❓ AGENT TEAMS vs SUBAGENTS
══════════════════════════════════════════════════════════════

[Insertar aquí la comparativa extraída de las docs oficiales]

══════════════════════════════════════════════════════════════
```

AskUserQuestion:
- 🆕 Crear un team ahora
- 🔙 Volver al menú de Aragorn

---

**Módulo**: `03d-team-browse.md`
**Invocado desde**: `03a-team-inventory.md` (opciones B, C, E)
**Requiere**: Read, Bash
