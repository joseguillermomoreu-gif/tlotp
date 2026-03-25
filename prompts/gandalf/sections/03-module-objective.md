# 🎯 Módulo G3 — El Objetivo

## Misión

Capturar la aventura que el usuario quiere especificar.
Es la única pregunta de texto libre del flujo — el resto se guía con opciones.
La descripción del objetivo + el tipo de aventura condicionan todo G5, G6 y G7.

---

## Introducción con lore

Mostrar antes de la pregunta:

```
⚡ "¿Qué aventura traes a Rivendel, viajero?"

  El Consejo necesita conocer la misión antes de trazar el plan.
  Frodo no emprendió el viaje sin saber adónde iba.
  Bilbo no salió de La Comarca sin el contrato de Thorin.

  Describe tu aventura. Sin límite de palabras.
  Cuanto más detalle, mejor mapa trazará el Consejo.
```

---

## Paso 1 — Descripción libre

Usar AskUserQuestion con campo libre:

```json
{
  "questions": [{
    "header": "El Objetivo — Paso 1/2",
    "question": "⚡ ¿Qué quieres construir, refactorizar o explorar?\n(Describe la aventura con tus palabras)",
    "multiSelect": false,
    "options": [
      {
        "label": "✍️  Escribir la descripción",
        "description": "Una feature, un módulo, un MVP, una migración..."
      },
      {
        "label": "🔙 Volver al menú de Gandalf",
        "description": ""
      }
    ]
  }]
}
```

---

## Paso 2 — Tipo de aventura

Tras recoger la descripción, clasificar el tipo:

```json
{
  "questions": [{
    "header": "El Objetivo — Paso 2/2",
    "question": "⚡ ¿Qué tipo de aventura es esta?",
    "multiSelect": false,
    "options": [
      {
        "label": "✨ Nueva feature en proyecto existente",
        "description": "Añadir funcionalidad a un codebase que ya existe"
      },
      {
        "label": "🏗️  Nuevo proyecto desde cero (greenfield)",
        "description": "La Comarca antes de los hobbits — lienzo en blanco"
      },
      {
        "label": "🔄 Refactoring o migración técnica",
        "description": "Mejorar lo que hay sin cambiar el comportamiento"
      },
      {
        "label": "🔬 Spike técnico o exploración",
        "description": "Investigar una tecnología o enfoque nuevo"
      }
    ]
  }]
}
```

---

## Impacto del tipo en los módulos siguientes

| Tipo | G5 (requirements) | G6 (design) | G7 (tasks) |
|------|-------------------|-------------|------------|
| Nueva feature | Requisitos funcionales + no-funcionales | Adaptar arquitectura existente, ADR de integración | Tareas por capa (dominio → infra → UI) |
| Greenfield | Requisitos de producto + técnicos | Arquitectura desde cero, ADR de elección de stack | Tareas por fase (setup → core → deploy) |
| Refactoring | Requisitos de comportamiento preservado | Diagrama AS-IS vs TO-BE | Tareas por módulo refactorizado |
| Spike | Hipótesis + criterios de éxito | Experimento y métricas | Tareas de exploración (timeboxed) |

---

## Confirmación con lore

Tras seleccionar tipo, mostrar confirmación:

```
⚡ La aventura ha sido registrada en los pergaminos del Consejo:

  📜 Objetivo:  [descripción del usuario]
  🗺️  Tipo:     [tipo elegido]
  🏰 Contexto: [resumen del informe Rohirrim en 1 línea]

  "El Consejo de Rivendel ha tomado nota.
   Ahora los pergaminos pueden ser escritos."
```

AskUserQuestion:
- ✅ Continuar a los Requisitos → G5
- ✏️ Modificar el objetivo
- 🔙 Volver al menú

---

## Momento A — Propuesta Consolidada Pre-Generación

Antes de cargar G4b, el Consejo presenta su visión del trabajo completo.

### Verificar GANDALF_TEAM

**Si `GANDALF_TEAM` está activo** (hay un team seleccionado para esta sesión SDD):

Invocar al lead/orquestador del team seleccionado via Agent tool, pasándole
el contexto completo disponible: `contexto_rohirrim` + objetivo G3 + `contexto_docs`.

El lead genera la propuesta consolidada basándose en el análisis de su team.

**Fallback**: Si el Agent falla o supera 30s de timeout, generar la propuesta
de forma autónoma (comportamiento sin team) sin error bloqueante.

Banner con team activo:

```
╔════════════════════════════════════════════════════════════╗
║  ⚡ EL CONSEJO Y SU EJÉRCITO PRESENTAN LA PROPUESTA        ║
╚════════════════════════════════════════════════════════════╝

  ⚔️  Team activo: [nombre-del-team]
  👑 Lead: [nombre-del-lead]

  La propuesta ha sido forjada por el ejército completo.
  El Consejo no camina solo — sus guerreros han hablado.

  📋 Requirements: [N estimado] requisitos ([MUST: X · SHOULD: Y])
                   Inferidos de: [resumen del objetivo en 1 línea]

  🏗️  Design: [patrón arquitectónico] · [N] ADRs estimados
              Basado en: [stack principal detectado]

  📝 Tasks: [N estimado] tareas ([S/M/L estimados])
            Orden: [bloques del tipo de aventura elegido]
```

**Si `GANDALF_TEAM` NO está activo** (sin team, comportamiento por defecto):

Gandalf genera la propuesta de forma autónoma, sin cambios respecto al
comportamiento original.

Banner sin team:

```
╔════════════════════════════════════════════════════════════╗
║  ⚡ EL CONSEJO PRESENTA SU PROPUESTA ANTES DE LA FORJA     ║
╚════════════════════════════════════════════════════════════╝

  Basándose en el mapa Rohirrim y el objetivo definido,
  el Consejo anticipa lo que será forjado:

  📋 Requirements: [N estimado] requisitos ([MUST: X · SHOULD: Y])
                   Inferidos de: [resumen del objetivo en 1 línea]

  🏗️  Design: [patrón arquitectónico] · [N] ADRs estimados
              Basado en: [stack principal detectado]

  📝 Tasks: [N estimado] tareas ([S/M/L estimados])
            Orden: [bloques del tipo de aventura elegido]
```

AskUserQuestion:
```json
{
  "questions": [{
    "header": "Propuesta del Consejo",
    "question": "⚡ ¿Cómo procedemos con la forja de los pergaminos?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aceptar todo — forjar los 3 pergaminos sin interrupciones",
        "description": "Requirements → Design → Tasks de forma consecutiva"
      },
      {
        "label": "🔍 Revisar uno a uno — flujo guiado",
        "description": "Aprobar / modificar / saltar cada elemento en G5, G6 y G7"
      },
      {
        "label": "✏️ Ajustar la propuesta antes de continuar",
        "description": "Modificar estimaciones o prioridades"
      },
      {
        "label": "🔙 Volver al menú",
        "description": ""
      }
    ]
  }]
}
```

Guardar la elección como `GANDALF_MODE`:
- "✅ Aceptar todo" → `GANDALF_MODE=fast`
- "🔍 Revisar uno a uno" → `GANDALF_MODE=review`

---

## Transición

Si confirma:
→ Cargar `@prompts/gandalf/sections/04b-module-docs-fetch.md`

---

**Módulo**: `03-module-objective.md`
**Invocado desde**: `02-module-field-report.md`
**Propaga**: objetivo + tipo al contexto de G4b, G5, G6, G7
