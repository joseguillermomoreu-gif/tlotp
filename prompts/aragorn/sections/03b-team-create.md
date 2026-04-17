# ⚔️ Módulo: Agent Teams — Crear Nuevo Team

> **Flujo completo de creación**: Pasos A0-A8 incluyendo lógica del Cronista.
> Invocado desde el menú del Team Builder cuando el usuario elige "Crear nuevo team".

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
    "header": "Nuevo team — Paso 1/5",
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
⚔️  NUEVO TEAM — Paso 2/5
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

> 💰 **Impacto estimado en tokens: +medio**  
> Se han seleccionado N agentes para trabajar en paralelo con contextos independientes simultáneos.  
> _Referencia completa de costes: leer `prompts/shared/orquestacion.md` sección "Guía de Coste de Tokens"_

### Paso A4b — Asignar lead del team (obligatorio)

**OBLIGATORIO**: Todo team debe tener exactamente un lead asignado. No se puede avanzar sin lead.

Mostrar:

```
⚔️  NUEVO TEAM — Paso 3/5
══════════════════════════════════════════════════════════════

Un team necesita un Capitán que coordine la batalla.
Agentes seleccionados para "[nombre-del-team]":
  [lista de agentes seleccionados en el paso anterior, indicando si son Lead o Worker]

══════════════════════════════════════════════════════════════
```

**Detectar candidatos a lead**: entre los agentes seleccionados, identificar los que tengan `type: lead` en su frontmatter. Si hay alguno, mostrarlos primero como candidatos sugeridos.

Preguntar con AskUserQuestion:

```json
{
  "questions": [{
    "header": "Asignar lead — Paso 3/5",
    "question": "👑 ¿Quién liderará este ejército?\n(El lead coordina y delega. Debe ser un agente de tipo Lead.)",
    "multiSelect": false,
    "options": [
      { "label": "👑 [agente-lead-1] — [descripción breve]", "description": "Tipo: Lead" },
      { "label": "⚙️ [agente-worker-1] — [descripción breve]", "description": "⚠️ Es Worker — considera crear un Lead primero" },
      {
        "label": "✨ Crear un nuevo agente Lead ahora",
        "description": "Ir al módulo de creación de agentes y volver"
      }
    ]
  }]
}
```

**Nota**: Generar las opciones dinámicamente con los agentes seleccionados en el Paso A4.
Los agentes con `type: lead` se muestran sin advertencia. Los `type: worker` o sin tipo se marcan con `⚠️ Es Worker`.

Si el usuario elige un agente Worker como lead: mostrar aviso informativo pero permitir continuar:
```
⚠️  Este agente es de tipo Worker, no Lead.
    Funcionará como coordinador, pero considera convertirlo a Lead
    en "Inspeccionar arsenal" para mantener consistencia.
```

Si el usuario elige "Crear un nuevo agente Lead": ir al módulo de creación (`02-module-create.md`)
con el tipo pre-seleccionado como Lead, y al terminar volver a este paso con el nuevo agente como lead seleccionado.

Guardar el lead elegido para incluirlo en la configuración del team.

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

El fichero de configuración debe incluir el campo `lead` con el nombre del agente seleccionado
como lead en el Paso A4b, según la estructura extraída de las docs oficiales.

### Paso A7 — Confirmación con lore épico

Asignar un nombre de batalla al team basado en los agentes y su propósito:

```
══════════════════════════════════════════════════════════════
⚔️  EJÉRCITO FORMADO: [nombre-del-team]
══════════════════════════════════════════════════════════════

  🏰 "[Frase épica de batalla — variada]"

  Capitán:  👑 [nombre-del-lead]
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

### Paso A7b — Proponer Cronista

Tras confirmar la creación del team (config escrito en A6, lore mostrado en A7),
proponer al usuario añadir un agente cronista/documentador que registre las
sesiones de trabajo del team recién creado.

```
══════════════════════════════════════════════════════════════
📜 PROPUESTA DEL CONSEJO — Cronista del Ejército
══════════════════════════════════════════════════════════════

  Todo ejército necesita un escriba que registre sus gestas.
  Un agente cronista documenta automáticamente cada sesión:
  qué se analizó, qué decisiones se tomaron, discrepancias
  resueltas y próximos pasos.

  Ejemplos existentes:
    📝 pateandotoledo-reporter — cronista de pateandotetoledo.es
    📝 josemoreupeso-reporter  — cronista de josemoreupeso.es

