# 📖 Fuentes de Documentación Oficial - TLOTP

> **Índice central** de URLs oficiales que TLOTP consulta via WebFetch.
> Ningún módulo debe hardcodear documentación: siempre fetch live.

---

## 🔗 Documentación Oficial de Claude Code

### Memoria y Configuración

| URL | Qué contiene | Épicas que lo usan |
|-----|-------------|-------------------|
| https://code.claude.com/docs/en/memory | Jerarquía de memoria (7 niveles), rules con `paths:`, imports `@`, auto memory, best practices | Palantír, Celebrimbor |

**Qué extraer**: Tipos de memoria, ubicaciones de archivos, jerarquía de precedencia, sistema de rules con paths, estructura de auto memory.

---

### Hooks

| URL | Qué contiene | Épicas que lo usan |
|-----|-------------|-------------------|
| https://code.claude.com/docs/en/hooks-guide | Guía completa de hooks: 3 tipos (command, prompt, agent), todos los eventos, matchers, configuración en settings.json, ejemplos prácticos | Palantír (#52) |

**Qué extraer**: Tipos de hooks, tabla de eventos con matchers, formatos de input/output JSON, exit codes, configuración por scope, ejemplos de auto-format, block files, notifications.

**Suplemento** (info práctica en español no cubierta por docs oficiales):
> WebFetch: https://wmedia.es/es/articulos/claude-code-hooks-guia-practica
> Extraer: casos de uso prácticos, tips y patrones comunes en español.

---

### Skills

| URL | Qué contiene | Épicas que lo usan |
|-----|-------------|-------------------|
| https://code.claude.com/docs/en/skills | Sistema de skills nativo: SKILL.md, frontmatter, invocation control, context fork, supporting files, slash commands | Celebrimbor |

**Qué extraer**: Estructura de SKILL.md, campos de frontmatter, ubicaciones (enterprise/personal/project/plugin), control de invocación, patrones avanzados.

---

### CLI de skills.sh (vercel-labs/skills)

| URL | Qué contiene | Épicas que lo usan |
|-----|-------------|-------------------|
| https://github.com/vercel-labs/skills | CLI `npx skills`: 7 comandos (add, find, list, check, update, init, remove), flags, scopes, formatos de source | Celebrimbor |

**Qué extraer**: Comandos disponibles, flags por comando, scopes de instalación, métodos (symlink vs copy), estructura de SKILL.md, variables de entorno.

---

### Sub-agentes

| URL | Qué contiene | Épicas que lo usan |
|-----|-------------|-------------------|
| https://code.claude.com/docs/en/sub-agents | Sub-agentes: built-in (Explore, Plan, general-purpose), custom agents, frontmatter, tools, permissions, hooks, memory | Aragorn, general |

**Qué extraer**: Built-in subagents, configuración de custom agents, campos de frontmatter, permission modes, persistent memory, hooks en subagents.

---

### Agent Teams

| URL | Qué contiene | Épicas que lo usan |
|-----|-------------|-------------------|
| https://code.claude.com/docs/en/agent-teams | Agent Teams nativos: lead + teammates, shared task list, mailbox, display modes, best practices, limitaciones | Aragorn |

**Qué extraer**: Arquitectura (lead, teammates, task list, mailbox), habilitación (`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS`), control de equipos, display modes, mejores prácticas, limitaciones conocidas.

---

### Output Styles

| URL | Qué contiene | Épicas que lo usan |
|-----|-------------|-------------------|
| https://code.claude.com/docs/en/output-styles | Output styles: built-in (Default, Explanatory, Learning), custom styles, frontmatter, relación con CLAUDE.md | Palantír |

**Qué extraer**: Estilos disponibles, cómo crear custom styles, frontmatter, diferencias con CLAUDE.md y skills.

---

## 📋 Cómo Usar Este Índice

### Para módulos de TLOTP

Cada módulo que necesite documentación oficial debe:

1. **Referenciar este fichero** como índice de fuentes
2. **Usar WebFetch** a la URL correspondiente antes de ejecutar
3. **Extraer solo lo relevante** para su función específica
4. **NO hardcodear** el contenido de la documentación

### Patrón de uso en módulos

```markdown
## 📖 Documentación Oficial (Live)

**ANTES de ejecutar este módulo**, consultar documentación actualizada:

> **WebFetch**: [URL del índice docs-sources.md]
> **Extraer**: [campos específicos que necesita este módulo]

Usar la información obtenida como fuente de verdad.
```

### Nota sobre WebFetch

- Requiere que el usuario haya aprobado el permiso WebFetch (ver PASO 1.5 en tlotp-main.md)
- Si WebFetch no está disponible, informar al usuario y ofrecer alternativas
- Las URLs se verificaron por última vez: 2026-02-27

---

*Fuente única de verdad para documentación externa de TLOTP*
*Última actualización: 2026-02-27*
