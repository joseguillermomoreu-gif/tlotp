# 🔄 Módulo: Actualizar Skills

## Misión

Actualizar skills instaladas a sus últimas versiones usando `npx skills update`.

---

## Paso 0 — Verificación pre-menú (automática)

Este paso se ejecuta silenciosamente **antes de mostrar el menú principal**, al arrancar Celebrimbor.

```bash
npx skills check
```

**Si hay updates disponibles**, mostrar aviso en el menú:
```
⚠️  Hay skills con actualizaciones disponibles → Opción 3
    • playwright-pom (v1.2.0 → v1.3.0)
    • typescript-utils (v2.1.0 → v2.2.0)
```

**Si todo está actualizado**: no mostrar nada (silencioso).

---

## Paso 1 — Verificar updates disponibles

Al seleccionar la opción "Actualizar skills", ejecutar de nuevo:

```bash
npx skills check
```

**Si hay updates:**
```
══════════════════════════════════════════════════════════════
🔄 Actualizaciones disponibles (2)
══════════════════════════════════════════════════════════════

  1. playwright-pom   v1.2.0 → v1.3.0
  2. typescript-utils v2.1.0 → v2.2.0

══════════════════════════════════════════════════════════════
```

**Si no hay updates:**
```
✅ Todas las skills están actualizadas. No hay nada que actualizar.
```
→ Ofrecer volver al menú.

---

## Paso 2 — Advertencia y confirmación

Mostrar resumen de lo que se actualizará:

```
⚠️  npx skills update actualiza TODAS las skills instaladas.
    No es posible actualizar de forma selectiva con el CLI.

Skills que se procesarán:
  ↑ playwright-pom   (v1.2.0 → v1.3.0)
  ↑ typescript-utils (v2.1.0 → v2.2.0)
  · other-skill      (sin cambios)
```

Mostrar con `AskUserQuestion`:

```json
{
  "questions": [{
    "header": "Confirmar actualización",
    "question": "¿Confirmas la actualización de todas las skills?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Sí, actualizar todas",
        "description": "npx skills update se ejecutará ahora"
      },
      {
        "label": "🚫 Cancelar",
        "description": "Volver sin actualizar"
      }
    ]
  }]
}
```

---

## Paso 3 — Ejecutar actualización

```bash
npx skills update
```

Mostrar output en tiempo real mientras se ejecuta.

---

## Paso 4 — Mostrar resultado

```
══════════════════════════════════════════════════════════════
✅ Actualización completada
══════════════════════════════════════════════════════════════

  ✓ playwright-pom   → v1.3.0
  ✓ typescript-utils → v2.2.0
  · other-skill        sin cambios

💡 Recarga Claude Code para aplicar los cambios.

══════════════════════════════════════════════════════════════
```

---

## Paso 5 — Acciones posteriores

Mostrar con `AskUserQuestion`:

```json
{
  "questions": [{
    "header": "Actualización completada",
    "question": "¿Qué deseas hacer ahora?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔍 Buscar e instalar más skills",
        "description": ""
      },
      {
        "label": "🔙 Volver al menú principal",
        "description": ""
      }
    ]
  }]
}
```

---

## Manejo de errores

### Error de red
```
⚠️ No se pudo conectar para descargar updates.
   Verifica tu conexión e inténtalo de nuevo.
```

### Sin permisos
```
❌ Sin permisos para actualizar skills.
   Solución: chown -R $USER ~/.claude/skills/
```

### Actualización parcial
```
⚠️ Actualización parcial: X actualizadas, Y fallaron.

Fallaron:
  ✗ typescript-utils (archivo corrupto)

Solución sugerida: eliminar y reinstalar la skill fallida.
```
→ Ofrecer ir a eliminar + reinstalar.

---

**Módulo**: `11-module-update.md`
**Invocado desde**: `02-menu-principal.md` (Opción 3)
**Pre-menú**: Paso 0 ejecutado automáticamente al arrancar Celebrimbor
**Usa**: `npx skills check`, `npx skills update`
