# ✨ Módulo: Crear un Agente Asistido

## Misión

Guiar al usuario paso a paso para crear un agente o subagente personalizado según
la documentación oficial de Claude Code. Todo el contenido técnico se obtiene vía
WebFetch on-the-fly, nunca hardcodeado.

---

## Paso 0 — Documentación oficial (on-the-fly)

**IMPORTANTE**: Comprobar primero si la documentación ya está cargada en el contexto.

**Si ya está en contexto**: usar directamente sin re-fetchear.

**Si no está en contexto**, hacer WebFetch:

> **WebFetch**: `https://code.claude.com/docs/en/sub-agents`
> **Extraer**: campos válidos del frontmatter YAML (name, description, tools, model,
> permissionMode, maxTurns, disallowedTools, skills, mcpServers, hooks, memory, background),
> scopes, mejores prácticas de description para invocación automática, ejemplos.

**Fallback si WebFetch falla**: Mostrar solo las URLs y no continuar:

```
⚠️ No se pudo cargar la documentación oficial.
   La creación asistida requiere las docs oficiales de Claude Code.

   Puedes consultarlas directamente:
     📖 Sub-agents: https://code.claude.com/docs/en/sub-agents
```

Ofrecer AskUserQuestion: reintentar WebFetch / volver al menú.

---

## Paso 1 — Nombre

Preguntar con AskUserQuestion:

```json
{
  "questions": [{
    "header": "Crear agente — Paso 1/5",
    "question": "✨ ¿Cómo se llamará el nuevo agente?\n(ej: symfony-expert, playwright-agent, code-reviewer-php)",
    "multiSelect": false,
    "options": [
      {
        "label": "✍️  Escribir el nombre ahora",
        "description": "Solo letras minúsculas, números y guiones"
      },
      {
        "label": "🔙 Volver al menú de Aragorn",
        "description": ""
      }
    ]
  }]
}
```

Tras recibir el nombre del usuario:

- Validar formato: solo letras minúsculas, números y guiones (`/^[a-z0-9-]+$/`)
- Comprobar si ya existe:

```bash
ls ~/.claude/agents/[nombre].md 2>/dev/null
ls .claude/agents/[nombre].md 2>/dev/null
```

Si existe, avisar y preguntar (AskUserQuestion):
- ✏️ Sobreescribir — crear nueva versión
- 🔙 Usar otro nombre

⚡ *"Aragorn siempre forja sus agentes en la Ciudadela de Minas Tirith."*

Los agentes se crean en `~/.claude/agents/` (scope global).
Motivo: los agentes de proyecto (`.claude/agents/`) no pueden usarse como miembros
de Agent Teams — quedarían encerrados en un único repositorio.

📂 **Destino**: `~/.claude/agents/{nombre}.md`

> Si el usuario menciona explícitamente "scope proyecto": explicar el motivo anterior
> y continuar con scope global sin preguntar de nuevo.

---

## Paso 2 — Descripción (campo más crítico)

**CRÍTICO**: La `description` es el campo más importante de un agente. Claude la lee
para decidir cuándo invocarlo automáticamente. Debe incluir:
- Para qué sirve el agente
- Cuándo Claude debe invocarlo (triggers)
- Ejemplos de tareas que delegar

Mostrar antes de preguntar:

```
✨ CREAR AGENTE — Paso 2/5: Descripción
══════════════════════════════════════════════════════════════

⚠️  La descripción es el campo MÁS CRÍTICO del agente.
    Claude la lee para decidir cuándo invocarlo automáticamente.

    Una buena descripción incluye:
    • Para qué sirve (rol del agente)
    • Cuándo debe ser invocado (triggers)
    • Ejemplos de tareas concretas

    ❌ Mala:  "Experto en Symfony"
    ✅ Buena: "Experto en Symfony y PHP para este proyecto.
               Invócame para: analizar services y repositorios,
               optimizar queries Doctrine, revisar configuración
               de bundles, o cuando el contexto sea PHP/Symfony.
               Ejemplo: 'Analiza UserRepository y sugiere mejoras'"

══════════════════════════════════════════════════════════════
```