══════════════════════════════════════════════════════════════
```

> 💰 **Impacto estimado en tokens: +bajo**  
> El cronista se invoca al final de la sesión para generar el informe. Un único spawn ligero.  
> _Referencia completa de costes: leer `prompts/shared/orquestacion.md` sección "Guía de Coste de Tokens"_

AskUserQuestion:

```json
{
  "questions": [{
    "header": "Cronista del Ejército",
    "question": "📜 ¿Añadir un cronista al team \"[nombre-del-team]\"?\n    Se invocará automáticamente al final de cada sesión para documentarla.",
    "multiSelect": false,
    "options": [
      {
        "label": "📜 Sí, añadir cronista (recomendado)",
        "description": "El cronista documenta cada sesión automáticamente al terminar"
      },
      {
        "label": "⏭️  Omitir — continuar sin cronista",
        "description": "El team queda listo sin agente documentador"
      },
      {
        "label": "🚫 Cancelar workflow completo",
        "description": "Abortar la creación del team"
      }
    ]
  }]
}
```

**Si elige "Omitir"** → saltar a Paso A7c (Documentación vía Palantír).
**Si elige "Cancelar"** → abortar el workflow, volver al menú de Aragorn.
**Si elige "Sí, añadir cronista"** → continuar con la configuración del reporter:

#### Configuración del reporter

Solicitar datos del agente cronista mediante AskUserQuestion:

**Nombre del agente** (con sugerencia por defecto):

```json
{
  "questions": [{
    "header": "Cronista — Paso 1/3",
    "question": "📜 ¿Cómo se llamará el cronista?\n    Sugerencia: [nombre-del-team]-reporter",
    "multiSelect": false,
    "options": [
      {
        "label": "✍️  Escribir el nombre",
        "description": "Solo letras minúsculas, números y guiones"
      },
      {
        "label": "✅ Usar sugerencia: [nombre-del-team]-reporter",
        "description": ""
      }
    ]
  }]
}
```

**Descripción del rol** (con sugerencia por defecto):

```json
{
  "questions": [{
    "header": "Cronista — Paso 2/3",
    "question": "📜 ¿Qué rol tendrá el cronista?\n    Sugerencia: Cronista de [nombre-del-team]. Documenta sesiones de trabajo.",
    "multiSelect": false,
    "options": [
      {
        "label": "✍️  Escribir descripción personalizada",
        "description": ""
      },
      {
        "label": "✅ Usar sugerencia por defecto",
        "description": "Cronista de [nombre-del-team]. Documenta sesiones de trabajo del team: qué se analizó o implementó, discrepancias entre agentes y cómo se resolvieron, decisiones tomadas y próximos pasos."
      }
    ]
  }]
}
```

**Ruta del fichero de salida**:

```json
{
  "questions": [{
    "header": "Cronista — Paso 3/3",
    "question": "📜 ¿Dónde guardará el cronista sus informes?",
    "multiSelect": false,
    "options": [
      {
        "label": "📄 .claude/project-knowledge.md",
        "description": "Ruta por defecto — acumula informes entre sesiones"
      },
      {
        "label": "✍️  Especificar otra ruta",
        "description": "Indicar ruta personalizada para los informes"
      }
    ]
  }]
}
```

#### Lore TLOTP opt-in

Tras recoger los datos del reporter, ofrecer activar narrativa épica:

```json
{
  "questions": [{
    "header": "Cronista — Estilo narrativo",
    "question": "📜 ¿Activar narrativa épica LOTR en el cronista?\n    Los informes tendrán estilo Tierra Media manteniendo el contenido técnico.",
    "multiSelect": false,
    "options": [
      {
        "label": "⚔️  Sí — Estilo La Comunidad del Código",
        "description": "Sesiones como gestas, discrepancias como batallas de criterio, decisiones como decretos del Consejo"
      },
      {
        "label": "📋 No — Reporter estándar",
        "description": "Informes profesionales sin narrativa épica"
      }
    ]
  }]
}
```

#### Crear fichero del agente

Crear el fichero del agente en `~/.claude/agents/[nombre-cronista].md` usando Write.

**Si lore INACTIVO** — estructura estándar (patrón pateandotoledo-reporter):

```markdown
---
name: [nombre-cronista]
description: |
  Cronista de [nombre-del-team]. Documenta sesiones de trabajo del team:
  qué se analizó o implementó, discrepancias entre agentes y cómo se
  resolvieron, decisiones tomadas y próximos pasos.

  Invócame al final de cualquier sesión para generar el informe en [ruta-salida]

  Ejemplo: "@[nombre-cronista] documenta la sesión de hoy"
