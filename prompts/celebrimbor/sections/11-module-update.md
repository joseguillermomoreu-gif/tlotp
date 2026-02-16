# 🔄 Módulo Actualizar Skills - Celebrimbor

## Misión

Actualizar skills instaladas a sus últimas versiones usando el backend seleccionado.

---

## 🎯 Flujo de Actualización

### Paso 0: Verificación al Inicio (PRE-MENU)

**IMPORTANTE**: Esta verificación se ejecuta ANTES de mostrar el menú principal.

**Ubicación**: Después de seleccionar backend, antes del menú de operaciones.

**Comando**:
```bash
npx skills check
```

**Parsear output**:
```
Checking for skill updates...
Checking 3 skill(s) for updates...

Available updates:
• playwright-pom (v1.2.0 → v1.3.0)
• typescript-utils (v2.1.0 → v2.2.0)

✓ 1 skill is up to date
```

**Mostrar en banner del menú**:
```
═══════════════════════════════════════════════════════════════
    🔮 Celebrimbor - Gestión de Skills ⚒️
═══════════════════════════════════════════════════════════════

Backend activo: CLI ⚡ (Node.js v20.11.0)

🔍 Verificando estado de skills...

✓ 3 skills instaladas

⚠️ 2 skills con actualizaciones disponibles:
  • playwright-pom (v1.2.0 → v1.3.0)
  • typescript-utils (v2.1.0 → v2.2.0)

💡 Usa "4. Actualizar Skills" para actualizarlas

═══════════════════════════════════════════════════════════════
```

**Si NO hay updates**:
```
🔍 Verificando estado de skills...

✓ 3 skills instaladas
✓ Todas las skills están actualizadas
```

---

## 🔄 Paso 1: Usuario Selecciona Opción 4

**Desde menú principal**: "4. 🔄 Actualizar Skills"

**Mostrar**:
```
═══════════════════════════════════════════════════════════════
    🔄 Actualizar Skills (Todas)
═══════════════════════════════════════════════════════════════
```

---

## 🔍 Paso 2: Verificar Updates Disponibles

**Ejecutar nuevamente** (por si el usuario dejó pasar tiempo):
```bash
npx skills check
```

**Si hay updates disponibles**:
```
Actualizaciones disponibles (2):

  1. playwright-pom
     Actual: v1.2.0 → Nueva: v1.3.0
     Descripción: Page Object Model patterns

  2. typescript-utils
     Actual: v2.1.0 → Nueva: v2.2.0
     Descripción: TypeScript utility functions

═══════════════════════════════════════════════════════════════
```

**Si NO hay updates**:
```
✅ Todas las skills están actualizadas

No hay nada que actualizar.

═══════════════════════════════════════════════════════════════

¿Qué deseas hacer?
1. Volver al menú principal
2. Buscar nuevas skills
3. Listar skills instaladas

Elige [1-3]: _
```

→ Volver al flujo correspondiente según elección.

---

## ⚠️ Paso 3: Advertencia - Update All

**IMPORTANTE**: Backend CLI solo permite actualizar TODAS las skills.

**Mostrar advertencia clara**:
```
═══════════════════════════════════════════════════════════════
⚠️ Modo de Actualización: TODAS las Skills
═══════════════════════════════════════════════════════════════

Backend CLI (npx) actualiza TODAS las skills instaladas.

Skills que se actualizarán:
  ✓ playwright-pom (v1.2.0 → v1.3.0)
  ✓ typescript-utils (v2.1.0 → v2.2.0)
  • other-skill (sin cambios - ya actualizada)

Total: 3 skills procesadas, 2 con actualizaciones

⚠️ No es posible actualizar skills de forma selectiva con CLI.

💡 Actualización selectiva estará disponible con Backend Git (v4.0.0)

═══════════════════════════════════════════════════════════════
```

---

## 🤔 Paso 4: Confirmación del Usuario

**Preguntar**:
```
¿Deseas actualizar TODAS las skills? [s/N]: _
```

**Si usuario dice "N" o vacío**:
- Cancelar actualización
- Volver al menú principal

**Si usuario dice "s" o "S"**:
- Continuar con actualización

---

## 🚀 Paso 5: Ejecutar Actualización

**Comando**:
```bash
npx skills update
```

**Mostrar progreso**:
```
🔄 Actualizando skills...

Ejecutando: npx skills update

[Aquí se muestra el output de npx skills update en tiempo real]
```

**Output esperado de npx**:
```
Updating skills...

✓ playwright-pom updated to v1.3.0
✓ typescript-utils updated to v2.2.0
✓ other-skill already up to date

Successfully updated 2 skill(s)
```

