# 🔍 Otros Archivos y Configuraciones

**Descripción**: Archivos adicionales relacionados con **configuración de Claude Code**, fuera de la jerarquía oficial.

**IMPORTANTE**:
- ✅ SOLO archivos de configuración de Claude Code
- ❌ NO incluyas documentación general del proyecto (README.md, TEST.md, CI.md, etc.)
- ✅ Sé específico: settings, configs, symlinks a skills, archivos CLAUDE*.md extras

---

## 📂 Exploración Completa de `~/.claude/`

Explora el directorio `~/.claude/` buscando **archivos y directorios de configuración de Claude Code**.

**Ya cubierto en jerarquía oficial** (omitir):
- `~/.claude/CLAUDE.md`
- `~/.claude/rules/`
- `~/.claude/projects/`

**Buscar y mostrar**:
- ✅ **Directorios de configuración**: `skills/`, `templates/`, `hooks/`, `config/`, `mcp-servers/`
- ✅ **Archivos de settings**: `settings.json`, `keybindings.json`
- ✅ **Symlinks**: a skills, templates, configs externos
- ✅ **Archivos .md de configuración**: que NO sean documentación de proyecto
- ❌ **NO incluir**: `.credentials.json` (privado - conexión con servidores Anthropic)
- ❌ **NO incluir**: Directorios operacionales (cache/, debug/, downloads/, backups/, telemetry/, etc.)
- ❌ **NO incluir**: Archivos .md que sean documentación de otros proyectos

**Para cada archivo encontrado**:
- PATH completo
- Tipo y tamaño
- Número de líneas (usar `wc -l`)
- Fecha de modificación
- **NO leer contenido completo** si tiene más de 100 líneas

**Formato de listado**:
```
Directorio: name/
  Total archivos: 21

  Archivo: playwright.md
    PATH: ~/.claude/name/playwright.md
    Líneas: 367
    Tamaño: 24K
    Modificado: 2026-01-15
    Descripción: skill de playwright

  [... resto de archivos ...]
```

---

## 📂 Exploración Completa de `./.claude/`

Explora el directorio `./.claude/` buscando **SOLO archivos de configuración de Claude Code**.

**Ya cubierto en jerarquía oficial** (omitir):
- `./.claude/CLAUDE.md`
- `./.claude/rules/`

**Buscar y mostrar**:
- ✅ **Settings y configs**: `settings*.json`, `.skills-config`, `keybindings.json`
- ✅ **Symlinks**: links a skills, templates, etc.
- ✅ **Directorios de config**: directorios que NO sean documentación del proyecto
- ❌ **NO incluir**: archivos .md de documentación del proyecto (TEST.md, POM.md, CI.md, README.md, etc.)

**Criterio**: Si el archivo es configuración/settings de Claude Code → incluir. Si es documentación del proyecto → omitir.

---

## 📂 Archivos de Configuración en Raíz del Proyecto

Busca en la raíz del proyecto (`.`) **SOLO archivos de autogestión/configuración de Claude Code**.

**Ya cubierto en jerarquía oficial** (omitir):
- `./CLAUDE.md`
- `./CLAUDE.local.md`

**Buscar y mostrar**:
- ✅ Archivos con nombres relacionados con Claude: `.claude-*`, `claude-*`, `CLAUDE*.md`
- ✅ `MEMORY.md` en raíz (confusión común - no es oficial)
- ✅ Archivos de configuración específicos de Claude: `claude.json`, `claude-config.*`, etc.
- ❌ **NO incluir**: Archivos .md del proyecto (README.md, TEST.md, POM.md, CI.md, docs del proyecto, etc.)

**Criterio**: SOLO archivos que sean claramente de configuración/autogestión de Claude Code, NO documentación general del proyecto.

**Formato**:
```
Archivo: MEMORY.md
  PATH: ./MEMORY.md
  Líneas: 45
  Tipo: Markdown
  Nota: ⚠️ No es oficial - auto memory oficial está en ~/.claude/projects/<project>/memory/
```

---

## 📊 Resumen de Archivos Encontrados

Al final de esta sección, muestra un resumen:

```
📋 Resumen de Archivos de Configuración Adicionales:

En ~/.claude/:
  - [X] directorios de config (skills, hooks, config, etc.)
  - [X] archivos de settings (.json, .config, etc.)
  - [X] symlinks a configuraciones externas

En ./.claude/:
  - [X] archivos de configuración (settings, configs)
  - [X] symlinks

En raíz del proyecto:
  - [X] archivos de configuración Claude

Total de archivos de configuración adicionales: [X]

Omitidos: [X] directorios operacionales, .credentials.json, documentación del proyecto
```

---

## ⚙️ Reglas de Filtrado Inteligente

- ✅ SOLO archivos de **configuración/autogestión de Claude Code**
- ❌ NO documentación del proyecto (TEST.md, POM.md, CI.md, README.md del proyecto, etc.)
- ✅ Usa comandos de exploración (ls, find) para descubrir
- ✅ NO leas contenido completo de archivos largos (>100 líneas)
- ✅ Filtra inteligentemente - no todo .md es configuración de Claude
- ❌ **EXCLUIR**: `.credentials.json` (privado - NO leer, NO respaldar, NO mencionar)
- ❌ **EXCLUIR**: Directorios operacionales (cache/, debug/, backups/, telemetry/)
