# 📖 Fuentes de Documentación Oficial - TLOTP

> **Índice central** de URLs oficiales que TLOTP consulta via WebFetch.
> Ningún módulo debe hardcodear documentación: siempre fetch live.

---

## 🔗 Documentación Oficial de Claude Code

### Visión General y Fundamentos

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://code.claude.com/docs/en/how-claude-code-works | Arquitectura interna, flujo de contexto, cómo procesa Claude Code las instrucciones | Palantír | Todos (onboarding), Gandalf |
| https://code.claude.com/docs/en/features-overview | Resumen de todas las features disponibles: memoria, skills, hooks, MCPs, agentes, output styles | Palantír | Todos (onboarding) |
| https://code.claude.com/docs/en/best-practices | Mejores prácticas oficiales: estructura de proyectos, uso de memoria, seguridad | Palantír | Celebrimbor, Gandalf |
| https://code.claude.com/docs/en/settings | Configuración global y por proyecto: permisos, herramientas, allowlists, settings.json | Palantír | Celebrimbor, Aragorn |

**Qué extraer**: Conceptos clave del sistema, jerarquía de configuración, qué puede configurar el usuario y dónde.

---

### Memoria y Configuración

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://code.claude.com/docs/en/memory | Jerarquía de memoria (7 niveles), rules con `paths:`, imports `@`, auto memory, best practices | Palantír, Celebrimbor | Aragorn, Gandalf |

**Qué extraer**: Tipos de memoria, ubicaciones de archivos, jerarquía de precedencia, sistema de rules con paths, estructura de auto memory.

---

### Hooks

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://code.claude.com/docs/en/hooks-guide | Guía completa: 3 tipos (command, prompt, agent), todos los eventos, matchers, configuración en settings.json, ejemplos prácticos | Palantír | Ents, Aragorn |
| https://code.claude.com/docs/en/hooks | Referencia técnica de hooks (variante URL) | Palantír, Aragorn | Ents |

**Qué extraer**: Tipos de hooks, tabla de eventos con matchers, formatos de input/output JSON, exit codes, configuración por scope, ejemplos de auto-format, block files, notifications.

**Suplemento** (info práctica en español):
> WebFetch: https://wmedia.es/es/articulos/claude-code-hooks-guia-practica
> Extraer: casos de uso prácticos, tips y patrones comunes en español.

---

### Skills (Sistema Nativo Claude Code)

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://code.claude.com/docs/en/skills | Sistema de skills nativo: SKILL.md, frontmatter, invocation control, context fork, supporting files, slash commands | Celebrimbor | Palantír (análisis de config), Aragorn |

**Qué extraer**: Estructura de SKILL.md, campos de frontmatter, ubicaciones (enterprise/personal/project/plugin), control de invocación, patrones avanzados.

---

### MCPs (Model Context Protocol)

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://code.claude.com/docs/en/mcp | Protocolo MCP: configurar servidores MCP, scopes (local/project/user), transports (stdio/SSE/HTTP), autenticación, seguridad | Bardo | Aragorn, Palantír |

**Qué extraer**: Cómo añadir servidores MCP, configuración en settings.json, tipos de transport, scopes, servidores MCP populares.

---

### Plugins

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://code.claude.com/docs/en/plugins | Sistema de plugins: estructura, instalación, diferencias con skills y MCPs | Bardo | Celebrimbor |

**Qué extraer**: Qué son los plugins, cómo instalarlos, diferencia con skills, casos de uso.

---

### Output Styles

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://code.claude.com/docs/en/output-styles | Output styles: built-in (Default, Explanatory, Learning), custom styles, frontmatter, relación con CLAUDE.md | Palantír | Celebrimbor, Gandalf |

**Qué extraer**: Estilos disponibles, cómo crear custom styles, frontmatter, diferencias con CLAUDE.md y skills.

---

### Sub-agentes

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://code.claude.com/docs/en/sub-agents | Sub-agentes: built-in (Explore, Plan, general-purpose), custom agents, frontmatter, tools, permissions, hooks, memory | Aragorn | Ents (agentes de CI), Gandalf |

**Qué extraer**: Built-in subagents, configuración de custom agents, campos de frontmatter, permission modes, persistent memory, hooks en subagents.

---

### Agent Teams

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://code.claude.com/docs/en/agent-teams | Agent Teams nativos: lead + teammates, shared task list, mailbox, display modes, best practices, limitaciones | Aragorn | Gandalf (orquestación de specs) |

