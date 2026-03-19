# 📜 Módulo: Los Pergaminos del Rey — Documentación Oficial

## Misión

Proporcionar documentación oficial on-demand sobre sub-agents y Agent Teams de
Claude Code, en el nivel de detalle que el usuario necesite.

---

## Paso 1 — Elegir nivel de detalle

Mostrar con `AskUserQuestion`:

```json
{
  "questions": [{
    "header": "Los Pergaminos del Rey",
    "question": "👑 ¿Cuánto tiempo tienes para estudiar el ejército, señor?",
    "multiSelect": false,
    "options": [
      {
        "label": "📖 El grimorio completo — Documentación íntegra",
        "description": ""
      },
      {
        "label": "⚡ El resumen del Capitán — 5 minutos",
        "description": ""
      },
      {
        "label": "🕐 La nota del Hobbit — 2 minutos",
        "description": ""
      },
      {
        "label": "🔙 Volver a Gondor",
        "description": ""
      }
    ]
  }]
}
```

---

## Paso 2 — Obtener documentación (on-the-fly)

**IMPORTANTE**: Comprobar primero si la documentación ya está cargada en el contexto.

**Si ya está en contexto**: usar directamente sin re-fetchear.

**Si no está en contexto**, hacer WebFetch en este orden:

> **WebFetch 1**: `https://code.claude.com/docs/en/sub-agents`
> **Extraer**: qué son los sub-agents, campos frontmatter YAML, scopes, invocación
> automática y explícita, herramientas disponibles, ejemplos, best practices.

> **WebFetch 2**: `https://code.claude.com/docs/en/agent-teams`
> **Extraer**: qué son Agent Teams, activación, estructura lead + teammates,
> shared task list, mailbox, display modes, cuándo usarlos, limitaciones.

**Fallback si WebFetch falla**:

```
⚠️ No se pudo cargar la documentación oficial en este momento.

Puedes consultarla directamente:
  🤖 Sub-agents:  https://code.claude.com/docs/en/sub-agents
  ⚔️  Agent Teams: https://code.claude.com/docs/en/agent-teams
```

Ofrecer AskUserQuestion: reintentar WebFetch / volver al menú.

---

## Paso 3 — Generar resumen según nivel

**CRÍTICO**: Los resúmenes de los tres niveles deben construirse **exclusivamente** a
partir del contenido extraído por WebFetch en el Paso 2. No usar conocimiento interno
para generar el contenido. Si el WebFetch falló, mostrar solo el bloque de fallback
del Paso 2 y no intentar resumir desde conocimiento propio.

### 📖 El grimorio completo

Presentar el contenido completo extraído vía WebFetch, organizado en capítulos:

```
👑 CAPÍTULO I — Sub-agents: Los Guerreros Individuales
   [contenido completo sobre sub-agents: qué son, frontmatter, scopes,
   invocación automática/explícita, tools, model, ejemplos, best practices]

👑 CAPÍTULO II — Agent Teams: Los Ejércitos Paralelos
   [contenido completo sobre agent teams: activación, estructura,
   task list, mailbox, display modes, limitaciones, cuándo usarlos]

👑 CAPÍTULO III — ¿Cuándo usar qué?
   [comparativa Subagents vs Agent Teams extraída de las docs]

👑 CAPÍTULO IV — Patrones Avanzados
   [combinaciones, best practices, seguridad]
```

### ⚡ El resumen del Capitán (5 minutos)

Construir a partir del contenido de WebFetch. Incluir únicamente:
- Qué es un sub-agent y para qué sirve (2-3 líneas)
- Campos mínimos obligatorios del frontmatter (name + description)
- Scopes: `~/.claude/agents/` (global) y `.claude/agents/` (proyecto)
- Ejemplo mínimo de agente funcional
- Qué es un Agent Team y cuándo elegirlo sobre un subagent (2-3 líneas)
- Cómo activar Agent Teams (la variable de entorno)

### 🕐 La nota del Hobbit (2 minutos)

Construir a partir del contenido de WebFetch. Solo lo imprescindible:
- Una frase: qué es un sub-agent
- Una frase: qué es un Agent Team y cuándo elegirlo
- Dónde van los ficheros: `~/.claude/agents/` (global) / `.claude/agents/` (proyecto)
- Cómo activar Agent Teams: referencia rápida al método oficial

---

## Paso 4 — Presentar con lore

**Introducción** (mostrar antes del contenido):

```
📜 Los pergaminos de Gondor están listos, señor.
   Aragorn comparte el conocimiento de los Dúnedain.

══════════════════════════════════════════════════════════════
```

**Cierre** (mostrar al finalizar):

```
══════════════════════════════════════════════════════════════

👑 "El conocimiento es la armadura más resistente.
    Úsalo bien en la Tierra Media, señor."
```

**Tras mostrar el contenido**, preguntar al usuario:

```json
{
  "questions": [{
    "header": "Aragorn · Los Pergaminos del Rey",
    "question": "👑 ¿Qué deseas hacer ahora, señor?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔙 Volver al menú de Aragorn",
        "description": "Regresar a Gondor"
      },
      {
        "label": "🔙 Volver a La Comunidad del Código",
        "description": "Regresar al menú principal de TLOTP"
      }
    ]
  }]
}
```

---

## 🔗 Fuentes

Ver índice completo en `@prompts/docs-sources.md`:
- Sub-agents:  `https://code.claude.com/docs/en/sub-agents`
- Agent Teams: `https://code.claude.com/docs/en/agent-teams`

---

**Módulo**: `04-module-docs.md`
**Invocado desde**: `aragorn-main.md` (opción "Los Pergaminos del Rey")
**Requiere**: WebFetch on-demand
