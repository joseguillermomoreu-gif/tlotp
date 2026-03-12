# 🔍 Contemplar el Reino — Análisis de Configuración

## Flujo de ejecución

Este módulo ejecuta los siguientes pasos en orden:

---

## PASO 1: Leer y mapear toda la configuración

Ejecutar los dos módulos de lectura existentes:

1. `@prompts/palantir/sections/03-jerarquia-oficial.md` — leer jerarquía oficial (CLAUDE.md, rules/, auto memory) y obtener los 6 WebFetch de documentación oficial
2. `@prompts/palantir/sections/04-exploracion-custom.md` — explorar settings.json, skills/, hooks/ y otros ficheros adicionales

---

## PASO 2: Análisis inteligente

Con toda la información leída y la documentación oficial cargada, realizar el análisis cruzando ambas fuentes.

### 2.1 — Detectar conflictos y redundancias

Buscar:
- Reglas en CLAUDE.md global que contradigan reglas en CLAUDE.md de proyecto
- Rules en `rules/` que solapen o contradigan instrucciones en CLAUDE.md
- Hooks configurados que dupliquen comportamientos ya cubiertos por permisos o rules
- Instrucciones en CLAUDE.md que deberían ser skills (contenido muy largo o específico de un stack)
- Contenido en CLAUDE.md que pertenece a settings.json (configuración técnica, modelos, permisos)

### 2.2 — Verificar buenas prácticas

Verificar contra la documentación oficial:
- CLAUDE.md global: ¿supera 200 líneas? ¿es específico o demasiado genérico?
- Rules: ¿tienen frontmatter `paths:` correcto? ¿están activas para los paths adecuados?
- MEMORY.md: ¿supera 200 líneas? (solo se cargan las primeras 200)
- settings.json: ¿permisos demasiado permisivos o demasiado restrictivos?
- Hooks: ¿matchers correctos? ¿eventos apropiados para lo que hacen?
- ¿Hay features recomendadas por el stack que no están configuradas?

### 2.3 — Scoring 0-100

Calcular una puntuación basada en los criterios de la documentación oficial.
La puntuación NO es determinista (puede variar entre análisis) pero SIEMPRE se basa en:
- Cumplimiento de buenas prácticas oficiales
- Ausencia de conflictos
- Uso correcto de cada feature en su scope
- Organización y estructura de los ficheros

**Mostrar**:
```
📊 PUNTUACIÓN DE CONFIGURACIÓN: [X]/100

  ✅ Fortalezas detectadas: [lista breve]
  ⚠️  Áreas de mejora:      [lista breve]
```

---

## PASO 3: Mostrar sugerencias priorizadas

Si hay sugerencias, mostrarlas ordenadas por urgencia antes del menú de revisión.

**Formato**:
```
🔍 ANÁLISIS COMPLETADO — [X] sugerencias encontradas
══════════════════════════════════════════════════════

🔴 ALTA PRIORIDAD ([X])
  1. [descripción del problema]
  2. [descripción del problema]

🟡 MEDIA PRIORIDAD ([X])
  3. [descripción del problema]

🟢 BAJA PRIORIDAD ([X])
  4. [descripción del problema]

══════════════════════════════════════════════════════
```

Si no hay sugerencias:
```
✅ CONFIGURACIÓN IMPECABLE
   No se han encontrado mejoras aplicables. Puntuación: [X]/100
```

---

## PASO 4: Menú de revisión

**Usar AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Sugerencias",
    "question": "¿Cómo deseas proceder con las sugerencias?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔍 Revisar una a una",
        "description": "Revisar cada sugerencia con propuesta de solución"
      },
      {
        "label": "⏭️ Saltar todas",
        "description": "Ignorar sugerencias y volver al menú de Palantír"
      }
    ]
  }]
}
```

---

## PASO 5: Revisor uno a uno

Si el usuario elige "Revisar una a una", iterar por cada sugerencia con este flujo:

**Mostrar para cada sugerencia** (contador visible):

```
🔧 SUGERENCIA [X/N] — [🔴/🟡/🟢] [PRIORIDAD]
══════════════════════════════════════════════════════

📍 Ubicación:  [fichero afectado]
🌍 Scope:      [Global (~/.claude/) / Proyecto (.claude/)] — [justificación]

❌ Problema:
   [descripción clara del problema]

✅ Solución propuesta:
   [descripción de qué se haría exactamente]

   Destino sugerido: [ruta completa]
   Motivo: [por qué global o proyecto]

══════════════════════════════════════════════════════
```

**AskUserQuestion por cada sugerencia**:

```json
{
  "questions": [{
    "header": "Sugerencia [X/N]",
    "question": "¿Qué hacemos con esta sugerencia?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aplicar",
        "description": "Aplicar la solución propuesta"
      },
      {
        "label": "✏️ Modificar",
        "description": "Ajustar la solución antes de aplicar"
      },
      {
        "label": "🔄 Cambiar destino",
        "description": "Aplicar en global en lugar de proyecto o viceversa"
      },
      {
        "label": "⏭️ Saltar",
        "description": "Dejar esta sugerencia sin cambios"
      }
    ]
  }]
}
```

**Si elige "Modificar"**: Preguntar qué cambiar, confirmar y aplicar.
**Si elige "Cambiar destino"**: Mostrar las dos opciones (global/proyecto) con rutas, confirmar y aplicar.
**Si elige "Aplicar"**: Ejecutar el cambio, confirmar éxito y pasar a la siguiente.
**Si elige "Saltar"**: Pasar a la siguiente sugerencia.

**IMPORTANTE**: Antes de aplicar cualquier cambio, indicar siempre:
- Si afecta configuración **global** (`~/.claude/`) o **de proyecto** (`.claude/`)
- La ruta exacta del fichero que se modificará
- Si el cambio requiere crear un fichero nuevo o modificar uno existente

---

## PASO 6: Resumen final

Al terminar el revisor, mostrar:

```
📋 RESUMEN DE CAMBIOS
══════════════════════════════════════════════════════
  ✅ Aplicadas:  [X]
  ✏️  Modificadas: [X]
  ⏭️  Saltadas:   [X]
══════════════════════════════════════════════════════
```

Luego volver automáticamente al menú principal de Palantír.
