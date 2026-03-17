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

- **⚔️ Convocar al ejército** → Cargar `@prompts/gandalf/sections/10-module-forge-team.md`
- **📝 Ver tasks.md** → Leer el fichero y mostrarlo. AskUserQuestion para continuar.
- **✏️ Mejorar** → Preguntar cuál fichero:
  - requirements.md → `@prompts/gandalf/sections/05-module-requirements.md`
  - design.md → `@prompts/gandalf/sections/06-module-design.md`
  - tasks.md → `@prompts/gandalf/sections/07-module-tasks.md`
- **🔙 Volver** → Menú de Gandalf

---

**Módulo**: `08-module-council.md`
**Invocado desde**: `07-module-tasks.md` / `04-module-continue.md`
**Requiere**: contexto_rohirrim, ficheros SDD generados
