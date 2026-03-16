# 🧙‍♂️ TLOTP - The Lord of the Prompt

> **"Un prompt para configurarlos a todos"**

[Issues](https://github.com/joseguillermomoreu-gif/tlotp/issues) | [Roadmap](MILESTONES.md) | [Contribuir](CONTRIBUTING.md)

Un único super-prompt para auto-configurar Claude Code de forma asistida, inteligente y evolutiva.

> ✅ **4 épicas production-ready** (Palantír · Bardo · Celebrimbor · Ents). En desarrollo: Aragorn (agentes) y Gandalf (Spec-Driven Development).

---

## 🎯 ¿Qué problema resuelve TLOTP?

### ❌ El Problema

Configurar Claude Code correctamente requiere:
- Crear múltiples archivos de configuración manualmente
- Mantener skills actualizadas (se vuelven obsoletas rápido)
- Recordar preferencias entre proyectos
- Instalar y mantener scripts complejos
- Buscar, evaluar e instalar skills una a una

### ✅ La Solución

**Un único prompt** que hace todo de forma asistida e interactiva:
- 🔮 **Inspecciona y gestiona** todas tus configuraciones de Claude Code
- 🏹 **Descubre e instala** MCPs y plugins desde el marketplace oficial en tiempo real
- ⚒️ **Busca, instala y actualiza** skills desde [skills.sh](https://skills.sh) (59,000+)
- 🌳 **Analiza, mejora y crea** pipelines de GitHub Actions
- 👑 **Gestiona agentes** desde marketplaces (VoltAgent + aitmpl.com) *(en desarrollo)*
- ⚡ **Diseña proyectos** con Spec-Driven Development antes de escribir código *(en desarrollo)*

Sin instalación. Sin scripts. Solo copy-paste del prompt.

---

## ⚡ Inicio Rápido

Ejecuta el menú principal de TLOTP para acceder a todas las épicas:

```
@prompts/tlotp-main.md
```

Desde ahí podrás elegir:
- 🔮 **Palantír** — Gestor de configuraciones ✅ Production-ready
- 🏹 **Bardo** — Proveedor de MCPs y plugins ✅ Production-ready
- ⚒️ **Celebrimbor** — Forjador de skills ✅ Production-ready
- 🌳 **Ents** — Guardianes del CI/CD ✅ Production-ready
- 👑 **Aragorn** — Gestor de agentes 🚧 En desarrollo
- ⚡ **Gandalf** — Iniciar una nueva aventura (SDD) 📐 Diseñado

O puedes usar cada épica directamente:

```
@prompts/palantir/palantir-main.md
```
```
@prompts/bardo/bardo-main.md
```
```
@prompts/celebrimbor/celebrimbor-main.md
```
```
@prompts/ents/ents-main.md
```

---

## 📊 Estado Actual

**Versión**: TLOTP v3.5.0 — *"The Smuggler of Lake-town"*

| Épica | Estado | Descripción |
|-------|--------|-------------|
| 🔮 **Palantír v1.7** | ✅ Completado | CRUD completo de configuraciones Claude Code |
| 🏹 **Bardo v1.0** | ✅ Completado | MCPs y plugins: analizar, recomendar, instalar, verificar |
| ⚒️ **Celebrimbor v1.0** | ✅ Completado | Gestión de skills desde skills.sh (59,000+) |
| 🌳 **Ents v1.0** | ✅ Completado | Analizar, mejorar y crear pipelines GitHub Actions |
| 👑 **Aragorn** | 🚧 En desarrollo | Gestor de agentes/subagentes (VoltAgent + aitmpl.com) |
| ⚡ **Gandalf** | 📐 Diseñado | Spec-Driven Development — El Consejo de Rivendel |
| 💍 **Gollum** | 💭 Futuro | Companion de testing (skill/agente — forma TBD) |

---

## 🔮 Palantír — The All-Seeing Configuration Stone

Inspector y gestor completo de configuraciones de Claude Code con CRUD total:

- **Inspector** (READ) — 7 niveles de jerarquía oficial + detección custom
- **Reset** (DELETE) — Completo o selectivo con backup obligatorio antes de borrar
- **Recovery** (UPDATE) — Restaurar desde backups con merge inteligente
- **Configurador** (CREATE) — Añadir preferencias con detección de conflictos y propuestas iterativas

**[📖 Guía de Uso](docs/PALANTIR.md)** | **Issue épica**: [#1](https://github.com/joseguillermomoreu-gif/tlotp/issues/1)

---

## ⚒️ Celebrimbor — El Forjador de Skills

Gestión completa de skills desde [skills.sh](https://skills.sh) (59,000+ skills curadas):

- **Search** — Buscar skills por nombre o categoría con preview
- **Install** — Instalación global o por proyecto con configuración automática de `paths:`
- **List** — Inventario de skills instaladas (global y local)
- **Update** — Detectar y actualizar skills con nuevas versiones
- **Remove** — Eliminar skills individuales

**Requisito**: Node.js >= 18 (usa `npx skills`)

**[📖 Guía de Uso](prompts/celebrimbor/README.md)** | **Issue épica**: [#42](https://github.com/joseguillermomoreu-gif/tlotp/issues/42)

---

## 🌳 Ents — Guardianes del CI/CD

Asistente interactivo para analizar, visualizar, mejorar y crear pipelines
de GitHub Actions. Sin docs estáticas: consulta la documentación oficial
en tiempo real vía WebFetch.

- **Analyzer** — Escaneo completo del CI/CD del proyecto
- **Diagram Renderer** — Visualización ASCII de pipelines
- **Improvement Engine** — Sugerencias con docs oficiales live
- **Modifier** — Modificación guiada con preview antes de aplicar
- **Creator** — Crear GitHub Actions desde cero paso a paso

**Acceso directo**: `@prompts/ents/ents-main.md` | **Issue épica**: [#71](https://github.com/joseguillermomoreu-gif/tlotp/issues/71)

---

## 🚀 Próximas Épicas

### 👑 Aragorn — Gestor de Agentes y Subagentes *(en desarrollo)*
Análogo a Celebrimbor pero para agentes: descubre e instala agentes desde
**VoltAgent** (127+ agentes) y **aitmpl.com** (600+ componentes). Gestión completa
(buscar, instalar con scope global/proyecto, verificar, actualizar, eliminar) y
**Team Builder** para configurar Agent Teams experimentales.

### ⚡ Gandalf — Iniciar una Nueva Aventura *(diseñado)*
La última opción del menú TLOTP. Asistente de **Spec-Driven Development** que guía
la creación de un SDD profesional antes de escribir código — el antídoto al vibe coding.
Genera 3 ficheros compatibles con Claude Code Plan Mode, Amazon Kiro y Cursor:
`requirements.md` (EARS format) + `design.md` (arquitectura + decisiones) + `tasks.md`.
Lore: el **Consejo de Rivendel**, donde cada componente del proyecto suma un miembro
a La Comunidad del Código con su frase icónica (*"¡Cuenta con mi hacha!"*, *"¡Y con mi arco!"*...).

---

## 🆚 vs. claude-code-auto-skills

| Aspecto | claude-code-auto-skills | TLOTP |
|---------|-------------------------|-------|
| **Instalación** | Scripts bash complejos | ❌ Ninguna |
| **Skills** | Archivos estáticos | ✅ Desde skills.sh (59k+) |
| **Actualización** | Manual (git pull) | ✅ Automática vía CLI |
| **Scope** | Solo skills | ✅ Workflow completo |
| **Portabilidad** | Instalar en cada máquina | ✅ Universal (copy-paste) |
| **Agentes** | ❌ No soporta | ✅ Gestión asistida *(próximo)* |

TLOTP es la **evolución** de claude-code-auto-skills.

---

## 📖 Documentación

- **[MILESTONES.md](MILESTONES.md)** — Épicas y roadmap (temática LOTR)
- **[CONTRIBUTING.md](CONTRIBUTING.md)** — Cómo contribuir y sistema de gamificación
- **[docs/PALANTIR.md](docs/PALANTIR.md)** — Guía completa de Palantír
- **[prompts/celebrimbor/README.md](prompts/celebrimbor/README.md)** — Guía de Celebrimbor

---

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Ver **[CONTRIBUTING.md](CONTRIBUTING.md)** para el sistema de gamificación, épicas disponibles y cómo unirte a La Comunidad del Código.

---

## 👨‍💻 Autor

**José Guillermo Moreu**
- GitHub: [@joseguillermomoreu-gif](https://github.com/joseguillermomoreu-gif)
- Proyecto anterior: [claude-code-auto-skills](https://github.com/joseguillermomoreu-gif/claude-code-auto-skills)

---

## 📖 Glosario de Documentación Oficial

TLOTP consulta documentación en tiempo de ejecución (nunca hardcodeada). Este glosario centraliza todas las fuentes, qué épica las usa y dónde más podrían aplicarse.

> Índice completo con instrucciones de uso: [`prompts/docs-sources.md`](prompts/docs-sources.md)

### Claude Code — Documentación Oficial

| URL | Descripción | Épicas | Potencial |
|-----|-------------|--------|-----------|
| [how-claude-code-works](https://code.claude.com/docs/en/how-claude-code-works) | Arquitectura interna y flujo de contexto | Palantír | Todos |
| [features-overview](https://code.claude.com/docs/en/features-overview) | Resumen de todas las features disponibles | Palantír | Todos |
| [best-practices](https://code.claude.com/docs/en/best-practices) | Mejores prácticas oficiales | Palantír | Celebrimbor, Gandalf |
| [settings](https://code.claude.com/docs/en/settings) | Configuración global/proyecto, permisos, allowlists | Palantír | Celebrimbor, Aragorn |
| [memory](https://code.claude.com/docs/en/memory) | Jerarquía de memoria (7 niveles), rules, auto memory | Palantír, Celebrimbor | Aragorn, Gandalf |
| [hooks-guide](https://code.claude.com/docs/en/hooks-guide) | Hooks: tipos, eventos, matchers, configuración | Palantír | Ents, Aragorn |
| [skills](https://code.claude.com/docs/en/skills) | Skills nativas: SKILL.md, frontmatter, invocación | Celebrimbor | Palantír |
| [mcp](https://code.claude.com/docs/en/mcp) | MCPs: configurar servidores, scopes, transports | Bardo | Aragorn, Palantír |
| [plugins](https://code.claude.com/docs/en/plugins) | Plugins: estructura, instalación, diferencias con skills | Bardo | Celebrimbor |
| [discover-plugins](https://code.claude.com/docs/en/discover-plugins) | Descubrir plugins: catálogo, búsqueda, criterios de selección | Bardo | Palantír |
| [plugin-marketplaces](https://code.claude.com/docs/en/plugin-marketplaces) | Marketplaces de plugins: fuentes oficiales, instalación | Bardo | Celebrimbor |
| [output-styles](https://code.claude.com/docs/en/output-styles) | Output styles: built-in y custom, frontmatter | Palantír | Celebrimbor, Gandalf |
| [sub-agents](https://code.claude.com/docs/en/sub-agents) | Sub-agentes: built-in, custom, permisos, memory | Aragorn | Ents, Gandalf |
| [agent-teams](https://code.claude.com/docs/en/agent-teams) | Agent Teams: lead+teammates, task list, mailbox | Aragorn | Gandalf |
| [github-actions](https://code.claude.com/docs/en/github-actions) | Integración Claude Code + GitHub Actions | Ents | Gandalf |
| [code-review](https://code.claude.com/docs/en/code-review) | Code review automatizado en pipelines | Ents | Gandalf |

### Recursos Externos

| URL | Descripción | Épicas | Potencial |
|-----|-------------|--------|-----------|
| [vercel-labs/skills](https://github.com/vercel-labs/skills) | CLI `npx skills`: comandos, flags, scopes | Celebrimbor | Palantír |
| [skills.sh](https://skills.sh) | Portal web de skills: catálogo público | Celebrimbor | Palantír |
| [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) | Catálogo curado de subagentes | Aragorn | Gandalf |
| [aitmpl.com/agents](https://aitmpl.com/agents) | Marketplace de agentes con API pública | Aragorn | — |
| [wmedia.es hooks](https://wmedia.es/es/articulos/claude-code-hooks-guia-practica) | Guía práctica de hooks en español | Palantír | Ents |

---

## 📜 Licencia

Por definir.

---

*Última actualización: 2026-03-16*

**Desarrollado con 💙 usando Claude Code**

*"One Prompt to Rule Them All"* 💍
