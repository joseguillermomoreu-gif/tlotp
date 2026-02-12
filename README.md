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

## ⚡ Estado Actual

🚧 **TLOTP está en desarrollo activo**

Estamos construyendo el sistema por épicas (fases):

1. 🔮 **Palantír** - Configuration Inspector & Reset ← **En desarrollo**
2. 💍 **Gollum** - Playwright E2E MVP
3. 🏛️ **Elrond** - Global & Generic Configuration
4. ⚡ **Gandalf** - Autonomous PHP Project (objetivo final)

**Ver progreso**: [MILESTONES.md](MILESTONES.md) | [Issues en GitHub](https://github.com/joseguillermomoreu-gif/tlotp/issues)

### 🎯 Próximos hitos

- [ ] Completar Palantír (herramienta de inspección de configs)
- [ ] Implementar primer prompt funcional (Gollum - Playwright MVP)
- [ ] Sistema de configuración global (Elrond)

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

- **[TLOTP.md](TLOTP.md)** - Especificación completa del proyecto
- **[PREFERENCIAS.md](PREFERENCIAS.md)** - Catálogo de todas las preferencias configurables
- **[MILESTONES.md](MILESTONES.md)** - Épicas y roadmap del proyecto (temática LOTR)
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Cómo contribuir

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

#### 1. 🔮 Palantír - Configuration Inspector & Reset (**← En desarrollo**)
**Issue épico**: [#1](https://github.com/joseguillermomoreu-gif/tlotp/issues/1) | **Tareas**: #5-#28

Herramienta para inspeccionar y gestionar configuraciones de TLOTP. Fundamental para desarrollar las siguientes épicas.

**Entregables**:
- Inspector de configs (global/proyecto/skills)
- Sistema de reset (total/selectivo/interactivo)
- Prompt dedicado y modo conversacional

---

#### 2. 💍 Gollum - Playwright E2E MVP
**Issue épico**: [#2](https://github.com/joseguillermomoreu-gif/tlotp/issues/2)

Primer proyecto real configurado con TLOTP. MVP enfocado en testing E2E con Playwright.

---

#### 3. 🏛️ Elrond - Global & Generic Configuration
**Issue épico**: [#3](https://github.com/joseguillermomoreu-gif/tlotp/issues/3)

Sistema de configuración global reutilizable para cualquier tipo de proyecto.

---

#### 4. ⚡ Gandalf - Autonomous PHP Project
**Issue épico**: [#4](https://github.com/joseguillermomoreu-gif/tlotp/issues/4)

Objetivo final: autonomía total. Claude ejecuta ciclo completo (tarea → código → QA → deploy).

---

**Estado actual**: Trabajando en Palantír (épica #1)
**Progreso general**: [Ver en GitHub Projects](https://github.com/joseguillermomoreu-gif/tlotp/issues)

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
