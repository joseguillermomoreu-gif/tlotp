# 🏷️ TLOTP - Versionado del Proyecto

> **Fuente única de verdad** para la versión de TLOTP

---

## 📊 Versión Actual

**TLOTP v3.13.0**
- **Fecha release**: 2026-03-12
- **Nombre código**: "The Voices in the Stone" (Palantír redesign + TLOTP lore)

---

## 🎯 Componentes Incluidos

### ✅ Palantír - Inspector de Configuración
**Estado**: Completado
- Inspector CRUD completo (Read, Reset, Recovery, Configurador, Hooks)
- Sistema de backups automáticos
- Detección de conflictos y merge inteligente
- Gestión de hooks: inspección, creación asistida, decision helper
- 12 módulos

### ✅ Celebrimbor - Gestor de Skills
**Estado**: MVP Completado
- CRUD completo (Search, Install, List, Update, Remove)
- Backend CLI (Node.js >=18)
- Integración con skills.sh (59,000+ skills)
- 11 módulos, 4,234 líneas

### ✅ Bardo - Proveedor de MCPs y Plugins
**Estado**: Completado
- Análisis de MCP servers en todos los scopes (local/project/user)
- Análisis de plugins instalados con clasificación por tipo
- Detector de stack tecnológico (lenguajes, frameworks, DBs, servicios)
- Consulta en tiempo real al marketplace oficial (sin hardcodeo)
- Motor de recomendaciones con por qué, para qué y ejemplos de uso
- Asistente de instalación guiada ítem a ítem con confirmación
- Verificación post-instalación con semáforos ✅⚠️❌
- 7 módulos (B1–B7)

### ⏳ Gollum - E2E Testing
**Estado**: Planificado
- Playwright automation
- Page Object Model

### ⏳ Elrond - Global Config
**Estado**: Planificado
- Gestión de configuración global

### ⏳ Gandalf - Autonomous Workflow
**Estado**: Planificado
- Workflow autónomo PHP/Symfony

---

## 📝 Formato de Uso en Prompts

**En banners header**:
```
═══ TLOTP v3.4.0 ═══
```

**En títulos de archivos**:
```
# 💍 TLOTP v3.4.0 - The Lord of the Prompt
```

**En metadata**:
```
Versión: TLOTP v3.4.0
```

---

## 📋 Changelog

### v3.13.0 (2026-03-12) - "The Voices in the Stone"

**🔮 Palantír v2.0 — Rediseño completo**:
- Nuevo menú principal con lore LOTR: Contemplar el reino / Susurrar planes / Compartir visiones / Salir
- Nuevo módulo `02-contemplar-reino`: análisis completo con 6 WebFetch docs oficiales, scoring 0-100, sugerencias priorizadas 🔴🟡🟢, revisor uno a uno con contador y frases de lore
- Nuevo módulo `05-susurrar-planes`: añadir configuración con análisis de tipo visible (CLAUDE.md/rules/hook/settings/MEMORY), análisis de scope con consecuencias de local vs global, WebFetch condicional
- Nuevo módulo `06-compartir-visiones`: importar (análisis + modo seguro / de golpe / mejorar importación), exportar por scope a .md portable, eliminar con análisis de impacto
- Reescritura de `01-mini-guide`: lore de Isengar + solicitud de permisos al final
- Eliminados 9 módulos obsoletos (backup, reset, recovery, reconstruction-engine, configurator, hooks-system, metadata, formato-output, reglas-ejecucion)
- Renumeración coherente de secciones según flujo de ejecución (00→01→02→03→04→05→06)
- `palantir-main.md` actualizado: eliminados 11 @imports obsoletos + info_claude.md estática

**🧭 TLOTP Main — Lore y navegación**:
- Menú principal paginado con lore épico completo para las 5 épicas
- Detección de OS al inicio (`uname -s` → 🐧/🍎/🪟)
- Epics con archivos afectados en línea separada bajo cada opción
- Mini-guía de Palantír integrada al invocar la épica

**Closes**: #139, #140, #147, #148, #150, #151

---

### v3.5.0 (2026-03-10) - "The Smuggler of Lake-town"

