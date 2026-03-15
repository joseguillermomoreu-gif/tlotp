# 📥 Módulo: Instalar Skill

## Misión

Instalar una skill desde skills.sh en la estructura oficial de Claude Code (`<name>/SKILL.md`).

---

## Paso 1 — Seleccionar skill a instalar

**Dos formas de llegar aquí:**

### Desde resultados de búsqueda (07-module-search.md)
```
¿Qué skill quieres instalar?
Introduce el número de la lista o el nombre completo: _
```

### Instalación directa desde menú
```
📥 Instalar skill

Introduce el nombre de la skill:
Ejemplos: playwright-pom, typescript-utils, php-pro

Skill: _
```

---

## Paso 2 — Verificar duplicados

Comprobar si ya existe en las rutas oficiales:

```bash
# Nueva estructura
ls ~/.claude/skills/<name>/SKILL.md 2>/dev/null
ls ./.claude/skills/<name>/SKILL.md 2>/dev/null

# Legacy
ls ~/.claude/skills/<name>.md 2>/dev/null
ls ./.claude/skills/<name>.md 2>/dev/null
```

**Si ya existe:**
```
⚠️ "<name>" ya está instalada en: ~/.claude/skills/<name>/SKILL.md

¿Qué deseas hacer?
1. Cancelar
2. Reinstalar (sobreescribir)
3. Instalar también en local (además de global)
```

---

## Paso 3 — Elegir scope

```
📍 ¿Dónde instalar "<name>"?

1. 🌍 Global (~/.claude/skills/<name>/SKILL.md)
   • Disponible en TODOS tus proyectos

2. 📂 Local (./.claude/skills/<name>/SKILL.md)
   • Solo para ESTE proyecto
```

---

## Paso 4 — Ejecutar instalación

```bash
# Instalar con npx skills
npx skills add <name> -a claude-code -y
```

Mostrar progreso:
```
📥 Instalando "<name>"...

  ✓ Descargando desde skills.sh
  ✓ Instalando con npx skills
```

### Adaptar a estructura oficial

Tras la instalación, verificar la estructura creada por el CLI.
Si el CLI crea un archivo plano (`<name>.md`), migrarlo a la estructura oficial:

```bash
# Si el CLI creó un archivo plano, migrar a directorio
if [ -f ~/.claude/skills/<name>.md ] && [ ! -d ~/.claude/skills/<name> ]; then
  mkdir -p ~/.claude/skills/<name>
  mv ~/.claude/skills/<name>.md ~/.claude/skills/<name>/SKILL.md
fi
```

Si el scope elegido es **local**:
```bash
mkdir -p ./.claude/skills/<name>
# mover o copiar a ./.claude/skills/<name>/SKILL.md
```

---

## Paso 5 — Verificar instalación

```bash
# Verificar que el archivo existe en la ruta correcta
ls ~/.claude/skills/<name>/SKILL.md   # global
ls ./.claude/skills/<name>/SKILL.md   # local
```

Leer el frontmatter y mostrar:
```
══════════════════════════════════════════════════════════════
✅ Skill instalada correctamente
══════════════════════════════════════════════════════════════

  Nombre:      <name>
  Descripción: <description del frontmatter>
  Ubicación:   ~/.claude/skills/<name>/SKILL.md
  Estructura:  ✅ Formato oficial (<name>/SKILL.md)

══════════════════════════════════════════════════════════════
```

---

## 🔥 Mensaje de lore épico al finalizar

Tras confirmar la instalación exitosa, mostrar:

```
⚒️  Los Gwaith-i-Mírdain han sellado el trato.

    "<name>" ha sido forjada en las fraguas de Eregion
    y añadida a tu arsenal, viajero.

    Que sirva bien en la Tierra Media.
```

---

## Paso 6 — Acciones posteriores

```
¿Qué deseas hacer ahora?

1. 📥 Instalar otra skill
2. 🔍 Buscar más skills
3. 🔙 Volver al menú principal
```

---

## Manejo de errores

### Skill no encontrada en skills.sh
```
❌ "<name>" no existe en skills.sh

  • Verifica el nombre exacto
  • Usa "Buscar" para encontrar skills disponibles
```

### Error de permisos
```
❌ Sin permisos para escribir en ~/.claude/skills/

  Solución: chown -R $USER ~/.claude/
  O bien: instala en local (./.claude/skills/)
```

### Error de red
```
⚠️ No se pudo descargar la skill.
   Verifica tu conexión e inténtalo de nuevo.
```

---

**Módulo**: `08-module-install.md`
**Invocado desde**: `07-module-search.md` o `02-menu-principal.md`
**Requiere**: Bash, Write