---

## ✅ Paso 6: Confirmación de Resultado

**Parsear resultado** y mostrar resumen:

```
═══════════════════════════════════════════════════════════════
✅ Actualización Completada
═══════════════════════════════════════════════════════════════

Skills actualizadas (2):
  ✓ playwright-pom → v1.3.0
  ✓ typescript-utils → v2.2.0

Skills sin cambios (1):
  • other-skill (ya estaba actualizada)

Total: 3 skills procesadas

💡 Las actualizaciones estarán disponibles al recargar Claude Code
   o iniciar una nueva sesión.

═══════════════════════════════════════════════════════════════
```

---

## 🎭 Paso 7: Acciones Posteriores

**Preguntar**:
```
¿Qué deseas hacer ahora?

1. Ver skills instaladas (listar)
2. Buscar nuevas skills
3. Instalar otra skill
4. Volver al menú principal

Elige [1-4]: _
```

---

## 🎨 Manejo de Errores

### Error 1: Network Error

**npx skills update falla por conexión**:
```bash
npx skills update
# Error: Failed to fetch updates from repository
# Network error: ENOTFOUND
```

**Mostrar**:
```
═══════════════════════════════════════════════════════════════
❌ Error de Conexión
═══════════════════════════════════════════════════════════════

No se pudo conectar a los repositorios de skills.

Posibles causas:
  • Sin conexión a internet
  • Repositorios temporalmente no disponibles
  • Firewall bloqueando la conexión

Soluciones:
  • Verifica tu conexión a internet
  • Reintenta en unos momentos
  • Usa Backend Git (offline) en v4.0.0

═══════════════════════════════════════════════════════════════

¿Reintentar actualización? [s/N]: _
```

### Error 2: Sin Permisos

**Falla al escribir archivos**:
```bash
npx skills update
# Error: Permission denied writing to ~/.agents/skills/
```

**Mostrar**:
```
═══════════════════════════════════════════════════════════════
❌ Error de Permisos
═══════════════════════════════════════════════════════════════

No se pudo actualizar por falta de permisos.

Solución:
  sudo chown -R $USER ~/.agents/skills/
  sudo chown -R $USER ~/.claude/skills/

O verificar permisos:
  ls -la ~/.agents/skills/
  ls -la ~/.claude/skills/

═══════════════════════════════════════════════════════════════

¿Deseas ver ayuda para corregir permisos? [s/N]: _
```

### Error 3: Actualización Parcial

**Algunas skills se actualizan, otras fallan**:
```
Updating skills...

✓ playwright-pom updated to v1.3.0
✗ typescript-utils failed to update (corrupted file)

Partially completed: 1 of 2 skill(s) updated
```

**Mostrar**:
```
═══════════════════════════════════════════════════════════════
⚠️ Actualización Parcial
═══════════════════════════════════════════════════════════════

Actualizadas correctamente (1):
  ✓ playwright-pom → v1.3.0

Fallaron (1):
  ✗ typescript-utils (archivo corrupto)

Acciones recomendadas:
1. Eliminar skill corrupta: npx skills remove typescript-utils
2. Reinstalar: npx skills add typescript-utils
3. Reportar issue si el problema persiste

═══════════════════════════════════════════════════════════════

¿Deseas eliminar y reinstalar la skill fallida? [s/N]: _
```

→ Si "s": Ir a módulo 10 (remove) + módulo 08 (install)

---

## 🔧 Características Futuras

### Backend Git - Update Selectivo (v2.2.0)

**Actualización selectiva de skills individuales**:
```
═══════════════════════════════════════════════════════════════
    🔄 Actualizar Skills (Selectivo)
═══════════════════════════════════════════════════════════════

Backend activo: Git 📦

Actualizaciones disponibles (3):

  1. playwright-pom (v1.2.0 → v1.3.0)
  2. typescript-utils (v2.1.0 → v2.2.0)
  3. react-hooks (v3.0.0 → v3.1.0)

¿Cuáles actualizar? [1-3, all, none]: 1,3

Seleccionadas:
  ✓ playwright-pom
  ✓ react-hooks

¿Confirmar actualización selectiva? [s/N]: s

Actualizando...
  ✓ playwright-pom → v1.3.0
  ✓ react-hooks → v3.1.0

✅ 2 skills actualizadas exitosamente
```

---

## 🔗 Integración con Otros Módulos

### Con Detector de Entorno (01)

