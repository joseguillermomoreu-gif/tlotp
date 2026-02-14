# 💍 ÉPICAS - The Journey of TLOTP

> **Organización**: Cada épica usa un personaje de The Lord of the Rings
> **Propósito**: "One Prompt to Rule Them All" - Temática coherente con TLOTP

---

## 🎯 Sistema de Épicas

Cada **épica** representa una fase importante del desarrollo de TLOTP y lleva el nombre de un personaje de la Tierra Media que simboliza el propósito de esa fase.

### **Formato de Issues**

```
[PERSONAJE] Descripción de la tarea

Ejemplo:
[Palantír] Implementar inspector de configuración
[Gollum] Crear TLOTP-prompt.md para Playwright
```

---

## 🗺️ Épicas Definidas (Por Orden de ROI)

### **1. 🔮 Palantír - Configuration Inspector & Reset**

**GitHub Issue**: [#1](https://github.com/joseguillermomoreu-gif/tlotp/issues/1)
**Prioridad**: Alta
**ROI**: Inmediato - Herramienta de desarrollo

**Símbolo**: La piedra vidente que permite VER todo

**Descripción**:
Sistema para visualizar y gestionar configuraciones de Claude Code, siguiendo la jerarquía oficial. Permite inspeccionar toda la configuración (oficial + custom) y gestionarla (backup, reset).

**Objetivo**:
Herramienta fundamental para desarrollar y testear las siguientes épicas.

**Progreso**: 🎉 **Sprint P4 COMPLETADO (95%)** - Palantír v1.6 con Reconstrucción

**Entregables Sprint P2** ✅ COMPLETADO:
- [x] **#18** Palantír-prompt.md v1.2 ✅ CERRADO 2026-02-13 (150 XP)
- [x] **#7** Inspector config global (resumen) ✅ CERRADO 2026-02-13 (50 XP)
- [x] **#8** Inspector config global (completo) ✅ CERRADO 2026-02-13 (80 XP)
- [x] **#9** Inspector config proyecto (resumen) ✅ CERRADO 2026-02-13 (50 XP)
- [x] **#10** Inspector config proyecto (completo) ✅ CERRADO 2026-02-13 (80 XP)
- [x] **#11** Inspector de skills ✅ CERRADO 2026-02-13 (60 XP)

**Entregables Sprint P3** ✅ COMPLETADO:
- [x] **#38** Sistema de Reset y Recovery ✅ CERRADO 2026-02-13 (350 XP) 🏆
  - Reset Completo (fichero por fichero)
  - Reset Selectivo (regla por regla)
  - Recovery desde backups con merge inteligente
  - Menú principal con 3 modos
  - Documentación oficial Claude Code Memory
  - 2 tests completos de validación

**Entregables Sprint P4** ✅ COMPLETADO:
- [x] **#40** Motor de Reconstrucción Inteligente ✅ CERRADO 2026-02-13 (400 XP) 🏆⚒️
  - Sistema de acumulación temporal en memoria
  - Validación de estructura por tipo de archivo
  - Prevención de archivos corruptos
  - Regla anti-auto-memory (no contaminar MEMORY.md)
  - Manejo correcto de symlinks
  - UX mejorado con AskUserQuestion en menú
  - **Problema resuelto**: Settings Error corrupto

**Entregables Sprint P5** ⏳ PRÓXIMO:
- [ ] **#41** Sistema de Configuración Asistida - 450 XP 💎
- [ ] **#31** Mejorar instrucciones condicionales - 60 XP
- [ ] **#32** Validar opción "Sí, mostrar resumen" - 50 XP
- [ ] **#33** Mejorar mensaje "otros CLAUDE.md en jerarquía superior" - 50 XP

**Funcionalidades implementadas** (v1.6):
- ✅ Jerarquía oficial Claude Code (7 niveles)
- ✅ Exploración genérica de configuración adicional
- ✅ Sistema de backup con 4 opciones de path
- ✅ Detección de imports, symlinks, YAML frontmatter
- ✅ Filtrado inteligente (excluye docs de proyecto)
- ✅ AskUserQuestion para interacción elegante
- ✅ **Sistema de Reset Completo e Interactivo**
- ✅ **Sistema de Reset Selectivo (regla por regla)**
- ✅ **Sistema de Recovery desde backups**
- ✅ **Menú principal con 3 modos**
- ✅ **Motor de Reconstrucción Inteligente** ⚒️
- ✅ **Prevención de contaminación Auto-Memory**
- ✅ **Manejo correcto de symlinks**
- ✅ **Validación de estructura antes de escribir**

**Estado**: ✅ **Palantír v1.6 COMPLETO Y VALIDADO**
**Próximo**: Sprint P5 (Configurador + Mejoras pendientes)
**Testing**: ✅ Testing exhaustivo completado - "funciona perfecto" 🎉
**XP Sprint P2**: +470 XP total (235 XP cada fundador)
**XP Sprint P3**: +350 XP total (175 XP cada fundador)
**XP Sprint P4**: +400 XP total (200 XP cada fundador)

---

### **2. 💍 Gollum - Playwright E2E MVP**

**GitHub Issue**: [#2](https://github.com/joseguillermomoreu-gif/tlotp/issues/2)
**Prioridad**: Alta
**ROI**: Rápido - Primer caso de uso real

**Símbolo**: "My precious" - Primer hobbit con el anillo, trabajo oscuro de testing

**Descripción**:
Primer proyecto configurado con TLOTP. MVP enfocado en testing E2E con Playwright, incluyendo todas las preferencias específicas de este tipo de proyectos.

**Objetivo**:
MVP funcional que valide que TLOTP funciona end-to-end con un caso específico.

**Entregables**:
- [ ] TLOTP-prompt funcional para proyectos Playwright
- [ ] Detección automática de playwright.config.ts
- [ ] Preguntas específicas para E2E testing
- [ ] Generación de CLAUDE.md con config E2E
- [ ] Generación de MEMORY.md con comandos útiles
- [ ] Skills generadas (playwright.md, pom.md)
- [ ] Ejemplo completo documentado

**Estado**: ⏳ Pendiente
**Dependencias**: Palantír
**Target**: Por definir

---

### **3. 🏛️ Elrond - Global & Generic Configuration**

**GitHub Issue**: [#3](https://github.com/joseguillermomoreu-gif/tlotp/issues/3)
**Prioridad**: Media-Alta
**ROI**: Escalable - Base reutilizable

**Símbolo**: El sabio de Rivendel que establece las bases del viaje

**Descripción**:
Sistema de configuración global del usuario y aspectos genéricos que aplican a cualquier tipo de proyecto, independiente del stack tecnológico.

**Objetivo**:
Generalizar TLOTP para configurar aspectos fundamentales reutilizables.

**Entregables**:
- [ ] Sistema de configuración global completo
- [ ] Preguntas genéricas (workflow, git, preferencias)
- [ ] Generación de ~/.claude/CLAUDE.md
- [ ] Sistema de skills genéricas
- [ ] Detección y reutilización de config existente
- [ ] Documentación de configuración global

**Estado**: ⏳ Pendiente
**Dependencias**: Palantír, Gollum
**Target**: Por definir

---

### **4. ⚡ Gandalf - Autonomous PHP Project**

**GitHub Issue**: [#4](https://github.com/joseguillermomoreu-gif/tlotp/issues/4)
**Prioridad**: Media
**ROI**: Máximo - Autonomía total

**Símbolo**: "No llega tarde ni pronto, llega cuando se lo propone"

**Descripción**:
Proyecto PHP personal con autonomía completa. Claude puede recibir una instrucción y ejecutar el ciclo completo: crear tarea en GitHub, crear rama, planificar, implementar, pasar QA, y deployar.

**Objetivo**:
El objetivo final de TLOTP - autonomía total en un proyecto real.

**Workflow autónomo**:
1. Usuario: "Añade sección de contacto al portfolio"
2. Claude:
   - Crea issue en GitHub
   - Crea rama desde develop
   - Planifica implementación
   - Implementa código
   - Ejecuta QA (PHPUnit, PHPStan, Behat)
   - Deploy automático
   - Actualiza issue como completado

**Entregables**:
- [ ] Configuración completa de proyecto PHP
- [ ] Integración avanzada con GitHub (issues, tasks, projects)
- [ ] Sistema de tareas automatizado
- [ ] QA PHP completa (testing, linting, static analysis)
- [ ] Deploy automatizado
- [ ] Workflow autónomo end-to-end
- [ ] Documentación completa del sistema

**Estado**: ⏳ Pendiente
**Dependencias**: Palantír, Gollum, Elrond
**Target**: Por definir

---

### **5. 👑 Aragorn - Agent Orchestrator & Unified Command**

**GitHub Issue**: [#5](https://github.com/joseguillermomoreu-gif/tlotp/issues/5)
**Prioridad**: Futura (TLOTP v2.0)
**ROI**: Revolucionario - Multi-Agent System

**Símbolo**: El Rey que retorna y unifica todos los ejércitos

**Descripción**:
Sistema de orquestación multi-agente donde TLOTP configura, instala y coordina múltiples agentes Claude Code trabajando en paralelo e interactuando entre sí.

**Objetivo**:
TLOTP 2.0 - Llevar Claude Code a la N-ésima potencia mediante coordinación de múltiples agentes autónomos.

**Entregables**:
- [ ] Sistema de configuración de agentes (.md files)
- [ ] Instalación automática de agentes en el sistema
- [ ] Ventana interactiva (Aragorn's Command Center)
- [ ] Protocolo de comunicación inter-agente
- [ ] Sistema de dependencias entre agentes
- [ ] Orquestación inteligente de tareas
- [ ] Distribución automática de trabajo
- [ ] Recuperación de fallos y retry logic
- [ ] Dashboard de visualización de todos los agentes activos

**Características Clave**:
- **Multi-Session Management**: Múltiples sesiones de Claude Code activas
- **Inter-Agent Communication**: Agentes que se comunican y colaboran
- **Strategic Distribution**: TLOTP decide qué agentes lanzar para cada tarea
- **Unified Command**: Ventana que muestra estado de todos los agentes
- **Autonomous Collaboration**: Agentes trabajan juntos sin intervención

**Concepto Visual - Aragorn's Command Center**:
```
┌────────────────────────────────────────────────────┐
│          ⚔️  ARAGORN COMMAND CENTER  ⚔️           │
│         The King's View of All Armies             │
├────────────────────────────────────────────────────┤
│ 🟢 Backend-Guard     │ Testing API endpoints     │
│ 🟢 Frontend-Knight   │ Building UI components    │
│ 🟡 Database-Sentinel │ Waiting for migration     │
│ 🔴 Deploy-Rider      │ Error: blocked by tests   │
│                                                    │
│ Total: 4 agents | 2 active | 1 waiting | 1 error │
└────────────────────────────────────────────────────┘
```

**Estado**: ⏳ Futuro (TLOTP v2.0)
**Dependencias**: Todas las épicas v1.x completadas
**Target**: Por definir (después de Gandalf)

---

## 📊 Progreso General

### TLOTP v1.x - The Fellowship

```
🔮 Palantír (Inspector/Reset/Recovery/Reconstruction) [█████████-]  95% ✅ P4 completado
💍 Gollum (Playwright MVP)                            [----------]   0%
🏛️ Elrond (Global Config)                             [----------]   0%
⚡ Gandalf (Autonomous)                               [----------]   0%
```

### TLOTP v2.x - The Return of the King

```
👑 Aragorn (Multi-Agent)      [----------]   0%
```


---

## 🎮 Cómo Usar

### **Crear Issue de Tarea**

```markdown
Título: [Palantír] Implementar inspector de config global

Descripción:
Crear comando/prompt que permita visualizar toda la configuración global.

- [ ] Leer ~/.claude/CLAUDE.md
- [ ] Formatear y mostrar al usuario
- [ ] Mostrar skills cargadas
- [ ] Mostrar fechas de generación

Epic: #1 (Palantír)
Labels: enhancement
```

### **Buscar Issues de una Épica**

En GitHub:
```
is:issue "Palantír" in:title
is:issue linked:joseguillermomoreu-gif/tlotp#1
```

---

## 🎯 Convenciones

1. **Prefijo obligatorio**: `[PERSONAJE]` al inicio del título
2. **Referencia a épica**: Mencionar issue épico en descripción
3. **Labels**: Usar labels apropiados (enhancement, bug, docs)
4. **Descripción**: Clara y con checklist si es tarea compleja

---

## 🗺️ Roadmap

### TLOTP v1.x - The Fellowship

```
Palantír → Gollum → Elrond → Gandalf
  (Dev)   (Quick)  (Scale)  (Auto)
   ⚡       🎯       📈       🚀
```

**Orden por ROI v1.x**:
1. Herramienta de soporte (necesaria para desarrollo)
2. MVP específico (valida el concepto)
3. Generalización (escala la solución)
4. Autonomía de proyecto (objetivo v1.0)

### TLOTP v2.x - The Return of the King

```
Aragorn
(Multi-Agent Orchestration)
👑 ⚔️ 🏰
```

**Objetivo v2.0**:
Sistema revolucionario de múltiples agentes Claude Code coordinados, comunicándose y colaborando para completar tareas complejas de forma distribuida y autónoma.

---

*"One Prompt to Rule Them All"* 💍

*Última actualización: 2026-02-12*
