# 📊 Formato de Respuesta

## Banner Inicial

**Al INICIO de la ejecución** (una sola vez):

```markdown
═══════════════════════════════════════════════════════════

                     🔮 P A L A N T Í R

             The All-Seeing Configuration Stone
                TLOTP Inspector Module v1.3

             Jerarquía Oficial Claude Code Memory

═══════════════════════════════════════════════════════════
```

---

## Formato Durante Inspección

**Luego** pregunta por el backup y procede con la inspección mostrando:

```markdown
[Si se hizo backup:]
═══════════════════════════════════════════════════════════

                 ✅ Backup Completado

═══════════════════════════════════════════════════════════

📦 Ubicación: [PATH_COMPLETO_DEL_BACKUP]
📊 Total archivos: [número] ([tamaño total])

💡 Ver detalles completos en: BACKUP_INDEX.md

═══════════════════════════════════════════════════════════

# 📋 INSPECCIÓN DE CONFIGURACIONES

═══════════════════════════════════════════════════════════

## 🏢 1. Managed Policy (Organización)

**Descripción**: Políticas organizacionales (IT/DevOps)
**PATH**: [/etc/claude-code/CLAUDE.md o equivalente según OS]
**STATUS**: [✅ Encontrado / ❌ No existe / ⚠️ Sin permisos]

[Si existe: Mostrar contenido COMPLETO]

**IMPORTANTE**: Si NO hay imports detectados, NO MUESTRES nada sobre imports.

[SOLO Si hay imports @path/to/file:]
**Imports detectados**:
  - @path/to/file1
  - @path/to/file2

---

## 👤 2. User Memory (Personal - Global)

**Descripción**: Preferencias personales para todos los proyectos
**PATH**: ~/.claude/CLAUDE.md
**STATUS**: [✅ / ❌ / ⚠️]

[Contenido completo]

**IMPORTANTE**: Si NO hay imports detectados, NO MUESTRES nada sobre imports.

[SOLO Si hay imports @path/to/file:]
**Imports detectados**:
  - @path/to/file1
  - @path/to/file2

---

## 📚 3. User Rules (Personal - Modular)

**Descripción**: Reglas personales por tema
**PATH directorio**: ~/.claude/rules/
**STATUS**: [✅ / ❌ / ⚠️]

[Listar estructura de subdirectorios]

### Archivo: [nombre.md]
**PATH**: [path completo]
**Paths específicos**: [Si tiene YAML frontmatter, mostrar]
**Symlink**: [Si es symlink, indicar destino]

[Contenido completo del archivo]

[Repetir para cada archivo en el directorio]

---

## 📁 4. Project Memory (Equipo - Compartido)

**Descripción**: Instrucciones del proyecto compartidas con el equipo

### CLAUDE.md encontrados (de específico a general):

#### ./path/to/CLAUDE.md
**PATH**: [path completo]
**STATUS**: [✅ / ❌ / ⚠️]

[Contenido completo]

**IMPORTANTE**: Si NO hay imports detectados, NO MUESTRES nada sobre imports.

[SOLO Si hay imports @path/to/file:]
**Imports detectados**:
  - @path/to/file1
  - @path/to/file2

**IMPORTANTE**: Si NO hay otros CLAUDE.md en jerarquía superior, NO MUESTRES nada.

[SOLO si existen otros CLAUDE.md:]
**Otros CLAUDE.md en jerarquía superior**:
  - /path/to/parent/CLAUDE.md
  - /path/to/grandparent/CLAUDE.md

---

## 📋 5. Project Rules (Equipo - Modular)

**Descripción**: Reglas modulares del proyecto con paths específicos
**PATH directorio**: ./.claude/rules/
**STATUS**: [✅ / ❌ / ⚠️]

[Mostrar estructura de subdirectorios completa]

### frontend/react.md
**PATH**: ./.claude/rules/frontend/react.md
**Paths específicos**:
```yaml
---
paths:
  - "src/**/*.tsx"
  - "src/**/*.ts"
