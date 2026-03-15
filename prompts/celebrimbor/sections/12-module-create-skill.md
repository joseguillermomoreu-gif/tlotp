# ✨ Módulo: Crear Skill Asistida

## Misión

Guiar al usuario paso a paso para crear una skill correctamente según la documentación oficial de Claude Code. La doc se obtiene via fetch on-demand, nunca hardcodeada.

---

## Paso 0 — Fetch on-demand de doc oficial

Verificar si la documentación oficial ya está disponible en el contexto de la conversación.

- **Si está disponible**: usar directamente
- **Si no está disponible**: hacer WebFetch

```
WebFetch → https://code.claude.com/docs/en/skills
```

Extraer y retener para este módulo:
- Estructura oficial: `<name>/SKILL.md` en directorio
- Campos válidos de frontmatter: `name`, `description`, `argument-hint`, `disable-model-invocation`, `user-invocable`, `allowed-tools`, `model`, `context`, `agent`, `hooks`
- Tipos de skill: referencia vs tarea
- Sustituciones: `$ARGUMENTS`, `$ARGUMENTS[N]`, `$N`, `${CLAUDE_SKILL_DIR}`, `${CLAUDE_SESSION_ID}`

---

## Paso 1 — Nombre y scope

```
✨ Crear una nueva skill

¿Cómo se llamará tu skill?
  • Solo letras minúsculas, números y guiones
  • Máximo 64 caracteres
  • Ejemplos: php-pro, commit-helper, deploy-staging

Nombre: _
```

Validar formato: `/^[a-z0-9-]{1,64}$/`

Si el nombre ya existe, advertir:
```
⚠️ Ya existe una skill con ese nombre en: ~/.claude/skills/<name>/
   ¿Sobreescribir? [s/N]
```

```
¿Dónde instalarla?

1. 🌍 Global (~/.claude/skills/<name>/SKILL.md)
   • Disponible en TODOS tus proyectos

2. 📂 Local (./.claude/skills/<name>/SKILL.md)
   • Solo para ESTE proyecto
```

---

## Paso 2 — Tipo de skill

```
¿Qué tipo de skill es?

1. 📚 Referencia — Conocimiento que Claude aplica automáticamente
   Ejemplos: convenciones de código, patrones de arquitectura,
             guías de estilo, contexto de dominio

2. ⚡ Tarea — Flujo de pasos concretos que el usuario invoca
   Ejemplos: /deploy, /commit, /send-report, /run-tests

3. 🤔 No estoy seguro — Cuéntame qué quieres hacer y te ayudo
```

Si elige **3**: preguntar qué quiere hacer y recomendar el tipo apropiado.

---

## Paso 3 — Descripción (frontmatter)

La `description` es el campo más importante: Claude la usa para decidir cuándo activar la skill automáticamente.

```
✍️  Descripción de la skill

La description es clave: Claude la lee para saber cuándo usar tu skill.
Una buena description es específica y menciona cuándo activarse.

❌ Mala:   "Ayuda con PHP"
✅ Buena:  "Aplica cuando trabajas con PHP 8.3+, Symfony o Laravel.
            Usa cuando el código importe namespace Symfony\\ o veas
            archivos .php, composer.json o config/services.yaml"

Escribe la description de tu skill:
_
```

---

## Paso 4 — Configuración de invocación

Según el tipo elegido en Paso 2:

### Si es skill de Tarea:
```
⚙️  ¿Cómo debe invocarse esta skill?

Esta skill es de tipo Tarea (flujo con pasos concretos).

Recomendación: desactivar la invocación automática de Claude
para que solo tú la actives con /nombre.

¿Añadir disable-model-invocation: true? (Recomendado para tareas)

1. ✅ Sí — Solo yo la invocaré con /<nombre>
2. ❌ No — Claude también puede invocarla automáticamente
```

