# 📋 Módulo Listar Skills - Celebrimbor

## Misión

Listar todas las skills instaladas siguiendo la jerarquía oficial de Claude Code.

---

## 🎯 Jerarquía Oficial de Claude Code

Según la documentación oficial, los skills/rules se buscan en este orden (de menos a más específico):

### Niveles de Skills/Rules:

1. **Managed Policy**: `/etc/claude-code/` (organizaciones)
2. **User Memory**: `~/.claude/CLAUDE.md` (NO es skill)
3. **User Rules**: `~/.claude/rules/` ⭐ Skills globales modulares
4. **User Skills**: `~/.claude/skills/` ⭐ Skills globales (si existe)
5. **Project Memory**: `./CLAUDE.md` (NO es skill)
6. **Project Rules**: `./.claude/rules/` ⭐ Skills locales modulares
7. **Project Skills**: `./.claude/skills/` ⭐ Skills locales (si existe)
8. **Project Local**: `./CLAUDE.local.md` (NO es skill)

**Skills están en**: `rules/` y `skills/` (tanto global como local)

---

## 🔍 Detección de Skills Instaladas

### Búsqueda en Directorios

**Global**:
```bash
# User Rules (preferido)
ls -1 ~/.claude/rules/*.md 2>/dev/null

# User Skills (alternativo)
ls -1 ~/.claude/skills/*.md 2>/dev/null
```

**Local (Proyecto)**:
```bash
# Project Rules (preferido)
ls -1 ./.claude/rules/*.md 2>/dev/null

# Project Skills (alternativo)
ls -1 ./.claude/skills/*.md 2>/dev/null
```

### Parsear Archivos

Para cada archivo `.md` encontrado:

1. **Nombre**: Extraer nombre sin extensión
   - `playwright-pom.md` → `playwright-pom`

2. **Ubicación**: Global o Local

3. **Directorio**: `rules/` o `skills/`

4. **Metadata** (opcional):
   - Leer frontmatter YAML si existe
   - Extraer descripción, versión, fecha

**Ejemplo de frontmatter**:
```yaml
---
name: playwright-pom
description: Page Object Model patterns for Playwright
author: vercel-labs/skills
installed_at: 2026-02-15
version: 1.0.0
paths:
  - "tests/**/*.spec.ts"
  - "pages/**/*.ts"
---
```

---

## 📊 Formato de Output

### Output Completo

```
═══════════════════════════════════════════════════════════════
📦 Skills Instaladas - Inventario Completo
═══════════════════════════════════════════════════════════════

🌍 GLOBAL (~/.claude/)
───────────────────────────────────────────────────────────────

  📁 rules/ (2 skills)
    1. llms.md
       📝 Knowledge sobre LLMs y prompt engineering
       📅 Instalado: 2026-01-20

    2. git-workflow.md
       📝 Convenciones de Git y commits
       📅 Instalado: 2026-01-15

  📁 skills/ (2 skills)
    3. playwright-pom.md
       📝 Page Object Model patterns for Playwright
       📦 vercel-labs/skills
       📅 Instalado: 2026-02-10

    4. typescript-utils.md
       📝 Utilidades para TypeScript
       📦 community/typescript
       📅 Instalado: 2026-02-05

───────────────────────────────────────────────────────────────

📂 LOCAL (./.claude/) - Proyecto: tlotp
───────────────────────────────────────────────────────────────

  📁 rules/ (2 skills)
    5. php-symfony.md
       📝 Best practices de Symfony y Doctrine
       📅 Instalado: 2026-02-01

    6. hexagonal-architecture.md
       📝 Patrones de arquitectura hexagonal
       📅 Instalado: 2026-01-25

  📁 skills/ (0 skills)
    (vacío)

═══════════════════════════════════════════════════════════════
📊 Resumen:
   • Total: 6 skills
   • Global: 4 skills (2 rules + 2 skills)
   • Local: 2 skills (2 rules + 0 skills)
═══════════════════════════════════════════════════════════════
```

### Output Resumido

