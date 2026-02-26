# ⚡ Backend CLI - Celebrimbor

## Misión

Implementar el backend que usa `npx skills` (Node.js) para gestionar skills.

> **Referencia CLI completa**: Ver `sections/14-skills-cli-reference.md`
> **Fuente oficial**: [github.com/vercel-labs/skills](https://github.com/vercel-labs/skills)

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
npx skills find [query]
```

> **IMPORTANTE**: El comando es `find`, NO `search`.

**Ejemplos**:
```bash
npx skills find playwright   # Buscar por keyword
npx skills find              # Modo interactivo
```

**Parseo**:
- Capturar nombre, autor, descripción, instalaciones
- Formatear como lista estructurada
- Mostrar al usuario de forma clara

**Alternativa** — listar skills de un repo sin instalar:
```bash
npx skills add vercel-labs/agent-skills --list
```

---

### 2. **Instalar Skill**

**Comando CLI**:
```bash
npx skills add <source> [options]
```

**Flags clave**:
- `-a claude-code` → agente destino
- `-s <skill-name>` → skill específica
- `-g` → instalar en global
- `-y` → no interactivo
- `--copy` → copiar en vez de symlink

**Ejemplos**:
```bash
# Instalar skill específica para Claude Code (no interactivo)
npx skills add vercel-labs/agent-skills -s playwright-pom -a claude-code -y

# Instalar en global
npx skills add vercel-labs/agent-skills -s playwright-pom -g -a claude-code -y

# Ver skills disponibles antes de instalar
npx skills add vercel-labs/agent-skills --list
```

**Proceso**:
1. Ejecutar `npx skills add` con flags `-a claude-code -s <skill> -y`
2. Si es global: añadir `-g`
3. Verificar instalación exitosa
4. Confirmar path final del archivo

---

### 3. **Listar Skills Instaladas**

**Comando CLI**:
```bash
npx skills list [options]
npx skills ls [options]
```

**Flags**:
- `-g` → solo globales
- `-a claude-code` → filtrar por agente

**Ejemplos**:
```bash
npx skills list                  # Todas las instaladas
npx skills ls -g                 # Solo globales
npx skills ls -a claude-code     # Solo de Claude Code
```

**Fallback** (lectura manual de directorios):
```bash
# Global
ls -1 ~/.claude/skills/*.md
ls -1 ~/.claude/rules/*.md

# Local
ls -1 ./.claude/skills/*.md
ls -1 ./.claude/rules/*.md
```

---

### 4. **Verificar Actualizaciones**

**Comando CLI**:
```bash
npx skills check
```

**Comportamiento**: Compara skills instaladas con sus fuentes remotas.

---

### 5. **Actualizar Skills**

**Comando CLI**:
```bash
npx skills update
```

> **NOTA**: Actualiza TODAS las skills de golpe. No acepta nombre individual.

**Fallback** (reinstalar skill específica):
```bash
npx skills add <source> -s <skill-name> -a claude-code -y
```

---

### 6. **Eliminar Skill**

**Comando CLI**:
```bash
npx skills remove [skill] [options]
npx skills rm [skill] [options]
```

**Flags**:
- `-g` → scope global
- `-a claude-code` → agente específico
- `-y` → sin confirmación
- `--all` → eliminar todo

**Ejemplos**:
```bash
npx skills remove playwright-pom -a claude-code -y   # Específica
npx skills remove -g my-skill                         # Desde global
npx skills remove --all                               # Todo
```

**Fallback** (eliminar archivo manualmente):
```bash
rm ~/.claude/skills/playwright-pom.md
rm ./.claude/rules/playwright-pom.md
```

---

### 7. **Crear Plantilla de Skill**

**Comando CLI**:
```bash
npx skills init [name]
```

**Comportamiento**:
- Sin nombre: crea `SKILL.md` en directorio actual
- Con nombre: crea subdirectorio con `SKILL.md`

---

## 📍 Scopes de Instalación

| Scope | Flag | Ubicación | Uso |
|-------|------|-----------|-----|
| **Project** | (default) | `.claude/skills/` | Compartido via repo |
| **Global** | `-g` | `~/.claude/skills/` | Personal, todos los proyectos |

## 🔗 Métodos de Instalación

| Método | Flag | Descripción |
|--------|------|-------------|
| **Symlink** | (default) | Referencia a copia canónica. Recomendado. |
| **Copy** | `--copy` | Copia independiente. Usar si symlinks fallan. |

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
2. Esperar v4.0.0 → Usar Backend Git (sin Node.js)
```

### Error: Skill no encontrada

**Acción**:
```
❌ Skill no encontrada

La skill "non-existent-skill" no existe en skills.sh

Sugerencias:
- Verificar nombre (sensible a mayúsculas)
- Buscar alternativas: npx skills find <query>
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
  version: "2.0.0"

  operations:
    search:   "npx skills find {query}"
    install:  "npx skills add {source} -s {skill} -a claude-code -y"
    list:     "npx skills list" / "npx skills ls -a claude-code"
    check:    "npx skills check"
    update:   "npx skills update"
    remove:   "npx skills remove {skill} -a claude-code -y"
    init:     "npx skills init {name}"
```

---

## 🎯 Reglas de Ejecución

1. **SIEMPRE validar Node.js** antes de ejecutar comandos
2. **Usar `find`** para buscar, NUNCA `search`
3. **Usar flags `-a claude-code -y`** para operaciones no interactivas
4. **Capturar y parsear** output de npx skills
5. **Manejo robusto de errores** (skill no existe, network fail, etc.)
6. **Confirmación al usuario** antes de instalar/eliminar
7. **Verificar instalación** después de cada operación
8. **Consultar** `14-skills-cli-reference.md` ante cualquier duda de sintaxis

---

**Módulo anterior**: 03-abstraction-layer.md
**Módulo siguiente**: 05-backend-git.md (v4.0.0)
**Módulo relacionado**: 06-backend-selector.md
**Referencia CLI**: 14-skills-cli-reference.md
