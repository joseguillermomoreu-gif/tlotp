# ⚒️ Celebrimbor - El Forjador de Skills

> *"Tres Anillos para los Reyes Elfos bajo el cielo..."*

**Versión**: TLOTP v2.1.0 (en desarrollo)
**Épica**: #2 Celebrimbor
**Estado**: 🚧 MVP Backend CLI en desarrollo

---

## 🎯 ¿Qué es Celebrimbor?

Sistema de gestión de skills para Claude Code que ofrece **dos modos de operación**:

- ⚡ **Backend CLI** (Node.js >=18) - MVP v2.1.0 - 🚧 En desarrollo
- 📦 **Backend Git** (universal) - v2.2.0 - ⏳ Planificado

---

## 🚀 Inicio Rápido

### Requisitos v2.1.0 (Backend CLI)

- Node.js >= 18.0.0
- npm >= 9.0.0
- npx (incluido con npm)

**Verificar requisitos**:
```bash
node --version   # >= v18.0.0
npm --version    # >= 9.0.0
```

### Uso

```
@prompts/celebrimbor/celebrimbor-main.md
```

Claude Code ejecutará:
1. Detección automática de entorno
2. Validación de requisitos
3. Menú principal interactivo

---

## 📁 Estructura

```
prompts/celebrimbor/
├── celebrimbor-main.md              # Entry point principal
├── README.md                        # Este archivo
└── sections/
    ├── 01-detector-entorno.md       # Detección Node.js ✅
    ├── 02-menu-principal.md         # Menú interactivo ✅
    ├── 03-backend-cli.md            # Backend CLI (WIP)
    ├── 04-backend-git.md            # Backend Git (v2.2.0)
    └── 05-modo-automatico.md        # Modo automático (futuro)
```

---

## 📋 Progreso del Desarrollo

### Tarea #1: Setup y Detección ✅
- [x] Detección de Node.js
- [x] Validación de requisitos
- [x] Reporte de estado
- [x] Documentación de requisitos

### Tarea #2: Arquitectura Modular (WIP)
- [ ] Interfaz común
- [ ] Backend CLI (implementar)
- [ ] Backend Git (hooks)
- [ ] Sistema de selección

### Tareas #3-#13: (Pendientes)
Ver issue #42 para detalles completos

---

## 🧪 Testing

**Test de detección**:
```
@tests/celebrimbor/test-detector.md
```

Valida:
- Detección de Node.js en todos los escenarios
- Parseo de versiones
- Validación de requisitos
- Formato de reportes

---

## 📚 Documentación

- **Requisitos del Sistema**: `docs/REQUISITOS.md`
- **Épica Completa**: Issue #42
- **Milestones**: `MILESTONES.md`

---

## 🔗 Integración

### Con Palantír (Épica #1)
- Configuración de skills en `~/.claude/rules/`
- Validación de configuraciones
- Evitar duplicados

### Con Gollum (Épica #3)
- Instalación automática de skills E2E
- Configuración de proyecto Playwright

---

## 🎮 Roadmap

**v2.1.0 (Actual)** - Backend CLI MVP
- ✅ Detección de entorno
- 🚧 Arquitectura modular dual
- ⏳ Módulos: Buscar, Instalar, Gestionar, Listar
- ⏳ Modo automático
- ⏳ Integración con Palantír

**v2.2.0 (Futuro)** - Backend Git
- ⏳ Clonación de repositorio skills
- ⏳ Búsqueda local
- ⏳ Instalación manual
- ⏳ Sin dependencia de Node.js

---

⚒️ *"En las fraguas de Eregion, cada herramienta se adapta a su artesano..."*

💍 *One Prompt to Rule Them All*