tools:
  - Read
  - Write
  - Edit
  - Glob
  - Grep
memory: project
background: true
model: claude-haiku-4-5-20251001
---

Eres el cronista de [nombre-del-team]. Tu misión es documentar
lo que ocurrió en cada sesión de trabajo del team de forma profesional
y estructurada, acumulando conocimiento entre sesiones.

## Proyecto

[nombre-del-team] — [descripción del team]

## Proceso al ser invocado

1. Leer `[ruta-salida]` para entender el contexto acumulado
2. Leer tu memoria de sesiones en `.claude/agent-memory/[nombre-cronista]/MEMORY.md`
3. Recopilar la información de la sesión actual:
   - Qué tarea o análisis se realizó
   - Qué agentes participaron
   - Qué decisiones se tomaron
   - Qué discrepancias hubo y cómo se resolvieron
   - Qué se implementó o documentó
   - Qué queda pendiente

4. Generar el informe de sesión con este formato:

### [FECHA] — [Tipo de sesión: SDD / Implementación / Análisis]

**Tarea**: [descripción breve]
**Agentes involucrados**: [lista]

**Resumen**: [qué se hizo y qué se produjo]

**Decisiones tomadas**:
- [Decisión] → [Justificación]

**Discrepancias resueltas** (si las hubo):
- **Problema**: [descripción]
  - Postura A ([agente]): [postura]
  - Postura B ([agente]): [postura]
  - Intervención: [scrum-master u otro]
  - Consenso: [solución adoptada]

**Entregables**:
- [ficheros creados / modificados / documentos producidos]

**Próximos pasos**:
- [acción pendiente]

5. Añadir la entrada al final de `[ruta-salida]`
6. Actualizar tu MEMORY.md con los patrones más importantes

## Criterios de calidad del informe

- **Conciso pero completo**: suficiente para que alguien que no estuvo
  entienda qué pasó y por qué
- **Profesional**: estructura clara, lenguaje técnico preciso
- **Accionable**: los próximos pasos deben ser concretos y ejecutables
- **Sin ruido**: no incluir detalles internos de los agentes, solo resultados
```

**Si lore ACTIVO** — añadir al final del prompt (después de "Criterios de calidad"):

```markdown

## Estilo narrativo — La Comunidad del Código

Eres un escriba de la Tierra Media. Tus informes son pergaminos de gesta heroica
que documentan las aventuras de La Comunidad del Código. El contenido técnico
se mantiene intacto, pero la forma adopta el estilo épico:

- **Sesiones** → gestas o jornadas de la expedición
- **Discrepancias entre agentes** → batallas de criterio entre forjadores
- **Decisiones técnicas** → decretos del Consejo de Rivendel
- **Implementaciones exitosas** → forjas completadas en los Fuegos de Orthanc
- **Bugs o errores** → emboscadas de orcos en el camino
- **Próximos pasos** → el camino que queda por recorrer hacia Mordor

