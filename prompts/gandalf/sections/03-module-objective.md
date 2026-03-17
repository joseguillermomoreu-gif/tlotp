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

## Transición

Si confirma:
→ Cargar `@prompts/gandalf/sections/05-module-requirements.md`

---

**Módulo**: `03-module-objective.md`
**Invocado desde**: `02-module-field-report.md`
**Propaga**: objetivo + tipo al contexto de G5, G6, G7
