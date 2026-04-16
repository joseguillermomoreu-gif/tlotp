# Changelog

All notable changes to TLOTP are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/).
This project adheres to [Semantic Versioning](https://semver.org/).

---

## [6.1.1] - 2026-04-16 - "The Watchers on the Wall"

- Patch release

## [6.1.0] - 2026-04-16

- Minor improvements and fixes

## [6.0.0] - 2026-04-16

- Major release

## [5.1.0] - 2026-04-15 - "Los Escribas de Gondor"

### Changed

- G4b rewrite: tabla tech-stack reemplazada por tabla SDD methodology (EARS, Plan Mode, Kiro, ADR, C4)
- G3 Momento A: invocacion condicional al lead del team si GANDALF_TEAM activo, con fallback autonomo 30s
- Aragorn Team Builder: nuevo paso "Proponer Cronista" tras crear team — configuracion guiada del agente reporter con lore TLOTP opt-in
- Patron de reporters reutilizable: nombre, descripcion, ruta de salida, narrativa epica opcional

Closes: #340, #342

## [5.0.0] - 2026-04-15 - "The Two Towers of the Web"

### Changed

- Major release: "The Fellowship Assembled"

## [4.0.0] - 2026-04-15 - "El Mago Blanco"

### Added

- Gandalf — Spec-Driven Development completo (G0-G10)
- 5 exploradores Rohirrim paralelos (Agent tool) mapean el proyecto antes de preguntar nada
- Editor EARS interactivo para requirements.md con clasificacion MoSCoW
- design.md con diagramas Mermaid obligatorios + ADR-lite + seguridad + riesgos
- tasks.md con grafo de dependencias Mermaid + sizing S/M/L/XL + acceptance criteria
- Consejo de Rivendel condicional: La Comunidad se convoca segun el stack detectado
- G10 forge-team: Aragorn crea un Agent Team basado en el SDD automaticamente
- Documentacion on-demand: Plan Mode + Kiro + EARS via WebFetch
- Detector de SDD existente para retomar aventuras en curso
- tlotp-main.md: Gandalf activo (ya no WIP)

Closes: #264-#274

## [3.22.0] - 2026-04-15 - "El Rey que Regresa"

### Added

- Aragorn — Gestor de agentes y Agent Teams (redesign completo)
- aragorn-main.md: banner epico, permisos, menu paginado 3 pantallas, sistema lore de personajes
- 5 modulos nuevos: analyze, marketplace, create, team-builder, docs
- Sugerencias de agentes desde marketplace en tiempo real (VoltAgent + aitmpl.com)
- Lore de personajes al instalar/listar (Gimli=PHP, Legolas=review, Sam=tests...)
- Team Builder con propuesta automatica por stack + lore epico

Closes: #252-#263

## [3.16.0] - 2026-04-15 - "Las Almenaras de Gondor"

### Added

- Automatizacion del ciclo de release completo:
  - `release-prep.yml`: pre-bump workflow_dispatch — calcula version, actualiza VERSION.md, crea PR develop a master
  - `backmerge.yml`: sincronizacion automatica master a develop con [skip ci] y auto-merge
- CI hardening en `semver.yml`: paths filter + warning visible cuando falta seccion de changelog
- Branch protection endurecida: dismiss_stale_reviews, require_code_owner_reviews (develop), required_conversation_resolution

Closes: #177, #178, #179, #180, #181

## [3.15.0] - 2026-04-15 - "Guardians of the Branch"

### Changed

- Ents redesign completo + CI/CD hardening

## [3.14.0] - 2026-04-15 - "The Voices in the Stone"

### Changed

- Menu principal TLOTP rediseñado (paginacion 3 pantallas)

## [3.13.0] - 2026-03-12 - "The Voices in the Stone"

### Changed — Palantir v2.0

- Nuevo menu principal con lore LOTR: Contemplar el reino / Susurrar planes / Compartir visiones / Salir
- Nuevo modulo `02-contemplar-reino`: analisis completo con 6 WebFetch docs oficiales, scoring 0-100, sugerencias priorizadas, revisor uno a uno con contador y frases de lore
- Nuevo modulo `05-susurrar-planes`: añadir configuracion con analisis de tipo visible (CLAUDE.md/rules/hook/settings/MEMORY), analisis de scope con consecuencias de local vs global, WebFetch condicional
- Nuevo modulo `06-compartir-visiones`: importar (analisis + modo seguro / de golpe / mejorar importacion), exportar por scope a .md portable, eliminar con analisis de impacto
- Reescritura de `01-mini-guide`: lore de Isengar + solicitud de permisos al final
- Eliminados 9 modulos obsoletos (backup, reset, recovery, reconstruction-engine, configurator, hooks-system, metadata, formato-output, reglas-ejecucion)
- Renumeracion coherente de secciones segun flujo de ejecucion (00-01-02-03-04-05-06)
- `palantir-main.md` actualizado: eliminados 11 @imports obsoletos + info_claude.md estatica

### Changed — TLOTP Main

- Menu principal paginado con lore epico completo para las 5 epicas
- Deteccion de OS al inicio (`uname -s`)
- Epics con archivos afectados en linea separada bajo cada opcion
- Mini-guia de Palantir integrada al invocar la epica

Closes: #139, #140, #147, #148, #150, #151

## [3.5.0] - 2026-03-10 - "The Smuggler of Lake-town"

### Added — Bardo

- B1: Analisis de MCP servers en scopes local/project/user desde `~/.claude.json` y `.mcp.json`
- B2: Analisis de plugins instalados con clasificacion por tipo (LSP/integracion/workflow/output)
- B3: Detector de stack tecnologico (PHP, TypeScript, Python, Go, Rust, Java + frameworks + DBs + servicios)
- B4: Consulta en tiempo real al marketplace oficial via WebFetch — nunca hardcodeado
- B5: Motor de recomendaciones con matching stack a MCPs/plugins + por que, para que y ejemplo de uso
- B6: Asistente de instalacion guiada item a item con seleccion de scope y confirmacion explicita
- B7: Verificacion post-instalacion con semaforos y resolucion accionable por item
- Bardo integrado en menu principal de TLOTP como opcion 2 (entre Palantir y Celebrimbor)

Closes: #81-#88, #98, #99

## [3.4.0] - 2026-02-27 - "The All-Seeing Hooks"

### Added — Palantir Hooks

- Nuevo modulo `11-hooks-system.md` para gestion completa de hooks (#52)
- Inspeccion de hooks en 3 niveles de settings.json con analisis inteligente
- Creacion asistida: describe que automatizar, Palantir genera el hook JSON
- Decision Helper: arbol interactivo para elegir entre hook vs rule vs CLAUDE.md vs MCP
- Validacion exclusiva contra documentacion oficial via WebFetch
- Deteccion de conflictos, anti-loops, y metricas de cobertura

### Added — Documentacion Live

- Nuevo fichero `docs-sources.md` como indice central de documentacion (#64)
- Reemplazadas ~545 lineas hardcodeadas por instrucciones WebFetch a URLs oficiales
- 7+ fuentes oficiales indexadas (memory, hooks-guide, agent-teams, skills, sub-agents, output-styles)

### Added — Permisos Pre-aprobados

- Nuevo PASO 1.5 al inicio de TLOTP para solicitar permisos antes del menu (#49)
- 5 permisos necesarios: Bash, WebFetch, Write, Edit, Read
- 3 opciones: aprobar todos, revisar uno a uno, cancelar

Closes: #49, #52, #64

## [3.3.0] - 2026-02-26 - "The Contextual Forge"

### Added — Celebrimbor Post-instalacion

- Nuevo modulo `15-module-post-install-rules.md` para crear rules con `paths:` tras instalar una skill
- Activacion contextual nativa: skills se invocan solo al tocar ficheros que matchean el patron
- Sugerencias inteligentes de globs por tipo de skill (10 tipos: TypeScript, Playwright, Python, PHP, CI/CD...)
- Deteccion de rules existentes para evitar duplicados
- Agrupacion de skills en una sola rule si comparten paths
- Actualizado `08-module-install.md` con nuevo Paso 6.5
- Zero coste de contexto hasta activacion (vs CLAUDE.md que carga siempre)

Closes: #53

## [3.2.0] - 2026-02-26 - "The Forger's Knowledge"

### Added — Celebrimbor CLI

- Nuevo modulo `14-skills-cli-reference.md` basado en repo oficial `vercel-labs/skills`
- Corregido `search` a `find` (comando real del CLI)
- Documentados todos los flags reales: `-g`, `-a`, `-s`, `-l`, `-y`, `--copy`, `--all`
- Documentados 7 comandos: `add`, `find`, `list/ls`, `check`, `update`, `init`, `remove/rm`
- Actualizado `04-backend-cli.md` alineado con la realidad
- Registrado modulo 14 en arquitectura de Celebrimbor

Closes: #54
Supersedes: #47

## [3.0.0] - 2026-02-16 - "The Two Towers"

### Breaking Changes

- Menu principal TLOTP completamente rediseñado (mas conciso)
- Documentacion reorganizada y simplificada
- Opciones WIP ahora muestran informacion detallada al seleccionarse

### Added

- Concepto: "Un prompt para dominarlos a todos"
- Documentacion interactiva mejorada (Opcion 3)
- Seccion "Sobre TLOTP" (Opcion 4)
- Descripcion de epicas mas concisa
- Usa documentacion oficial Claude Code on-the-fly
- Combina con configuraciones existentes sin borrar

### Stats

- 2 epicas completadas (Palantir + Celebrimbor)
- 22 modulos totales
- ~8,330 lineas de prompts
- 2,540 XP acumulados (gamificacion)

## [2.1.0] - 2026-02-16 - "La Comunidad del Codigo"

### Added

- Palantir CRUD completo operativo
- Celebrimbor MVP funcional con backend CLI
- 15,845 lineas totales de prompts
- 7 epicas diseñadas (2 completas, 5 planificadas)

## [2.0.0] - Previous

- Version inicial de desarrollo con prototipos.
