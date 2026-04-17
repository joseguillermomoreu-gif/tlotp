# 📥 Importar Visiones — Compartir Visiones entre Palantíri

> **IMPORTADO POR**: `palantir-main.md`
>
> Opción 1 del módulo Compartir Visiones: importar configuraciones
> desde un fichero o texto pegado (6 pasos).

---

## Menú principal

**Usar AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Compartir Visiones",
    "question": "¿Qué deseas hacer con las visiones del Palantír?",
    "multiSelect": false,
    "options": [
      {
        "label": "📥 Importar visiones",
        "description": "Cargar configuraciones desde un fichero o texto pegado"
      },
      {
        "label": "📤 Exportar visiones",
        "description": "Volcar toda tu configuración actual a un fichero .md portable"
      },
      {
        "label": "🗑️ Eliminar característica",
        "description": "Borrar una configuración existente con análisis previo"
      },
      {
        "label": "🔙 Volver al menú de Palantír",
        "description": ""
      }
    ]
  }]
}
```

---

## OPCIÓN 1: Importar visiones

### PASO 1: Obtener contenido a importar

**Usar AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Importar",
    "question": "¿Cómo quieres proporcionar el contenido a importar?",
    "multiSelect": false,
    "options": [
      {
        "label": "📂 Proporcionar ruta de fichero",
        "description": "Indica la ruta absoluta al fichero .md exportado"
      },
      {
        "label": "📝 Pegar contenido directamente",
        "description": "Escribe o pega el contenido del exportado en el chat"
      }
    ]
  }]
}
```

- Si elige ruta: pedir la ruta y leer el fichero con Read tool
- Si elige pegar: indicar `Pega el contenido ahora:` y esperar input libre

---

### PASO 2: Cargar documentación oficial (condicional)

@prompts/palantir/sections/00-docs-official.md

---

### PASO 3: Análisis del contenido importado

Con el contenido obtenido y la documentación oficial, analizar:

1. **Validez estructural**: ¿El formato es reconocible como configuración de Claude Code?
2. **Extracción de características**: Identificar cada característica individual (regla, permiso, hook, instrucción...) — NO por fichero, sino por ítem
3. **Conflictos**: ¿Alguna característica contradice o duplica algo ya en la config actual?
4. **Mejoras**: ¿Alguna característica podría expresarse mejor según las docs oficiales?
5. **Errores**: ¿Algo claramente incorrecto, peligroso o mal formado?

Mostrar resumen del análisis:

```
📊 ANÁLISIS DE IMPORTACIÓN
══════════════════════════════════════════════════════

  📦 Características encontradas: [N]
  ✅ Válidas sin conflicto:       [N]
  ⚠️  Con conflicto o mejora:     [N]
  ❌ Errores o formatos inválidos: [N]

══════════════════════════════════════════════════════
```

---

### PASO 4: Menú de acción

**Si hay conflictos, mejoras o errores** (AskUserQuestion con 4 opciones):

```json
{
  "questions": [{
    "header": "Acción",
    "question": "¿Cómo deseas proceder con la importación?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aplicar todas de golpe",
        "description": "Importar todo tal cual — sobreescribe configuraciones existentes"
      },
      {
        "label": "🛡️ Una a una (modo seguro)",
        "description": "Revisar e importar característica a característica con confirmación"
      },
      {
        "label": "✨ Mejorar importación",
        "description": "Ver y aplicar mejoras sobre el contenido antes de importar"
      },
      {
        "label": "🚫 Cancelar",
        "description": "Volver al menú principal sin importar nada"
      }
    ]
  }]
}
```

**Si no hay conflictos ni mejoras** (AskUserQuestion con 3 opciones):

```json
{
  "questions": [{
    "header": "Acción",
    "question": "¿Cómo deseas proceder con la importación?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aplicar todas de golpe",
        "description": "Importar todo tal cual — sobreescribe configuraciones existentes"
      },
      {
        "label": "🛡️ Una a una (modo seguro)",
        "description": "Revisar e importar característica a característica con confirmación"
      },
      {
        "label": "🚫 Cancelar",
        "description": "Volver al menú principal sin importar nada"
      }
    ]
  }]
}
```

---

### PASO 5a: Mejorar importación

Mostrar los cambios propuestos sobre el contenido a importar:

```
✨ MEJORAS PROPUESTAS SOBRE LA IMPORTACIÓN
══════════════════════════════════════════════════════

[Para cada mejora/corrección detectada:]

  #[N] [tipo: CORRECCIÓN / MEJORA / CONFLICTO]
  ─────────────────────────────────────────────
  Característica: [descripción]
  Problema:       [qué está mal o puede mejorarse]
  Cambio:         [qué se modificaría en el contenido]

══════════════════════════════════════════════════════
```

**AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Mejorar importación",
    "question": "¿Aplicamos estas mejoras al contenido antes de importar?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aplicar mejoras y continuar",
        "description": "Actualizar el contenido con las mejoras y volver al menú de acción"
      },
      {
        "label": "🚫 Cancelar",
        "description": "Volver al menú principal sin importar nada"
      }
    ]
  }]
}
```

- Si acepta: aplicar mejoras sobre el contenido en memoria y **volver al PASO 4** con el contenido mejorado

---

### PASO 5b: Una a una (modo seguro)

Iterar por cada característica extraída en orden. Para cada una:

```
🔮 Palantír examina la característica #[X]...

📥 IMPORTACIÓN [X/N]
══════════════════════════════════════════════════════

📦 Característica:  [descripción clara del ítem]
📁 Tipo:            [instrucción CLAUDE.md / rule / hook / settings / memoria]

🌍 Scope sugerido:  [Global (~/.claude/) / Proyecto (.claude/)]
   Motivo: [justificación según docs oficiales y config actual]

📍 Ubicación:       [ruta exacta del fichero donde se añadiría]

⚠️  Impacto detectado:
   [conflictos, solapamientos o "Ninguno detectado"]

══════════════════════════════════════════════════════
```

**AskUserQuestion por cada característica**:

```json
{
  "questions": [{
    "header": "Importación [X/N]",
    "question": "¿Qué hacemos con esta característica?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aplicar en scope sugerido",
        "description": "Importar en la ubicación recomendada"
      },
      {
        "label": "🔄 Cambiar scope",
        "description": "Aplicar en global en lugar de proyecto o viceversa"
      },
      {
        "label": "⏭️ Saltar",
        "description": "Dejar esta característica sin importar"
      },
      {
        "label": "🚫 Cancelar todo",
        "description": "Abortar la importación completa"
      }
    ]
  }]
}
```

- **Aplicar**: importar en la ubicación sugerida, mostrar frase de lore breve, pasar a la siguiente
- **Cambiar scope**: preguntar a cuál cambiar, actualizar propuesta y aplicar
- **Saltar**: `🔮 Palantír ignoró esta visión por el momento.` — siguiente
- **Cancelar todo**: mostrar resumen parcial y volver al menú principal

---

### PASO 5c: Aplicar todas de golpe

Aplicar todas las características en sus ubicaciones naturales (según análisis de docs y config actual), sobreescribiendo lo existente si hay conflicto.

Mostrar progreso y confirmar con frase épica al terminar.

---

### PASO 6: Resumen de importación

```
📋 RESUMEN DE IMPORTACIÓN
══════════════════════════════════════════════════════
  ✅ Importadas:  [N]
  ⏭️  Saltadas:   [N]
  ❌ Errores:     [N]
══════════════════════════════════════════════════════
```

Volver automáticamente al **menú principal de Compartir visiones**.

---

*Importar Visiones — Palantír Módulo 06a v1.0*