```
═══════════════════════════════════════════════════════════════
📦 Skills Instaladas (Resumen)
═══════════════════════════════════════════════════════════════

🌍 Global (4):
  • llms
  • git-workflow
  • playwright-pom
  • typescript-utils

📂 Local (2):
  • php-symfony
  • hexagonal-architecture

Total: 6 skills
═══════════════════════════════════════════════════════════════
```

---

## 🎨 Casos Especiales

### Caso 1: Sin Skills Instaladas

```
═══════════════════════════════════════════════════════════════
📦 Skills Instaladas
═══════════════════════════════════════════════════════════════

No se encontraron skills instaladas.

💡 Sugerencia:
   Usa "1. Buscar Skills" para encontrar e instalar skills
   desde el catálogo de skills.sh

═══════════════════════════════════════════════════════════════
```

### Caso 2: Solo Globales

```
═══════════════════════════════════════════════════════════════
📦 Skills Instaladas
═══════════════════════════════════════════════════════════════

🌍 Global (3):
  • llms
  • git-workflow
  • playwright-pom

📂 Local: (ninguna)

💡 Tip: Las skills locales son específicas del proyecto actual
═══════════════════════════════════════════════════════════════
```

### Caso 3: Solo Locales

```
═══════════════════════════════════════════════════════════════
📦 Skills Instaladas
═══════════════════════════════════════════════════════════════

🌍 Global: (ninguna)

📂 Local (2):
  • php-symfony
  • hexagonal-architecture

💡 Tip: Instala skills globales para usarlas en todos tus proyectos
═══════════════════════════════════════════════════════════════
```

---

## 🔧 Funcionalidad Adicional

### Detectar Skills Obsoletas (Futuro)

**Leer fecha de instalación** del frontmatter:
```yaml
installed_at: "2026-01-15"
```

**Comparar con fecha actual**:
```python
if days_since_install > 30:
    mark_as_potentially_outdated()
```

**Mostrar**:
```
⚠️ Skills potencialmente obsoletas (>30 días):
  • git-workflow.md (45 días)
    💡 Ejecuta "4. Actualizar Skills" para actualizar
```

---

## 🔗 Integración

### Con Módulo de Búsqueda (07)

**Uso**: Llamar ANTES de buscar
```python
# Antes de buscar, mostrar qué tiene
installed_skills = list_installed_skills()
display_summary(installed_skills)

# LUEGO buscar
search_new_skills()
```

### Con Módulo de Instalación (08)

**Uso**: Detectar duplicados
```python
# Antes de instalar, verificar si ya existe
if skill_name in installed_skills:
    warn("Skill ya instalada")
    ask("¿Sobreescribir? [s/N]")
```

---

## 🎯 Reglas de Ejecución

1. **SIEMPRE buscar en orden**: global rules → global skills → local rules → local skills
2. **Mostrar directorios vacíos** como "(vacío)" para claridad
3. **Metadata opcional**: Si no hay frontmatter, mostrar solo nombre
4. **Formato consistente**: Mismo estilo que otros módulos
5. **Resumen al final**: Total global, local, y general

---

## 📊 Ejemplo Completo de Ejecución

```
Usuario selecciona: "3. Listar Skills Instaladas"

═══════════════════════════════════════════════════════════════
    🔮 Celebrimbor - Inventario de Skills ⚒️
═══════════════════════════════════════════════════════════════

Analizando configuración...

═══════════════════════════════════════════════════════════════
📦 Skills Instaladas
═══════════════════════════════════════════════════════════════

🌍 GLOBAL (~/.claude/)

  📁 rules/ (1 skill)
    • llms.md

  📁 skills/ (1 skill)
    • playwright-pom.md

📂 LOCAL (./.claude/)

  📁 rules/ (0 skills)
    (vacío)

═══════════════════════════════════════════════════════════════
📊 Total: 2 skills (2 globales, 0 locales)
═══════════════════════════════════════════════════════════════

¿Qué deseas hacer?

1. Ver detalles completos (metadata)
2. Buscar nuevas skills
3. Volver al menú principal

Elige [1-3]: _
```

---

**Módulo anterior**: 08-module-install.md
**Integra con**: 07-module-search.md, 08-module-install.md
**Usa jerarquía**: Documentación oficial Claude Code
**Tarea**: #3/#4 - Listar Skills