**Al inicio de Celebrimbor**:
```python
# Después de detectar backend CLI
if backend == "CLI":
    updates_available = check_updates()
    display_updates_banner(updates_available)
    show_menu()
```

### Con Backend CLI (04)

```python
def check_updates():
    """Ejecuta npx skills check y parsea resultado"""
    output = bash("npx skills check")
    return parse_updates(output)

def update_all_skills():
    """Ejecuta npx skills update"""
    output = bash("npx skills update")
    return parse_update_result(output)
```

### Con Módulo Listar (09)

**Mostrar versiones actuales antes de actualizar**:
```python
installed = list_module.get_installed_skills()
updates = check_updates()

# Combinar info
for skill in installed:
    if skill.name in updates:
        skill.current_version = installed[skill.name].version
        skill.new_version = updates[skill.name].version
```

### Con Módulo Buscar (07)

**Después de actualizar, ofrecer buscar más**:
```python
if user_selects("Buscar nuevas skills"):
    search_module.run()
```

---

## 🎯 Reglas de Ejecución

1. **SIEMPRE ejecutar `npx skills check` al inicio** de Celebrimbor
2. **Mostrar updates disponibles** en el banner del menú principal
3. **Advertir claramente** que CLI actualiza TODAS las skills
4. **Pedir confirmación** antes de ejecutar update
5. **Mostrar progreso** durante la actualización
6. **Parsear resultado** y confirmar qué se actualizó
7. **Manejo robusto de errores** (network, permisos, parcial)
8. **Ofrecer acciones posteriores** (listar, buscar, instalar)

---

## 📊 Ejemplo Completo de Ejecución

### Escenario: Usuario con 2 Skills con Updates Disponibles

**Inicio de Celebrimbor (después de seleccionar backend)**:
```
═══════════════════════════════════════════════════════════════
    🔮 Celebrimbor - Gestión de Skills ⚒️
═══════════════════════════════════════════════════════════════

Backend activo: CLI ⚡ (Node.js v20.11.0)

🔍 Verificando estado de skills...

✓ 3 skills instaladas

⚠️ 2 skills con actualizaciones disponibles:
  • playwright-pom (v1.2.0 → v1.3.0)
  • typescript-utils (v2.1.0 → v2.2.0)

💡 Usa "4. Actualizar Skills" para actualizarlas

═══════════════════════════════════════════════════════════════

Operaciones disponibles:
...
4. 🔄 Actualizar Skills ✅
...

Elige una opción [1-9]: 4
```

**Usuario selecciona opción 4**:
```
═══════════════════════════════════════════════════════════════
    🔄 Actualizar Skills (Todas)
═══════════════════════════════════════════════════════════════

Actualizaciones disponibles (2):

  1. playwright-pom
     Actual: v1.2.0 → Nueva: v1.3.0

  2. typescript-utils
     Actual: v2.1.0 → Nueva: v2.2.0

───────────────────────────────────────────────────────────────

⚠️ Backend CLI actualiza TODAS las skills instaladas

Skills que se procesarán:
  ✓ playwright-pom (v1.2.0 → v1.3.0)
  ✓ typescript-utils (v2.1.0 → v2.2.0)
  • react-hooks (sin cambios)

Total: 3 skills procesadas, 2 con actualizaciones

───────────────────────────────────────────────────────────────

¿Deseas actualizar TODAS las skills? [s/N]: s

───────────────────────────────────────────────────────────────

🔄 Actualizando skills...

Ejecutando: npx skills update

✓ playwright-pom updated to v1.3.0
✓ typescript-utils updated to v2.2.0
✓ react-hooks already up to date

Successfully updated 2 skill(s)

═══════════════════════════════════════════════════════════════
✅ Actualización Completada
═══════════════════════════════════════════════════════════════

Skills actualizadas (2):
  ✓ playwright-pom → v1.3.0
  ✓ typescript-utils → v2.2.2

Skills sin cambios (1):
  • react-hooks (ya estaba actualizada)

💡 Recarga Claude Code para aplicar cambios

═══════════════════════════════════════════════════════════════

¿Qué deseas hacer ahora?
1. Ver skills instaladas (listar)
2. Buscar nuevas skills
3. Volver al menú principal

Elige [1-3]: 3
```

---

**Módulo anterior**: 10-module-remove.md
**Integra con**: 04-backend-cli.md, 09-module-list.md, 01-detector-entorno.md
**Usa**: `npx skills check`, `npx skills update`
**Tarea**: #6 - Módulo Actualizar (100 XP)
**Backend**: CLI actual (update all), Git futuro v4.0.0 (update selective)
