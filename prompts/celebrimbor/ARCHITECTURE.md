# 🏗️ Arquitectura de Celebrimbor - Dual-Backend

**TLOTP**: Ver VERSION.md
**Tarea**: #2 - Arquitectura Modular Dual-Backend
**Estado**: ✅ Diseño Completo

---

## 🎯 Visión General

Celebrimbor utiliza **arquitectura de capas** con **dual-backend** para máxima flexibilidad:

```
┌─────────────────────────────────────────────────────────┐
│                    USUARIO                              │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│          Menú Principal (02-menu-principal.md)          │
│              Interfaz de Usuario                        │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│      Selector de Backend (06-backend-selector.md)       │
│   Detecta entorno y elige backend apropiado            │
└─────────┬────────────────────────────────┬──────────────┘
          │                                │
    ┌─────▼─────┐                    ┌─────▼─────┐
    │ Detección │                    │   Config  │
    │  Entorno  │                    │   Saved   │
    │    (01)   │                    │  Prefs    │
    └───────────┘                    └───────────┘
          │                                │
          └────────────┬───────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────┐
│    Capa de Abstracción (03-abstraction-layer.md)       │
│   Define interfaz común: search, install, list, etc.   │
└────┬─────────────────────────────────────────────┬──────┘
     │                                             │
┌────▼────────────────┐               ┌───────────▼──────┐
│   Backend CLI (04)  │               │  Backend Git (05)│
│   Node.js >=18      │               │  Git (v4.0.0)    │
│   npx skills        │               │  git clone       │
└─────────────────────┘               └──────────────────┘
```

---

## 📦 Módulos y Responsabilidades

### **01-detector-entorno.md** - Detección de Entorno
**Responsabilidad**: Detectar y validar requisitos del sistema

**Input**: Ninguno
**Output**: Estado del entorno (Node.js, npm, Git, skills CLI)

**Operaciones**:
- Detectar versión de Node.js
- Validar npm y npx
- Probar `npx skills`
- Detectar Git
- Generar reporte visual

---

### **02-menu-principal.md** - Interfaz de Usuario
**Responsabilidad**: Presentar opciones y gestionar interacción

**Input**: Backend seleccionado
**Output**: Acción del usuario

**Operaciones**:
- Mostrar banner de bienvenida
- Adaptar menú según backend disponible
- Capturar selección de usuario
- Ejecutar operación correspondiente
- Loop continuo hasta salir

---

### **03-abstraction-layer.md** - Capa de Abstracción
**Responsabilidad**: Definir contrato común para todos los backends

**Define**:
```python
interface Backend:
  search(query, filters) -> List[Skill]
  install(skill_name, location, config) -> Status
  list(location) -> List[InstalledSkill]
  update(skill_name, location) -> Status
  remove(skill_name, location) -> Status
  is_available() -> bool
```

**Principio**: Los consumidores NO saben qué backend usan

---

### **04-backend-cli.md** - Backend Node.js
**Responsabilidad**: Implementar operaciones usando `npx skills`

**Requisitos**:
- Node.js >= 18.0.0
- npm >= 9.0.0
- npx skills funcional

**Implementa**:
- search: `npx skills search <query>`
- install: `npx skills add <skill>`
- list: `npx skills list` + lectura manual
- update: `npx skills update <skill>`
- remove: `npx skills remove <skill>` o rm

**Estado**: ✅ Implementado (Backend CLI MVP)

---

### **05-backend-git.md** - Backend Git Clone
**Responsabilidad**: Implementar operaciones sin Node.js

**Requisitos**:
- Git (cualquier versión)

**Implementa** (v4.0.0):
- search: grep local en repo clonado
- install: cp de repo → destino
- list: ls de directorios
- update: git pull + re-copy
- remove: rm manual

**Estado**: 🚧 Hooks preparados, implementación en v4.0.0

---

### **06-backend-selector.md** - Selector Inteligente
**Responsabilidad**: Elegir backend apropiado según entorno

**Proceso**:
1. Leer detección de entorno (módulo 01)
2. Verificar preferencia guardada (`~/.celebrimbor/config.yml`)
3. Si no hay preferencia:
   - Versión actual: CLI automático (o error)
   - v4.0.0: Preguntar si ambos disponibles
4. Retornar backend seleccionado
5. Guardar preferencia

**Output**: Objeto backend listo para usar

---

## 🎨 Principios de Diseño

### 1. **Separación de Responsabilidades**
Cada módulo tiene UNA responsabilidad clara

### 2. **Inversión de Dependencias**
Los módulos superiores NO conocen detalles de backends

### 3. **Sustituibilidad de Backends**
Cambiar backend es transparente para el usuario

### 4. **Extensibilidad**
Fácil añadir nuevos backends (npm, curl, API, etc.)

### 5. **Fail-Safe**
Si un backend falla, intentar alternativa automáticamente

### 6. **User-Centric**
Experiencia consistente independiente del backend

---

## 🚀 Roadmap de Implementación

### MVP Actual (Backend CLI)
- ✅ Arquitectura dual-backend diseñada
- ✅ Backend CLI completamente funcional
- ✅ Backend Git: hooks preparados (no implementado)
- ✅ Selector: solo CLI
- ✅ Documentación completa

### v4.0.0 - Git Backend
- ⏳ Implementar Backend Git completo
- ⏳ Selector: preguntar CLI vs Git
- ⏳ Testing exhaustivo dual-mode
- ⏳ Documentación Git backend

---

**Diseñada por**: La Fellowship del Teclado 🥔🤖
**Tarea**: #2 - Arquitectura Modular Dual-Backend
**XP**: 120 XP + Badge "Maestro de las Fraguas" 🏆
**TLOTP**: Ver VERSION.md
