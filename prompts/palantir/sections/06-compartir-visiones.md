# 📤 Compartir Visiones entre Palantíri

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

Comprobar si la documentación oficial ya está en contexto de esta sesión.

**Si no está en contexto**, obtener en este orden:

> **WebFetch 1**: https://code.claude.com/docs/en/how-claude-code-works
> **Extraer**: arquitectura general, cómo se cargan los ficheros de configuración

> **WebFetch 2**: https://code.claude.com/docs/en/best-practices
> **Extraer**: criterios de buenas prácticas, qué va en cada fichero, límites

> **WebFetch 3**: https://code.claude.com/docs/en/memory
> **Extraer**: tipos de memoria, jerarquía de precedencia, rules con paths, @imports

> **WebFetch 4**: https://code.claude.com/docs/en/settings
> **Extraer**: jerarquía de settings, ubicaciones, permisos disponibles

> **WebFetch 5**: https://code.claude.com/docs/en/hooks
> **Extraer**: eventos, schema de configuración, tipos de hooks, matchers

> **WebFetch 6**: https://code.claude.com/docs/en/features-overview
> **Extraer**: cuándo usar cada feature, costes de contexto, qué va dónde

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

## OPCIÓN 2: Exportar visiones

### PASO 1: Seleccionar scope

**Usar AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Exportar",
    "question": "¿Qué configuraciones deseas exportar?",
    "multiSelect": false,
    "options": [
      {
        "label": "🏠 Solo local (.claude/)",
        "description": "Exportar únicamente la configuración del proyecto actual"
      },
      {
        "label": "🌍 Solo global (~/.claude/)",
        "description": "Exportar únicamente la configuración global del usuario"
      },
      {
        "label": "🌐 Local y global",
        "description": "Exportar toda la configuración disponible"
      }
    ]
  }]
}
```

---

### PASO 2: Leer configuración del scope elegido

Leer silenciosamente todos los ficheros relevantes según el scope:

- `CLAUDE.md` (global y/o proyecto según scope)
- `settings.json` (global y/o proyecto)
- `rules/*.md` (global y/o proyecto)
- Hooks definidos en settings.json
- `MEMORY.md` (solo 200 primeras líneas)

---

### PASO 3: Pedir path de destino

Mostrar:

```
📤 Exportación lista.

¿Dónde deseas guardar el fichero exportado?
Ejemplo: ~/tlotp-backup-2026-03-12.md

Path de destino:
```

Obtener input libre del usuario.

---

### PASO 4: Generar fichero exportado

Crear el fichero `.md` con la siguiente estructura:

```markdown
# 📤 Exportación de Configuración Claude Code
# Generado por Palantír — TLOTP
# Fecha: [fecha actual]
# Scope: [Local / Global / Local y Global]

---

## 📄 CLAUDE.md — [scope]
# Fichero: [ruta completa]

[contenido completo]

---

## ⚙️ settings.json — [scope]
# Fichero: [ruta completa]

[contenido completo]

---

## 📁 rules/ — [scope]
# Directorio: [ruta completa]

### [nombre-regla.md]
# Fichero: [ruta completa]
[contenido completo]

---

## 🪝 Hooks — [scope]
# Definidos en: [ruta settings.json]

[sección hooks extraída del settings.json]

---

## 🧠 MEMORY.md
# Fichero: [ruta completa]
# Nota: Solo se exportan las primeras 200 líneas (límite de carga de Claude Code)

[primeras 200 líneas]
```

Crear el fichero en la ruta indicada y confirmar con frase épica:
*"Las visiones han sido grabadas en piedra. El Palantír las guardará para la eternidad."*

Volver automáticamente al **menú principal de Compartir visiones**.

---

## OPCIÓN 3: Eliminar característica

### PASO 1: Seleccionar scope

**Usar AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Eliminar",
    "question": "¿Qué configuraciones deseas inspeccionar para eliminar?",
    "multiSelect": false,
    "options": [
      {
        "label": "🏠 Local (.claude/)",
        "description": "Ver solo configuraciones del proyecto actual"
      },
      {
        "label": "🌍 Global (~/.claude/)",
        "description": "Ver solo configuraciones globales del usuario"
      },
      {
        "label": "🌐 Mostrar todas",
        "description": "Ver todas las configuraciones disponibles (local y global)"
      }
    ]
  }]
}
```

---

### PASO 2: Construir lista numerada de características

Leer todos los ficheros del scope elegido y extraer cada característica individualmente (no por fichero). Mostrar en formato listado:

```
🗑️ CARACTERÍSTICAS DISPONIBLES
══════════════════════════════════════════════════════

   #   TIPO              FICHERO                      DESCRIPCIÓN
  ───────────────────────────────────────────────────────────────────
   1.  Instrucción       CLAUDE.md [global]           "No usar sudo directamente"
   2.  Instrucción       CLAUDE.md [global]           "Conventional Commits: type(scope)"
   3.  Rule (paths:*.ts) rules/typescript.md [global] "Strict typing en TypeScript"
   4.  Permiso           settings.json [global]       allowedTools: Bash
   5.  Hook              settings.json [global]       PostToolUse → git-commit-check.sh
   6.  Instrucción       CLAUDE.md [proyecto]         "Stack: PHP/Symfony hexagonal"
   ...

══════════════════════════════════════════════════════

Indica el número de la característica que deseas eliminar:
```

Obtener número del usuario.

---

### PASO 3: Cargar documentación oficial (condicional)

Si no está en contexto de esta sesión, obtener los 6 WebFetch en el mismo orden que en el módulo de Importar (PASO 2 de Importar).

---

### PASO 4: Análisis de eliminación

Con la característica seleccionada y la documentación oficial:

1. **¿Es seguro eliminarla?** — ¿Qué impacto tendría en el comportamiento de Claude?
2. **¿Está duplicada?** — ¿Existe otra regla/config que cubra lo mismo?
3. **¿Hay dependencias?** — ¿Algún otro ítem de la config depende de este?
4. **¿Alternativa posible?** — ¿Podría modificarse en lugar de eliminarse para mejor resultado?

Mostrar:

```
🔍 ANÁLISIS DE ELIMINACIÓN
══════════════════════════════════════════════════════

📍 Característica: [descripción]
📁 Fichero:        [ruta completa]

⚠️  Impacto de eliminar:
   [qué cambiaría en el comportamiento de Claude Code]

💡 Recomendación:
   [✅ Seguro eliminar / ⚠️ Eliminar con precaución / ❌ No recomendado]
   [justificación según docs oficiales]

══════════════════════════════════════════════════════
```

---

### PASO 5: Menú de decisión

**Usar AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Eliminar característica",
    "question": "¿Qué hacemos con esta característica?",
    "multiSelect": false,
    "options": [
      {
        "label": "🗑️ Eliminar",
        "description": "Borrar definitivamente esta característica"
      },
      {
        "label": "✏️ Proponer alternativa",
        "description": "Claude sugerirá una modificación en lugar de eliminar"
      },
      {
        "label": "🚫 Cancelar",
        "description": "No tocar nada y volver al menú"
      }
    ]
  }]
}
```

**Si elige Eliminar**: aplicar, confirmar con frase épica breve, volver al menú de Compartir visiones

**Si elige Proponer alternativa**:
- Mostrar propuesta de modificación en lugar de eliminación
- AskUserQuestion: `✅ Aplicar alternativa` / `🗑️ Eliminar igualmente` / `🚫 Cancelar`
- Aplicar según elección

**Si elige Cancelar**: `🔮 Palantír retuvo esta visión.` — volver al menú de Compartir visiones

---

## OPCIÓN 4: Volver al menú de Palantír

Volver a `@prompts/palantir/sections/00-menu-principal.md` (PASO 2).
