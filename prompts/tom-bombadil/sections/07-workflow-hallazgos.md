# 🔨 Módulo 07 — Workflow Asistido Hallazgo a Hallazgo

## Propósito

Guiar al usuario a través de cada hallazgo individualmente, presentando una
ficha detallada y 4 opciones de acción (aplicar, saltar, modificar, salir).
Al terminar, mostrar el resumen final con el score actualizado.

---

## PASO 1 — Ordenar los hallazgos por severidad

Ordenar el array `HALLAZGOS` en orden descendente de severidad:

```
Orden: critico > alto > medio > info
```

En caso de empate (dos hallazgos con la misma severidad), mantener el
orden de recolección original (agentes → skills → MCPs → configs → TLOTP).

Registrar `TOTAL = len(HALLAZGOS)`.

---

## PASO 2 — Inicializar contadores

```
APLICADOS     = 0
SALTADOS      = 0
MODIFICADOS   = 0
ACTUAL        = 1   # índice 1-based
```

---

## PASO 3 — Loop por hallazgo

Para cada hallazgo `H` en el orden definido:

### 3.1 — Mostrar la ficha

```
══════════════════════════════════════════════════════════════
🌾 HALLAZGO {ACTUAL}/{TOTAL} — {EMOJI_SEVERIDAD} {SEVERIDAD_UPPER}
══════════════════════════════════════════════════════════════
📁 Fichero: {H.fichero}

🔍 PROBLEMA DETECTADO
   {H.descripcion}

💀 CASO DE USO MALICIOSO CONOCIDO
   {H.caso_uso_malicioso}

📌 FRAGMENTO SOSPECHOSO (líneas {H.linea_inicio}–{H.linea_fin})
   ┌─────────────────────────────────────────────────────────┐
   │ {H.fragmento}                                            │
   └─────────────────────────────────────────────────────────┘

💊 SOLUCIÓN PROPUESTA
   {H.solucion_propuesta}

══════════════════════════════════════════════════════════════
```

**Mapping de severidad a emoji y texto**:

| severidad | emoji | texto uppercase |
|-----------|-------|-----------------|
| critico   | 🔴    | CRÍTICO         |
| alto      | 🟠    | ALTO            |
| medio     | 🟡    | MEDIO           |
| info      | 🟢    | INFO            |

### 3.2 — Pregunta de acción

```json
{
  "questions": [{
    "header": "Tom Bombadil — Acción sobre hallazgo",
    "question": "🌾 ¿Qué hacemos con este hallazgo?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aplicar la solución propuesta",
        "description": "Tom ejecuta la solución que te ha mostrado"
      },
      {
        "label": "⏭️  Saltar",
        "description": "Dejar el fichero como está y pasar al siguiente hallazgo"
      },
      {
        "label": "✏️  Modificar antes de aplicar",
        "description": "Ajustar la solución antes de tocar el fichero"
      },
      {
        "label": "🚫 Salir del flujo",
        "description": "Abandonar. Los hallazgos restantes quedan sin revisar."
      }
    ]
  }]
}
```

### 3.3 — Ejecutar la acción elegida

#### ✅ Aplicar

- Usar **Edit** (o **Write** si el cambio es amplio) sobre `H.fichero`
  para implementar exactamente `H.solucion_propuesta`.
- Si la solución implica eliminar un fichero completo (ej: agente malicioso
  irrecuperable), confirmar adicionalmente con `AskUserQuestion` antes de
  ejecutar `rm` con Bash.
- `APLICADOS += 1`
- Mostrar:
  ```
  ✅ Aplicado. El fichero ha sido purificado.
  ```

#### ⏭️ Saltar

- No tocar el fichero.
- `SALTADOS += 1`
- Mostrar:
  ```
  ⏭️  Hallazgo saltado. El fichero queda intacto.
  ```

#### ✏️ Modificar

- Preguntar al usuario en formato libre: *"¿Cómo quieres ajustar la solución?"*
- Con su respuesta, componer una solución revisada.
- Mostrar la nueva solución propuesta con `AskUserQuestion` (✅ Aplicar /
  ⏭️ Saltar / 🚫 Salir). No volver a ofrecer "Modificar" para evitar bucles.
- Si aplica la solución revisada: `MODIFICADOS += 1`
- Si finalmente salta: `SALTADOS += 1`

#### 🚫 Salir

- Romper el loop inmediatamente.
- Los hallazgos no revisados no cuentan en ningún contador.
- Mostrar:
  ```
  🚫 Saliendo del flujo. Los hallazgos restantes quedan sin revisar.
  ```
- Continuar al PASO 4.

### 3.4 — Avanzar

`ACTUAL += 1`. Volver a 3.1 con el siguiente hallazgo hasta terminar
todos los hallazgos o haberse salido del flujo.

---

## PASO 4 — Recalcular el score final

Restar del `DEDUCCION` original los puntos que corresponden a los
hallazgos `APLICADOS` y `MODIFICADOS` (los `SALTADOS` y los no revisados
siguen restando).

Fórmula:

```
DEDUCCION_FINAL = DEDUCCION_INICIAL
  - (puntos de todos los APLICADOS + MODIFICADOS según su severidad)

SCORE_FINAL = max(0, min(100, 100 - DEDUCCION_FINAL))
```

---

## PASO 5 — Mostrar resumen final

```
══════════════════════════════════════════════════════════════
🌾 TOM BOMBADIL — MISIÓN COMPLETADA
══════════════════════════════════════════════════════════════

  PUNTUACIÓN INICIAL:  {SCORE_INICIAL} / 100
  PUNTUACIÓN FINAL:    {SCORE_FINAL} / 100  {EMOJI_FINAL}

  "{ESTADO_NARRATIVO_FINAL}"

──────────────────────────────────────────────────────────────
  ✅ Aplicados   ·  {APLICADOS}
  ⏭️ Saltados    ·  {SALTADOS}
  ✏️ Modificados ·  {MODIFICADOS}
──────────────────────────────────────────────────────────────
  "Buen trabajo, viajero. Tom Bombadillo descansa.
   Pero volverá a patrullar cuando lo necesites."
══════════════════════════════════════════════════════════════
```

Donde `{ESTADO_NARRATIVO_FINAL}` se obtiene aplicando la tabla del
módulo 06 al `SCORE_FINAL`, y `{EMOJI_FINAL}` es `✨` si
`SCORE_FINAL >= 90`, si no el emoji del rango correspondiente.

---

## PASO 6 — Sesión efímera: NO guardar informe

**No crear ningún fichero de informe**. Toda la información mostrada
queda solo en la sesión. El usuario que quiera conservarla puede
copiar la salida manualmente.

---

## PASO 7 — Volver al menú principal

Tras mostrar el resumen, devolver el control al loop continuo de
`tom-bombadil-main.md` (PASO 6), que ofrecerá:

- Volver al menú de escaneo
- Volver a La Comunidad del Código
- Salir de TLOTP

---

**Módulo**: `07-workflow-hallazgos.md`
**Invocado desde**: `tom-bombadil-main.md` (PASO 5) o desde `06-score-estado.md`
**Requiere**: Read, Edit, Write, Bash, AskUserQuestion
