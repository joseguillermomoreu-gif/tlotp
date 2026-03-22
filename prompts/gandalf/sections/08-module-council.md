# ⚡ Módulo G8 — El Consejo de Rivendel

## Misión

El módulo más épico de Gandalf. Los miembros del Consejo se convocan
condicionalmente según lo que los Rohirrim detectaron en el proyecto.
La Comunidad del Código al completo, reunida para bendecir la aventura.

---

## Tabla de convocatoria condicional

Cada miembro se convoca **SOLO si la condición se cumple** en `contexto_rohirrim`:

| Condición detectada | Miembro | Frase icónica | Detalle mostrado |
|--------------------|---------|---------------|-----------------|
| Backend (PHP/Python/Go/Java/Ruby) | 🪓 **Gimli** | "¡Cuenta con mi hacha!" | Stack backend detectado |
| Frontend (TS/React/Vue/Svelte/CSS) | 🏹 **Legolas** | "¡Y con mi arco!" | Stack frontend detectado |
| Tests detectados (cualquier tipo) | 🥔 **Sam** | "¡El señor Frodo no irá solo!" | Frameworks de test |
| Agentes Claude Code instalados | 👑 **Aragorn** | "¡Con Andúril, reforjada!" | Nº de agentes instalados |
| MCPs instalados | 🏹 **Bardo** | "¡Mis flechas conocen cada API!" | MCPs activos |
| CI/CD detectado | 🌳 **Los Ents** | "¡Los Ents marchan a la guerra!" | Workflows detectados |
| Base de datos / ORM | 🛡️ **Boromir** | "¡Gondor os apoyará con queries optimizadas!" | DB + ORM detectados |
| Auth / seguridad detectada | 🧝‍♀️ **Galadriel** | "En las sombras del código, veo la amenaza." | Sistema de auth |
| SDD completo (3 ficheros ✅) | ⚡ **Gandalf el Blanco** | "Así comienza... cada gran historia." | Ficheros generados |
| SDD incompleto | ⚡ **Gandalf (gris)** | "El mapa aún tiene zonas en blanco." | Qué falta completar |

---

## Formato del Consejo

```
╔══════════════════════════════════════════════════════════════╗
║   ⚡ EL CONSEJO DE RIVENDEL — La Comunidad del Código       ║
╚══════════════════════════════════════════════════════════════╝

  Los miembros del Consejo toman su asiento en Rivendel:

  🪓 Gimli:      "¡Cuenta con mi hacha!"
                  PHP 8.3 + Symfony 7.1 + PHPStan level 9

  🏹 Legolas:    "¡Y con mi arco!"
                  TypeScript + React + Playwright

  🥔 Sam:        "¡El señor Frodo no irá solo!"
                  PHPUnit · Behat · Playwright E2E · 80% cobertura

  👑 Aragorn:    "¡Con Andúril, reforjada!"
                  3 agentes Claude Code listos para la batalla

  🌳 Los Ents:   "¡Los Ents marchan a la guerra!"
                  GitHub Actions x4 workflows · Docker ✅

  🛡️ Boromir:    "¡Gondor os apoyará!"
                  PostgreSQL + Doctrine ORM

  🧝‍♀️ Galadriel:  "En las sombras del código, veo la amenaza."
                  JWT + OAuth2 · OWASP checklist en el SDD

  ⚡ Gandalf:    "Así comienza... cada gran historia."
                  requirements.md ✅ · design.md ✅ · tasks.md ✅

══════════════════════════════════════════════════════════════

📊 RESUMEN DEL SDD — La misión está definida:

  📋 Requirements: [N] requisitos ([MUST: x · SHOULD: y · COULD: z])
  🏗️  Design:      [N] componentes · [M] ADRs · diagrama Mermaid ✅
  📝 Tasks:       [N] tareas ([S: x · M: x · L: x · XL: x])

══════════════════════════════════════════════════════════════
🗺️  La Comunidad del Código está lista.
    El viaje puede comenzar. No hay marcha atrás.
══════════════════════════════════════════════════════════════
```

**Si el SDD está incompleto** (Gandalf el Gris):
```
  ⚡ Gandalf (gris): "El mapa aún tiene zonas en blanco."
                     Faltan: [lista de ficheros pendientes]
                     → Completa el SDD antes de partir.
```

---

## AskUserQuestion final

