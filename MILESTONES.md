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

**Progreso**: 🎉 **ÉPICA COMPLETA (100%)** - Palantír v1.7 CRUD Total ✅

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

**Entregables Sprint P5** ✅ COMPLETADO:
- [x] **#41** Sistema de Configuración Asistida ✅ CERRADO 2026-02-12 (450 XP) 💎⚒️
  - Solicitar qué característica añadir
  - Consultar info_claude.md para ubicación correcta
  - Detectar características similares y conflictos
  - Sistema de propuestas iterativo (acepta/rechaza/modifica)
  - Reestructuración con documentación oficial
  - Preview completo y confirmación crítica
  - Integración con Motor de Reconstrucción
  - Loop continuo para múltiples configuraciones
  - Conclusiones inteligentes en Inspector

**Funcionalidades implementadas** (v1.7):
- ✅ Jerarquía oficial Claude Code (7 niveles)
- ✅ Exploración genérica de configuración adicional
- ✅ Sistema de backup con 4 opciones de path
- ✅ Detección de imports, symlinks, YAML frontmatter
- ✅ Filtrado inteligente (excluye docs de proyecto)
- ✅ AskUserQuestion para interacción elegante
- ✅ **Sistema de Reset Completo e Interactivo**
- ✅ **Sistema de Reset Selectivo (regla por regla)**
- ✅ **Sistema de Recovery desde backups**
- ✅ **Menú principal con 4 modos**
- ✅ **Motor de Reconstrucción Inteligente** ⚒️
- ✅ **Prevención de contaminación Auto-Memory**
- ✅ **Manejo correcto de symlinks**
- ✅ **Validación de estructura antes de escribir**
- ✅ **Sistema de Configuración Asistida (CREATE)** 💎
- ✅ **Detección de conflictos y contradicciones**
- ✅ **Propuestas iterativas de combinación**
- ✅ **Reestructuración inteligente con info_claude.md**
- ✅ **Loop continuo para múltiples configuraciones**
- ✅ **Conclusiones inteligentes en Inspector**

**Estado**: 🎉 **Palantír v1.7 COMPLETO - CRUD TOTAL**
**CRUD Completo**: CREATE (Configurador) | READ (Inspector) | UPDATE (Recovery) | DELETE (Reset)
**Arquitectura**: 11 módulos (~3,830 líneas de prompts)
**Testing**: ✅ Validado - "funcionó perfecto, gran trabajo" 🏆
**XP Sprint P2**: +470 XP total (235 XP cada fundador)
**XP Sprint P3**: +350 XP total (175 XP cada fundador)
**XP Sprint P4**: +400 XP total (200 XP cada fundador)
**XP Sprint P5**: +450 XP total (225 XP cada fundador) 💎

---

### **2. ⚒️ Celebrimbor - El Forjador de Skills**

