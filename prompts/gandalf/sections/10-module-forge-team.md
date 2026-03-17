# ⚔️ Módulo G10 — Forja el Ejército para la Misión

## Misión

El SDD está completo. La misión ha sido definida por el Consejo de Rivendel.
Ahora Gandalf convoca a Aragorn para forjar el ejército que ejecutará el plan.
El equipo se propone automáticamente según el SDD + agentes instalados.

---

## Introducción épica

```
╔══════════════════════════════════════════════════════════════╗
║   ⚔️  EL CONSEJO HA HABLADO — El ejército debe partir       ║
╚══════════════════════════════════════════════════════════════╝

  ⚡ Gandalf golpea su bastón en el suelo de Rivendel:

     "El mapa está trazado. Los requisitos, escritos.
      La arquitectura, sellada. Las tareas, ordenadas.

      Ahora necesitamos a los guerreros que ejecuten el plan.
      Aragorn — convoca a tu ejército."

  👑 Aragorn entra en la sala del Consejo:
     "La misión es clara. Sé qué guerreros necesitamos."

══════════════════════════════════════════════════════════════
```

---

## Paso 1 — Leer el SDD y los agentes instalados

Ejecutar en paralelo:

```bash
# Leer agentes instalados
echo "=== GLOBAL ==="
ls ~/.claude/agents/ 2>/dev/null || echo "(vacío)"
echo "=== PROYECTO ==="
ls .claude/agents/ 2>/dev/null || echo "(vacío)"
```

Y leer los ficheros SDD generados (requirements.md, design.md, tasks.md).

---

## Paso 2 — Análisis del SDD para propuesta de team

Analizar el SDD para detectar qué tipos de agentes son más relevantes:

| Señal en el SDD | Agente relevante (si existe) | Rol en el team |
|-----------------|------------------------------|----------------|
| Requisitos de calidad / code review | code-reviewer, quality-* | Revisor de implementación |
| Stack PHP/Symfony en Éowyn | php-pro, symfony-*, backend-* | Experto backend |
| Tests / acceptance criteria E2E | playwright-*, testing-*, qa-* | Guardián de los tests |
| Arquitectura / ADRs | architect-*, design-*, hexagonal-* | Revisor de arquitectura |
| CI/CD en Pippin | devops-*, deploy-*, docker-* | Guardián del deploy |
| Seguridad en el SDD | security-*, audit-*, galadriel-* | Auditor de seguridad |
| Frontend en Théoden | typescript-*, react-*, frontend-* | Experto frontend |

**Nombre del team**: Derivar del objetivo del SDD:
- Basado en el nombre de la aventura descrita en G3
- Formato: `[aventura-en-kebab-case]-team`
- Ejemplos: `auth-module-team`, `api-migration-team`, `payment-refactor-team`

---

## Paso 3 — Propuesta del ejército

Mostrar la propuesta con lore:

```
╔══════════════════════════════════════════════════════════════╗
║   ⚔️  ARAGORN — Propuesta del Ejército para la Misión       ║
╚══════════════════════════════════════════════════════════════╝

  📜 Misión: [objetivo del SDD en 1 línea]

  Aragorn ha revisado el SDD y el arsenal disponible:

  ⚔️  Team propuesto: [nombre-del-team]

  Guerreros convocados:
  [emoji] [Personaje] ([nombre-agente]) — "[frase épica]"
  [emoji] [Personaje] ([nombre-agente]) — "[frase épica]"
  [emoji] [Personaje] ([nombre-agente]) — "[frase épica]"

  📍 Fichero:  .claude/teams/[nombre-del-team].yml
  📝 Misión:   [descripción del propósito del team]

  "¡La Batalla del Pelennor Fields comienza!
   El ejército está formado para esta aventura."

══════════════════════════════════════════════════════════════
```

Usar el sistema de personajes de `aragorn-main.md` para asignar personaje por rol.

---

## Paso 4 — AskUserQuestion

