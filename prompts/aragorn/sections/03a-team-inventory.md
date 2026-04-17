# ⚔️ Módulo: Agent Teams — Inventario y Menú

## Misión

Asistir al usuario para configurar, gestionar y usar Agent Teams según la
documentación oficial de Claude Code. Todo el contenido técnico se obtiene vía
WebFetch on-the-fly, nunca hardcodeado.

---

## Fase 0 — Inventario de Teams Existentes

**Antes de cualquier menú o documentación**, detectar todos los Agent Teams existentes.

### Paso F0.1 — Escanear ambos scopes

```bash
echo "=== GLOBAL (~/.claude/agents/) ==="
ls ~/.claude/agents/ 2>/dev/null || echo "(vacío)"
echo "=== PROJECT (.claude/agents/) ==="
ls .claude/agents/ 2>/dev/null || echo "(vacío)"
```

Para cada fichero/directorio encontrado, leer su contenido con Read para extraer:
- Nombre del team
- Campo `lead` del fichero de configuración del team
- Número de agentes miembros (campos `teammates` o equivalente según docs)

### Paso F0.2 — Mostrar inventario

**Si se encuentran teams en algún scope**, mostrar:

```
══════════════════════════════════════════════════════════════
⚔️  TUS EJÉRCITOS DE GONDOR
══════════════════════════════════════════════════════════════

  🌍 GLOBAL (~/.claude/agents/):
  [Para cada team global]:
    ⚔️  [nombre-team]
       👑 Lead: [nombre-lead]  ·  🧑‍🤝‍🧑 Workers: [N]  ·  🗡️ [lista nombres separados por coma]

  📁 PROYECTO (.claude/agents/):
  [Para cada team de proyecto]:
    ⚔️  [nombre-team]
       👑 Lead: [nombre-lead]  ·  🧑‍🤝‍🧑 Workers: [N]  ·  🗡️ [lista nombres separados por coma]

  [Si algún scope está vacío, omitir esa sección]

══════════════════════════════════════════════════════════════
📊 Total: [N] teams  (global: [N] · proyecto: [N])
══════════════════════════════════════════════════════════════
```

Luego usar AskUserQuestion:

```json
{
  "questions": [{
    "header": "Agent Teams — Inventario",
    "question": "⚔️  ¿Qué quieres hacer con tus ejércitos?",
    "multiSelect": false,
    "options": [
      {
        "label": "🆕 Crear nuevo team",
        "description": "Forjar un nuevo ejército desde cero"
      },
      {
        "label": "👁️  Ver detalle de un team",
        "description": "Inspeccionar configuración completa"
      },
      {
        "label": "✏️  Editar un team",
        "description": "Modificar nombre o agentes miembros"
      },
      {
        "label": "🛡️  Forjar un Coordinador de Ejércitos",
        "description": "Crear un agente orquestador para uno de tus teams"
      },
      {
        "label": "🔍 Analizar coherencia",
        "description": "Detectar duplicados y conflictos entre scopes"
      },
      {
        "label": "🗑️  Eliminar un team",
        "description": "Borrar con confirmación previa"
      },
      {
        "label": "❓ ¿Cuándo usar Agent Teams vs Subagents?",
        "description": "Guía desde docs oficiales"
      },
      {
        "label": "🔙 Volver al menú de Aragorn",
        "description": ""
      }
    ]
  }]
}
```

**Si NO hay teams en ningún scope**, mostrar:

```
══════════════════════════════════════════════════════════════
⚔️  EJÉRCITOS DE GONDOR
══════════════════════════════════════════════════════════════

  No hay teams configurados todavía.
  Los archivos del rey esperan ser formados.

══════════════════════════════════════════════════════════════
```

Y usar AskUserQuestion:

```json
{
  "questions": [{
    "header": "Agent Teams",
    "question": "⚔️  No hay teams aún — ¿Qué quieres hacer?",
    "multiSelect": false,
    "options": [
      {
        "label": "🆕 Crear mi primer team",
        "description": "Forjar el primer ejército de Gondor"
      },
      {
        "label": "❓ ¿Qué son los Agent Teams?",
        "description": "Ver explicación desde docs oficiales"
      },
      {
        "label": "🔙 Volver al menú de Aragorn",
        "description": ""
      }
    ]
  }]
}
```

---

## Paso 0 — Documentación oficial (on-the-fly)

**IMPORTANTE**: Comprobar primero si la documentación ya está cargada en el contexto.

**Si ya está en contexto**: usar directamente sin re-fetchear.

**Si no está en contexto**, hacer WebFetch en paralelo:

> **WebFetch 1**: `https://code.claude.com/docs/en/agent-teams`
> **Extraer**: qué son Agent Teams, cómo activarlos, estructura lead + teammates,
> shared task list, mailbox, display modes, cuándo usarlos, limitaciones, ejemplos.

> **WebFetch 2**: `https://code.claude.com/docs/en/sub-agents`
> **Extraer**: diferencia Subagents vs Agent Teams, cuándo elegir cada uno,
> invocación automática vs explícita, contextos compartido vs independiente.

**Fallback si WebFetch falla**: Mostrar solo las URLs:

```
⚠️ No se pudo cargar la documentación oficial.
   El módulo de Agent Teams requiere las docs oficiales.

   Puedes consultarlas directamente:
     ⚔️  Agent Teams: https://code.claude.com/docs/en/agent-teams
     🤖 Sub-agents:  https://code.claude.com/docs/en/sub-agents
```

Ofrecer AskUserQuestion: reintentar WebFetch / volver al menú.

---

## Paso 1 — Menú del Team Builder

Tras cargar la documentación, mostrar menú:

```
══════════════════════════════════════════════════════════════
⚔️  TEAM BUILDER — Ejércitos de Gondor
══════════════════════════════════════════════════════════════

  Los Agent Teams permiten que múltiples agentes trabajen
  en paralelo, cada uno con su propio contexto independiente.
  [mostrar breve resumen extraído de las docs WebFetch]
══════════════════════════════════════════════════════════════
```

```json
{
  "questions": [{
    "header": "Agent Teams",
    "question": "⚔️  ¿Qué quieres hacer?",
    "multiSelect": false,
    "options": [
      {
        "label": "🆕 Crear nuevo team",
        "description": "Configurar un equipo de agentes paralelos"
      },
      {
        "label": "📋 Ver teams configurados",
        "description": "Listar y gestionar teams existentes"
      },
      {
        "label": "🪟 ¿Cómo ver cada agente en su propia pestaña?",
        "description": "Guía para visualizar resultados independientes"
      },
      {
        "label": "❓ ¿Cuándo usar Agent Teams vs Subagents?",
        "description": "Explicación desde docs oficiales"
      },
      {
        "label": "⚔️  H — Patrón de debate entre pares",
        "description": "Adversarial Collaboration: dos workers en paralelo con consenso facilitado por Scrum Master"
      }
    ]
  }]
}
```

---

**Módulo**: `03a-team-inventory.md`
**Invocado desde**: `aragorn-main.md` (opción "Agent Teams")
**Requiere**: WebFetch on-demand, Read, Bash
