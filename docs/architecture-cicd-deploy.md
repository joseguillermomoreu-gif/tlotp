# 🏗️ TLOTP - CI/CD, Deploy y Paginación

> CI/CD, deploy, GitHub rulesets y patrones de UI.
> Documento complementario a [ARCHITECTURE.md](../ARCHITECTURE.md).

---

## 🔄 Patrón de Pre-carga de Módulos

### Definición

Antes de mostrar cualquier contenido al usuario (incluyendo banners, menús o cualquier texto), todos los `@imports` referenciados en el archivo deben ser resueltos y cargados en memoria **en su totalidad**.

### Objetivo

Garantizar que el usuario vea el prompt completo en un único bloque de salida, sin cargas incrementales visibles ni interrupciones durante la ejecución inicial.

### Instrucción de Pre-carga Estándar

La siguiente instrucción debe incluirse en **TODOS** los archivos `*-main.md`, **ANTES** de la sección "Inicio de Ejecución" o equivalente:

```markdown
**PRE-CARGA OBLIGATORIA**: Antes de mostrar cualquier contenido al usuario, resolver
todos los @imports referenciados en este fichero. Cargar todos los módulos en memoria
completa antes de renderizar el banner o mostrar cualquier texto. El usuario debe ver
el prompt completo en un único bloque de salida, sin cargas incrementales visibles.
```

### Ubicación Exacta en el Flujo

En un `*-main.md`, la estructura debe ser:

```markdown
# 🎯 [Nombre Épica] v[VERSION]

[Descripción breve del prompt]

## 📚 Carga de Módulos

@prompts/[nombre]/sections/01-[concern].md
@prompts/[nombre]/sections/02-[concern].md
[... más imports ...]

**PRE-CARGA OBLIGATORIA**: Antes de mostrar cualquier contenido al usuario, resolver
todos los @imports referenciados en este fichero. Cargar todos los módulos en memoria
completa antes de renderizar el banner o mostrar cualquier texto. El usuario debe ver
el prompt completo en un único bloque de salida, sin cargas incrementales visibles.

## ✨ Inicio de Ejecución

[El contenido del prompt comienza aquí...]
```

### Beneficios

- ✅ **UX mejorada**: Sin distracciones de carga visible
- ✅ **Fiabilidad**: Todos los módulos garantizados antes de ejecución
- ✅ **Claridad**: Instrucción explícita y estándar
- ✅ **Mantenibilidad**: Patrón consistente en todas las épicas

---

## 📄 Patrón de Paginación 3+1+Navegación

### Definición

Patrón estándar para presentar múltiples opciones cuando `AskUserQuestion` no puede mostrar todas simultáneamente (limitado a 4 opciones máximo).

### Estructura Base: 3 Contenido + 1 Navegación

Cuando hay más opciones de contenido que pueden caber en una página:
- **Páginas intermedias**: Mostrar 3 opciones de contenido + 1 botón "➕ Ver más..."
- **Última página**: Mostrar 3 opciones de contenido + 1 botón de navegación (típicamente "🔙 Volver a página 1")

### ADR-01: Limitación de Opciones

`AskUserQuestion` en Claude Code acepta máximo **4 opciones** por pregunta. Para manejar más opciones:

1. **Páginas intermedias** (opciones 1-N): 3 opciones de contenido + 1 navegación
2. **Última página** (opciones totales): Puede ser:
   - **Variante A** (contenido prevalente): 3 opciones de contenido + 1 navegación principal
   - **Variante B** (navegación exhaustiva): 0 opciones de contenido + 4 opciones de navegación

### JSON Estándar — Páginas Intermedias

```json
{
  "questions": [{
    "header": "[Nombre Épica] ([Página Actual]/[Total Páginas])",
    "question": "¿Qué quieres hacer?",
    "multiSelect": false,
    "options": [
      { "label": "[Opción 1 de contenido]", "description": "" },
      { "label": "[Opción 2 de contenido]", "description": "" },
      { "label": "[Opción 3 de contenido]", "description": "" },
      { "label": "➕ Ver más...", "description": "" }
    ]
  }]
}
```

