# ⚔️ Módulo: Agent Teams — Configurar y Usar Equipos

## Misión

Asistir al usuario para configurar, gestionar y usar Agent Teams según la
documentación oficial de Claude Code. Todo el contenido técnico se obtiene vía
WebFetch on-the-fly, nunca hardcodeado.

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
        "label": "❓ ¿Cuándo usar Agent Teams vs Subagents?",
        "description": "Explicación desde docs oficiales"
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

## Opción A — Crear nuevo team

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

### Paso A7 — Confirmación

```
✅ TEAM CONFIGURADO CORRECTAMENTE
══════════════════════════════════════════════════════════════

  🏛️  Team:     [nombre]
  📝  Para:     [descripción]
  ⚔️   Agentes:  [lista]
  📍  Fichero:  .claude/teams/[nombre].yml

  [Incluir cómo usar el team según las docs oficiales]

══════════════════════════════════════════════════════════════
👑 "Los ejércitos de Gondor están listos, señor.
    El team marcha."
```

AskUserQuestion:
- 🆕 Crear otro team
- 📋 Ver todos los teams
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

## Opción C — ¿Cuándo usar Agent Teams vs Subagents?

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

## 🔗 Fuentes

Ver índice completo en `@prompts/docs-sources.md`:
- Agent Teams: `https://code.claude.com/docs/en/agent-teams`
- Sub-agents:  `https://code.claude.com/docs/en/sub-agents`

---

**Módulo**: `03-module-team-builder.md`
**Invocado desde**: `aragorn-main.md` (opción "Agent Teams")
**Reemplaza**: `ar7-team-builder.md`
**Requiere**: WebFetch on-demand, Read, Bash, Write, Edit
