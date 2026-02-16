# ⚡ Backend CLI - Celebrimbor

## Misión

Implementar el backend que usa `npx skills` (Node.js) para gestionar skills.

---

## 🎯 Requisitos

**Obligatorios**:
- Node.js >= 18.0.0
- npm >= 9.0.0
- npx (incluido con npm)

**Validación** (usa módulo 01-detector-entorno.md):
```bash
node --version  # >= v18.0.0
npm --version   # >= 9.0.0
npx skills --version  # Debe funcionar
```

---

## 🔧 Implementación de Operaciones

### 1. **Buscar Skills**

**Comando CLI**:
```bash
npx skills search <query>
```

**Ejemplo**:
```bash
npx skills search playwright
```

**Output esperado**:
```
🔍 Searching for "playwright"...

Found 12 skills:

  playwright-pom                    vercel-labs/skills
  Page Object Model patterns for Playwright
  1,523 installs

  playwright-fixtures               playwright-community
  Custom test fixtures for Playwright
  892 installs

  ...
```

**Parseo**:
- Capturar nombre, autor, descripción, instalaciones
- Formatear como lista estructurada
- Mostrar al usuario de forma clara

---

### 2. **Instalar Skill**

**Comando CLI**:
```bash
npx skills add <owner/repo/skill-name>
```

**Ejemplo**:
```bash
# Instalación global
npx skills add vercel-labs/skills/playwright-pom

# El CLI preguntará la ubicación:
# ? Where should this skill be installed?
#   > Global (~/.claude/skills/)
#     Local (./.claude/rules/)
```

**Automatización**:
- NO modo interactivo (evitar preguntas del CLI)
- Usar flags si están disponibles
- Copiar manualmente si es necesario

**Proceso**:
1. Ejecutar `npx skills add <skill>`
2. Si pide ubicación → responder automáticamente
3. Verificar instalación exitosa
4. Confirmar path final del archivo

**Configuración de `paths:`**:

Si la skill requiere `paths:`, añadir después de instalar:

```yaml
# En ~/.claude/skills/playwright-pom.md o ./.claude/rules/playwright-pom.md

---
paths:
  - "tests/**/*.spec.ts"
  - "pages/**/*.ts"
---

# Contenido de la skill...
```

---

### 3. **Listar Skills Instaladas**

**Comando CLI**:
```bash
npx skills list
```

**Output esperado**:
```
📦 Installed skills:

Global (~/.claude/skills/):
  - playwright-pom (vercel-labs/skills)
  - typescript-utils (community/typescript)

Local (./.claude/rules/):
  - php-symfony (custom)
```

**Complementar con lectura manual**:

Si `npx skills list` no existe, leer directorios:
```bash
# Global
ls -1 ~/.claude/skills/*.md

# Local
ls -1 ./.claude/rules/*.md
```

---

### 4. **Actualizar Skill**

**Comando CLI**:
```bash
npx skills update <skill-name>
```

**Ejemplo**:
```bash
npx skills update playwright-pom
```

**Fallback** (si comando no existe):
```bash
# Re-instalar skill (sobreescribe)
npx skills add vercel-labs/skills/playwright-pom --force
```

---

### 5. **Eliminar Skill**

**Comando CLI**:
```bash
npx skills remove <skill-name>
```

**Fallback** (si comando no existe):
```bash
# Eliminar archivo manualmente
rm ~/.claude/skills/playwright-pom.md
# o
rm ./.claude/rules/playwright-pom.md
```

---

## 🎨 Manejo de Errores

### Error: Node.js < 18

**Detectado por**: módulo 01-detector-entorno.md

**Acción**:
```
❌ Node.js desactualizado

Tu versión: v12.22.9
Requerido:   v18.0.0+

Opciones:
1. Actualizar Node.js → Usar Backend CLI
2. Esperar v2.2.0 → Usar Backend Git (sin Node.js)

Ver instrucciones: docs/REQUISITOS.md
```

### Error: Skill no encontrada

**Comando falla**:
```bash
npx skills add non-existent-skill
# Error: Skill not found
```

**Acción**:
```
❌ Skill no encontrada

La skill "non-existent-skill" no existe en skills.sh

Sugerencias:
- Verificar nombre (sensible a mayúsculas)
- Buscar alternativas: npx skills search <query>
- Ver catálogo: https://skills.sh
```

### Error: npx no disponible

**Acción**:
```
❌ npx no está disponible

Instala npm:
  Ubuntu: sudo apt install npm
  macOS:  brew install node
  Windows: choco install nodejs
```

---

## 🔗 Integración con Abstracción

**Implementa** la interfaz definida en `03-abstraction-layer.md`:

```yaml
backend_cli:
  name: "cli"
  available: true (si Node.js >=18)
  version: "1.0.0"

  operations:
    search:   "npx skills search {query}"
    install:  "npx skills add {skill}"
    list:     "npx skills list" + lectura manual
    update:   "npx skills update {skill}"
    remove:   "npx skills remove {skill}" o rm manual
```

---

## 📦 Optimizaciones

### Cache de Skills Disponibles

Para evitar llamar `npx skills search` repetidamente:

```yaml
# ~/.celebrimbor/cache/skills-index.yml
cached_at: "2026-02-15T10:30:00Z"
ttl: 3600  # 1 hora

skills:
  - name: "playwright-pom"
    author: "vercel-labs"
    ...
```

**Invalidar cache**:
- Después de 1 hora
- Si usuario ejecuta "Actualizar índice"

---

## 🎯 Reglas de Ejecución

1. **SIEMPRE validar Node.js** antes de ejecutar comandos
2. **Capturar y parsear** output de npx skills
3. **Manejo robusto de errores** (skill no existe, network fail, etc.)
4. **Confirmación al usuario** antes de instalar/eliminar
5. **Verificar instalación** después de cada operación

---

**Módulo anterior**: 03-abstraction-layer.md
**Módulo siguiente**: 05-backend-git.md (hooks para v2.2.0)
**Módulo relacionado**: 06-backend-selector.md
