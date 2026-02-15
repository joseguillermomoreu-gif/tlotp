# 🧙‍♂️ TLOTP - The Lord of the Prompt

> **"Un prompt para configurarlos a todos"**

🚧 **En desarrollo activo** | [Issues](https://github.com/joseguillermomoreu-gif/tlotp/issues) | [Roadmap](MILESTONES.md)

Un único super-prompt para auto-configurar Claude Code de forma asistida, inteligente y evolutiva.

---

## 🎯 ¿Qué es TLOTP?

**TLOTP** (The Lord of the Prompt) es un sistema revolucionario que configura tu entorno de Claude Code mediante un único prompt interactivo.

### ❌ El Problema

Configurar Claude Code correctamente requiere:
- Crear múltiples archivos de configuración manualmente
- Mantener skills actualizadas (se vuelven obsoletas)
- Recordar preferencias entre proyectos
- Instalar y mantener scripts complejos

### ✅ La Solución

Un **único prompt** que:
- 🎯 Hace preguntas interactivas (~20-30 preguntas)
- 🔧 Genera configuración completa automáticamente
- 📚 Crea skills actualizadas usando Context7
- 🔄 Se auto-actualiza cuando las skills envejecen
- 🚀 Sin instalación, sin scripts, solo copy-paste

---

## ⚡ Inicio Rápido

### 💍 El Verdadero "One Prompt to Rule Them All"

Ejecuta el menú principal de TLOTP para acceder a todas las épicas:

```
@prompts/tlotp-main.md
```

Desde ahí podrás elegir:
- 🔮 **Palantír** - Gestor de configuraciones (✅ v1.7 Completo)
- ⚒️ **Celebrimbor** - Forjador de skills (🚧 v1.0 MVP en desarrollo)
- 💍 **Gollum**, 🏛️ **Elrond**, ⚡ **Gandalf** (⏳ Planificadas)

---

## ⚡ Estado Actual

**Versión**: TLOTP v2.1.0 (en desarrollo)

🎉 **Primera épica completada!** - Palantír v1.7 funcional y documentado
🚧 **Segunda épica en desarrollo** - Celebrimbor MVP (Tarea #1 completada)

Estamos construyendo el sistema por épicas (fases):

### TLOTP v2.x - The Fellowship (Configuración Básica)
1. 🔮 **Palantír** - CRUD de Configuraciones ← ✅ **COMPLETADO v1.7** (TLOTP v2.0)
2. ⚒️ **Celebrimbor** - Forjador de Skills ← 🚧 **En desarrollo** (TLOTP v2.1)
3. 💍 **Gollum** - Playwright E2E MVP ← ⏳ **Siguiente** (TLOTP v2.2)
4. 🏛️ **Elrond** - Global & Generic Configuration (TLOTP v2.3)
5. ⚡ **Gandalf** - Autonomous PHP Project (TLOTP v2.4)

### TLOTP v3.x - The Return of the King (Multi-Agent System)
6. 👑 **Aragorn** - Agent Orchestrator & Unified Command (futuro)

**Ver progreso**: [MILESTONES.md](MILESTONES.md) | [Issues en GitHub](https://github.com/joseguillermomoreu-gif/tlotp/issues)

### 🎯 Próximos hitos

- [x] ✅ Palantír v1.7 - CRUD completo con 11 módulos (TLOTP v2.0)
- [x] 🚧 Celebrimbor Tarea #1 - Detección de entorno y menú principal
- [ ] Celebrimbor Tarea #2 - Arquitectura modular dual-backend
- [ ] Celebrimbor v1.0 MVP - Sistema completo con Backend CLI (TLOTP v2.1)
- [ ] Gollum - Primer proyecto E2E configurado con TLOTP (TLOTP v2.2)
- [ ] Elrond - Sistema de configuración global (TLOTP v2.3)

---

## 🎨 Objetivos - Qué Configurará TLOTP

Cuando esté completo, TLOTP configurará **TODO** lo que necesitas:

### 1. **Workflow y Git**
- Estrategia de branching (gitflow, github-flow, trunk-based)
- Convenciones de commits (conventional commits)
- Cuándo hacer commits/push
- Merge strategy

### 2. **Testing y QA**
- Dónde ejecutar tests (local, Docker, CI)
- Framework de testing (auto-detectado)
- Linting automático
- Coverage mínimo

### 3. **Deploy**
- Estrategia (CI/CD, scripts, manual)
- Cuándo desplegar
- Ambientes (dev, staging, prod)

### 4. **Stack Tecnológico**
- Backend framework (auto-detectado)
- Frontend framework (auto-detectado)
- Database, testing E2E, etc.

### 5. **Skills**
- Generadas on-the-fly con Context7
- Siempre actualizadas
- Auto-detección de antigüedad

### 6. **Comportamiento de Claude**
- Nivel de proactividad
- Documentación en código
- Explicaciones de cambios

---

## 🚀 Características

### 🔍 **Detección Inteligente**
- Auto-detecta stack del proyecto
- Lee configuración existente
- Sugiere opciones basadas en tu setup

### 📚 **Skills Dinámicas**
- NO son archivos estáticos
- Se generan usando Context7
- Siempre con docs actualizadas
- Fecha de generación incluida

### 🔄 **Auto-actualización**
- Detecta skills antiguas (>7 días)
- Pregunta si actualizar
- Regenera con docs más recientes

### 🎯 **Universal**
- Funciona para cualquier proyecto
- No requiere instalación
- Portable entre máquinas
- Compatible con cualquier stack

---

## 📖 Documentación

### General
- **[TLOTP.md](TLOTP.md)** - Especificación completa del proyecto
- **[PREFERENCIAS.md](PREFERENCIAS.md)** - Catálogo de todas las preferencias configurables
- **[MILESTONES.md](MILESTONES.md)** - Épicas y roadmap del proyecto (temática LOTR)
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Cómo contribuir

### Guías de Uso
- **[Menú Principal](prompts/tlotp-main.md)** 💍 - Entry point único para todas las épicas
- **[Palantír v1.7](docs/PALANTIR.md)** 🔮 - Guía completa del sistema de gestión de configuraciones
- **[Celebrimbor](prompts/celebrimbor/README.md)** ⚒️ - El forjador de skills (en desarrollo)

---

## 🆚 vs. claude-code-auto-skills

| Aspecto | claude-code-auto-skills | TLOTP |
|---------|-------------------------|-------|
| **Instalación** | Scripts bash complejos | ❌ Ninguna |
| **Skills** | Archivos estáticos | ✅ Generadas on-the-fly |
| **Actualización** | Manual (git pull) | ✅ Automática (Context7) |
| **Scope** | Solo skills | ✅ Workflow completo |
| **Portabilidad** | Instalar en cada máquina | ✅ Universal |
| **Mantenimiento** | 20+ archivos .md | ✅ Mínimo (prompt + auto-gen) |

TLOTP es la **evolución** de claude-code-auto-skills.

---

## 🗺️ Roadmap

Ver **[MILESTONES.md](MILESTONES.md)** para el roadmap completo con todas las épicas y tareas.

### Épicas Definidas (orden por ROI)

#### 1. 🔮 Palantír - CRUD de Configuraciones (**✅ COMPLETADO v1.7**)
**Issue épico**: [#1](https://github.com/joseguillermomoreu-gif/tlotp/issues/1) | **[📖 Guía de Uso](docs/PALANTIR.md)**

Sistema completo de gestión de configuraciones de Claude Code con CRUD total:
- ✅ **Inspector** (READ) - 7 niveles + custom + conclusiones inteligentes
- ✅ **Reset** (DELETE) - Completo o selectivo con backup obligatorio
- ✅ **Recovery** (UPDATE) - Restaurar desde backups con merge
- ✅ **Configurador** (CREATE) - Añadir preferencias con detección de conflictos

**Arquitectura**: 11 módulos (~3,830 líneas) | **XP**: 1,670 XP ganados

---

#### 2. ⚒️ Celebrimbor - El Forjador de Skills (**⏳ Siguiente**)
**Issue épico**: [#42](https://github.com/joseguillermomoreu-gif/tlotp/issues/42)

Sistema de gestión de skills desde skills.sh con configuración automática de `paths:`.
Modo Automático detecta proyecto y auto-configura skills necesarias.

**XP Disponible**: 1,590 XP (13 tareas)

---

#### 3. 💍 Gollum - Playwright E2E MVP
**Issue épico**: [#2](https://github.com/joseguillermomoreu-gif/tlotp/issues/2)

Primer proyecto E2E configurado con TLOTP usando Celebrimbor para skills.

---

#### 4. 🏛️ Elrond - Global & Generic Configuration
**Issue épico**: [#3](https://github.com/joseguillermomoreu-gif/tlotp/issues/3)

Sistema de configuración global reutilizable para cualquier tipo de proyecto.

---

#### 5. ⚡ Gandalf - Autonomous PHP Project
**Issue épico**: [#4](https://github.com/joseguillermomoreu-gif/tlotp/issues/4)

Objetivo final: autonomía total. Claude ejecuta ciclo completo (tarea → código → QA → deploy).

---

**Estado actual**: 🚧 Celebrimbor Tarea #1 completada - TLOTP v2.1.0 en desarrollo
**Último completado**: ✅ Palantír v1.7 - [Ver Guía de Uso](docs/PALANTIR.md)
**Progreso general**: [MILESTONES.md](MILESTONES.md) | [GitHub Issues](https://github.com/joseguillermomoreu-gif/tlotp/issues)
**XP total acumulado**: 1,985 XP cada fundador (3,970 XP compartidos)

---

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Este es un proyecto colaborativo.

Ver **[CONTRIBUTING.md](CONTRIBUTING.md)** para más información.

---

## 📜 Licencia

Por definir.

---

## 👨‍💻 Autor

**José Guillermo Moreu**
- GitHub: [@joseguillermomoreu-gif](https://github.com/joseguillermomoreu-gif)
- Proyecto anterior: [claude-code-auto-skills](https://github.com/joseguillermomoreu-gif/claude-code-auto-skills)

---

## 🙏 Agradecimientos

Este proyecto nace de la experiencia adquirida desarrollando **claude-code-auto-skills**, que sirvió como prototipo de aprendizaje y validación del concepto.

---

**Desarrollado con 💙 y usando Claude Code**
