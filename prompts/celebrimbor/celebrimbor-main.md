# 🔮 Celebrimbor - El Forjador de Skills ⚒️

> *"Tres Anillos para los Reyes Elfos bajo el cielo..."*

**Versión**: TLOTP v2.1.0 (en desarrollo)
**Épica**: #2 Celebrimbor
**Backend**: CLI (Node.js) - MVP
**Estado**: 🚧 En desarrollo - Tarea #1

---

## 🎯 Misión

Celebrimbor forja y gestiona skills para Claude Code, ofreciendo dos modos de operación:

- ⚡ **Backend CLI** (Node.js) - MVP v1.0
- 📦 **Backend Git** (universal) - v2.0 (futuro)

---

## 📋 Módulos

Este prompt principal carga todos los módulos de Celebrimbor:

### Módulos Activos (v1.0)

1. **01-detector-entorno.md** - Detección de Node.js y requisitos ✅
2. **02-menu-principal.md** - Menú interactivo (WIP)
3. **03-backend-cli.md** - Backend CLI de skills.sh (WIP)

### Módulos Futuros (v2.0)

- **04-backend-git.md** - Backend Git Clone (sin Node.js)
- **05-modo-automatico.md** - Detección y configuración automática

---

## 🚀 Inicio

### Paso 1: Detección de Entorno

**IMPORTANTE**: Antes de cualquier operación, ejecutar detección de entorno.

**Leer módulo**: `@sections/01-detector-entorno.md`

**Ejecutar**:
1. Detectar versión de Node.js
2. Validar npx y skills CLI
3. Mostrar reporte con estado
4. Si Node.js < 18: Informar y dar opciones

### Paso 2: Menú Principal

**Leer módulo**: `@sections/02-menu-principal.md`

**Mostrar opciones**:
1. ⚡ Backend CLI (si Node.js >=18)
2. 📦 Backend Git (WIP - v2.0)
3. 🤖 Modo Automático (detectar proyecto)
4. ℹ️ Ayuda y documentación
5. 🚪 Salir

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

**Estado actual**: Tarea #1 (Setup y detección)
**Siguiente**: Tarea #2 (Arquitectura modular dual-backend)

**Branch**: `feature/celebrimbor-1-setup-node`
**Issues**: #42 (Épica completa)

---

⚒️ *"En las fraguas de Eregion, cada herramienta se adapta a su artesano..."*

💍 *One Prompt to Rule Them All*
