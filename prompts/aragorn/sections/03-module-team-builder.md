# ⚔️ Módulo: Agent Teams — Configurar y Usar Equipos

## Misión

Asistir al usuario para configurar, gestionar y usar Agent Teams según la
documentación oficial de Claude Code. Todo el contenido técnico se obtiene vía
WebFetch on-the-fly, nunca hardcodeado.

---

## Fase 0 — Inventario de Teams Existentes

**Antes de cualquier menú o documentación**, detectar todos los Agent Teams existentes.

### Paso F0.1 — Escanear ambos scopes

```bash
echo "=== GLOBAL (~/.claude/agents/) ==="
ls ~/.claude/agents/ 2>/dev/null || echo "(vacío)"
echo "=== PROJECT (.claude/agents/) ==="
ls .claude/agents/ 2>/dev/null || echo "(vacío)"
```

Para cada fichero/directorio encontrado, leer su contenido con Read para extraer:
- Nombre del team
- Número de agentes miembros (campos `teammates` o equivalente según docs)

### Paso F0.2 — Mostrar inventario

**Si se encuentran teams en algún scope**, mostrar:

```
══════════════════════════════════════════════════════════════
⚔️  TUS EJÉRCITOS DE GONDOR
══════════════════════════════════════════════════════════════

  🌍 GLOBAL (~/.claude/agents/):
  [Para cada team global]:
    ⚔️  [nombre-team]
       🧑‍🤝‍🧑 Agentes: [N]  ·  🗡️ [lista nombres separados por coma]

  📁 PROYECTO (.claude/agents/):
  [Para cada team de proyecto]:
    ⚔️  [nombre-team]
       🧑‍🤝‍🧑 Agentes: [N]  ·  🗡️ [lista nombres separados por coma]

  [Si algún scope está vacío, omitir esa sección]

══════════════════════════════════════════════════════════════
📊 Total: [N] teams  (global: [N] · proyecto: [N])
══════════════════════════════════════════════════════════════
```

Luego usar AskUserQuestion:

```json
{
  "questions": [{
    "header": "Agent Teams — Inventario",
    "question": "⚔️  ¿Qué quieres hacer con tus ejércitos?",
    "multiSelect": false,
    "options": [
      {
        "label": "🆕 Crear nuevo team",
        "description": "Forjar un nuevo ejército desde cero"
      },
      {
        "label": "👁️  Ver detalle de un team",
        "description": "Inspeccionar configuración completa"
      },
      {
        "label": "✏️  Editar un team",
        "description": "Modificar nombre o agentes miembros"
      },
      {
        "label": "🔍 Analizar coherencia",
        "description": "Detectar duplicados y conflictos entre scopes"
      },
      {
        "label": "🗑️  Eliminar un team",
        "description": "Borrar con confirmación previa"
      },
      {
        "label": "❓ ¿Cuándo usar Agent Teams vs Subagents?",
        "description": "Guía desde docs oficiales"
      },
      {
        "label": "🔙 Volver al menú de Aragorn",
        "description": ""
      }
    ]
  }]
}
```

**Si NO hay teams en ningún scope**, mostrar:

```
══════════════════════════════════════════════════════════════
⚔️  EJÉRCITOS DE GONDOR
══════════════════════════════════════════════════════════════

  No hay teams configurados todavía.
  Los archivos del rey esperan ser formados.

══════════════════════════════════════════════════════════════
```

Y usar AskUserQuestion:

```json
{
  "questions": [{
    "header": "Agent Teams",
    "question": "⚔️  No hay teams aún — ¿Qué quieres hacer?",
    "multiSelect": false,
    "options": [
      {
        "label": "🆕 Crear mi primer team",
        "description": "Forjar el primer ejército de Gondor"
      },
      {
        "label": "❓ ¿Qué son los Agent Teams?",
        "description": "Ver explicación desde docs oficiales"
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

## Paso 0 — Documentación oficial (on-the-fly)

**IMPORTANTE**: Comprobar primero si la documentación ya está cargada en el contexto.

**Si ya está en contexto**: usar directamente sin re-fetchear.

**Si no está en contexto**, hacer WebFetch en paralelo:

> **WebFetch 1**: `https://code.claude.com/docs/en/agent-teams`
> **Extraer**: qué son Agent Teams, cómo activarlos, estructura lead + teammates,
> shared task list, mailbox, display modes, cuándo usarlos, limitaciones, ejemplos.

