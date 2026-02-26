# 📖 Referencia CLI skills.sh - Celebrimbor

## Fuente

Referencia basada en el repositorio oficial [`vercel-labs/skills`](https://github.com/vercel-labs/skills).
Web: [skills.sh](https://skills.sh) | Docs: [skills.sh/docs](https://skills.sh/docs)

---

## 🔧 Comandos Disponibles

### 1. `skills add` — Instalar skills

**Sintaxis**:
```bash
npx skills add <source> [options]
```

**Flags**:

| Flag | Descripción |
|------|-------------|
| `-g, --global` | Instalar en directorio global del usuario (`~/`) |
| `-a, --agent <agents...>` | Agentes destino (ej: `claude-code`, `cursor`) |
| `-s, --skill <skills...>` | Instalar skills específicas por nombre |
| `-l, --list` | Mostrar skills disponibles sin instalar |
| `--copy` | Copiar archivos en vez de symlink |
| `-y, --yes` | Saltar confirmaciones (no interactivo) |
| `--all` | Instalar todo: `--skill '*' --agent '*' -y` |

**Formatos de source aceptados**:
- GitHub shorthand: `owner/repo`
- URL completa: `https://github.com/owner/repo`
- Path directo a skill: `https://github.com/owner/repo/tree/main/skills/skill-name`
- GitLab: `https://gitlab.com/org/repo`
- SSH: `git@github.com:owner/repo.git`
- Local: `./my-local-skills`

**Ejemplos**:
```bash
# Listar skills de un repo antes de instalar
npx skills add vercel-labs/agent-skills --list

# Instalar skill específica para Claude Code (no interactivo)
npx skills add vercel-labs/agent-skills -s frontend-design -a claude-code -y

# Instalar en global
npx skills add vercel-labs/agent-skills -s frontend-design -g -a claude-code -y

# Instalar todas las skills de un repo para Claude Code
npx skills add vercel-labs/agent-skills --skill '*' -a claude-code -y

# Una skill para todos los agentes
npx skills add vercel-labs/agent-skills --agent '*' -s frontend-design -y

# Skills con espacios en el nombre (requieren comillas)
npx skills add owner/repo -s "Convex Best Practices" -a claude-code -y
```

---

### 2. `skills find` — Buscar skills

**Sintaxis**:
```bash
npx skills find [query]
```

**Comportamiento**:
- Sin query: modo interactivo (busca en skills.sh)
- Con query: busca por keyword

**Ejemplos**:
```bash
npx skills find              # Interactivo
npx skills find typescript   # Buscar por keyword
npx skills find playwright   # Buscar por keyword
```

> **IMPORTANTE**: El comando es `find`, NO `search`. El comando `search` no existe.

---

### 3. `skills list` / `skills ls` — Listar skills instaladas

**Sintaxis**:
```bash
npx skills list [options]
npx skills ls [options]
```

**Flags**:

| Flag | Descripción |
|------|-------------|
| `-g, --global` | Solo skills globales |
| `-a, --agent <agents...>` | Filtrar por agente |

**Ejemplos**:
```bash
npx skills list                          # Todas las instaladas
npx skills ls -g                         # Solo globales
npx skills ls -a claude-code             # Solo de Claude Code
npx skills ls -a claude-code -a cursor   # De Claude Code y Cursor
```

---

### 4. `skills check` — Detectar actualizaciones

**Sintaxis**:
```bash
npx skills check
```

**Comportamiento**:
- Compara skills instaladas con sus fuentes remotas
- Muestra cuáles tienen actualizaciones disponibles

---

### 5. `skills update` — Aplicar actualizaciones

**Sintaxis**:
```bash
npx skills update
```

**Comportamiento**:
- Actualiza TODAS las skills que tienen actualizaciones pendientes
- No acepta nombre de skill individual (actualiza todo de golpe)

> **NOTA**: No existe `npx skills update <skill-name>`. Se actualizan todas a la vez.

---

### 6. `skills init` — Crear plantilla de skill

**Sintaxis**:
```bash
npx skills init [name]
```

**Comportamiento**:
- Sin nombre: crea `SKILL.md` en el directorio actual
- Con nombre: crea subdirectorio con `SKILL.md` dentro

**Ejemplo**:
```bash
npx skills init                # Crea ./SKILL.md
npx skills init my-skill       # Crea ./my-skill/SKILL.md
```

---

### 7. `skills remove` / `skills rm` — Desinstalar skills

**Sintaxis**:
```bash
npx skills remove [skill] [options]
npx skills rm [skill] [options]
```

**Flags**:

| Flag | Descripción |
|------|-------------|
| `-g, --global` | Buscar en scope global |
| `-a, --agent <agents...>` | Especificar agentes (`'*'` para todos) |
| `-s, --skill <skills...>` | Especificar skills (`'*'` para todas) |
| `-y, --yes` | Saltar confirmaciones |
| `--all` | Eliminar todo: `--skill '*' --agent '*' -y` |

**Ejemplos**:
```bash
npx skills remove                                    # Interactivo
npx skills remove web-design-guidelines              # Skill específica
npx skills remove -g my-skill                        # Desde global
npx skills remove -a claude-code -a cursor my-skill  # De agentes específicos
npx skills remove --all                              # Eliminar todo
```

---

## 📍 Scopes de Instalación

| Scope | Flag | Ubicación | Uso |
|-------|------|-----------|-----|
| **Project** | (default) | `./<agent>/skills/` | Compartido via repo (versionable) |
| **Global** | `-g` | `~/<agent>/skills/` | Personal, disponible en todos los proyectos |

### Ubicaciones para Claude Code

| Scope | Path |
|-------|------|
| Project skills | `.claude/skills/` |
| Project rules | `.claude/rules/` |
| Global skills | `~/.claude/skills/` |
| Global rules | `~/.claude/rules/` |

---

## 🔗 Métodos de Instalación

| Método | Flag | Descripción |
|--------|------|-------------|
| **Symlink** | (default) | Referencia a copia canónica. Single source of truth. Recomendado. |
| **Copy** | `--copy` | Copia independiente por agente. Usar cuando symlinks no funcionan. |

---

## 📄 Estructura de SKILL.md

Las skills son directorios con un fichero `SKILL.md` que usa frontmatter YAML:

```markdown
---
name: my-skill
description: Brief explanation of functionality
---

# My Skill

Instructions for agent activation.

## When to Use

Scenario descriptions.

## Steps

1. First action
2. Second action
```

**Campos obligatorios**: `name` + `description`

**Campos opcionales**:
- `metadata.internal: true` — Oculta la skill del descubrimiento normal (solo visible con `INSTALL_INTERNAL_SKILLS=1`)

---

## 🌍 Variables de Entorno

| Variable | Propósito |
|----------|-----------|
| `INSTALL_INTERNAL_SKILLS=1` | Incluir skills internas/ocultas en búsqueda |
| `DISABLE_TELEMETRY` | Desactivar telemetría anónima |
| `DO_NOT_TRACK` | Alternativa para desactivar telemetría |

---

## ⚠️ Errores Comunes y Prevención

| Error | Causa | Solución |
|-------|-------|----------|
| "No skills found" | `SKILL.md` sin `name` o `description` en frontmatter | Verificar YAML frontmatter |
| Skill no carga | Path incorrecto o frontmatter inválido | Verificar ubicación y formato |
| Permission errors | Sin permisos de escritura | Verificar permisos del directorio destino |
| `search` no reconocido | Comando incorrecto | Usar `find` en vez de `search` |

---

## 🎯 Cheatsheet Rápido para Celebrimbor

```bash
# Buscar
npx skills find <query>

# Instalar (Claude Code, no interactivo)
npx skills add <owner/repo> -s <skill-name> -a claude-code -y

# Instalar global
npx skills add <owner/repo> -s <skill-name> -g -a claude-code -y

# Listar
npx skills list
npx skills ls -a claude-code

# Verificar updates
npx skills check

# Actualizar todas
npx skills update

# Crear skill nueva
npx skills init <name>

# Eliminar
npx skills remove <skill-name> -a claude-code -y

# Ver disponibles sin instalar
npx skills add <owner/repo> --list
```

---

**Fuente oficial**: [github.com/vercel-labs/skills](https://github.com/vercel-labs/skills)
**Última verificación**: 2026-02-26