```json
{
  "questions": [{
    "header": "El Ejército para la Misión",
    "question": "⚔️  ¿Confirmamos este ejército para la aventura?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Sí — forjar el team y crear el fichero de configuración",
        "description": "Crear .claude/teams/[nombre].yml"
      },
      {
        "label": "✏️  Ajustar — cambiar agentes o nombre del team",
        "description": "Modificar la propuesta antes de crear"
      },
      {
        "label": "🏪 No tengo agentes — ir a instalarlos primero",
        "description": "Aragorn te ayudará a reclutar guerreros"
      },
      {
        "label": "🔙 Volver al Consejo de Rivendel",
        "description": ""
      }
    ]
  }]
}
```

---

## Paso 5 — Creación del fichero de team

Si confirma, leer la estructura oficial de Agent Teams:

**IMPORTANTE**: La estructura del fichero debe extraerse de las docs oficiales.
Si ya están en contexto del módulo 03-module-team-builder.md de Aragorn, usar directamente.
Si no: hacer WebFetch `https://code.claude.com/docs/en/agent-teams`.

Crear el directorio si no existe:
```bash
mkdir -p .claude/teams/
```

Escribir `.claude/teams/[nombre].yml` con la estructura oficial + comentario de la misión SDD.

---

## Paso 6 — Confirmación épica final

```
╔══════════════════════════════════════════════════════════════╗
║   ⚔️  EL EJÉRCITO HA SIDO FORMADO                           ║
╚══════════════════════════════════════════════════════════════╝

  ⚡ Gandalf cierra el Consejo con estas palabras:

     "El SDD es el mapa. El ejército es la fuerza.
      La aventura puede comenzar cuando estés listo.
      El código llegará, como la marea del Destino."

  👑 Aragorn: "¡Por la Tierra Media! ¡El ejército marcha!"

  ══════════════════════════════════════════════════════════════

  📄 SDD generado:
    📋 [ruta]/requirements.md  ✅
    🏗️  [ruta]/design.md       ✅
    📝 [ruta]/tasks.md         ✅

  ⚔️  Team configurado:
    📍 .claude/teams/[nombre].yml  ✅
    🤖 Agentes: [lista]

  🚀 Cómo usar el team:
    "@[nombre-team] implementa la tarea T01"
    "@[nombre-team] revisa el código según el design.md"

══════════════════════════════════════════════════════════════
```

---

## Si no hay agentes instalados

```
⚠️  "El ejército necesita guerreros.
    Ningún hobbit embarcó en una aventura sin compañeros."

  Para convocar agentes, Aragorn puede ayudarte:
```

AskUserQuestion:
- 🏪 Ir a Aragorn — buscar e instalar agentes desde marketplaces
- ✨ Ir a Aragorn — crear un agente asistido
- ⏭️ Continuar sin team (usaré el SDD directamente con Claude)
- 🔙 Volver al Consejo

Si elige ir a Aragorn:
→ Cargar `@prompts/aragorn/aragorn-main.md`

---

## AskUserQuestion final

```json
{
  "questions": [{
    "header": "La aventura comienza",
    "question": "⚡ ¿Qué quieres hacer ahora?",
    "multiSelect": false,
    "options": [
      {
        "label": "📝 Ver el tasks.md — la primera tarea me espera",
        "description": "Empezar la implementación"
      },
      {
        "label": "⚔️  Ir a Aragorn — gestionar el ejército",
        "description": "Ver, editar o crear más teams"
      },
      {
        "label": "✨ Iniciar otra aventura SDD",
        "description": "Volver al inicio de Gandalf"
      },
      {
        "label": "🔙 Volver a La Comunidad del Código",
        "description": "Menú principal de TLOTP"
      }
    ]
  }]
}
```

---

**Módulo**: `10-module-forge-team.md`
**Invocado desde**: `08-module-council.md`
**Requiere**: Write, Bash, contexto SDD completo, WebFetch (condicional para Agent Teams docs)
**Routing a**: `aragorn-main.md` (si necesita instalar agentes o gestionar teams)
