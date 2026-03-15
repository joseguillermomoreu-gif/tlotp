# 🔍 Módulo: Analizar Skills Instaladas y Sugerir Mejoras

## Misión

Inspeccionar las skills instaladas del usuario, comparar con la documentación oficial de Claude Code y mostrar un informe con sugerencias de mejora.

**Documentación oficial** (WebFetch on-demand si no está en contexto):
```
https://code.claude.com/docs/en/skills
```

---

## Paso 0 — Fetch on-demand de doc oficial

Antes de analizar, verificar si la documentación oficial de skills ya está cargada en el contexto de la conversación.

- **Si está disponible**: usar directamente
- **Si no está disponible**: hacer WebFetch a `https://code.claude.com/docs/en/skills`

Extraer y retener:
- Estructura oficial de skills (`<name>/SKILL.md`)
- Campos válidos de frontmatter: `name`, `description`, `argument-hint`, `disable-model-invocation`, `user-invocable`, `allowed-tools`, `model`, `context`, `agent`, `hooks`
- Rutas oficiales de instalación

---

## Paso 1 — Descubrir skills instaladas

Buscar en todas las rutas oficiales:

```bash
# Personal — nueva estructura (directorio)
ls ~/.claude/skills/*/SKILL.md 2>/dev/null

# Personal — estructura legacy (archivo plano)
ls ~/.claude/skills/*.md 2>/dev/null | grep -v "SKILL.md"

# Proyecto — nueva estructura
ls ./.claude/skills/*/SKILL.md 2>/dev/null

# Proyecto — estructura legacy
ls ./.claude/skills/*.md 2>/dev/null | grep -v "SKILL.md"

# Legacy commands (aún válidos según doc oficial)
ls ~/.claude/commands/*.md 2>/dev/null
ls ./.claude/commands/*.md 2>/dev/null
```

Para cada skill encontrada, leer su contenido para extraer el frontmatter.

---

## Paso 2 — Analizar cada skill

Para cada skill, verificar:

### ✅ Estructura
- **Nueva** (`<name>/SKILL.md` en directorio) → ✅ Correcto
- **Legacy** (`<name>.md` archivo plano) → ⚠️ Funciona, pero considera migrar al formato de directorio

### ✅ Frontmatter
- ¿Tiene `description`? → Sin description, Claude no sabe cuándo usarla automáticamente → ❌ Crítico
- ¿El `description` es descriptivo (>15 caracteres)? → ⚠️ Mejorable si es muy corto
- ¿Tiene `name`? → Opcional, pero recomendable para claridad
- ¿Tiene campos obsoletos? (`paths:` ya no existe en la doc oficial) → ❌ Obsoleto

### ✅ Configuración de invocación
- ¿Tiene `disable-model-invocation: true`? → Solo puede invocarla el usuario
- ¿Tiene `user-invocable: false`? → Solo puede invocarla Claude
- Sin ambos → Claude y usuario pueden invocarla (comportamiento por defecto)
- Verificar que la configuración tiene sentido según el tipo de skill

---

## Paso 3 — Generar informe

```
══════════════════════════════════════════════════════════════
⚒️  CELEBRIMBOR — Análisis de Skills
══════════════════════════════════════════════════════════════

🌍 PERSONAL (~/.claude/skills/)
──────────────────────────────────────────────────────────────
  ✅ playwright-pom/SKILL.md    — estructura correcta, description OK
  ⚠️  git-workflow.md           — archivo plano (legacy), considera migrar
  ❌  php-pro/SKILL.md          — sin description en frontmatter

📂 PROYECTO (./.claude/skills/)
──────────────────────────────────────────────────────────────
  ⚠️  typescript-utils.md       — tiene paths: obsoleto, archivo plano

📁 LEGACY COMMANDS
──────────────────────────────────────────────────────────────
  ℹ️  deploy.md                 — legacy command, funciona igual que skill

══════════════════════════════════════════════════════════════
📊 Resumen: 5 skills · 1 ✅ correcta · 2 ⚠️ mejorables · 1 ❌ crítica
══════════════════════════════════════════════════════════════
```

---

## Paso 4 — Sugerencias accionables

Para cada issue encontrado, mostrar la sugerencia específica:

### ❌ Sin description
```
skill: php-pro/SKILL.md
Problema: Sin campo description en el frontmatter
Impacto: Claude no sabe cuándo activar esta skill automáticamente

Sugerencia: Añadir al frontmatter:
  description: "Aplica cuando trabajas con PHP 8.3+, Laravel o Symfony.
                Usa cuando el código importe namespace Symfony o Laravel."
```

### ⚠️ Archivo plano (legacy)
```
skill: git-workflow.md
Problema: Archivo plano — formato antiguo
Impacto: Funciona, pero no puede tener archivos de soporte ni scripts

Sugerencia: Migrar a directorio:
  mkdir ~/.claude/skills/git-workflow
  mv ~/.claude/skills/git-workflow.md ~/.claude/skills/git-workflow/SKILL.md
```

### ⚠️ Campo paths: obsoleto
```
skill: typescript-utils.md
Problema: Tiene paths: en el frontmatter — campo obsoleto
Impacto: El campo es ignorado por Claude Code

Sugerencia: Eliminar el bloque paths: del frontmatter
```

---

## Paso 5 — Opciones al usuario

Mostrar con `AskUserQuestion`:

```
¿Qué deseas hacer?

1. 🔧 Aplicar sugerencias una a una
2. 📋 Ver detalles completos de una skill
3. 🔙 Volver al menú principal
```

### Si elige "Aplicar sugerencias una a una"

Para cada issue (ordenados: ❌ primero, ⚠️ después):

```
Ítem X/N — [nombre de la skill]
Problema: [descripción del problema]
Acción propuesta: [qué se va a hacer]

¿Aplicar?
  ✅ Aplicar
  ⏭️ Saltar
  🚫 Cancelar todo
```

Ejecutar la acción y confirmar resultado antes de pasar al siguiente.

Al finalizar, mostrar resumen:
```
Análisis completado:
  ✅ Aplicadas: X
  ⏭️ Saltadas: Y
  Total revisadas: Z
```

---

## Casos especiales

### Sin skills instaladas
```
No se encontraron skills instaladas en las rutas oficiales.

Rutas verificadas:
  • ~/.claude/skills/
  • ./.claude/skills/
  • ~/.claude/commands/
  • ./.claude/commands/

💡 Usa "Buscar e instalar skills" para añadir skills desde skills.sh
   o "Crear una skill" para crear la tuya propia.
```

### Todas las skills están correctas
```
⚒️ Los Gwaith-i-Mírdain inspeccionan el arsenal...

✅ Todas las skills están correctas y bien configuradas.
   Eregion aprueba tu colección, viajero.

Total: X skills · 0 issues encontrados
```

---

**Módulo**: `07-module-analyze.md`
**Invocado desde**: `02-menu-principal.md` (Opción 1)
**Requiere**: WebFetch on-demand, Read, Edit (para aplicar sugerencias)
