# 🔮 Celebrimbor - El Forjador de Skills ⚒️

> *"Tres Anillos para los Reyes Elfos bajo el cielo..."*

---

## 📋 Carga de Versiones

@prompts/VERSION.md

**IMPORTANTE**: Usa la versión TLOTP definida en VERSION.md en todos los banners y outputs

---

## 📊 Metadata

**Épica**: #2 Celebrimbor
**Estado**: ✅ MVP Completado - CRUD Funcional

---

## 🎯 Misión

Celebrimbor forja y gestiona skills para Claude Code, ofreciendo dos modos de operación:

- ⚡ **Backend CLI** (Node.js >=18) - ✅ Disponible
- 📦 **Backend Git** (universal) - 🚧 Futuro

---

## 📋 Arquitectura Modular

Este prompt principal carga todos los módulos de Celebrimbor:

### Capa de Detección y Selección

1. **01-detector-entorno.md** - Detección de Node.js, npm, Git ✅
2. **06-backend-selector.md** - Selector inteligente de backend ✅

### Capa de Abstracción

3. **03-abstraction-layer.md** - Interfaz común para backends ✅

### Backends (Dual-Mode)

4. **04-backend-cli.md** - Backend CLI (Node.js >=18) ✅ MVP
5. **05-backend-git.md** - Backend Git (hooks v4.0.0) ✅ Arquitectura

### Interfaz de Usuario

6. **02-menu-principal.md** - Menú interactivo adaptativo ✅

### Módulos de Operaciones (CRUD)

7. **07-module-search.md** - Búsqueda de skills
8. **08-module-install.md** - Instalación de skills
9. **09-module-list.md** - Listar skills instaladas
10. **10-module-remove.md** - Eliminar skills
11. **11-module-update.md** - Actualizar skills

### Post-Instalación

12. **15-module-post-install-rules.md** - Rules con paths para activación contextual ✅ Tarea #53

### Referencia Técnica

13. **14-skills-cli-reference.md** - Referencia CLI oficial (vercel-labs/skills) ✅ Tarea #54

### Módulos Futuros (v2.2+)
- **12-mode-auto.md** - Modo automático
- **13-integration-palantir.md** - Integración Palantír

---

## 🚀 Flujo de Ejecución

### Paso 1: Detección de Entorno

**Módulo**: `sections/01-detector-entorno.md`

1. Detectar Node.js, npm, npx, Git
2. Validar requisitos (Node.js >=18)
3. Generar reporte visual

### Paso 2: Selección de Backend

**Módulo**: `sections/06-backend-selector.md`

1. Verificar preferencia guardada (`~/.celebrimbor/config.yml`)
2. Si no hay preferencia:
   - Versión actual: Usar CLI si disponible, error si no
   - v4.0.0: Preguntar CLI vs Git si ambos disponibles
3. Cargar backend seleccionado

### Paso 2.5: Verificación de Updates (NUEVO)

**IMPORTANTE**: Después de seleccionar backend CLI, antes del menú.

1. Ejecutar `npx skills check`
2. Parsear resultado (skills con updates disponibles)
3. Mostrar banner con estado de updates en menú principal

**Ver**: `sections/11-module-update.md` (Paso 0)

### Paso 3: Operaciones de Usuario

**Módulo**: `sections/02-menu-principal.md`

Menú adaptativo según backend:
1. 🔍 Buscar skills
2. 📥 Instalar skill
3. 📋 Listar skills instaladas
4. 🔄 Actualizar skills
5. 🗑️ Eliminar skill
6. 🤖 Modo Automático (v2.2+)
7. ⚙️ Cambiar backend
8. 🚪 Salir

### Paso 4: Ejecutar Operación

**Módulo backend** (04 o 05):
- Backend CLI: `sections/04-backend-cli.md`
- Backend Git: `sections/05-backend-git.md` (v4.0.0)

**Usando abstracción** (`sections/03-abstraction-layer.md`):
```
backend.search(query)
backend.install(skill_name, location)
backend.list(location)
backend.update(skill_name)
backend.remove(skill_name)
```

---

## 🔧 Requisitos v1.0 (Backend CLI)

**Obligatorios**:
- Node.js >= 18.0.0
- npm >= 9.0.0
- npx (incluido con npm)

**Opcionales**:
- Git (para actualizar skills)

---

## 📚 Estructura de Archivos

```
prompts/celebrimbor/
├── celebrimbor-main.md          # Entry point (este archivo)
└── sections/
    ├── 01-detector-entorno.md   # Detección Node.js
    ├── 02-menu-principal.md     # Menú interactivo
    ├── 03-backend-cli.md        # Backend CLI (npx skills)
    ├── 04-backend-git.md        # Backend Git (v2.0)
    └── 05-modo-automatico.md    # Modo automático (v2.0)
```

---

## 🎮 Cómo Usar

```
@prompts/celebrimbor/celebrimbor-main.md
```

Claude Code ejecutará la detección de entorno y mostrará el menú principal.

---

## 🔗 Integración con Palantír

Celebrimbor se integra con Palantír (Épica #1) para:
- Configurar skills en `~/.claude/rules/` o `./.claude/rules/`
- Validar configuraciones existentes
- Evitar duplicados

---

## 📝 Notas de Desarrollo

**Estado actual**: Tarea #6 (Actualizar skills)
**Completadas**: Tareas #1-5 (Setup, Arquitectura, CRUD básico)
**Siguiente**: Tarea #7 (Modo Automático - v4.0.0)

**Branch**: `feature/celebrimbor-6-update-module`
**Issues**: #42 (Épica completa)

**XP Acumulado**: 710 XP (Tareas #1-6)

---

⚒️ *"En las fraguas de Eregion, cada herramienta se adapta a su artesano..."*

💍 *One Prompt to Rule Them All*
