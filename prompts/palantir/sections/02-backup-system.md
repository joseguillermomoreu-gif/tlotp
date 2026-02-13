# 💾 Sistema de Backup

**ANTES de la inspección**, usa el tool `AskUserQuestion` para preguntar al usuario:

## Pregunta 1: ¿Hacer Backup?

```
header: "Backup"
question: "¿Quieres hacer un backup de tus configuraciones antes de inspeccionar?"
options:
  1. label: "Sí, hacer backup"
     description: "Recomendado: Guardar copia de seguridad de todas las configuraciones"
  2. label: "No, solo inspeccionar"
     description: "Continuar directamente sin crear backup"
```

**Si selecciona "No"**: Salta al siguiente paso (Inspección).

**Si selecciona "Sí"**, continúa con Pregunta 2:

## Pregunta 2: ¿Dónde Guardar el Backup?

```
header: "Path Backup"
question: "¿Dónde quieres guardar el backup?"
options:
  1. label: "Directorio interno de Claude (~/.claude/backup/)"
     description: "Backup centralizado, no contamina proyectos (Recomendado)"
  2. label: "Proyecto actual (./tlotp_backup/)"
     description: "Backup portable con el proyecto donde ejecutas Palantír"
  3. label: "Proyecto TLOTP"
     description: "En el repositorio TLOTP (busca palantir-prompt.md)"
  4. label: "Path personalizado"
     description: "Especificar ruta manualmente"
```

**Si selecciona opción 4 (Path personalizado)**: Pregunta al usuario "Indica el path completo donde guardar el backup:"

## Crear el Backup

Una vez elegido el path de destino:

1. **Crea la estructura de backup** con timestamp: `[PATH_ELEGIDO]/backup_YYYY-MM-DD_HH-MM-SS/`

2. **Dentro del backup, crea subdirectorios** que reflejen la jerarquía:
   ```
   backup_YYYY-MM-DD_HH-MM-SS/
   ├── managed-policy/        (si existe)
   ├── user-memory/            (~/.claude/CLAUDE.md)
   ├── user-rules/             (~/.claude/rules/*.md)
   ├── project-memory/         (./CLAUDE.md, ./.claude/CLAUDE.md)
   ├── project-rules/          (./.claude/rules/*.md)
   ├── project-local/          (./CLAUDE.local.md)
   ├── auto-memory/            (~/.claude/projects/<project>/memory/)
   └── BACKUP_INDEX.md         (índice de todo lo respaldado)
   ```

3. **Para CADA archivo de configuración** que detectes:
   - Cópialo al subdirectorio correspondiente del backup
   - Preserva la estructura de subdirectorios (ej: rules/frontend/react.md)
   - Añade metadata al final del archivo:
   ```

   ---
   ## 📦 Backup Metadata
   - Fecha de backup: YYYY-MM-DD HH:MM:SS
   - Ubicación original: [PATH_COMPLETO_DEL_ARCHIVO_ORIGINAL]
   - Tipo: [Managed Policy/User Memory/Project Rules/etc.]
   - Backup realizado por: Palantír (TLOTP) v1.3
   ```

4. **Crea BACKUP_INDEX.md** en la raíz del backup con:

   ```markdown
═══════════════════════════════════════════════════════════

                   🔮 P A L A N T Í R

             The All-Seeing Configuration Stone
                 TLOTP Inspector Module v1.3

            Jerarquía Oficial Claude Code Memory

═══════════════════════════════════════════════════════════

   Fecha: YYYY-MM-DD HH:MM:SS
   Proyecto: [nombre del proyecto]
   Total de archivos: [número]

   ## Archivos Respaldados

   ### Managed Policy
   - [listar archivos o "No encontrado"]

   ### User Memory
   - [listar archivos o "No encontrado"]

   ### User Rules
   - [listar archivos o "No encontrado"]

   ### Project Memory
   - [listar archivos o "No encontrado"]

   ### Project Rules
   - [listar archivos o "No encontrado"]

   ### Project Local
   - [listar archivos o "No encontrado"]

   ### Auto Memory
   - [listar archivos o "No encontrado"]
   ```

5. **Informa al usuario** con el siguiente banner:

═══════════════════════════════════════════════════════════

                  ✅ Backup Completado

═══════════════════════════════════════════════════════════

📦 Ubicación: [PATH_COMPLETO_DEL_BACKUP]
📊 Total archivos: [número] ([tamaño total])

💡 Ver detalles completos en: BACKUP_INDEX.md

═══════════════════════════════════════════════════════════
