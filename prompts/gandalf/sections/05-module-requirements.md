# 📋 Módulo G5 — Requirements.md — Editor EARS

## Misión

Crear `requirements.md` en formato EARS de forma interactiva.
Los requisitos se infieren del contexto Rohirrim + objetivo G3.
El usuario revisa, modifica y aprueba uno a uno.

---

## Paso 0 — El formato EARS

Mostrar brevemente antes de empezar:

```
⚡ "Los pergaminos deben ser precisos.
   Gandalf usa el formato EARS para que cada requisito
   sea inambiguo, verificable y trazable."

EARS — Easy Approach to Requirements Syntax:

  UBIQUITOUS:   THE SYSTEM SHALL [acción]
  EVENT-DRIVEN: WHEN [disparador] THE SYSTEM SHALL [acción]
  UNWANTED:     IF [condición no deseada] THEN THE SYSTEM SHALL [acción]
  OPTION:       WHERE [feature opcional] THE SYSTEM SHALL [acción]
  COMPLEX:      WHILE [estado] WHEN [disparador] THE SYSTEM SHALL [acción]
```

---

## Paso 1 — Inferir requisitos automáticamente

A partir del `contexto_rohirrim` + objetivo G3, inferir automáticamente
entre 3 y 5 requisitos funcionales relevantes para la aventura descrita.

**Criterios de inferencia según tipo de aventura** (del G3):
- **Nueva feature**: requisitos de la funcionalidad descrita + integraciones detectadas
- **Greenfield**: requisitos de producto + autenticación/seguridad básica
- **Refactoring**: requisitos de comportamiento preservado + criterios de refactoring
- **Spike**: hipótesis técnicas a validar + criterios de éxito del spike

---

## Paso 2 — Revisión uno a uno

Aplicar el patrón estándar de TLOTP (`Ítem X/N`):

```
══════════════════════════════════════════════════════════════
📋 REQUISITO [X/N]
══════════════════════════════════════════════════════════════

  🏷️  Tipo:       [UBIQUITOUS / EVENT-DRIVEN / UNWANTED / ...]
  📌 Prioridad:  [MUST / SHOULD / COULD]

  [WHEN el usuario envíe el formulario de registro]
  [THE SYSTEM SHALL validar el email, crear la cuenta y enviar
   un correo de confirmación en menos de 2 segundos]

══════════════════════════════════════════════════════════════
```

AskUserQuestion:

```json
{
  "questions": [{
    "header": "Requisito X/N",
    "question": "⚡ ¿Aceptamos este requisito?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aceptar — pasar al siguiente",
        "description": ""
      },
      {
        "label": "✏️  Modificar — ajustar antes de aceptar",
        "description": ""
      },
      {
        "label": "⏭️  Saltar — no incluir este requisito",
        "description": ""
      },
      {
        "label": "🚫 Cancelar todo",
        "description": "Volver al menú sin guardar"
      }
    ]
  }]
}
```

---

## Paso 3 — Añadir requisitos nuevos

Tras revisar los inferidos, preguntar:

```json
{
  "questions": [{
    "header": "Requisitos adicionales",
    "question": "⚡ ¿Quieres añadir más requisitos?",
    "multiSelect": false,
    "options": [
      {
        "label": "✍️  Añadir un requisito nuevo",
        "description": ""
      },
      {
        "label": "✅ No, los requisitos son suficientes",
        "description": "Continuar al preview del fichero"
      },
      {
        "label": "🔙 Volver a revisar los anteriores",
        "description": ""
      }
    ]
  }]
}
```

Repetir este paso en bucle hasta que el usuario confirme que son suficientes.

---

## Paso 4 — Requisitos No Funcionales

Añadir siempre una sección de Requisitos No Funcionales (RNF) con al menos:
- Performance (si hay datos del stack que lo impliquen)
- Seguridad (siempre presente — inferir del stack Rohirrim)
- Mantenibilidad (siempre presente)

---

## Paso 5 — Preview completo

Mostrar el fichero completo antes de escribir:

```
══════════════════════════════════════════════════════════════
📋 PREVIEW — requirements.md
══════════════════════════════════════════════════════════════
[contenido completo del fichero]
══════════════════════════════════════════════════════════════
```

AskUserQuestion:
- ✅ Guardar fichero → continuar a G6
- ✏️ Ajustar algo → volver a la revisión
- 🔙 Volver al menú sin guardar

---

## Paso 6 — Escribir fichero

Usar Write para crear el fichero. Si ya existe, preguntar:
- ✅ Sobrescribir
- ⏭️ Crear como requirements-v2.md
- 🚫 Cancelar

**Ruta por defecto**: `docs/requirements.md`
Si no existe carpeta `docs/`: crear en la raíz o donde el usuario prefiera.

---

## Lore al guardar

```
══════════════════════════════════════════════════════════════
📜 EL PERGAMINO DE LOS DESEOS HA SIDO INSCRITO
══════════════════════════════════════════════════════════════

  ⚡ Gandalf sella el pergamino con su bastón blanco:
     "Los requisitos son la brújula de La Comunidad."

  🥔 Sam: "¡El señor Frodo no irá solo sin saber adónde va!"
     → [N] requisitos funcionales aseguran el camino.

  📄 Fichero: [ruta]/requirements.md
  📊 Total:   [N] requisitos ([MUST: X · SHOULD: Y · COULD: Z])

══════════════════════════════════════════════════════════════
```

---

## Transición

→ Cargar `@prompts/gandalf/sections/06-module-design.md`

---

**Módulo**: `05-module-requirements.md`
**Invocado desde**: `03-module-objective.md` / `04-module-continue.md`
**Requiere**: Write, contexto_rohirrim, objetivo G3