> **WebFetch 2**: `https://code.claude.com/docs/en/sub-agents`
> **Extraer**: diferencia Subagents vs Agent Teams, cuándo elegir cada uno,
> invocación automática vs explícita, contextos compartido vs independiente.

**Fallback si WebFetch falla**: Mostrar solo las URLs:

```
⚠️ No se pudo cargar la documentación oficial.
   El módulo de Agent Teams requiere las docs oficiales.

   Puedes consultarlas directamente:
     ⚔️  Agent Teams: https://code.claude.com/docs/en/agent-teams
     🤖 Sub-agents:  https://code.claude.com/docs/en/sub-agents
```

Ofrecer AskUserQuestion: reintentar WebFetch / volver al menú.

---

## Paso 1 — Menú del Team Builder

Tras cargar la documentación, mostrar menú:

```
══════════════════════════════════════════════════════════════
⚔️  TEAM BUILDER — Ejércitos de Gondor
══════════════════════════════════════════════════════════════

  Los Agent Teams permiten que múltiples agentes trabajen
  en paralelo, cada uno con su propio contexto independiente.
  [mostrar breve resumen extraído de las docs WebFetch]
══════════════════════════════════════════════════════════════
```

```json
{
  "questions": [{
    "header": "Agent Teams",
    "question": "⚔️  ¿Qué quieres hacer?",
    "multiSelect": false,
    "options": [
      {
        "label": "🆕 Crear nuevo team",
        "description": "Configurar un equipo de agentes paralelos"
      },
      {
        "label": "📋 Ver teams configurados",
        "description": "Listar y gestionar teams existentes"
      },
      {
        "label": "🪟 ¿Cómo ver cada agente en su propia pestaña?",
        "description": "Guía para visualizar resultados independientes"
      },
      {
        "label": "❓ ¿Cuándo usar Agent Teams vs Subagents?",
        "description": "Explicación desde docs oficiales"
      }
    ]
  }]
}
```

---

## Opción A — Crear nuevo team

### Paso A0 — Proponer team según stack y agentes instalados

**Antes de pedir nombre**, Aragorn analiza el stack y los agentes disponibles y propone
combinaciones de team con nombre + agentes sugeridos. El usuario elige una propuesta
o crea la suya.

**Reglas de matching** (basadas en agentes instalados detectados en Paso A1):

| Stack / Patrón | Team sugerido | Agentes candidatos |
|----------------|--------------|-------------------|
| PHP + tests disponibles | "quality-shield" | code-reviewer + php-pro + test-automator |
| TypeScript + Playwright | "frontend-guard" | typescript-pro + playwright-agent + code-reviewer |
| Backend + Frontend | "full-stack-review" | backend-agent + frontend-agent + architect-reviewer |
| Deploy / CI/CD | "deploy-guard" | devops-engineer + deployment-engineer + security-auditor |
| Refactoring | "clean-architecture" | refactoring-specialist + architect-reviewer + code-reviewer |
| Cualquier proyecto | "war-council" | Los 3 agentes con más alta puntuación del arsenal |

Si no hay suficientes agentes instalados para una propuesta (< 2), saltar directamente al Paso A3.

Mostrar propuestas con AskUserQuestion:

```json
{
  "questions": [{
    "header": "Propuesta de team",
    "question": "⚔️  Aragorn ha analizado tu arsenal. ¿Qué ejército convocamos?",
    "multiSelect": false,
    "options": [
      {
        "label": "⚔️  [nombre-propuesto-1] — [agentes]",
        "description": "[descripción del propósito del team]"
      },
      {
        "label": "⚔️  [nombre-propuesto-2] — [agentes]",
        "description": "[descripción del propósito del team]"
      },
      {
        "label": "✍️  Crear team personalizado",
        "description": "Elegir nombre y agentes manualmente"
      },
      {
        "label": "🔙 Volver",
        "description": ""
      }
    ]
  }]
}
```

Si el usuario elige una propuesta: saltar directamente al Paso A5 (activación) con los datos pre-cargados.
Si elige personalizado: continuar por el flujo normal (Paso A3).

