# 🔄 Sistema de Reset de Configuraciones

Este módulo se ejecuta cuando el usuario selecciona "Reset de configuraciones" en el menú principal.

---

## ⚠️ REGLA CRÍTICA: Backup Obligatorio

**ANTES** de cualquier reset, **SIEMPRE** hacer backup:

1. Crear directorio: `./tlotp_backup/reset_TIMESTAMP/`
2. Ejecutar backup completo (usar lógica de 02-backup-system.md)
3. Crear BACKUP_INDEX.md
4. Informar al usuario de la ubicación del backup
5. **Solo entonces** continuar con el reset

**Si el backup falla**: NO continuar con el reset, abortar operación.

---

## 📊 Paso 1: Backup Obligatorio

Mostrar mensaje:

```markdown
═══════════════════════════════════════════════════════════

                    ⚠️ SISTEMA DE RESET

═══════════════════════════════════════════════════════════

Antes de continuar, se creará un backup obligatorio de todas
tus configuraciones.

Creando backup...
```

Ejecutar:
1. Crear timestamp: `YYYYMMDD_HHMMSS`
2. Crear directorio: `./tlotp_backup/reset_{TIMESTAMP}/`
3. Copiar TODOS los archivos de configuración (usar lógica de 02-backup-system.md)
4. Crear BACKUP_INDEX.md

Mostrar resultado:

```markdown
✅ Backup creado en:
./tlotp_backup/reset_{TIMESTAMP}/

📦 Total: X archivos (~XXK)

Ver detalles en: BACKUP_INDEX.md

═══════════════════════════════════════════════════════════
```

---

## 📋 Paso 2: Selección de Nivel de Reset

Usar `AskUserQuestion`:

```
header: "Nivel de reset"
question: "¿Qué nivel de reset deseas realizar?"
multiSelect: false
options:
  1. label: "Soft Reset - Solo proyecto"
     description: "Borra: ./.claude/, CLAUDE.local.md, auto memory del proyecto"

  2. label: "Hard Reset - Proyecto + Project Memory"
     description: "Soft + ./CLAUDE.md y configuraciones compartidas del proyecto"

  3. label: "Nuclear Reset - TODO (global + proyecto)"
     description: "⚠️ PELIGRO: Borra ~/.claude/ completo (excepto backups)"
```

---

## 🔄 Paso 3: Ejecución según Nivel

### Nivel 1: Soft Reset

**Archivos/directorios a borrar**:
- `./.claude/` (todo el directorio)
- `./CLAUDE.local.md`
- `~/.claude/projects/{NOMBRE_PROYECTO}/memory/` (auto memory del proyecto)

**Confirmación**: Simple

Mostrar:
```markdown
📋 Soft Reset - Borrará:

  ✓ ./.claude/ (configuración local del proyecto)
  ✓ ./CLAUDE.local.md (si existe)
  ✓ Auto memory del proyecto

¿Continuar? (s/n):
```

Si confirma:
1. Borrar archivos listados
2. Logging de cada operación
3. Mostrar resultado

---

### Nivel 2: Hard Reset

**Archivos/directorios a borrar**:
- Todo de Soft Reset +
- `./CLAUDE.md` (project memory)
- Todos los `CLAUDE.md` en directorios superiores del proyecto

**Confirmación**: Simple

Mostrar:
```markdown
📋 Hard Reset - Borrará:

  ✓ Todo de Soft Reset +
  ✓ ./CLAUDE.md (project memory compartido)
  ✓ CLAUDE.md en directorios superiores

¿Continuar? (s/n):
```

Si confirma:
1. Ejecutar Soft Reset primero
2. Borrar archivos adicionales
3. Logging detallado
4. Mostrar resultado

---

### Nivel 3: Nuclear Reset

**Archivos/directorios a borrar**:
- `~/.claude/` **COMPLETO** (excepto `~/.claude/backups/` si existe)

**Confirmación**: Doble con texto especial

**Primera confirmación**:

Mostrar:
```markdown
═══════════════════════════════════════════════════════════

               ⚠️⚠️⚠️ NUCLEAR RESET ⚠️⚠️⚠️

═══════════════════════════════════════════════════════════

Esto borrará TODA tu configuración global de Claude Code:

  ✓ ~/.claude/CLAUDE.md (tu configuración personal)
  ✓ ~/.claude/rules/ (todas tus reglas)
  ✓ ~/.claude/skills/ (todos tus skills)
  ✓ ~/.claude/settings.json
  ✓ ~/.claude/projects/ (auto memory de TODOS los proyectos)
  ✓ TODO en ~/.claude/ (excepto backups)

Y también TODO del proyecto actual (Hard Reset).

⚠️ ESTA ACCIÓN NO SE PUEDE DESHACER ⚠️

Backup guardado en: ./tlotp_backup/reset_{TIMESTAMP}/

Para continuar, escribe exactamente: DELETE
(o escribe 'cancelar' para abortar):
```

Si el usuario escribe exactamente "DELETE":

**Segunda confirmación**:

```markdown
¿Estás completamente seguro de borrar TODO? (s/n):
```

Si confirma con "s":
1. Borrar `~/.claude/` completo (excepto backups)
2. Ejecutar Hard Reset del proyecto
3. Logging EXHAUSTIVO de cada archivo borrado
4. Mostrar resultado detallado

Si escribe cualquier otra cosa o "n": Cancelar operación.

---

## 📝 Paso 4: Ejecución y Logging

Para cada archivo/directorio a borrar:

1. **Verificar que existe** antes de intentar borrar
2. **Intentar borrar**
3. **Logging**:
   - ✅ Si se borra correctamente: "✅ Borrado: /path/to/file"
   - ❌ Si falla: "❌ Error al borrar: /path/to/file (razón)"
4. **Continuar** aunque algunos archivos fallen

**IMPORTANTE**: No fallar completamente si un archivo no se puede borrar, solo notificar.

---

## ✅ Paso 5: Resultado Final

Al terminar, mostrar resumen:

```markdown
═══════════════════════════════════════════════════════════

                  {NIVEL} RESET COMPLETADO

═══════════════════════════════════════════════════════════

✅ Archivos borrados: X
❌ Errores: Y

Backup disponible en:
./tlotp_backup/reset_{TIMESTAMP}/

{Si hubo errores:}
⚠️ Algunos archivos no pudieron borrarse. Ver log arriba.

{Si fue Nuclear:}
⚠️ Configuración global eliminada.
Para restaurar: usa Recovery desde el backup creado.

═══════════════════════════════════════════════════════════

                 ✅ Reset Finalizado

    Palantír (TLOTP) v1.4 - "Reset System"

═══════════════════════════════════════════════════════════
```

---

## 🚫 Cancelación

El usuario puede cancelar en cualquier momento:
- Si responde "n" en confirmaciones
- Si NO escribe "DELETE" en Nuclear Reset
- Si escribe "cancelar" en cualquier momento

Al cancelar, mostrar:

```markdown
❌ Reset cancelado

Ningún archivo fue modificado.
El backup creado se mantiene en:
./tlotp_backup/reset_{TIMESTAMP}/
```

---

## 🔧 Comandos de Bash a Usar

### Soft Reset
```bash
# Borrar ./.claude/
rm -rf ./.claude/

# Borrar CLAUDE.local.md (si existe)
[ -f ./CLAUDE.local.md ] && rm ./CLAUDE.local.md

# Borrar auto memory del proyecto
PROJECT_PATH=$(pwd | sed 's/\//-/g' | sed 's/^-//')
rm -rf ~/.claude/projects/$PROJECT_PATH/memory/
```

### Hard Reset
```bash
# Todo de Soft Reset +

# Borrar ./CLAUDE.md
[ -f ./CLAUDE.md ] && rm ./CLAUDE.md

# Buscar y borrar CLAUDE.md superiores
current=$(pwd)
while [ "$current" != "/" ]; do
  current=$(dirname "$current")
  [ -f "$current/CLAUDE.md" ] && rm "$current/CLAUDE.md"
done
```

### Nuclear Reset
```bash
# Backup de ~/.claude/backups/ (si existe)
[ -d ~/.claude/backups ] && mv ~/.claude/backups /tmp/claude_backups_temp

# Borrar TODO ~/.claude/
rm -rf ~/.claude/

# Restaurar backups
[ -d /tmp/claude_backups_temp ] && mkdir -p ~/.claude && mv /tmp/claude_backups_temp ~/.claude/backups

# Ejecutar Hard Reset del proyecto
# (usar comandos de Hard Reset)
```

---

*Sistema de Reset - Palantír v1.4*
*⚠️ Módulo de operaciones destructivas - Manejar con cuidado*