```json
{
  "questions": [{
    "header": "El Consejo de Rivendel",
    "question": "⚡ El Consejo ha deliberado. ¿Cuál es tu siguiente paso?",
    "multiSelect": false,
    "options": [
      {
        "label": "🚀 Crear tarea de ejecución del SDD",
        "description": "Generar prompt listo para invocar al orquestador del team"
      },
      {
        "label": "⚔️  Convocar al ejército para esta misión",
        "description": "Aragorn crea un Agent Team basado en el SDD"
      },
      {
        "label": "📝 Ver tasks.md — iniciar la implementación",
        "description": "El mapa está listo, el código puede comenzar"
      },
      {
        "label": "✏️  Mejorar algún fichero del SDD",
        "description": "Volver a requirements / design / tasks"
      },
      {
        "label": "🔙 Volver al menú de Gandalf",
        "description": ""
      }
    ]
  }]
}
```

---

## Routing

- **🚀 Crear tarea de ejecución** → Ejecutar sección "Generar prompt de ejecución" (ver abajo)
- **⚔️ Convocar al ejército** → Cargar `@prompts/gandalf/sections/10-module-forge-team.md`
- **📝 Ver tasks.md** → Leer el fichero y mostrarlo. AskUserQuestion para continuar.
- **✏️ Mejorar** → Preguntar cuál fichero:
  - requirements.md → `@prompts/gandalf/sections/05-module-requirements.md`
  - design.md → `@prompts/gandalf/sections/06-module-design.md`
  - tasks.md → `@prompts/gandalf/sections/07-module-tasks.md`
- **🔙 Volver** → Menú de Gandalf

---

## Generar prompt de ejecución del SDD

### Paso GE1 — Leer rutas de los ficheros SDD

Identificar las rutas reales de los 3 ficheros generados:
- `requirements.md` → ruta real donde fue guardado
- `design.md` → ruta real donde fue guardado
- `tasks.md` → ruta real donde fue guardado

Leer `tasks.md` para extraer la lista de tareas (título, agente sugerido, dependencias).

### Paso GE2 — Generar prompt base (sin GANDALF_TEAM)

Si **no hay `GANDALF_TEAM`** definido, generar prompt genérico:

````
# Prompt de Ejecución del SDD

Implementa el siguiente SDD siguiendo el orden de dependencias definido en tasks.md.

## SDD de referencia

- **requirements.md**: {ruta-real}
- **design.md**:       {ruta-real}
- **tasks.md**:        {ruta-real}

## Instrucciones

Lee los 3 ficheros del SDD antes de empezar.
Implementa cada tarea respetando el orden de dependencias indicado en tasks.md.
````

### Paso GE3 — Añadir sección de orquestación (con GANDALF_TEAM)

Si **`GANDALF_TEAM` está definido**:

1. Leer `~/.claude/teams/{GANDALF_TEAM}/config.json` → extraer `lead` y `teammates`
2. Para cada miembro del team, inferir su dominio según su nombre/tipo de agente
3. Para cada tarea de `tasks.md`, asignar el agente del team más adecuado según su especialidad
4. Generar la sección de orquestación:

````
# Prompt de Ejecución del SDD

Eres el orquestador del team `{GANDALF_TEAM}`.

## Regla absoluta

**ORQUESTAR, no implementar.**
NO escribas código ni edites ficheros directamente.
Delega CADA tarea al agente especializado correcto usando el Agent tool.

## SDD de referencia

- **requirements.md**: {ruta-real}
- **design.md**:       {ruta-real}
- **tasks.md**:        {ruta-real}

## Equipo disponible

- **{lead}**: coordinador (tú)
- **{teammate-1}** ({tipo}): responsable de {dominio}
- **{teammate-N}** ({tipo}): responsable de {dominio}

## Asignación de tareas

| Tarea | Agente asignado | Motivo |
|-------|----------------|--------|
| {T01 — título} | {agente} | {match de especialidad} |
| {T02 — título} | {agente} | {match de especialidad} |
| ... | ... | ... |

## Dependencias

Respetar el orden: {grafo de dependencias extraído de tasks.md}
Las tareas sin dependencias pueden delegarse en paralelo.
````

### Paso GE4 — Mostrar y ofrecer guardar

Mostrar el prompt completo en pantalla.

AskUserQuestion:

```json
{
  "questions": [{
    "header": "Prompt de ejecución",
    "question": "🚀 Prompt generado. ¿Qué quieres hacer?",
    "multiSelect": false,
    "options": [
      {
        "label": "💾 Guardar como sdd-execution-prompt.md",
        "description": "Guardar en el mismo directorio que el SDD"
      },
      {
        "label": "✅ Listo — ya lo he copiado",
        "description": "Volver al Consejo de Rivendel"
      }
    ]
  }]
}
```

Si elige guardar: escribir el fichero `sdd-execution-prompt.md` en el directorio del SDD con Write.
Mostrar confirmación y volver al Consejo de Rivendel.

---

**Módulo**: `08-module-council.md`
**Invocado desde**: `07-module-tasks.md` / `04-module-continue.md`
**Requiere**: contexto_rohirrim, ficheros SDD generados