### Paso A1 — Verificar activación de Agent Teams

```bash
{
  echo "=== ENV ==="
  echo "${CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS:-no-definida}"
  echo "=== AGENTES DISPONIBLES GLOBAL ==="
  ls ~/.claude/agents/ 2>/dev/null || echo "(vacío)"
  echo "=== AGENTES DISPONIBLES PROYECTO ==="
  ls .claude/agents/ 2>/dev/null || echo "(vacío)"
} 2>/dev/null
```

Si NO está activo el flag experimental, mostrar información extraída de las docs oficiales
sobre cómo activarlo y preguntar (AskUserQuestion):
- ✅ Añadir a `.bashrc`/`.zshrc` permanentemente
- 📋 Ver el comando — lo haré yo manualmente
- ⏭️ Continuar sin activar (podré activarlo después)

Si elige añadir permanentemente:

```bash
echo $SHELL
```

- `zsh` → añadir a `~/.zshrc`
- `bash` → añadir a `~/.bashrc`

```bash
echo '' >> ~/.zshrc
echo '# Agent Teams (Claude Code experimental)' >> ~/.zshrc
echo 'export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1' >> ~/.zshrc
```

### Paso A2 — Verificar agentes disponibles

Si hay menos de 2 agentes instalados en total:

```
⚠️  Para crear un team necesitas al menos 2 agentes instalados.

   Agentes actuales: [N]

💡 Usa "Buscar e instalar desde marketplaces" o "Crear un agente asistido"
   para reclutar guerreros primero.
```

Ofrecer AskUserQuestion:
- 🏪 Ir a Buscar e instalar
- ✨ Ir a Crear agente asistido
- ⏭️ Continuar de todos modos (crearé el team sin agentes reales aún)

### Paso A3 — Nombre del team

Preguntar con AskUserQuestion:

```json
{
  "questions": [{
    "header": "Nuevo team — Paso 1/4",
    "question": "⚔️  ¿Cómo se llamará el team?\n(ej: full-stack-review, security-audit, deploy-guard)",
    "multiSelect": false,
    "options": [
      {
        "label": "✍️  Escribir el nombre",
        "description": "Solo letras minúsculas, números y guiones"
      },
      {
        "label": "🔙 Volver",
        "description": ""
      }
    ]
  }]
}
```

Validar formato: solo letras minúsculas, números y guiones.

Comprobar si ya existe:

```bash
ls .claude/teams/[nombre].yml 2>/dev/null
```

### Paso A4 — Seleccionar agentes del team

Mostrar todos los agentes disponibles y pedir selección con multiSelect:

```
⚔️  NUEVO TEAM — Paso 2/4
══════════════════════════════════════════════════════════════

Agentes disponibles:

🌍 Global (~/.claude/agents/):
  • code-reviewer    — [descripción]
  • symfony-expert   — [descripción]

📁 Proyecto (.claude/agents/):
  • deploy-guardian  — [descripción]

Selecciona los agentes para "[nombre-del-team]"
(mínimo 2 para que tenga sentido un team)
══════════════════════════════════════════════════════════════
```

```json
{
  "questions": [{
    "header": "Seleccionar agentes",
    "question": "⚔️  ¿Qué agentes forman el team? (multiselect)",
    "multiSelect": true,
    "options": [
      { "label": "[agente-1] — [descripción breve]", "description": "" },
      { "label": "[agente-2] — [descripción breve]", "description": "" }
    ]
  }]
}
```

Nota: generar opciones dinámicamente según los agentes reales detectados en el Paso A1.

### Paso A5 — Descripción del team

Preguntar al usuario para qué se usará el team (AskUserQuestion con campo libre).

### Paso A6 — Generar configuración

**IMPORTANTE**: La estructura exacta del fichero de configuración debe extraerse de
las docs oficiales obtenidas en el Paso 0. Usar exclusivamente el formato documentado.

Si no se conoce la estructura exacta desde las docs, mostrar:

```
⚠️ No se encontró la estructura de configuración en las docs.
   Consulta: https://code.claude.com/docs/en/agent-teams
```

Crear directorio si no existe:

```bash
mkdir -p .claude/teams/
```

