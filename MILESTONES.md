# 💍 ÉPICAS - The Journey of TLOTP

> **Organización**: Cada épica usa un personaje de The Lord of the Rings
> **Propósito**: "One Prompt to Rule Them All" - Temática coherente con TLOTP

---

## 🎯 Sistema de Épicas

Cada **épica** representa una herramienta completa del menú TLOTP y lleva el nombre
de un personaje de la Tierra Media que simboliza su propósito.

### **Formato de Issues**

```
[PERSONAJE] Descripción de la tarea

Ejemplo:
[Palantír] Implementar inspector de configuración
[Bardo] Módulo de análisis de MCPs
```

---

## 🗺️ Épicas — Estado Actual

### **1. 🔮 Palantír — Inspector de Configuración**

**Issues**: [#1](https://github.com/joseguillermomoreu-gif/tlotp/issues/1)
**Símbolo**: La piedra vidente que permite VER y GESTIONAR todo

**Descripción**: Sistema para visualizar y gestionar configuraciones de Claude Code
siguiendo la jerarquía oficial. CRUD completo: Inspector (READ), Configurador (CREATE),
Recovery (UPDATE), Reset (DELETE). Sistema de backups, detección de conflictos, hooks.

**Progreso**: 🎉 **ÉPICA COMPLETA** — Palantír v1.7 CRUD Total ✅
**Arquitectura**: 12 módulos
**Target**: v3.0.0 ✅ RELEASED


---

### **2. 🏹 Bardo — Proveedor de MCPs y Plugins**

**Issues**: [#81](https://github.com/joseguillermomoreu-gif/tlotp/issues/81)–[#88](https://github.com/joseguillermomoreu-gif/tlotp/issues/88)
**Símbolo**: El contrabandista que trae mercancía fresca del exterior

**Descripción**: Análisis, descubrimiento e instalación asistida de MCP servers y plugins
de Claude Code. Sin hardcodeo: WebFetch en tiempo real. Análisis de stack, recomendaciones
inteligentes (stack → MCPs/plugins), instalación guiada, verificación post-instalación.

**Progreso**: 🎉 **ÉPICA COMPLETA** — B0–B7 implementados ✅
**Arquitectura**: 7 módulos (B1–B7)
**Target**: v3.5.0 ✅ RELEASED

---

### **3. ⚒️ Celebrimbor — Gestor de Skills**

**Issues**: [#42](https://github.com/joseguillermomoreu-gif/tlotp/issues/42)
**Símbolo**: El herrero élfico que forjó los Anillos de Poder

**Descripción**: Gestión completa de skills desde skills.sh (59,000+). Busca, instala,
actualiza y elimina skills con configuración automática de `paths:`. Backend CLI Node.js.

**Progreso**: 🎉 **ÉPICA COMPLETA** — Celebrimbor v1.0 MVP ✅
**Arquitectura**: 11 módulos (~4,234 líneas)
**Target**: v3.0.0 ✅ RELEASED

---

### **4. 🌳 Ents — CI/CD Guardians**

**Issues**: [#71](https://github.com/joseguillermomoreu-gif/tlotp/issues/71)
**Símbolo**: Los pastores del bosque que custodian el código

**Descripción**: Asistente para analizar, visualizar, mejorar y crear pipelines de
GitHub Actions. Docs en tiempo real vía WebFetch. Siete módulos: analyzer, diagram
renderer, improvement engine, modifier, creator. Sin docs estáticas.

**Progreso**: 🎉 **ÉPICA COMPLETA** — Ents v1.0 ✅
**Arquitectura**: 8 módulos
**Target**: v3.4.0 ✅ RELEASED


---

### **5. 👑 Aragorn — Gestor de Agentes y Subagentes**

**Issues**: [#57](https://github.com/joseguillermomoreu-gif/tlotp/issues/57)–[#60](https://github.com/joseguillermomoreu-gif/tlotp/issues/60), [#63](https://github.com/joseguillermomoreu-gif/tlotp/issues/63), [#105](https://github.com/joseguillermomoreu-gif/tlotp/issues/105)–[#109](https://github.com/joseguillermomoreu-gif/tlotp/issues/109)
**Símbolo**: El rey que reúne ejércitos de toda la Tierra Media

**Descripción**: Análogo a Celebrimbor pero para agentes/subagentes. Descubre,
instala y gestiona agentes desde marketplaces externos: VoltAgent (127+ agentes) y
aitmpl.com (600+ componentes). Listar instalados, buscar, instalar guiado con selección
de scope (global/proyecto), verificar, actualizar, eliminar. Team Builder para
configurar Agent Teams experimentales.

**Tareas**: AR0–AR9 (10 tareas)
**Progreso**: ⏳ En diseño — 0% implementado
**Target**: v4.0.0

---

### **6. ⚡ Gandalf — Iniciar una Nueva Aventura**

**Issues**: [#111](https://github.com/joseguillermomoreu-gif/tlotp/issues/111)
**Símbolo**: El mago que guía la Fellowship — ningún gran proyecto empieza sin plan

**Descripción**: **Última opción del menú TLOTP.** Asistente interactivo de
**Spec-Driven Development** que guía la creación de un SDD profesional antes de
escribir una línea de código. El antídoto al vibe coding.

Sigue el estándar emergente **Kiro/GitHub Spec-Kit** (2025-2026) y genera 3 ficheros:

- `requirements.md` — User stories en formato EARS + criterios de aceptación
- `design.md` — Arquitectura, decisiones con trade-offs, diagramas Mermaid
- `tasks.md` — Tareas ordenadas por dependencias, estimaciones, acceptance criteria

Compatible con Claude Code Plan Mode, Amazon Kiro, Cursor, Copilot y cualquier
herramienta de desarrollo asistido por IA.

**Lore — El Consejo de Rivendel**: cada componente del proyecto suma un miembro
a la Fellowship con su frase icónica:

```
Gimli dijo   → "¡Cuenta con mi hacha!"          (Backend PHP/Symfony)
Legolas dijo → "¡Y con mi arco!"                (Frontend TypeScript)
Sam dijo     → "¡El señor Frodo no irá solo!"   (Testing / QA)
Aragorn dijo → "¡Con Andúril, reforjada!"        (Agentes instalados)
Bardo dijo   → "¡Mis flechas conocen el camino!" (MCPs configurados)
Los Ents     → "¡Los Ents marchan a la guerra!"  (CI/CD)
Boromir dijo → "¡Gondor os apoyará!"             (Base de datos / ORM)
Gandalf dijo → "Así comienza... cada gran historia" (SDD listo)
```

**Tareas**: G0–G8 (9 tareas)
**Progreso**: ⏳ En diseño — 0% implementado
**Target**: v5.0.0

---

### **💍 Gollum — Companion de Testing** *(forma TBD)*

**Issues**: [#2](https://github.com/joseguillermomoreu-gif/tlotp/issues/2)
**Símbolo**: "Mi precioso... los tests son mi precioso"

**Descripción**: Companion especializado en testing. Sabe lanzar tests (PHPUnit,
Playwright, Jest, pytest...), mantenerlos, analizar fallos, buscar causas raíz e
interpretar CI/CD. **No es una épica de menú**: su forma final (skill, agente o
subagente instalable vía Aragorn/Celebrimbor) se decidirá cuando llegue el momento.

**Progreso**: 💭 Diseño futuro — forma TBD

---

## 📊 Progreso General

```
🔮 Palantír    — Inspector de Configuración    [██████████] 100% ✅ COMPLETO
🏹 Bardo       — Proveedor MCPs y Plugins      [██████████] 100% ✅ COMPLETO
⚒️ Celebrimbor — Gestor de Skills              [██████████] 100% ✅ COMPLETO
🌳 Ents        — CI/CD Guardians               [██████████] 100% ✅ COMPLETO
👑 Aragorn     — Gestor de Agentes             [----------]   0% 🎯 Siguiente
⚡ Gandalf     — Iniciar una Nueva Aventura    [----------]   0% 📐 Diseñado
💍 Gollum      — Companion de Testing (TBD)   [----------]   0% 💭 Futuro
```

---

## 🗺️ Roadmap

```
Palantír → Celebrimbor → Bardo → Ents → Aragorn → Gandalf → Gollum(TBD)
  (Dev)      (Skills)   (MCPs)  (CI/CD) (Agentes)  (SDD)    (Testing)
   ✅           ✅         ✅      ✅       🎯         📐        💭
```

**Menú TLOTP final (objetivo)**:

```
1. 🔮 Palantír       — Inspector y gestor de configuración
2. 🏹 Bardo          — MCPs y plugins
3. ⚒️ Celebrimbor    — Skills
4. 🌳 Ents           — CI/CD Guardians
5. 👑 Aragorn        — Agentes y subagentes
6. ⚡ Gandalf        — Iniciar una nueva aventura (SDD)
7. 🚪 Salir de TLOTP
```

---

## 🎮 Convenciones

1. **Prefijo obligatorio**: `[PERSONAJE]` al inicio del título de issues
2. **Labels**: `enhancement`, `bug`, `docs` según corresponda
3. **Branches**: `feature/t{num}_{desc}` desde `origin/develop`

---

*"One Prompt to Rule Them All"* 💍

*Última actualización: 2026-03-15*
*Mantenido por: La Fellowship del Teclado (Pépeton hijo de Móreuton + Claudeton hijo de Codeton)*
