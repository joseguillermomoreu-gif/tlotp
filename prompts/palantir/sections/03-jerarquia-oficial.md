# 📋 Inspección de Jerarquía Oficial

Debes inspeccionar **TODA la jerarquía oficial de memoria** de Claude Code en el siguiente orden:

## Para CADA ubicación de memoria:

1. **Indica el PATH completo** del archivo/directorio
2. **Muestra el CONTENIDO COMPLETO** sin modificar nada
3. **Indica STATUS**: ✅ Encontrado / ❌ No existe / ⚠️ Sin permisos
4. **NO formatees, NO resumas, NO filtres** - muestra todo tal cual
5. **Solicita** al usuario todos los permisos que necesites para acceder/leer/copiar los ficheros

---

## 🏢 1. Managed Policy (Organización)

**Descripción**: Políticas organizacionales gestionadas por IT/DevOps.

**Ubicaciones según OS** (busca en la correspondiente):
- **Linux**: `/etc/claude-code/CLAUDE.md`
- **macOS**: `/Library/Application Support/ClaudeCode/CLAUDE.md`
- **Windows**: `C:\Program Files\ClaudeCode\CLAUDE.md`

**Qué mostrar**:
- PATH completo del archivo
- STATUS (✅/❌/⚠️)
- Contenido completo si existe

---

## 👤 2. User Memory (Personal - Global)

**Descripción**: Preferencias personales que aplican a todos los proyectos.

**Ubicación**: `~/.claude/CLAUDE.md`

**Qué mostrar**:
- PATH completo
- STATUS
- Contenido completo
- **Detectar imports**: Si el archivo contiene `@path/to/file`, listar qué archivos importa

---

## 📚 3. User Rules (Personal - Modular)

**Descripción**: Reglas personales organizadas por tema.

**Ubicación**: `~/.claude/rules/*.md`

**Qué mostrar**:
- PATH del directorio `~/.claude/rules/`
- Listar TODOS los archivos `.md` recursivamente (incluyendo subdirectorios)
- Para cada archivo:
  - PATH completo
  - Si tiene YAML frontmatter con `paths:`, mostrarlo
  - Contenido completo del archivo
  - Si es symlink, indicar a qué apunta

**Ejemplo de archivo con paths**:
```markdown
---
paths:
  - "src/**/*.ts"
  - "lib/**/*.ts"
---

# TypeScript Rules
[contenido...]
```

---

## 📁 4. Project Memory (Equipo - Compartido)

**Descripción**: Instrucciones compartidas del proyecto con el equipo (en git).

**Ubicaciones posibles** (buscar ambas):
1. `./CLAUDE.md` (raíz del proyecto)
2. `./.claude/CLAUDE.md` (directorio oculto)

**Además, buscar recursivamente hacia ARRIBA**:
- Desde el directorio actual, busca CLAUDE.md en cada directorio padre hasta la raíz
- Ejemplo: Si estás en `/project/src/components/`, buscar en:
  - `/project/src/components/CLAUDE.md`
  - `/project/src/CLAUDE.md`
  - `/project/CLAUDE.md`

**Qué mostrar**:
- Todos los CLAUDE.md encontrados (del actual hacia arriba)
- Para cada uno: PATH, STATUS, contenido
- **Detectar imports**: Si contiene `@path/to/file`, listar archivos importados

---

## 📋 5. Project Rules (Equipo - Modular)

**Descripción**: Reglas modulares del proyecto, organizadas por tema, con soporte de paths específicos.

**Ubicación**: `./.claude/rules/*.md`

**Qué mostrar**:
- PATH del directorio `./.claude/rules/`
- Listar TODOS los archivos `.md` recursivamente
- Estructura de subdirectorios (ej: `frontend/`, `backend/`)
- Para cada archivo:
  - PATH completo
  - Si tiene YAML frontmatter con `paths:`, mostrarlo
  - Contenido completo del archivo
  - Si es symlink, indicar a qué apunta y mostrar contenido del destino

**Ejemplo de estructura**:
```
./.claude/rules/
├── frontend/
│   ├── react.md         (con paths: "src/**/*.tsx")
│   └── styles.md        (con paths: "src/**/*.css")
├── backend/
│   ├── api.md           (con paths: "src/api/**/*.ts")
│   └── database.md      (sin paths - aplica a todo)
└── security.md          (sin paths - aplica a todo)
```

---

## 🔒 6. Project Local (Personal - No en Git)

**Descripción**: Preferencias personales del proyecto actual (automáticamente gitignored).

**Ubicación**: `./CLAUDE.local.md`

**Qué mostrar**:
- PATH completo
- STATUS
- Contenido completo
- **Detectar imports**: Si contiene `@path/to/file`, listar archivos importados

**Nota**: Este archivo NO se comparte con el equipo (está en .gitignore automáticamente).

---

## 🤖 7. Auto Memory (Claude Auto-Guarda)

**Descripción**: Notas que Claude guarda automáticamente mientras trabaja en el proyecto.

**Ubicación**: `~/.claude/projects/<project>/memory/`

**Identificar <project>**:
- Si el proyecto es un repositorio git: usar la raíz del repo
- Si no es git: usar el directorio de trabajo actual

**Estructura**:
```
~/.claude/projects/<project>/memory/
├── MEMORY.md          ← Solo primeras 200 líneas se cargan al inicio
├── debugging.md       ← Topic files (se leen on-demand)
├── patterns.md
├── api-conventions.md
└── ...
```

**Qué mostrar**:
- PATH completo del directorio de auto memory
- Listar TODOS los archivos en el directorio
- Para `MEMORY.md`:
  - Mostrar **SOLO las primeras 200 líneas** (resto no se carga en Claude)
  - Indicar cuántas líneas tiene en total
  - Ejemplo: "MEMORY.md (412 líneas, solo primeras 200 cargadas)"
- Para otros archivos (topic files):
  - Nombre y número de líneas
  - PATH completo
  - **NO mostrar contenido completo** (son topic files que Claude lee on-demand)

---

## 🔧 Manejo de Problemas de Acceso

Si encuentras problemas de permisos al leer CUALQUIER archivo:

1. **Intenta primero** con Read tool
2. **Si falla por permisos**, usa `AskUserQuestion`:
   ```
   header: "Permisos"
   question: "No puedo leer [NOMBRE_ARCHIVO] con Read. ¿Intentar con Bash?"
   options:
     1. label: "Sí, intentar con Bash"
        description: "Leer usando cat (puede requerir permisos especiales)"
     2. label: "No, continuar sin este archivo"
        description: "Omitir y continuar con la inspección"
   ```
3. **Si usuario acepta**: Usa `cat [path]` con Bash
4. **Si aún así falla o usuario rechaza**: Marca STATUS como ⚠️ Sin permisos y continúa