Escribir el fichero `.claude/teams/[nombre].yml` usando Write con la estructura
extraída de las docs oficiales.

### Paso A7 — Confirmación con lore épico

Asignar un nombre de batalla al team basado en los agentes y su propósito:

```
══════════════════════════════════════════════════════════════
⚔️  EJÉRCITO FORMADO: [nombre-del-team]
══════════════════════════════════════════════════════════════

  🏰 "[Frase épica de batalla — variada]"

  Guerreros convocados:
    [emoji-personaje] [Personaje] ([nombre-agente]) — "[frase breve]"
    [emoji-personaje] [Personaje] ([nombre-agente]) — "[frase breve]"

  📍 Fichero:  .claude/teams/[nombre].yml
  📝 Misión:   [descripción]

  [Cómo usar el team según las docs oficiales]

══════════════════════════════════════════════════════════════
```

**Frases épicas de batalla** (rotar, nunca repetir la misma):
- *"¡La Batalla del Pelennor Fields comienza! Rohirrim y Elfos marchan juntos."*
- *"¡El cuerno de Gondor resuena! El ejército responde."*
- *"¡Por Frodo! ¡Por la Comarca! El team marcha al combate."*
- *"Sauron no esperaba esta coordinación. Que tiemble."*
- *"¡Rohirrim, a la carga! El team no conoce la derrota."*

Usar el sistema de personajes de `aragorn-main.md` para asignar a cada agente del team.

AskUserQuestion:
- 🆕 Crear otro team
- 📋 Ver todos los teams
- 💡 Cómo ver pestañas separadas por agente
- 🔙 Volver al menú de Aragorn

---

## Opción B — Ver teams configurados

### Paso B1 — Escanear teams

```bash
ls .claude/teams/ 2>/dev/null
```

Si no hay ninguno:

```
📋 No hay teams configurados todavía.
💡 Usa "Crear nuevo team" para configurar tu primer equipo.
```

### Paso B2 — Mostrar inventario

Para cada fichero `.yml` encontrado, leerlo con Read y mostrar:

```
📋 TEAMS CONFIGURADOS
══════════════════════════════════════════════════════════════

  1. full-stack-review
     📝 Revisión completa: calidad + seguridad
     ⚔️  Agentes: code-reviewer, symfony-expert
     📍 .claude/teams/full-stack-review.yml

══════════════════════════════════════════════════════════════
📊 Total: [N] teams configurados
```

AskUserQuestion:
- 🆕 Crear nuevo team
- 🔧 Editar un team (pedir cuál → reescribir configuración)
- 🗑️ Eliminar un team (pedir cuál → confirmar → `rm .claude/teams/[nombre].yml`)
- 🔙 Volver al menú de Aragorn

---

## Opción C — ¿Cómo ver cada agente en su propia pestaña?

**CRÍTICO**: El contenido de esta sección debe extraerse de las docs oficiales obtenidas
en el Paso 0 (`agent-teams`). Si las docs no mencionan display modes o pestañas,
mostrar solo lo que aparezca en las docs + las instrucciones prácticas de abajo.

Mostrar:

```
🪟 AGENTES EN PESTAÑAS SEPARADAS
══════════════════════════════════════════════════════════════

Cada agente de un Agent Team es una instancia de Claude Code
independiente. Para verlos en pestañas separadas:

📖 Según las docs oficiales:
   [insertar aquí el contenido relevante de las docs sobre
    display modes, cómo se visualizan los agentes paralelos,
    output de cada instancia — extraído del WebFetch]

💡 Guía práctica:
   1. Abre Claude Code en modo terminal
   2. Invoca tu team: "@[nombre-team] [tu tarea]"
   3. Cada agente del team abre su propio proceso
   4. Si tu terminal lo soporta (tmux, iTerm2, WezTerm...):
      - Claude Code puede sugerir abrir cada instancia
        en un panel/pestaña diferente automáticamente
   5. Los resultados de cada agente aparecen por separado
      con su nombre como prefijo

🔧 Configuración recomendada para ver tabs:
   - Terminal con soporte de splits: tmux, WezTerm, iTerm2
   - O abre múltiples ventanas de terminal manualmente
   - Cada agente del team = una pestaña dedicada
══════════════════════════════════════════════════════════════
```

