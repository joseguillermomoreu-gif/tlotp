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
Sistema para visualizar y gestionar configuraciones de TLOTP, tanto globales como por proyecto. Permite inspeccionar qué está configurado y resetear/vaciar cuando sea necesario.

**Objetivo**:
Herramienta fundamental para desarrollar y testear las siguientes épicas.

**Entregables**:
- [ ] Comando/prompt para inspeccionar config global
- [ ] Comando/prompt para inspeccionar config de proyecto
- [ ] Sistema de reset con confirmación
- [ ] Documentación de uso

**Estado**: ⏳ Pendiente
**Target**: Por definir

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

## 📊 Progreso General

```
🔮 Palantír (Inspector)        [----------]  0%
💍 Gollum (Playwright MVP)     [----------]  0%
🏛️ Elrond (Global Config)      [----------]  0%
⚡ Gandalf (Autonomous)        [----------]  0%
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

```
Palantír → Gollum → Elrond → Gandalf
  (Dev)   (Quick)  (Scale)  (Ultimate)
   ⚡       🎯       📈        🚀
```

**Orden por ROI**:
1. Herramienta de soporte (necesaria para desarrollo)
2. MVP específico (valida el concepto)
3. Generalización (escala la solución)
4. Autonomía total (objetivo final)

---

*"One Prompt to Rule Them All"* 💍

*Última actualización: 2026-02-12*