**Ejemplo real**:
```json
{
  "questions": [{
    "header": "🌳 Ents (1/3)",
    "question": "¿Qué quieres hacer?",
    "multiSelect": false,
    "options": [
      { "label": "🔍 Inspeccionar workflows", "description": "" },
      { "label": "📝 Crear workflow", "description": "" },
      { "label": "✏️ Editar workflow", "description": "" },
      { "label": "➕ Ver más...", "description": "" }
    ]
  }]
}
```

### JSON Estándar — Última Página (Variante A: Contenido Prevalente)

Cuando hay pocas opciones de contenido pendientes y la navegación es secundaria:

```json
{
  "questions": [{
    "header": "[Nombre Épica] ([Total]/[Total])",
    "question": "¿Qué quieres hacer?",
    "multiSelect": false,
    "options": [
      { "label": "[Opción 1 de contenido]", "description": "" },
      { "label": "[Opción 2 de contenido]", "description": "" },
      { "label": "[Opción 3 de contenido]", "description": "" },
      { "label": "🔙 Volver a página 1", "description": "" }
    ]
  }]
}
```

**Ejemplo real**:
```json
{
  "questions": [{
    "header": "🌳 Ents (3/3)",
    "question": "¿Qué quieres hacer?",
    "multiSelect": false,
    "options": [
      { "label": "🗑️ Borrar workflow", "description": "" },
      { "label": "📊 Ver estadísticas", "description": "" },
      { "label": "🔐 Gestionar secretos", "description": "" },
      { "label": "🔙 Volver a página 1", "description": "" }
    ]
  }]
}
```

### JSON Estándar — Última Página (Variante B: Navegación Exhaustiva)

Cuando se priorizan opciones de navegación sobre contenido remanente:

```json
{
  "questions": [{
    "header": "[Nombre Épica] ([Total]/[Total])",
    "question": "¿Qué quieres hacer?",
    "multiSelect": false,
    "options": [
      { "label": "🔙 Volver a página 1", "description": "" },
      { "label": "🔙 Volver al menú anterior", "description": "" },
      { "label": "🏠 Volver al menú principal de TLOTP", "description": "" },
      { "label": "🚪 Salir", "description": "" }
    ]
  }]
}
```

**Ejemplo real**:
```json
{
  "questions": [{
    "header": "🌳 Ents (3/3)",
    "question": "¿Qué quieres hacer?",
    "multiSelect": false,
    "options": [
      { "label": "🔙 Volver a página 1", "description": "" },
      { "label": "🔙 Volver al menú anterior", "description": "" },
      { "label": "🏠 Volver al menú principal de TLOTP", "description": "" },
      { "label": "🚪 Salir", "description": "" }
    ]
  }]
}
```

### Criterios de Elección: Variante A vs Variante B

#### Usar Variante A (3 contenido + 1 navegación principal) cuando:
- Quedan 1-3 opciones de contenido sin mostrar
- El usuario probablemente querrá explorar una de las opciones pendientes
- La navegación es auxiliar (su propósito es volver, no explorar)

**Casos de uso**:
- Menú de CRUD donde aún hay acciones por mostrar
- Listados paginados que continúan
- Wizards con pasos finales

#### Usar Variante B (0 contenido + 4 navegación) cuando:
- Se han mostrado todas las opciones de contenido
- El usuario ha completado el flujo principal
- Necesita navegación completa (salida, menú principal, volver atrás)

**Casos de uso**:
- Última página de un listado paginado (fin de contenido)
- Fin de un wizard o proceso
- Menús que llegaron al final de todas sus opciones

### Tabla de Decisión

| Situación | Variante | Razón |
|-----------|----------|-------|
| Páginas 1, 2, N-1 | A | Siempre "Ver más..." |
| Última página, hay contenido | A | 3 opciones + 1 navegación |
| Última página, sin contenido | B | 4 opciones de navegación |
| Menú principal de épica | A | Mostrar opciones, "Ver más" o "Salir" |
| Fin de wizard/flujo | B | Navegación exhaustiva, no más contenido |

### Implementación en Módulos

Cada módulo que use paginación debe:

1. **Detectar páginas**: Calcular `página_actual` y `total_páginas`
2. **Formatear header**: `[Nombre] ([actual]/[total])`
3. **Elegir JSON**: Usar plantilla A o B según el contexto
4. **Mantener consistencia**: Mismo estilo en todos los módulos de la épica