**🏹 Bardo - Proveedor de MCPs y Plugins (épica completa)**:
- B1: Análisis de MCP servers en scopes local/project/user desde `~/.claude.json` y `.mcp.json`
- B2: Análisis de plugins instalados con clasificación por tipo (LSP/integración/workflow/output)
- B3: Detector de stack tecnológico (PHP, TypeScript, Python, Go, Rust, Java + frameworks + DBs + servicios)
- B4: Consulta en tiempo real al marketplace oficial vía WebFetch — nunca hardcodeado
- B5: Motor de recomendaciones con matching stack→MCPs/plugins + por qué, para qué y ejemplo de uso
- B6: Asistente de instalación guiada ítem a ítem con selección de scope y confirmación explícita
- B7: Verificación post-instalación con semáforos ✅⚠️❌ y resolución accionable por ítem
- Bardo integrado en menú principal de TLOTP como opción 2 (entre Palantír y Celebrimbor)

**Closes**: #81–#88, #98, #99

---

### v3.4.0 (2026-02-27) - "The All-Seeing Hooks"

**Palantír - Sistema de Hooks**:
- Nuevo módulo `11-hooks-system.md` para gestión completa de hooks (#52)
- Inspección de hooks en 3 niveles de settings.json con análisis inteligente
- Creación asistida: describe qué automatizar → Palantír genera el hook JSON
- Decision Helper: árbol interactivo para elegir entre hook vs rule vs CLAUDE.md vs MCP
- Validación exclusiva contra documentación oficial via WebFetch
- Detección de conflictos, anti-loops, y métricas de cobertura

**TLOTP General - Documentación Live**:
- Nuevo fichero `docs-sources.md` como índice central de documentación (#64)
- Reemplazadas ~545 líneas hardcodeadas por instrucciones WebFetch a URLs oficiales
- 7+ fuentes oficiales indexadas (memory, hooks-guide, agent-teams, skills, sub-agents, output-styles)
- Módulos afectados: info_claude.md, 03-jerarquia-oficial.md, 14-skills-cli-reference.md, 04-backend-cli.md, 15-module-post-install-rules.md

**TLOTP General - Permisos Pre-aprobados**:
- Nuevo PASO 1.5 al inicio de TLOTP para solicitar permisos antes del menú (#49)
- 5 permisos necesarios: Bash, WebFetch, Write, Edit, Read
- 3 opciones: aprobar todos, revisar uno a uno, cancelar

**Closes**: #49, #52, #64

---

### v3.3.0 (2026-02-26) - "The Contextual Forge"

**Celebrimbor - Post-instalación: Rules con Paths**:
- Nuevo módulo `15-module-post-install-rules.md` para crear rules con `paths:` tras instalar una skill
- Activación contextual nativa: skills se invocan solo al tocar ficheros que matchean el patrón
- Sugerencias inteligentes de globs por tipo de skill (10 tipos: TypeScript, Playwright, Python, PHP, CI/CD...)
- Detección de rules existentes para evitar duplicados
- Agrupación de skills en una sola rule si comparten paths
- Actualizado `08-module-install.md` con nuevo Paso 6.5
- Zero coste de contexto hasta activación (vs CLAUDE.md que carga siempre)

**Closes**: #53

---

### v3.2.0 (2026-02-26) - "The Forger's Knowledge"

**Celebrimbor - Referencia CLI oficial**:
- Nuevo módulo `14-skills-cli-reference.md` basado en repo oficial `vercel-labs/skills`
- Corregido `search` → `find` (comando real del CLI)
- Documentados todos los flags reales: `-g`, `-a`, `-s`, `-l`, `-y`, `--copy`, `--all`
- Documentados 7 comandos: `add`, `find`, `list/ls`, `check`, `update`, `init`, `remove/rm`
- Actualizado `04-backend-cli.md` alineado con la realidad
- Registrado módulo 14 en arquitectura de Celebrimbor

**Closes**: #54
**Supersedes**: #47

---

### v3.0.0 (2026-02-16) - "The Two Towers"

**🎉 MAJOR RELEASE - Primera versión production-ready**

**Breaking Changes**:
- Menú principal TLOTP completamente rediseñado (más conciso)
- Documentación reorganizada y simplificada
- Opciones WIP ahora muestran información detallada al seleccionarse

**✨ Features Principales**:

**TLOTP General**:
- 💍 Nuevo concepto: "Un prompt para dominarlos a todos"
- 📚 Documentación interactiva mejorada (Opción 3)
- ℹ️ Sección "Sobre TLOTP" (Opción 4)
- 🎯 Descripción de épicas más concisa
- ✨ Usa documentación oficial Claude Code on-the-fly
- 🔄 Combina con configuraciones existentes sin borrar

**Palantír v1.7**:
- ✅ CRUD completo operativo
- 🔍 Analyzer de mejoras sugeridas
- 🛡️ Sistema de backup obligatorio
- 🔧 Configurador asistido con detección de conflictos
- 11 módulos, ~3,830 líneas

**Celebrimbor v1.0**:
- ✅ MVP completado con todas las operaciones CRUD
- 🔍 Search - Buscar en 59,000+ skills de skills.sh
- 📥 Install - Instalación con auto-config de paths
- 📋 List - Listar skills instaladas (global/local)
- 🔄 Update - Actualizar todas las skills
- 🗑️ Remove - Eliminar skills individuales
- ⚙️ Backend CLI funcional (Node.js >=18)
- 🚧 Opciones WIP documentadas (Modo Auto, Backend Git)
- 11 módulos, ~4,500 líneas

**📊 Estadísticas**:
- 2 épicas completadas (Palantír + Celebrimbor)
- 22 módulos totales
- ~8,330 líneas de prompts
- 2,540 XP acumulados (gamificación)
- Sistema completamente funcional y testeado

**🎯 Próximos pasos**:
- v3.1.0: Celebrimbor - Backend Git + Modo Automático
- v4.0.0: Gollum (Playwright E2E MVP)

---

### v2.1.0 (2026-02-16) - "The Fellowship of the Code"

**🎉 Release Highlights**:
- Palantír CRUD completo operativo
- Celebrimbor MVP funcional con backend CLI
- 15,845 líneas totales de prompts
- 7 épicas diseñadas (2 completas, 5 planificadas)

**✨ Features Principales**:

**Palantír**:
- Sistema de configuración asistida con detección de conflictos
- Motor de reconstrucción inteligente
- Reset selectivo (global/proyecto/skills/regla por regla)
- Recovery desde backups con merge
- Inspector de 7 niveles de jerarquía oficial

**Celebrimbor**:
- Gestión completa de skills (CRUD)
- Arquitectura dual-backend (CLI + Git futuro)
- Detección automática de updates al inicio
- Integración con skills.sh
- Detección de duplicados pre-instalación

**TLOTP General**:
- Menú épico de selección de herramientas
- Banner del Anillo Único (One Ring ASCII art)
- Sistema de navegación entre épicas
- Documentación completa

**📊 Estadísticas**:
- 22 módulos totales
- 2 épicas completadas
- 710 XP generados (gamificación)
- 46 issues de GitHub
- 3 épicas activas

---

### v2.0.0 (anterior)

Versión inicial de desarrollo con prototipos.

---

## 🔄 Versionado Semántico

TLOTP sigue [Semantic Versioning 2.0.0](https://semver.org/):

**MAJOR** (x.0.0):
- Cambios incompatibles con versión anterior
- Reestructuración completa
- Breaking changes en arquitectura

**MINOR** (x.y.0):
- Nuevas features compatibles hacia atrás
- Nuevas épicas completadas
- Mejoras significativas

**PATCH** (x.y.z):
- Bug fixes
- Mejoras de documentación
- Refactoring interno

---

## 🚀 Roadmap de Versiones

### v3.6.0 (Próxima minor)
- Palantír: Export/Import de configs (#28)
- Palantír: Mejorar detección de duplicados (#51)
- Palantír: Mejorar sistema de backup (#37)

### v4.0.0 (Próxima major - Gollum)
- Gollum: Playwright E2E MVP
- Setup automático de proyectos Playwright
- Integración con Celebrimbor para skills

### v5.0.0 (Futuro - Elrond & Gandalf)
- Elrond: Global Config System
- Gandalf: Autonomous Workflow MVP

### v6.0.0+ (Visión - Aragorn)
- Aragorn: Multi-Agent Orchestration
- Dashboard web interactivo
- CLI universal

---

## 🔧 Gestión de Versiones

**Actualización manual** (actual):
1. Editar este archivo (`VERSION.md`)
2. Actualizar referencias en prompts
3. Crear tag de Git: `git tag vX.Y.Z`
4. Push: `git push --tags`

**Automatización futura** (issue #44):
- GitHub Action automático
- Basado en conventional commits
- Auto-update de `VERSION.md`

---

*Última actualización: 2026-03-10*
*Mantenido por: La Fellowship del Teclado (Pépeton + Claudeton)*
