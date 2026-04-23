# 📊 Módulo 06 — Score y Estado del Reino

## Propósito

Calcular la puntuación de seguridad (0–100) a partir de todos los hallazgos
recolectados por los scanners, determinar el estado narrativo LOTR y presentar
el veredicto al usuario antes de iniciar el flujo asistido.

---

## PASO 1 — Unificar hallazgos

Combinar todos los arrays producidos por los scanners ejecutados:

```
HALLAZGOS = AGENTES_HALLAZGOS
         + SKILLS_HALLAZGOS
         + MCPS_HALLAZGOS
         + CONFIGS_HALLAZGOS
         + TLOTP_HALLAZGOS     (si se ejecutó el auto-análisis)
```

Contar hallazgos por severidad:

- `N_CRITICOS`  = cuantos con `severidad: "critico"`
- `N_ALTOS`     = cuantos con `severidad: "alto"`
- `N_MEDIOS`    = cuantos con `severidad: "medio"`
- `N_INFO`      = cuantos con `severidad: "info"`

---

## PASO 2 — Calcular el score

Aplicar la fórmula:

```
DEDUCCION = (N_CRITICOS × 25) + (N_ALTOS × 15) + (N_MEDIOS × 5) + (N_INFO × 1)

SCORE = max(0, 100 - DEDUCCION)
```

**Notas**:
- El score **nunca** baja de 0 (aunque la deducción teórica fuera 500+)
- El score es entero
- Si no hay ningún hallazgo (reino limpio), `SCORE = 100`

---

## PASO 3 — Determinar el estado narrativo

Mapear el `SCORE` al estado correspondiente:

| Rango     | Estado narrativo                                                             |
|-----------|------------------------------------------------------------------------------|
| `90–100`  | *"El Bosque Antiguo está en paz. El Anillo duerme."*                         |
| `70–89`   | *"Hay murmullos en los matorrales. Permanece alerta."*                       |
| `50–69`   | *"Sombras se agitan en el este. Tom huele el peligro."*                      |
| `25–49`   | *"Mordor llama a tus puertas. El reino está en riesgo."*                     |
| `0–24`    | *"El Ojo de Sauron te observa. Acción inmediata necesaria."*                 |

Mapear también el estado a un emoji de alerta:

| Rango     | Emoji |
|-----------|-------|
| `90–100`  | 🟢    |
| `70–89`   | 🟡    |
| `50–69`   | 🟡    |
| `25–49`   | 🟠    |
| `0–24`    | 🔴    |

---

## PASO 4 — Presentar el veredicto

Mostrar el siguiente banner, reemplazando los placeholders con los valores
reales calculados:

```
══════════════════════════════════════════════════════════════
🌾 EL VEREDICTO DE TOM BOMBADIL
══════════════════════════════════════════════════════════════

  PUNTUACIÓN DE SEGURIDAD: {SCORE} / 100

  {EMOJI_ESTADO} "{ESTADO_NARRATIVO}"

──────────────────────────────────────────────────────────────
  🔴 Críticos  ·  {N_CRITICOS}   (-25 c/u = -{N_CRITICOS * 25})
  🟠 Altos     ·  {N_ALTOS}      (-15 c/u = -{N_ALTOS * 15})
  🟡 Medios    ·  {N_MEDIOS}     (-5 c/u = -{N_MEDIOS * 5})
  🟢 Info      ·  {N_INFO}       (-1 c/u = -{N_INFO * 1})
──────────────────────────────────────────────────────────────
  Total de hallazgos: {TOTAL}
  Tom te guiará uno a uno. ¿Comenzamos?
══════════════════════════════════════════════════════════════
```

**Omisión condicional**: si una categoría tiene 0 hallazgos, puede omitirse
la línea correspondiente para limpiar la salida.

Si el total es 0:

```
══════════════════════════════════════════════════════════════
🌾 EL VEREDICTO DE TOM BOMBADIL
══════════════════════════════════════════════════════════════

  PUNTUACIÓN DE SEGURIDAD: 100 / 100   ✨

  🟢 "El Bosque Antiguo está en paz. El Anillo duerme."

──────────────────────────────────────────────────────────────
  No se ha detectado ningún comportamiento sospechoso.
  Tom Bombadillo se retira a su casa, complacido.
══════════════════════════════════════════════════════════════
```

En este caso, saltar directamente al loop del `tom-bombadil-main.md`
(volver al menú de escaneo), sin pasar por el módulo 07.

---

## PASO 5 — Pregunta para iniciar el flujo asistido

Si hay al menos un hallazgo, preguntar con `AskUserQuestion`:

```json
{
  "questions": [{
    "header": "Tom Bombadil — ¿Comenzamos a purificar?",
    "question": "🌾 Tom ha reunido los hallazgos. ¿Quieres revisarlos uno a uno?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Sí, Tom me guía hallazgo a hallazgo",
        "description": "Flujo asistido con 4 opciones por cada hallazgo"
      },
      {
        "label": "⏭️  Ahora no, volver al menú",
        "description": "Dejar el reino como está y volver al menú principal"
      }
    ]
  }]
}
```

- Si elige **Sí**: continuar con el módulo `07-workflow-hallazgos.md`.
- Si elige **Ahora no**: volver al menú principal de Tom Bombadil.

---

## Guardar el score inicial

Registrar `SCORE_INICIAL = SCORE` para usarlo en el resumen final del
módulo 07.

---

**Módulo**: `06-score-estado.md`
**Invocado desde**: `tom-bombadil-main.md` (PASO 4)
**Siguiente**: `07-workflow-hallazgos.md` (si el usuario acepta purificar)