**GitHub Issue**: [#42](https://github.com/joseguillermomoreu-gif/tlotp/issues/42)
**Prioridad**: Alta
**ROI**: Alto - Base reutilizable para todas las épicas

**Símbolo**: El herrero élfico que forjó los Anillos de Poder

**Descripción**:
Sistema completo de gestión de skills desde skills.sh. Busca, instala, actualiza y gestiona skills con configuración automática de `paths:`. Incluye modo automático que detecta el proyecto y configura todo sin intervención.

**Objetivo**:
Crear la base de gestión de skills reutilizable para todas las épicas futuras, aprovechando el ecosistema de skills.sh en lugar de crear skills manualmente.

**Entregables MVP** (v1.0):
- [x] Módulo Buscar - Buscar skills en skills.sh ✅
- [x] Módulo Instalar - Instalar con paths: automáticos ✅
- [x] Módulo Listar - Inventario de skills instaladas ✅
- [x] Módulo Actualizar - Actualizar skills existentes ✅
- [x] Módulo Eliminar - Borrar skills individuales ✅
- [x] Detector de entorno (Node.js >=18) ✅
- [x] Menú principal con navegación ✅
- [x] Opciones WIP documentadas (Modo Auto, Backend Git) ✅
- [x] Backend CLI funcional (Node.js >=18) ✅
- [x] Integración con skills.sh oficial ✅
- [x] Testing validado ✅

**Entregables Futuros** (v1.1+):
- [ ] Modo Automático 🤖 - Detectar proyecto y auto-configurar
- [ ] Backend Git - Alternativa sin Node.js
- [ ] Sistema de detección de proyecto (frameworks, lenguajes)
- [ ] Mapping proyecto → skills recomendadas
- [ ] Integración con Palantír Configurador

**Progreso**: 🎉 **Celebrimbor v1.0 COMPLETO - MVP Funcional** ✅
**CRUD Completo**: CREATE (Install) | READ (Search, List) | UPDATE (Update) | DELETE (Remove)
**Estado**: ✅ Completado
**Arquitectura**: 11 módulos (~4,500 líneas de prompts)
**Testing**: ✅ Validado
**XP Sprint 1**: 870 XP total (435 XP cada fundador) 🎯
**Dependencias**: Palantír ✅ (completado)
**Target**: v3.0.0 ✅ RELEASED

---

### **3. 💍 Gollum - Primer MVP Completo de TLOTP para E2E**

**GitHub Issue**: [#2](https://github.com/joseguillermomoreu-gif/tlotp/issues/2)
**Prioridad**: Alta
**ROI**: Alto - Valida concepto completo de TLOTP

**Símbolo**: "My precious" - El primer anillo funcional, obsesión por el testing perfecto

**Descripción**:
**Primer MVP completo de TLOTP** - Un prompt interactivo (`tlotp-e2e.md`) que configura automáticamente un proyecto Playwright E2E end-to-end. Gollum orquesta todo: detecta el proyecto, hace preguntas específicas, llama a Celebrimbor para instalar skills, genera configuraciones personalizadas, y valida que todo funciona.

**Gollum = Orquestador, Celebrimbor = Ejecutor de skills**

**Objetivo**:
- Crear el **primer prompt TLOTP funcional** que un usuario puede ejecutar
- Validar que TLOTP funciona end-to-end con un caso real
- Servir como **plantilla** para épicas futuras (Elrond, Gandalf)
- Demostrar el concepto: "One Prompt to Rule Them All"

**Flujo de Usuario**:
```
Usuario: @tlotp-e2e.md

Gollum:
  1. Detecta proyecto Playwright
  2. Hace preguntas específicas E2E (10-15 preguntas)
  3. Llama a Celebrimbor → instala skills (playwright, pom, typescript)
  4. Genera CLAUDE.md personalizado
  5. Genera MEMORY.md con comandos útiles
  6. Valida todo
  7. "¡Listo! Tu proyecto E2E está configurado 🎉"
```

**Entregables**:
- [ ] tlotp-e2e.md - Prompt interactivo completo
- [ ] Sistema de detección de proyectos Playwright
- [ ] Preguntas específicas E2E (convenciones, POM, CI/CD)
- [ ] Integración con Celebrimbor (modo automático)
- [ ] Generador de CLAUDE.md del proyecto
- [ ] Generador de MEMORY.md del proyecto
- [ ] Sistema de validación end-to-end
- [ ] Testing en proyecto E2E real
- [ ] Documentación de uso completa
- [ ] Ejemplo completo documentado

**Estado**: ⏳ Pendiente
**Dependencias**: Celebrimbor (debe estar completo)
**XP Estimado**: ~800-1,000 XP (10 tareas aprox.)
**Target**: Por definir

---

### **4. 🏛️ Elrond - Global & Generic Configuration**

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
**Dependencias**: Palantír, Celebrimbor, Gollum
**Target**: Por definir

---

### **5. ⚡ Gandalf - Autonomous PHP Project**

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
**Dependencias**: Palantír, Celebrimbor, Gollum, Elrond
**Target**: Por definir

---

### **6. 👑 Aragorn - Agent Orchestrator & Unified Command**

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
🔮 Palantír (CRUD Completo)                          [██████████] 100% 🎉 COMPLETO
⚒️ Celebrimbor (Forjador de Skills)                  [██████████] 100% 🎉 COMPLETO
💍 Gollum (Playwright MVP)                            [----------]   0% ⏳ Siguiente
🏛️ Elrond (Setup por tipo de proyecto)               [----------]   0%
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
Palantír → Celebrimbor → Gollum → Elrond → Gandalf
  (Dev)      (Skills)   (Quick)  (Scale)  (Auto)
   ✅           ✅         🎯       📈       🚀
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

*Última actualización: 2026-02-19*
