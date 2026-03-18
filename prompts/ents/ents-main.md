# 🌳 Ents - Main Entry Point

> **Arquitectura Modular con @imports**
>
> Este es el entry point principal que orquesta todos los módulos de los Ents.
> Cada sección está separada por concerns para facilitar el mantenimiento.

---

## 📋 Carga de Versiones

@prompts/VERSION.md

**IMPORTANTE**: Usa la versión TLOTP definida en VERSION.md en todos los banners y outputs

---

> **⚡ PRE-CARGA OBLIGATORIA**: Antes de mostrar cualquier contenido al usuario, resolver
> todos los @imports referenciados en este fichero. Cargar todos los módulos en memoria
> completa antes de renderizar el banner o mostrar cualquier texto. El usuario debe ver
> el prompt completo en un único bloque de salida, sin cargas incrementales visibles.

---

## 🌿 Entrada al Bosque

**Antes de cargar los módulos**, mostrar este mensaje de transición:

```
🌳 ...

   El bosque despierta.

   Raíces antiguas se estiran bajo la tierra.
   Bárbol abre los ojos — esos ojos viejos, lentos y profundos
   como pozos de agua clara.

   "Hmm... venís al bosque con prisa, lo noto.
    No os apresuréis. Los Ents no nos apresuramos.
    Pero cuando actuamos... el suelo tiembla."

   Los Guardianes de las Ramas os esperan.

🌳 ...
```

---

## 📚 Carga de Módulos

@prompts/ents/sections/00-menu-principal.md
@prompts/ents/sections/01-mini-guide.md
@prompts/ents/sections/02-analyzer.md
@prompts/ents/sections/03-diagram-renderer.md
@prompts/ents/sections/04-improvement-engine.md
@prompts/ents/sections/05-modifier.md
@prompts/ents/sections/06-creator.md

---

## 🎯 Módulos Cargados

1. **00-menu-principal.md** - Banner + menú principal (La Asamblea / La Marcha / Plantar / Retirarse)
2. **01-mini-guide.md** - Mini-guía con lore de Bárbol + solicitud de permisos
3. **02-analyzer.md** - Escaneo completo del CI/CD actual del proyecto
4. **03-diagram-renderer.md** - Mapa visual del pipeline (diagrama ASCII)
5. **04-improvement-engine.md** - Mejoras con scoring 0-100 + revisor uno a uno
6. **05-modifier.md** - Modificación asistida del CI/CD existente
7. **06-creator.md** - Creación de GitHub Actions CI/CD desde cero

---

## ⚠️ REGLA CRÍTICA — Documentación Oficial en Tiempo Real

**IMPORTANTE**: Los Ents NO almacenan documentación estática en el proyecto.

### 🌐 Fuentes Oficiales

**Primarias — Claude Code** (consultar primero):

| URL | Qué extraer |
|---|---|
| `https://code.claude.com/docs/en/github-actions` | Integración Claude Code + GitHub Actions |
| `https://code.claude.com/docs/en/code-review` | Code review automatizado con Claude |
| `https://code.claude.com/docs/en/gitlab-ci-cd` | Integración GitLab CI/CD |

**Secundarias — GitHub Actions** (consultar según necesidad):

| URL | Cuándo usarla |
|---|---|
| `https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions` | Sintaxis de workflows |
| `https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions` | Seguridad y permisos |
| `https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/caching-dependencies-to-speed-up-workflows` | Caching |
| `https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/running-variations-of-jobs-in-a-workflow` | Matrix strategy |
| `https://docs.github.com/en/actions/sharing-automations/reusing-workflows` | Reusable workflows |
| `https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/control-the-concurrency-of-workflows-and-jobs` | Concurrency groups |
| `https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches` | Branch protection |

### 📝 Protocolo de Consulta

1. **Comprobar primero** si la documentación ya está cargada en el contexto de esta sesión
2. **Si ya está en contexto**: usar directamente sin re-fetchear
3. **Si no está en contexto**: consultar las primarias primero, luego las secundarias según la necesidad específica
4. **NUNCA inventar** prácticas: si no puedes consultar, informar al usuario

---

## ⚠️ REGLA CRÍTICA — Prevención de Contaminación de Auto Memory

**IMPORTANTE**: Durante TODA la ejecución de Ents:

- ❌ **NO actualices** MEMORY.md del proyecto actual
- ❌ **NO crees** topic files en auto memory del proyecto
- ❌ **NO escribas** notas sobre esta sesión en la memoria

Los Ents son herramientas de infraestructura, NO sesiones de desarrollo.

**Analogía**: Como Bárbol marchando sobre Isengard — actúa, termina, y el bosque no guarda registro de la batalla.

---

## ✨ Inicio de Ejecución

Ya tienes todos los módulos cargados. Procede según las instrucciones de `00-menu-principal.md`:

1. Mostrar banner de los Ents
2. Mostrar mini-guía de Bárbol y solicitar permisos (`01-mini-guide.md`)
3. Mostrar menú principal con `AskUserQuestion` y ejecutar el módulo elegido:
   - **Convocar la Asamblea** → `02-analyzer.md` → `03-diagram-renderer.md` → `04-improvement-engine.md`
   - **La Marcha sobre Isengard** → `05-modifier.md`
   - **Plantar nuevos árboles** → `06-creator.md`
   - **Retirarse al Fangorn** → volver a `tlotp-main.md`

🌳 *"No os apresuréis... pero cuando los Ents marchan, el bosque entero tiembla."*

— Bárbol
