# 🧙‍♂️ TLOTP - The Lord of the Prompt

> **"Un prompt para configurarlos a todos"**

[Issues](https://github.com/joseguillermomoreu-gif/tlotp/issues) | [Roadmap](MILESTONES.md) | [Contribuir](CONTRIBUTING.md)

Un único super-prompt para auto-configurar Claude Code de forma asistida, inteligente y evolutiva.

> ⚠️ **TLOTP está en desarrollo activo.** Las épicas actuales (Palantír + Celebrimbor) son production-ready. Las futuras versiones ampliarán el sistema con setup asistido completo para distintos tipos de proyecto y gestión interactiva de agentes.

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
- ⚒️ **Busca, instala y actualiza** skills desde el repositorio oficial [skills.sh](https://skills.sh) (59,000+ skills)
- 🤖 **Configura agentes** de forma asistida e interactiva *(próximamente)*
- 🎯 **Setup completo** para distintos tipos de proyecto de una sola vez *(próximamente)*

Sin instalación. Sin scripts. Solo copy-paste del prompt.

---

## ⚡ Inicio Rápido

Ejecuta el menú principal de TLOTP para acceder a todas las épicas:

```
@prompts/tlotp-main.md
```

Desde ahí podrás elegir:
- 🔮 **Palantír** — Gestor de configuraciones ✅ v1.7 Production-ready
- ⚒️ **Celebrimbor** — Forjador de skills ✅ v1.0 Production-ready
- 🌳 **Ents** — Guardianes del CI/CD ✅ v1.0 Production-ready
- 💍 **Gollum**, 🏛️ **Elrond**, ⚡ **Gandalf**, 🪞 **Galadriel** ⏳ Planificadas

O puedes usar cada épica directamente:

```
@prompts/palantir/palantir-main.md
```
```
@prompts/celebrimbor/celebrimbor-main.md
```
```
@prompts/ents/ents-main.md
```

---

## 📊 Estado Actual

**Versión**: TLOTP v3.1.0 — *"The Two Towers"* 🏰

| Épica | Estado | Descripción |
|-------|--------|-------------|
| 🔮 **Palantír v1.7** | ✅ Completado | CRUD completo de configuraciones Claude Code |
| ⚒️ **Celebrimbor v1.0** | ✅ Completado | Gestión de skills desde skills.sh |
| 🌳 **Ents v1.0** | ✅ Completado | Analizar, mejorar y crear pipelines GitHub Actions |
| 💍 **Gollum** | ⏳ Próximo | Playwright E2E setup asistido |
| 🏛️ **Elrond** | ⏳ Planificado | Setup asistido por tipo de proyecto |
| ⚡ **Gandalf** | ⏳ Planificado | Workflow autónomo PHP/Symfony |
| 🪞 **Galadriel** | 💭 Futuro | Spec-Driven Development + ecosistema profesional |
| 👑 **Aragorn** | 💭 Futuro | Multi-Agent Orchestration |

**Estadísticas v3.4.0**:
- 3 épicas production-ready
- 31 módulos totales
- ~9,700 líneas de prompts
- 2,820 XP acumulados (gamificación)

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

## 🚀 Visión a Futuro

TLOTP está diseñado para crecer. Las próximas épicas traerán:

### Setup Asistido por Tipo de Proyecto
Una sola ejecución de TLOTP configurará **todo** lo que necesitas según tu stack:
- Proyecto Symfony → CLAUDE.md + skills PHP/Symfony/Doctrine + workflow Git
- Proyecto Playwright → skills E2E + configuración de tests + POM setup
- Proyecto Python/IA → skills LLM + configuración de evaluación + APIs

### Spec-Driven Development con Galadriel 🪞
TLOTP te asistirá para montar tu ecosistema profesional y crear un SDD completo
con la metodología **CGS (Context & Guided Specification)**: ecosistema configurado
a medida + especificación estructurada que guía todo el desarrollo asistido por IA.
Adiós al vibe coding, hola al desarrollo con contexto real.

### Gestión Interactiva de Agentes
TLOTP asistirá al usuario para **añadir y configurar agentes** de Claude Code de forma correcta e interactiva: elección del agente, configuración de parámetros, integración con el proyecto.

### Autonomía Progresiva
Desde configuración asistida hasta workflow completamente autónomo (Gandalf) donde Claude ejecuta el ciclo completo: tarea → código → QA → deploy.

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

¡Las contribuciones son bienvenidas! Ver **[CONTRIBUTING.md](CONTRIBUTING.md)** para el sistema de gamificación, épicas disponibles y cómo unirte a la Fellowship.

---

## 👨‍💻 Autor

**José Guillermo Moreu**
- GitHub: [@joseguillermomoreu-gif](https://github.com/joseguillermomoreu-gif)
- Proyecto anterior: [claude-code-auto-skills](https://github.com/joseguillermomoreu-gif/claude-code-auto-skills)

---

## 📜 Licencia

Por definir.

---

**Desarrollado con 💙 usando Claude Code**

*"One Prompt to Rule Them All"* 💍