Pedir descripción al usuario. Si proporciona una descripción corta (< 50 chars),
sugerir expandirla con AskUserQuestion:
- ✅ Usar mi descripción tal cual
- 💡 Ver sugerencia de Aragorn para mejorarla

Si elige ver sugerencia, proponer una versión expandida basada en el nombre y stack detectado.

---

## Paso 3 — Tools permitidas

Mostrar lista de tools disponibles según docs oficiales:

```
✨ CREAR AGENTE — Paso 3/5: Herramientas
══════════════════════════════════════════════════════════════

Tools disponibles para el agente:
  Read, Write, Edit, Bash, Glob, Grep, WebFetch, Agent,
  TodoWrite, TodoRead, NotebookEdit, Task (y otras)

Sin `tools` definidas: Claude asignará todas — ⚠️ riesgo de seguridad.
```

Preguntar con AskUserQuestion:

```json
{
  "questions": [{
    "header": "Crear agente — Paso 3/5",
    "question": "🔧 ¿Qué herramientas necesita el agente?",
    "multiSelect": false,
    "options": [
      {
        "label": "📖 Solo lectura (Read, Glob, Grep)",
        "description": "Ideal para agentes de análisis y revisión"
      },
      {
        "label": "✏️  Lectura + escritura (Read, Write, Edit, Glob, Grep)",
        "description": "Para agentes que modifican ficheros"
      },
      {
        "label": "⚡ Completo (Read, Write, Edit, Bash, Glob, Grep)",
        "description": "Para agentes con acceso total al entorno"
      },
      {
        "label": "✍️  Personalizar herramientas manualmente",
        "description": "Indicar exactamente qué tools incluir"
      }
    ]
  }]
}
```

---

## Paso 4 — Modelo y permisos

Preguntar con AskUserQuestion:

```json
{
  "questions": [{
    "header": "Crear agente — Paso 4/5",
    "question": "🤖 ¿Qué modelo y modo de permisos?",
    "multiSelect": false,
    "options": [
      {
        "label": "🎯 Por defecto (hereda del usuario)",
        "description": "Sin especificar model ni permissionMode"
      },
      {
        "label": "⚡ Sonnet (rápido y eficiente)",
        "description": "model: claude-sonnet-4-6 · permissionMode: default"
      },
      {
        "label": "🧠 Opus (máximo razonamiento)",
        "description": "model: claude-opus-4-6 · permissionMode: default"
      },
      {
        "label": "✅ Auto-aceptar edits",
        "description": "model: claude-sonnet-4-6 · permissionMode: acceptEdits"
      }
    ]
  }]
}
```

También preguntar `maxTurns` opcionalmen:

```json
{
  "questions": [{
    "header": "Crear agente — Límite de turnos",
    "question": "🔄 ¿Límite de turnos? (sin límite = más autónomo pero puede ser costoso)",
    "multiSelect": false,
    "options": [
      {
        "label": "∞ Sin límite (recomendado para tareas complejas)",
        "description": ""
      },
      {
        "label": "10 turnos (tareas acotadas)",
        "description": ""
      },
      {
        "label": "20 turnos (tareas medianas)",
        "description": ""
      },
      {
        "label": "✍️  Otro número",
        "description": ""
      }
    ]
  }]
}
```

---

## Paso 5 — Instrucciones del agente (cuerpo del fichero)

Tras el frontmatter, el fichero `.md` puede tener instrucciones adicionales en Markdown.

Mostrar:

```
✨ CREAR AGENTE — Paso 5/5: Instrucciones
══════════════════════════════════════════════════════════════

El cuerpo del fichero (tras el frontmatter) define el comportamiento
del agente: su rol, prioridades, formato de respuesta, restricciones...

Ejemplo para symfony-expert:
  "Eres un experto senior en Symfony 7 y PHP 8.3.
   Al analizar código, prioriza:
   1. Principios SOLID y arquitectura hexagonal
   2. Tipado estricto (PHPStan level 9)
   3. Buenas prácticas de Doctrine ORM"
══════════════════════════════════════════════════════════════
```

