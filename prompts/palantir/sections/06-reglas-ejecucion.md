# 🚀 Flujo de Ejecución y Reglas

## Flujo de Ejecución

**Sigue este flujo paso a paso**:

1. **Una sola vez al inicio**: Muestra la cabecera elegante

2. **Pregunta por backup** (con `AskUserQuestion`):
   - ¿Hacer backup? → Si sí: ¿Dónde guardar?
   - Si path personalizado: pedir el path

3. **Si hace backup**:
   - Crea estructura de directorios organizada
   - Copia TODOS los archivos detectados preservando jerarquía
   - Añade metadata a cada archivo copiado
   - Crea BACKUP_INDEX.md
   - Informa path completo del backup

4. **Inspecciona en orden**:

   **PARTE 1 - Jerarquía Oficial Claude Code**:
   1. Managed Policy
   2. User Memory
   3. User Rules
   4. Project Memory (recursivo hacia arriba)
   5. Project Rules
   6. Project Local
   7. Auto Memory (MEMORY.md primeras 200 líneas + topic files)

   **PARTE 2 - Otros Archivos (No Oficial)**:
   8. Exploración y detección genérica:
      - Explorar TODO `~/.claude/` (excluir ya cubierto en 1-7)
      - Explorar TODO `./.claude/` (excluir ya cubierto en 1-7)
      - Buscar archivos de configuración en raíz del proyecto
      - Mostrar TODO lo encontrado sin asumir qué es
      - Resumen de archivos adicionales detectados

5. **Para cada ubicación**:
   - Indica PATH completo
   - Muestra STATUS (✅/❌/⚠️)
   - Muestra contenido completo (excepto topic files y skills)
   - Detecta imports (@path/to/file) y lístalos
   - Detecta symlinks e indica destino
   - Detecta YAML frontmatter con paths: y muéstralo

6. **Si necesitas permisos**: Usa `AskUserQuestion` para pedir autorización de usar Bash

7. **Al finalizar inspección**:
   - Informa path del backup
   - Pregunta si quiere ver resumen (con `AskUserQuestion`)
   - Si SÍ: muestra resumen general
   - Si NO: despedida simple
   - **SIEMPRE al final**: Banner footer (lo último que se muestra)

---

## ⚙️ Reglas Importantes

### Cabecera y Footer
- ✅ Cabecera: UNA SOLA VEZ al inicio (antes de preguntar por backup)
- ✅ Footer: UNA SOLA VEZ al final (LO ÚLTIMO que se muestra)
- ✅ Footer va DESPUÉS del resumen (si usuario lo pide) o DESPUÉS de la despedida (si no lo pide)
- ❌ NO repitas cabecera/footer entre interacciones

### Contenido
- ✅ Muestra TODO sin formatear, solo paths y contenidos completos
- ✅ Imports: SOLO mostrar si hay imports @path/to/file detectados
- ✅ Symlinks: Formato conciso `skills/ → /path/ (symlink) | X archivos | XK total`
- ✅ YAML frontmatter: Extraer y mostrar paths de rules

### Auto Memory (Sección 7)
- ✅ MEMORY.md: SOLO primeras 200 líneas (indica total de líneas)
- ✅ Topic files: SOLO listar si existen (nombre + líneas + path, NO contenido)
- ✅ Si NO hay topic files: omitir sección (no decir "no se encontraron")

### Mensajes Condicionales
- ✅ **Imports**: Si NO hay imports → NO mostrar nada sobre imports
- ✅ **Topic files**: Si NO hay topic files → NO mostrar sección
- ✅ **CLAUDE.md superiores**: Si NO hay CLAUDE.md en jerarquía superior → NO mostrar mensaje
- ❌ NO mostrar mensajes tipo "No se encontraron imports" o "No se encontraron topic files"

### Archivos Largos (>100 líneas)
- ✅ Para archivos en exploración genérica >100 líneas: SOLO metadata
- ✅ Usa `wc -l` para contar sin leer contenido
- ✅ Muestra: PATH, líneas, tamaño, fecha de modificación
- ❌ NO leer contenido completo (evitar contaminar contexto)

### Jerarquía de búsqueda
- ✅ Project Memory: buscar recursivamente hacia ARRIBA desde cwd
- ✅ Project Rules: buscar recursivamente DENTRO de `.claude/rules/`
- ✅ User Rules: buscar recursivamente DENTRO de `~/.claude/rules/`

### Permisos
- ✅ Usa `AskUserQuestion` si necesitas Bash para leer archivos
- ✅ Marca STATUS apropiado si no tienes acceso
- ✅ Continúa con la inspección aunque falten archivos

### Filtrado Inteligente (Sección 8)
- ✅ **Secciones 1-7**: Jerarquía oficial Claude Code (especificada)
- ✅ **Sección 8**: Configuración adicional de Claude Code
- ✅ **INCLUIR**: settings.json, keybindings.json, configs, skills, hooks, symlinks, CLAUDE*.md
- ❌ **EXCLUIR**: `.credentials.json` (privado - NO leer, NO respaldar, NO mencionar)
- ❌ **EXCLUIR**: Documentación del proyecto (TEST.md, POM.md, CI.md, README.md del proyecto)
- ❌ **EXCLUIR**: Directorios operacionales (cache/, debug/, backups/, telemetry/)
- ✅ Para archivos >100 líneas: SOLO metadata, NO contenido completo
- ✅ Criterio: "¿Es configuración de Claude Code?" → SÍ: incluir, NO: omitir

### Backup
- ✅ Respalda TODO: jerarquía oficial + otros archivos detectados
- ✅ Estructura organizada por tipo
- ✅ BACKUP_INDEX.md con inventario completo de TODO
- ✅ Metadata añadida a cada archivo respaldado

---

*Palantír v1.3 - "La piedra que todo lo ve"* 👁️
*Arquitectura modular con @imports*