AskUserQuestion:
- 🆕 Crear un team ahora
- 📋 Ver mis teams configurados
- 🔙 Volver al menú de Aragorn

---

## Opción E — ¿Cuándo usar Agent Teams vs Subagents?

**CRÍTICO**: Mostrar EXCLUSIVAMENTE el contenido extraído de las docs oficiales
en el Paso 0. NO usar conocimiento interno para generar la comparativa.

Mostrar con esta estructura (contenido 100% de WebFetch):

```
══════════════════════════════════════════════════════════════
❓ AGENT TEAMS vs SUBAGENTS
══════════════════════════════════════════════════════════════

[Insertar aquí la comparativa extraída de las docs oficiales]

══════════════════════════════════════════════════════════════
```

AskUserQuestion:
- 🆕 Crear un team ahora
- 🔙 Volver al menú de Aragorn

---

## Operación: Ver Detalle de Team

### Paso VD1 — Seleccionar team

Si hay más de un team, preguntar con AskUserQuestion mostrando la lista completa
(nombre + scope) generada en la Fase 0. Si solo hay uno, seleccionarlo automáticamente.

### Paso VD2 — Leer y mostrar configuración completa

Leer el fichero del team con Read y mostrar:

```
══════════════════════════════════════════════════════════════
👁️  DETALLE: [nombre-team]
══════════════════════════════════════════════════════════════

  📍 Scope:      [global / proyecto]
  📁 Fichero:    [ruta completa]
  🧑‍🤝‍🧑 Agentes:   [N]

  Guerreros del ejército:
    [Para cada agente]:
    ⚔️  [nombre-agente]  ·  [descripción si disponible]

  📝 Descripción del team:
     [campo description del fichero si existe]

══════════════════════════════════════════════════════════════
```

AskUserQuestion:
- ✏️ Editar este team
- 🗑️ Eliminar este team
- 🔙 Volver al inventario

---

## Operación: Editar Team

### Paso ED1 — Seleccionar team

Si hay más de un team, preguntar con AskUserQuestion (lista de nombres + scope).

### Paso ED2 — Seleccionar qué editar

```json
{
  "questions": [{
    "header": "Editar team",
    "question": "✏️  ¿Qué deseas modificar en '[nombre-team]'?",
    "multiSelect": false,
    "options": [
      {
        "label": "📛 Cambiar nombre",
        "description": "Renombrar el fichero del team"
      },
      {
        "label": "🧑‍🤝‍🧑 Añadir agentes",
        "description": "Incorporar nuevos guerreros al ejército"
      },
      {
        "label": "➖ Quitar agentes",
        "description": "Retirar agentes del team con confirmación"
      },
      {
        "label": "📝 Cambiar descripción",
        "description": "Actualizar el propósito del team"
      },
      {
        "label": "🔙 Cancelar",
        "description": ""
      }
    ]
  }]
}
```

### Paso ED3 — Aplicar cambios

Mostrar el cambio propuesto y pedir confirmación (AskUserQuestion: Confirmar / Cancelar):

```
══════════════════════════════════════════════════════════════
✏️  CAMBIO PROPUESTO — [nombre-team]
══════════════════════════════════════════════════════════════
  [Describir el cambio concreto a aplicar]
══════════════════════════════════════════════════════════════
```

Tras confirmar, aplicar con Edit/Write según corresponda.

Mostrar confirmación:
*"El ejército ha sido reorganizado. Que los dioses de la batalla les sean favorables."*

Volver automáticamente al inventario (Fase 0).

---

## Operación: Eliminar Team

### Paso EL1 — Seleccionar team

Si hay más de un team, preguntar con AskUserQuestion (lista de nombres + scope).

### Paso EL2 — Confirmación obligatoria

**SIEMPRE** mostrar confirmación antes de eliminar:

```json
{
  "questions": [{
    "header": "⚠️  Confirmar eliminación",
    "question": "🗑️  ¿Seguro que quieres disolver el ejército '[nombre-team]'?\n    Esta acción no se puede deshacer.",
    "multiSelect": false,
    "options": [
      {
        "label": "🗑️  Sí, disolver el ejército",
        "description": "Eliminar [nombre-team] ([scope])"
      },
      {
        "label": "🔙 Cancelar — mantener el team",
        "description": ""
      }
    ]
  }]
}
```