### Si es skill de Referencia:
```
⚙️  ¿Debe aparecer en el menú / de Claude?

Esta skill es de tipo Referencia (conocimiento contextual).

Opciones:
1. ✅ Visible en menú (por defecto) — Usuario y Claude pueden invocarla
2. 👻 Oculta del menú (user-invocable: false) — Solo Claude la activa
   Útil para: contexto de sistema legacy, reglas internas, guías de fondo
```

---

## Paso 5 — Herramientas permitidas (opcional)

```
🔧 ¿Quieres restringir las herramientas disponibles para esta skill?

Ejemplos:
  • Solo lectura:   allowed-tools: Read, Grep, Glob
  • Solo bash git:  allowed-tools: Bash(git *)
  • Sin restricción (por defecto): dejar vacío

allowed-tools: [Enter para omitir] _
```

---

## Paso 6 — Contenido de la skill

Generar plantilla base según el tipo:

### Plantilla — Referencia
```markdown
---
name: <nombre>
description: <description>
{user-invocable: false  ← si se eligió oculta}
---

## Contexto

[Describe el conocimiento, convenciones o patrones que debe aplicar Claude]

## Cuándo aplicar

[Situaciones específicas donde este conocimiento es relevante]

## Reglas principales

1. [Regla 1]
2. [Regla 2]
3. [Regla 3]
```

### Plantilla — Tarea
```markdown
---
name: <nombre>
description: <description>
disable-model-invocation: true
{allowed-tools: <tools>  ← si se configuraron}
---

## Pasos

1. [Paso 1]
2. [Paso 2]
3. [Paso 3]

## Argumentos

$ARGUMENTS
```

Mostrar la plantilla al usuario y preguntar:
```
📝 Aquí tienes la plantilla base para tu skill:

[plantilla generada]

¿Qué deseas hacer?
1. ✅ Usar esta plantilla (puedo editarla después)
2. ✏️  Quiero modificar el contenido ahora
```

Si elige modificar: usar AskUserQuestion para recoger el contenido personalizado.

---

## Paso 7 — Crear la estructura

```bash
# Crear directorio
mkdir -p <scope>/.claude/skills/<nombre>

# Escribir SKILL.md
# (Write con el contenido generado)
```

Mostrar progreso:
```
✨ Forjando la skill en Eregion...

  ✓ Creando directorio <scope>/.claude/skills/<nombre>/
  ✓ Escribiendo SKILL.md
```

---

## Paso 8 — Verificar y mostrar resultado

```bash
cat <scope>/.claude/skills/<nombre>/SKILL.md
```

```
══════════════════════════════════════════════════════════════
✅ Skill creada correctamente
══════════════════════════════════════════════════════════════

  Nombre:    <nombre>
  Ubicación: <scope>/.claude/skills/<nombre>/SKILL.md
  Tipo:      Referencia / Tarea
  Invocación: /nombre (manual) / automática por Claude

══════════════════════════════════════════════════════════════
```

---

## 🔥 Lore épico al finalizar

```
⚒️  El fuego de Eregion ha forjado algo nuevo.

    Un Anillo de Poder nace hoy en la Tierra Media.
    "<nombre>" ha sido inscrita en los libros de los
    Gwaith-i-Mírdain para la eternidad, viajero.

    Los herreros se inclinan ante tu obra.
```

---

## Paso 9 — Acciones posteriores

```
¿Qué deseas hacer ahora?

1. ✨ Crear otra skill
2. 🔍 Analizar mis skills instaladas
3. 🔙 Volver al menú principal
```

---

## Casos especiales

### Sin permisos para crear directorio
```
❌ Sin permisos para escribir en <ruta>
   Solución: chown -R $USER ~/.claude/
   O bien: instala en local (./.claude/skills/)
```

### Nombre inválido
```
❌ Nombre inválido: "<input>"
   Solo letras minúsculas, números y guiones. Máximo 64 caracteres.
   Ejemplo válido: mi-skill-personalizada
```

---

**Módulo**: `12-module-create-skill.md`
**Invocado desde**: `02-menu-principal.md` (Opción 4)
**Requiere**: WebFetch on-demand, Bash, Write
**Doc oficial**: `https://code.claude.com/docs/en/skills`
