# 🗑️ Módulo Eliminar Skills - Celebrimbor

## Misión

Eliminar skills instaladas de forma segura con confirmación del usuario.

---

## 🎯 Flujo de Eliminación

### Paso 1: Listar Skills Instaladas

**Usar módulo 09-module-list.md** para mostrar skills disponibles:

```
═══════════════════════════════════════════════════════════════
🗑️ Eliminar Skill
═══════════════════════════════════════════════════════════════

Skills instaladas actualmente:

🌍 Global (2 skills):
  1. php-pro
  2. typescript-utils

📂 Local (1 skill):
  3. php-symfony

═══════════════════════════════════════════════════════════════
```

---

### Paso 2: Seleccionar Skill a Eliminar

**Solicitar al usuario**:
```
¿Qué skill deseas eliminar?

Introduce el número [1-3] o el nombre: _
```

**Validar**:
- Si número: verificar rango
- Si nombre: verificar que existe

**Capturar**:
```yaml
skill_to_remove:
  name: "php-pro"
  location: "global"  # o "local"
  path: "~/.claude/skills/php-pro"
```

---

### Paso 3: Confirmación Crítica

**⚠️ IMPORTANTE**: Siempre pedir confirmación antes de eliminar.

**Mostrar detalles**:
```
═══════════════════════════════════════════════════════════════
⚠️ Confirmar Eliminación
═══════════════════════════════════════════════════════════════

Skill a eliminar: php-pro
Ubicación: Global (~/.claude/skills/)
Archivo: ~/.claude/skills/php-pro
Link real: ~/.agents/skills/php-pro/SKILL.md

⚠️ Esta acción NO se puede deshacer.

La skill dejará de estar disponible en TODOS tus proyectos
(es global).

═══════════════════════════════════════════════════════════════

¿Estás seguro de eliminar "php-pro"? [s/N]: _
```

**Si usuario dice "N" o vacío**: Cancelar y volver al menú

**Si usuario dice "s" o "S"**: Continuar con eliminación

---

### Paso 4: Ejecutar Eliminación

**Opción A: Usar npx skills remove** (Recomendado)

```bash
# Con Node.js >=18 y skills CLI
npx skills remove <skill-name>
```

**Ejemplo**:
```bash
source ~/.nvm/nvm.sh && nvm use 20 > /dev/null 2>&1
npx skills remove php-pro
```

**Output esperado**:
```
✓ Removed skill: php-pro
✓ Symlink removed: ~/.claude/skills/php-pro
✓ Source removed: ~/.agents/skills/php-pro/
```

---

**Opción B: Eliminación Manual** (Fallback)

Si `npx skills remove` no existe o falla:

```bash
# Eliminar symlink
rm ~/.claude/skills/php-pro

# Eliminar directorio real (si existe)
rm -rf ~/.agents/skills/php-pro/
```

**Para skills locales**:
```bash
# Local
rm ./.claude/rules/php-symfony.md
```

---

### Paso 5: Verificar Eliminación

**Verificar que el archivo ya NO existe**:
```bash
if [ ! -f ~/.claude/skills/php-pro ]; then
  echo "✅ Skill eliminada correctamente"
else
  echo "❌ Error: Archivo aún existe"
fi
```

---

### Paso 6: Confirmación al Usuario

**Mostrar resultado**:
```
═══════════════════════════════════════════════════════════════
✅ Skill Eliminada Exitosamente
═══════════════════════════════════════════════════════════════

Skill: php-pro
Ubicación: Global
Archivo eliminado: ~/.claude/skills/php-pro

La skill ya NO estará disponible en Claude Code.
Recarga la ventana o inicia nueva sesión para aplicar cambios.

═══════════════════════════════════════════════════════════════
```

---

### Paso 7: Acciones Posteriores

**Preguntar**:
```
¿Qué deseas hacer ahora?

1. Eliminar otra skill
2. Ver skills instaladas (listar)
3. Buscar nuevas skills
4. Volver al menú principal

Elige [1-4]: _
```

---

## 🎨 Manejo de Errores

### Error 1: Skill No Encontrada

**Usuario intenta eliminar skill que no existe**:
```
❌ Skill No Encontrada

La skill "non-existent" no está instalada.

Skills disponibles para eliminar:
  • php-pro (global)
  • typescript-utils (global)

¿Deseas elegir otra? [s/N]: _
```

### Error 2: Sin Permisos

