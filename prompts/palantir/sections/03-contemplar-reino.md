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

## PASO 4: Menú post-análisis

Tras mostrar el scoring y las sugerencias priorizadas, **usar AskUserQuestion**:

```json
{
  "questions": [{
    "header": "¿Qué hacemos?",
    "question": "El análisis ha concluido. ¿Cómo deseas continuar?",
    "multiSelect": false,
    "options": [
      {
        "label": "⚔️ Aplicar mejoras",
        "description": "Revisaremos cada mejora una a una — confirmarás antes de aplicar cualquier cambio"
      },
      {
        "label": "🔙 Volver al menú de Palantír",
        "description": "Volver sin aplicar cambios"
      },
      {
        "label": "🚪 Salir",
        "description": "Cerrar Palantír y TLOTP"
      }
    ]
  }]
}
```

---

## PASO 5: Revisor uno a uno (si elige "Aplicar mejoras")

Iterar por cada sugerencia **en orden de prioridad** (🔴 primero, luego 🟡, luego 🟢).

**Mostrar para cada sugerencia** (contador visible):

```
🔮 Palantír muestra la mejora #[X]...

⚔️ MEJORA [X/N] — [🔴/🟡/🟢] [PRIORIDAD]
══════════════════════════════════════════════════════

📍 Fichero afectado: [ruta completa]
🌍 Scope sugerido:   [Global (~/.claude/) / Proyecto (.claude/)]
   Motivo: [justificación clara de por qué global o proyecto]

❌ Problema:
   [descripción clara del problema detectado]

✅ Solución propuesta:
   [descripción exacta de qué se aplicaría]

🎯 Resultado esperado:
   [qué mejorará o se corregirá tras aplicar]

══════════════════════════════════════════════════════
```

**AskUserQuestion por cada sugerencia**:

```json
{
  "questions": [{
    "header": "Mejora [X/N]",
    "question": "¿Qué hacemos con esta mejora?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aplicar",
        "description": "Aplicar la solución propuesta en el scope sugerido"
      },
      {
        "label": "✏️ Modificar propuesta",
        "description": "Ajustar la solución o cambiar el scope antes de aplicar"
      },
      {
        "label": "🔎 Buscar alternativa en docs",
        "description": "Razonar sobre la documentación ya cargada para proponer otra solución"
      },
      {
        "label": "⏭️ Saltar",
        "description": "Dejar esta mejora sin cambios y pasar a la siguiente"
      }
    ]
  }]
}
```

**Comportamiento por opción**:

- **Aplicar**: Ejecutar el cambio, confirmar éxito y mostrar una frase de lore variada, por ejemplo:
  - *"Desde el Palantír, el reino se ve más seguro."*
  - *"El reino gana poder. Palantír lo confirma."*
  - *"Saruman aprobaría esta mejora."*
  - *(Variar la frase según la mejora aplicada — que sea breve y épica)*
  - Luego pasar a la siguiente.
- **Modificar propuesta**: Preguntar qué cambiar (scope, contenido, formato). Mostrar propuesta actualizada y confirmar antes de aplicar.
- **Buscar alternativa en docs**: **NO re-fetchear** — releer y razonar explícitamente sobre la documentación oficial ya cargada en contexto (WebFetch 1-6 del PASO 1). Proponer una solución alternativa al mismo problema y volver a preguntar.
- **Saltar**: Mostrar `🔮 Palantír ignoró esto por el momento.` y pasar a la siguiente sugerencia.

**IMPORTANTE**: Antes de aplicar cualquier cambio, indicar siempre:
- Si afecta configuración **global** (`~/.claude/`) o **de proyecto** (`.claude/`)
- La ruta exacta del fichero que se modificará
- Si el cambio crea un fichero nuevo o modifica uno existente

---

## PASO 6: Resumen final

Al terminar el revisor (o si no hay sugerencias), mostrar:

```
📋 RESUMEN DE CAMBIOS
══════════════════════════════════════════════════════
  ✅ Aplicadas:   [X]
  ✏️  Modificadas: [X]
  ⏭️  Saltadas:    [X]
══════════════════════════════════════════════════════
```

**AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Finalizar",
    "question": "Análisis completado. ¿Qué deseas hacer?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔙 Volver al menú de Palantír",
        "description": "Continuar con otras opciones de Palantír"
      },
      {
        "label": "🏠 Volver al menú de TLOTP",
        "description": "Volver al menú principal de TLOTP"
      },
      {
        "label": "🚪 Salir",
        "description": "Cerrar Palantír y TLOTP"
      }
    ]
  }]
}
```