---
```
**Symlink**: [indicar si lo es]

[Contenido completo]

[Repetir para cada archivo]

---

## 🔒 6. Project Local (Personal - No Git)

**Descripción**: Preferencias personales del proyecto (gitignored)
**PATH**: ./CLAUDE.local.md
**STATUS**: [✅ / ❌ / ⚠️]

[Contenido completo]

**IMPORTANTE**: Si NO hay imports detectados, NO MUESTRES nada sobre imports.

[SOLO Si hay imports @path/to/file:]
**Imports detectados**:
  - @path/to/file1
  - @path/to/file2

---

## 🤖 7. Auto Memory (Claude Auto-Guarda)

**Descripción**: Notas automáticas de Claude para este proyecto
**PATH directorio**: ~/.claude/projects/[nombre-proyecto]/memory/
**STATUS**: [✅ / ❌ / ⚠️]

### MEMORY.md (índice principal)
**PATH**: [path completo]
**Líneas totales**: [número]
**Líneas cargadas**: 200 (solo primeras 200 se cargan automáticamente)

[Mostrar SOLO primeras 200 líneas]

**IMPORTANTE**: Si NO hay topic files adicionales, NO MUESTRES esta sección.

[SOLO Si hay topic files adicionales:]
### Topic Files (lectura on-demand)

- debugging.md ([número] líneas) - [PATH]
- patterns.md ([número] líneas) - [PATH]
[Listar todos los topic files encontrados]

---

## 🔍 8. Otros Archivos y Configuraciones

**Descripción**: Archivos de configuración de Claude Code (fuera de jerarquía oficial)

### Exploración ~/.claude/ (configuración adicional)

**PATH directorio**: ~/.claude/
**Archivos/directorios de configuración encontrados**: [número]

**Configuración detectada**:
- Directorios: skills/, hooks/, config/, templates/, mcp-servers/
- Archivos settings: settings.json, keybindings.json
- Symlinks a configuraciones externas

**Ejemplo**:
```
skills/ → /ruta/externa/skills (symlink)
  21 archivos | 260K total

  - playwright.md (367 líneas, 24K)
  - pom.md (616 líneas, 16K)
  - [... resto de archivos ...]
```

**Directorios omitidos** (operacionales):
- cache/, debug/, downloads/, backups/, telemetry/, session-env/, etc.

### Exploración ./.claude/ (configuración adicional)

**PATH directorio**: ./.claude/
**Archivos de configuración encontrados**: [número]

**Solo configuración de Claude Code**:
- settings.local.json (2.1K) - [PATH]
- config/settings.json (1.5K) - [PATH]
- symlinks/ - [detallar symlinks]

**Archivos omitidos**:
- ❌ Documentación del proyecto (TEST.md, POM.md, CI.md, README.md, etc.)

### Archivos raíz proyecto (configuración Claude)

**PATH directorio**: ./
**Archivos de configuración Claude encontrados**: [número]

**Solo archivos de configuración de Claude**:

Ejemplo:
- MEMORY.md (45 líneas) - [PATH]
  ⚠️ Nota: No oficial - auto memory oficial está en ~/.claude/projects/<project>/memory/

**Archivos omitidos**:
- ❌ Documentación del proyecto (README.md, CONTRIBUTING.md, docs/ del proyecto, etc.)

### 📊 Resumen Configuración Adicional

```
En ~/.claude/:
  - [X] directorios de config
  - [X] archivos de settings
  - [X] symlinks

En ./.claude/:
  - [X] archivos de configuración Claude

En raíz proyecto:
  - [X] archivos de config Claude (no docs del proyecto)

Total archivos de configuración: [X]
Archivos omitidos: operacionales + documentación proyecto
```

═══════════════════════════════════════════════════════════
```

---

## Resumen Final

**Al FINAL de la inspección**:

1. **Informar path del backup**:
```markdown
💾 Backup guardado en:
[PATH_COMPLETO_DEL_BACKUP]

Ver detalles completos en: BACKUP_INDEX.md
```

2. **Preguntar al usuario** (con `AskUserQuestion`):
```
header: "Resumen"
question: "¿Quieres ver un resumen general de tu configuración?"
options:
  1. label: "Sí, mostrar resumen"
     description: "Ver resumen de configuración activa"
  2. label: "No, terminar"
     description: "Finalizar inspección"
```

3. **Si selecciona "Sí"**, mostrar resumen:
```markdown
═══════════════════════════════════════════════════════════

                  📊 Resumen General

═══════════════════════════════════════════════════════════

Configuración Activa de Claude Code:

Jerarquía Oficial:
  1. ❌/✅ Managed Policy - [estado]
  2. ❌/✅ User Memory - [estado y líneas]
  3. ❌/✅ User Rules - [estado]
  4. ❌/✅ Project Memory - [estado y líneas]
  5. ❌/✅ Project Rules - [estado]
  6. ❌/✅ Project Local - [estado]
  7. ❌/✅ Auto Memory - [estado y líneas]

Configuración Adicional:
  - Model: [configurado globalmente]
  - Skills: [número] skills ([si es symlink: indicar])
  - Permissions: [si hay settings.local.json]
  - [Otros items detectados]

💾 Backup completo guardado en:
[PATH]
```

---

## Banner Footer

4. **SIEMPRE al final** (después del resumen o si selecciona "No"), mostrar banner footer:
```markdown
═══════════════════════════════════════════════════════════

                 ✅ Inspección Completada

    Palantír (TLOTP) v1.4 - "La piedra que todo lo ve"

═══════════════════════════════════════════════════════════
```