**Falla al eliminar archivo**:
```bash
rm ~/.claude/skills/php-pro
# Error: Permission denied
```

**Mostrar**:
```
❌ Error de Permisos

No se pudo eliminar el archivo ~/.claude/skills/php-pro

Solución:
  sudo rm ~/.claude/skills/php-pro

O verificar permisos:
  ls -la ~/.claude/skills/

¿Deseas reintentar con sudo? [s/N]: _
```

### Error 3: npx skills remove No Disponible

**Comando no existe**:
```bash
npx skills remove php-pro
# Error: Unknown command 'remove'
```

**Acción automática**:
```
⚠️ npx skills remove no disponible

Usando eliminación manual...

✓ Eliminando symlink ~/.claude/skills/php-pro
✓ Eliminando directorio ~/.agents/skills/php-pro/

✅ Skill eliminada manualmente
```

---

## 🔧 Características Adicionales

### Eliminación en Batch (Futuro)

**Eliminar múltiples skills**:
```
🗑️ Eliminar Múltiples Skills

Selecciona skills a eliminar (separa con comas):

1. php-pro
2. typescript-utils
3. php-symfony

Skills a eliminar: 1,3

Confirmar eliminación de:
  • php-pro (global)
  • php-symfony (local)

¿Continuar? [s/N]: _
```

### Backup Antes de Eliminar (Futuro)

**Opcional: Crear backup antes de eliminar**:
```
💾 Backup de Seguridad

¿Crear backup de "php-pro" antes de eliminar?

Ubicación del backup: ~/.celebrimbor/backups/
Archivo: php-pro_2026-02-16.md

Backup te permite restaurar la skill más tarde.

¿Crear backup? [S/n]: _
```

---

## 🔗 Integración con Otros Módulos

### Con Módulo de Listar (09)

```python
# Obtener skills instaladas
installed_skills = list_module.get_installed_skills()

# Mostrar opciones para eliminar
display_skills_to_remove(installed_skills)
```

### Con Backend CLI (04)

```python
# Usar backend para eliminación
backend = selector.get_backend()
result = backend.remove(skill_name, location)
```

### Con Módulo de Búsqueda (07)

```python
# Después de eliminar
if user_chooses("Buscar nuevas skills"):
    search_module.run()
```

---

## 🎯 Reglas de Ejecución

1. **SIEMPRE pedir confirmación** antes de eliminar
2. **Mostrar detalles** de lo que se va a eliminar
3. **Verificar eliminación** después de ejecutar
4. **Informar claramente** el resultado (éxito o error)
5. **Ofrecer acciones posteriores** (eliminar otra, buscar, listar)
6. **Manejo robusto de errores** (permisos, comando no existe)
7. **Preferir npx skills remove** cuando esté disponible
8. **Fallback a eliminación manual** si npx falla

---

## 📊 Ejemplo Completo de Ejecución

```
Usuario: "5. Eliminar Skill"

═══════════════════════════════════════════════════════════════
    🗑️ Eliminar Skill
═══════════════════════════════════════════════════════════════

Skills instaladas:

🌍 Global (1 skill):
  1. php-pro

¿Qué skill eliminar?: 1

───────────────────────────────────────────────────────────────

⚠️ Confirmar Eliminación

Skill: php-pro
Ubicación: Global (~/.claude/skills/php-pro)
Real: ~/.agents/skills/php-pro/

⚠️ NO se puede deshacer

¿Eliminar "php-pro"? [s/N]: s

───────────────────────────────────────────────────────────────

🗑️ Eliminando "php-pro"...

✓ Ejecutando: npx skills remove php-pro
✓ Symlink eliminado: ~/.claude/skills/php-pro
✓ Directorio eliminado: ~/.agents/skills/php-pro/
✓ Verificando eliminación

═══════════════════════════════════════════════════════════════
✅ Skill Eliminada Exitosamente
═══════════════════════════════════════════════════════════════

Skill: php-pro
Ubicación: Global

La skill ya NO está disponible.
Recarga Claude Code para aplicar cambios.

═══════════════════════════════════════════════════════════════

¿Qué hacer ahora?
1. Eliminar otra skill
2. Ver skills instaladas
3. Volver al menú

Elige [1-3]: _
```

---

**Módulo anterior**: 09-module-list.md
**Integra con**: 09-module-list.md, 04-backend-cli.md
**Usa**: npx skills remove (preferido) o rm manual (fallback)
**Tarea**: #5 - Módulo Eliminar