Preguntar con AskUserQuestion:

```json
{
  "questions": [{
    "header": "Instrucciones del agente",
    "question": "📝 ¿Quieres añadir instrucciones personalizadas?",
    "multiSelect": false,
    "options": [
      {
        "label": "✍️  Sí, añadir instrucciones",
        "description": "Definir rol, prioridades y comportamiento del agente"
      },
      {
        "label": "💡 Generar instrucciones automáticas",
        "description": "Aragorn generará instrucciones basadas en nombre y stack"
      },
      {
        "label": "⏭️  Sin instrucciones (solo frontmatter)",
        "description": ""
      }
    ]
  }]
}
```

Si elige generar automáticas: proponer instrucciones basadas en el nombre del agente y stack detectado.

---

## Paso 6 — Preview y confirmación

Mostrar preview completo del fichero a crear:

```
📄 PREVIEW DEL AGENTE
══════════════════════════════════════════════════════════════

Destino: ~/.claude/agents/symfony-expert.md

--- Contenido ---
---
name: symfony-expert
description: |
  Experto en Symfony y PHP para este proyecto.
  Invócame para: analizar services y repositorios,
  optimizar queries Doctrine, revisar configuración de bundles.
  Ejemplo: "Analiza UserRepository y sugiere mejoras"
tools:
  - Read
  - Write
  - Bash
  - Grep
  - Glob
model: claude-sonnet-4-6
permissionMode: acceptEdits
---

Eres un experto senior en Symfony 7 y PHP 8.3.
Al analizar código, prioriza:
1. Principios SOLID y arquitectura hexagonal
2. Tipado estricto (PHPStan level 9)
3. Buenas prácticas de Doctrine ORM
══════════════════════════════════════════════════════════════
```

AskUserQuestion:

```json
{
  "questions": [{
    "header": "Confirmar creación",
    "question": "✨ ¿Crear el agente con esta configuración?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Crear agente",
        "description": ""
      },
      {
        "label": "✏️  Modificar algo antes de crear",
        "description": "Volver a cualquier paso para ajustar"
      },
      {
        "label": "🚫 Cancelar",
        "description": ""
      }
    ]
  }]
}
```

---

## Paso 7 — Crear el agente

Crear el directorio si no existe:

```bash
mkdir -p ~/.claude/agents/
```

Escribir el fichero `.md` usando Write.

---

## Paso 8 — Confirmar y opciones

```
══════════════════════════════════════════════════════════════
✅ AGENTE CREADO CORRECTAMENTE
══════════════════════════════════════════════════════════════

  Nombre:   [nombre]
  Scope:    🌍 Global (~/.claude/agents/)
  Fichero:  [ruta completa]

  💡 Cómo usarlo:
     • Automático: Claude lo invocará cuando detecte tareas compatibles
     • Explícito: "@[nombre] [tu tarea]"

══════════════════════════════════════════════════════════════
👑 "Un guerrero forjado por tus propias manos.
    El ejército de Gondor crece, señor."
```

AskUserQuestion:

```json
{
  "questions": [{
    "header": "Agente creado",
    "question": "👑 ¿Qué deseas hacer ahora?",
    "multiSelect": false,
    "options": [
      {
        "label": "✨ Crear otro agente",
        "description": ""
      },
      {
        "label": "🔍 Inspeccionar el arsenal actualizado",
        "description": ""
      },
      {
        "label": "🔙 Volver al menú de Aragorn",
        "description": ""
      }
    ]
  }]
}
```

---

## 🔗 Fuentes

Ver índice completo en `@prompts/docs-sources.md`:
- Sub-agents: `https://code.claude.com/docs/en/sub-agents`

---

**Módulo**: `02-module-create.md`
**Invocado desde**: `aragorn-main.md` (opción "Crear un agente asistido")
**Requiere**: WebFetch on-demand, Read, Bash, Write