Ejemplo de apertura de informe:
> "En la vigésima jornada de la expedición, La Comunidad se reunió en el
> Salón del Consejo para forjar los pergaminos del módulo G4b..."

**IMPORTANTE**: La narrativa épica es la forma, nunca el fondo.
Las decisiones técnicas, datos concretos y acciones deben ser precisos.
El lore enriquece la lectura, no la oscurece.
```

#### Registrar cronista en la configuración del team

Tras crear el fichero del agente cronista, añadir el campo `cronista` al `.yml` del team:

```bash
# Añadir campo cronista al fichero de configuración del team
```

Usar Edit para añadir al fichero `.claude/teams/[nombre-del-team].yml`:

```yaml
cronista: [nombre-cronista]
```

Esto permite que `# SYNC: session-end` (definido en `aragorn-main.md`) lo localice automáticamente al final de cada sesión.

#### Confirmación de creación

Mostrar tras crear el fichero:

```
══════════════════════════════════════════════════════════════
📜 CRONISTA FORJADO: [nombre-cronista]
══════════════════════════════════════════════════════════════

  📍 Agente:    ~/.claude/agents/[nombre-cronista].md
  📄 Informes:  [ruta-salida]
  🎭 Estilo:    [Narrativa épica LOTR / Reporter estándar]

  ⚡ Invocación: automática al final de cada sesión del team
  💡 También puedes invocarlo manualmente:
     @[nombre-cronista] documenta la sesión de hoy

══════════════════════════════════════════════════════════════
```

### Paso A7c — Documentación vía Palantír

AskUserQuestion:

```json
{
  "questions": [{
    "header": "Ejército formado — Documentación",
    "question": "⚔️  ¿Grabamos los pergaminos del ejército en los muros de la fortaleza?\n    Palantír puede registrar en tu proyecto cuándo y cómo usar este team.",
    "multiSelect": false,
    "options": [
      {
        "label": "🔮 Sí, invocar a Palantír",
        "description": "Documentar en .claude/CLAUDE.md cuándo usar este team"
      },
      {
        "label": "⏭️  No, continuar sin documentar",
        "description": "El team queda listo pero sin instrucciones en el proyecto"
      }
    ]
  }]
}
```

**Si elige "Sí, invocar a Palantír"** → ir al **Paso A8**.
**Si elige "No"** → ir directamente al menú final (AskUserQuestion de abajo).

### Paso A8 — Documentar el team vía Palantír

Invocar Palantír con contexto preformateado del team recién creado.

**No pedir input libre al usuario** — Palantír recibe directamente la petición
pre-rellenada con los datos del team:

> "Añadir al CLAUDE.md del proyecto una sección que indique cuándo y cómo usar
> el Agent Team '[nombre-del-team]'.
>
> Datos del team:
> - Nombre: [nombre-del-team]
> - Agentes: [lista de agentes separados por coma]
> - Misión: [descripción del team]
>
> La sección debe indicar: para qué tipo de tareas invocar este team,
> cómo invocarlo (comando), y qué agentes lo componen."

Ejecutar: @prompts/palantir/sections/05-susurrar-planes.md
(Palantír arranca desde su PASO 2, saltando el PASO 1 de input libre
porque ya tiene la petición pre-rellenada)

Tras completar Palantír, mostrar:

```
🔮 Los pergaminos han sido grabados en la fortaleza.
   Palantír ha documentado el team en tu proyecto.
```

AskUserQuestion:
- 🆕 Crear otro team
- 📋 Ver todos los teams
- 💡 Cómo ver pestañas separadas por agente
- 🔙 Volver al menú de Aragorn

---

**Módulo**: `03b-team-create.md`
**Invocado desde**: `03a-team-inventory.md` (opción "Crear nuevo team")
**Requiere**: WebFetch on-demand, Read, Bash, Write, Edit