**Qué extraer**: Arquitectura (lead, teammates, task list, mailbox), habilitación (`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS`), control de equipos, display modes, mejores prácticas, limitaciones conocidas.

---

### CI/CD y GitHub Actions

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://code.claude.com/docs/en/github-actions | Integración Claude Code + GitHub Actions, mejores prácticas recomendadas | Ents | Gandalf |
| https://code.claude.com/docs/en/code-review | Code review automatizado, qué verificar en pipelines | Ents | Gandalf |
| https://code.claude.com/docs/en/gitlab-ci-cd | Patrones CI/CD aplicables | Ents | — |

**Qué extraer**: Configuración de workflows, triggers recomendados, seguridad, patrones de uso.

---

## 🔗 Recursos Externos

### Skills.sh (vercel-labs)

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://github.com/vercel-labs/skills | CLI `npx skills`: 7 comandos (add, find, list, check, update, init, remove), flags, scopes, formatos de source | Celebrimbor | Palantír (análisis) |
| https://skills.sh | Portal web de skills.sh: catálogo público de skills disponibles | Celebrimbor | Palantír |

**Qué extraer**: Comandos disponibles, flags por comando, scopes de instalación, métodos (symlink vs copy), estructura de SKILL.md, variables de entorno.

---

### Catálogos de Agentes

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://github.com/VoltAgent/awesome-claude-code-subagents | Lista curada de subagentes para Claude Code, con casos de uso y configuraciones | Aragorn | Gandalf |
| https://aitmpl.com/agents | Marketplace de agentes con API pública para buscar e instalar | Aragorn | — |

**Qué extraer**: Listado de agentes disponibles, nombres, descripciones, casos de uso, comandos de instalación.

---

### Servidores MCP Populares

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://api.githubcopilot.com/mcp/ | Servidor MCP oficial de GitHub Copilot | Bardo | Aragorn |
| https://mcp.sentry.dev/mcp | Servidor MCP oficial de Sentry | Bardo | Ents |
| https://mcp.slack.com/mcp | Servidor MCP oficial de Slack | Bardo | Aragorn |

---

### Recursos en Español

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://wmedia.es/es/articulos/claude-code-hooks-guia-practica | Guía práctica de hooks en español: casos de uso, tips, patrones comunes | Palantír | Ents, Aragorn |

---

### GitHub Actions (Documentación Oficial GitHub)

| URL | Qué contiene | Épicas que lo usan | Podría beneficiar |
|-----|-------------|-------------------|--------------------|
| https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions | Hardening de seguridad para workflows | Ents | — |
| https://docs.github.com/en/actions/sharing-automations/reusing-workflows | Reusable workflows | Ents | — |
| https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/caching-dependencies-to-speed-up-workflows | Caching de dependencias | Ents | — |
| https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/control-the-concurrency-of-workflows-and-jobs | Concurrencia de workflows | Ents | — |
| https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/running-variations-of-jobs-in-a-workflow | Matrix strategy | Ents | — |
| https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches | Branch protection rules | Ents | — |

---

## 📋 Cómo Usar Este Índice

### Para módulos de TLOTP

Cada módulo que necesite documentación oficial debe:

1. **Comprobar primero** si la documentación ya está en el contexto de la sesión (por WebFetch previo)
2. **Si ya está en contexto**: usar directamente sin re-fetchear
3. **Si no está en contexto**: hacer WebFetch a la URL correspondiente de este índice
4. **Extraer solo lo relevante** para su función específica
5. **NO hardcodear** el contenido de la documentación

### Patrón estándar en módulos

```markdown
## 📖 Documentación Oficial (Live)

**IMPORTANTE**: Comprobar primero si la documentación ya está cargada en el
contexto de esta sesión (por haber ejecutado previamente otro módulo que haya hecho WebFetch).

**Si ya está en contexto**: usar directamente esa información sin re-fetchear.

**Si no está en contexto**, hacer WebFetch:

> **WebFetch**: `[URL de docs-sources.md]`
> **Extraer**: [campos específicos que necesita este módulo]

**Fallback si WebFetch falla**: informar al usuario con ⚠️ y proporcionar el enlace para consulta manual.
```

### Nota sobre WebFetch

- Requiere que el usuario haya aprobado el permiso WebFetch (ver PASO 1.5 en tlotp-main.md)
- Si WebFetch no está disponible, informar al usuario y ofrecer alternativas
- Las URLs se verificaron por última vez: 2026-03-16

---

*Fuente única de verdad para documentación externa de TLOTP*
*Última actualización: 2026-03-16*
