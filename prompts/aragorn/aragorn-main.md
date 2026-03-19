# 👑 ARAGORN — El Rey que Regresa

---

> **⚡ PRE-CARGA OBLIGATORIA**: Antes de mostrar cualquier contenido al usuario, resolver
> todos los @imports referenciados en este fichero. Cargar todos los módulos en memoria
> completa antes de renderizar el banner o mostrar cualquier texto. El usuario debe ver
> el prompt completo en un único bloque de salida, sin cargas incrementales visibles.

---

## Banner de Entrada

**SIEMPRE** mostrar este banner al iniciar Aragorn:

```
══════════════════════════════════════════════════════════════
  ᚨᚱᚨᚷᚩᚱᚾ  👑  ARAGORN — El Rey que Regresa  ᚨᚱᚨᚷᚩᚱᚾ
══════════════════════════════════════════════════════════════
    Gestor de Agentes y Subagentes · TLOTP {VERSION}
──────────────────────────────────────────────────────────────

  "No pido la vida de ningún hombre que no quiera dármela.
   Pero hay esperanza. Si el valor no nos falta."

  El Rey de Reyes ha reunido su ejército:
    🏇 Los Rohirrim — veloces como el viento
    🧝 Los Elfos de Rivendel — precisión sin igual
    💀 El Ejército de los Muertos — ningún enemigo los detiene
    🛡️  Los Hombres de Gondor — guardianes incansables

  Cada agente: un guerrero de una raza diferente, forjado
  para una misión concreta. Tú eres el Elessar — convócalos.

══════════════════════════════════════════════════════════════
```

---

@prompts/aragorn/sections/00-module-permisos.md

---

## Menú Principal — Paginado

Tras los permisos, mostrar la **Pantalla 1**:

```
══════════════════════════════════════════════════════════════
👑 ARAGORN — Convoca al Ejército  (1/2)
══════════════════════════════════════════════════════════════
  "Los Rohirrim han llegado. Los Muertos obedecen.
   ¿Cuál es tu primera orden, Elessar?"
──────────────────────────────────────────────────────────────
  🔍 Inspeccionar arsenal de agentes
     Pasar revista: scoring, health check y mejoras

  🏪 Buscar e instalar desde marketplaces
     Reclutar nuevos guerreros de VoltAgent + aitmpl.com

  ✨ Crear un agente asistido
     Forjar un nuevo guerrero desde cero, a tu imagen

══════════════════════════════════════════════════════════════
```

```json
{
  "questions": [{
    "header": "Aragorn (1/2)",
    "question": "👑 ¿Cuál es tu misión, señor?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔍 Inspeccionar arsenal de agentes",
        "description": "Scoring, health check y revisor de mejoras uno a uno"
      },
      {
        "label": "🏪 Buscar e instalar desde marketplaces",
        "description": "VoltAgent + aitmpl.com en tiempo real"
      },
      {
        "label": "✨ Crear un agente asistido",
        "description": "Forjar un agente personalizado para tu stack"
      },
      {
        "label": "➕ Ver más opciones...",
        "description": ""
      }
    ]
  }]
}
```

Si elige **Ver más**, mostrar **Pantalla 2**:

```
══════════════════════════════════════════════════════════════
👑 ARAGORN — Los Archivos de Minas Tirith  (2/2)
══════════════════════════════════════════════════════════════
  "Incluso los elfos más sabios nacieron aprendices.
   Consulta los pergaminos antes de forjar, Elessar."
──────────────────────────────────────────────────────────────
  ⚔️  Agent Teams — ejércitos paralelos
     Rohirrim + Elfos + Muertos marchando a la vez

  📜 Los Pergaminos del Rey — Documentación oficial
     Sub-agents y Agent Teams on-demand desde las docs

══════════════════════════════════════════════════════════════
```

```json
{
  "questions": [{
    "header": "Aragorn (2/2)",
    "question": "👑 ¿Cuál es tu misión, señor?",
    "multiSelect": false,
    "options": [
      {
        "label": "⚔️  Agent Teams — configurar y usar equipos",
        "description": "Parallelismo real: lead + teammates con contextos independientes"
      },
      {
        "label": "📜 Los Pergaminos del Rey — Documentación oficial",
        "description": "Sub-agents y Agent Teams desde las docs oficiales"
      },
      {
        "label": "🔙 Volver a página 1",
        "description": ""
      },
      {
        "label": "🔙 Volver a La Comunidad del Código",
        "description": ""
      }
    ]
  }]
}
```

---

## Routing a Módulos

### Pantalla 1

#### 🔍 Inspeccionar arsenal de agentes
Cargar: `@prompts/aragorn/sections/00-module-analyze.md`

#### 🏪 Buscar e instalar desde marketplaces
Cargar: `@prompts/aragorn/sections/01-module-marketplace.md`

#### ✨ Crear un agente asistido
Cargar: `@prompts/aragorn/sections/02-module-create.md`

### Pantalla 2

#### ⚔️ Agent Teams — configurar y usar equipos
Cargar: `@prompts/aragorn/sections/03-module-team-builder.md`

#### 📜 Los Pergaminos del Rey
Cargar: `@prompts/aragorn/sections/04-module-docs.md`

#### 🔙 Volver a La Comunidad del Código
Cargar: `@prompts/tlotp-main.md`

---

## Lore al Instalar y Listar Agentes

@prompts/aragorn/sections/99-lore-characters.md

---

## Loop Continuo

Tras completar cualquier módulo, volver al **Paso del menú principal** (Pantalla 1) con AskUserQuestion hasta que el usuario elija salir.

---

**Prompt**: `aragorn-main.md`
**Invocado desde**: `tlotp-main.md`
**Reemplaza**: versión anterior de `aragorn-main.md` + ar1-ar10 legacy
**Requiere**: WebFetch on-demand, Read, Bash, Glob, Write, Edit