### Paso EL3 — Ejecutar eliminación

Si el usuario confirma:

```bash
rm [ruta-del-fichero-team]
```

Mostrar confirmación con lore épico:
*"El ejército ha sido disuelto. Sus guerreros regresan a sus tierras. Que Gondor los recuerde."*

Volver automáticamente al inventario (Fase 0).

---

## Operación: Análisis de Coherencia de Teams

### Paso AC1 — Cargar inventario completo

Ejecutar el mismo escaneo que la Fase 0 para obtener la lista actualizada de todos los
teams en ambos scopes. Leer cada fichero con Read para obtener nombre, agentes y scope.

### Paso AC2 — Ejecutar análisis

Evaluar los siguientes criterios sobre todos los teams detectados:

**Criterio 1 — Duplicados exactos entre scopes**
Detectar teams con el **mismo nombre** tanto en `~/.claude/agents/` como en `.claude/agents/`.
Acción sugerida: fusionar o eliminar el duplicado con indicación de cuál mantener.

**Criterio 2 — Nombres muy similares**
Detectar teams cuyo nombre tenga una distancia de edición ≤ 2 con otro team
(independientemente del scope). Por ejemplo: `code-review` vs `code-reviewer`.
Acción sugerida: renombrar el más reciente o fusionar si tienen propósito similar.

**Criterio 3 — Agentes solapados entre teams**
Detectar teams que comparten más del 50% de sus agentes con otro team.
Acción sugerida: especializar roles o fusionar los teams si tienen propósito similar.

### Paso AC3 — Mostrar informe

**Si se detectan problemas**, mostrar:

```
══════════════════════════════════════════════════════════════
🔍 ANÁLISIS DE COHERENCIA — EJÉRCITOS DE GONDOR
══════════════════════════════════════════════════════════════

  [Para cada problema detectado]:

  ⚠️  PROBLEMA [N]: [tipo — Duplicado / Nombre similar / Solapamiento]
  ────────────────────────────────────────────────────────────
  📋 Detectado:  [descripción concreta del problema]
  💡 Sugerencia: [acción propuesta]
  🎯 Motivo:     [justificación breve]

══════════════════════════════════════════════════════════════
📊 Total: [N] problemas detectados
══════════════════════════════════════════════════════════════
```

**Si no se detectan problemas**, mostrar:

```
══════════════════════════════════════════════════════════════
🔍 ANÁLISIS DE COHERENCIA
══════════════════════════════════════════════════════════════

  Los teams están en perfecta armonía 🧙‍♂️

  No se detectaron duplicados, nombres similares ni
  solapamientos significativos entre ejércitos.

══════════════════════════════════════════════════════════════
```

### Paso AC4 — Aplicar sugerencias (si hay problemas)

Para cada problema detectado, ofrecer acciones con AskUserQuestion:

```json
{
  "questions": [{
    "header": "Coherencia — Problema [N]/[TOTAL]",
    "question": "⚔️  [descripción del problema]\n    Sugerencia: [acción propuesta]",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aplicar sugerencia",
        "description": "[qué se hará concretamente]"
      },
      {
        "label": "⏭️  Saltar este problema",
        "description": "Ignorar y pasar al siguiente"
      },
      {
        "label": "🚫 Terminar análisis",
        "description": "Salir del análisis y volver al inventario"
      }
    ]
  }]
}
```

Aplicar la acción elegida (fusionar = copiar config + eliminar original, renombrar = mv del fichero).
Mostrar confirmación con frase épica antes de ejecutar cada acción.

Tras procesar todos los problemas (o al terminar), volver automáticamente al inventario (Fase 0).

---

## 🔗 Fuentes

Ver índice completo en `@prompts/docs-sources.md`:
- Agent Teams: `https://code.claude.com/docs/en/agent-teams`
- Sub-agents:  `https://code.claude.com/docs/en/sub-agents`

---

**Módulo**: `03-module-team-builder.md`
**Invocado desde**: `aragorn-main.md` (opción "Agent Teams")
**Reemplaza**: `ar7-team-builder.md`
**Requiere**: WebFetch on-demand, Read, Bash, Write, Edit
