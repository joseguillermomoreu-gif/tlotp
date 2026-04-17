# ⚔️ Módulo: Agent Teams — Ver Detalle, Editar, Eliminar, Coordinador y Coherencia

> **Operaciones CRUD sobre teams existentes**: inspección, edición, eliminación,
> forja de coordinador y análisis de coherencia.
> Invocado desde el inventario de teams.

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

## Opción F — Forjar un Coordinador de Ejércitos

### Paso F1 — Seleccionar team objetivo

Si hay más de un team, preguntar con AskUserQuestion mostrando la lista completa
generada en la Fase 0. Si solo hay uno, seleccionarlo automáticamente.

### Paso F2 — Proponer nombre del coordinador

Proponer nombre por defecto: `{team-name}-orchestrator`

Mostrar con AskUserQuestion:

```json
{
  "questions": [{
    "header": "Forjar Coordinador — Paso 1/3",
    "question": "🛡️  ¿Cómo se llamará el coordinador del team '{team}'?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Usar '{team-name}-orchestrator'",
        "description": "Nombre sugerido por Aragorn"
      },
      {
        "label": "✍️  Escribir otro nombre",
        "description": "Solo letras minúsculas, números y guiones"
      }
    ]
  }]
}
```

Validar formato: solo letras minúsculas, números y guiones (`/^[a-z0-9-]+$/`).

### Paso F3 — Precargar instrucciones de orquestación

Leer `.claude/teams/{team}.yml` para obtener los teammates y sus tipos.

Generar instrucciones base precargadas:

```
Eres el coordinador del Agent Team `{team}`.

## Rol: ORQUESTAR, no implementar

Tu misión es dirigir al equipo, no escribir código directamente.
Delega cada tarea al agente especializado correcto usando el Agent tool.
NUNCA edites ficheros ni ejecutes código tú mismo.

## Equipo a tu mando

{Para cada teammate del team}:
- **{nombre-agente}**: responsable de {dominio inferido del nombre}

## Tabla de delegación

| Tipo de tarea | Agente a invocar |
|--------------|-----------------|
| {dominio-1}  | {teammate-1}    |
| {dominio-2}  | {teammate-2}    |
| ...          | ...             |

## Protocolo de coordinación

1. Leer el SDD o la tarea asignada
2. Descomponer en subtareas según especialidad
3. Delegar cada subtarea al agente correcto
4. Verificar resultados y coordinar dependencias
5. Reportar el resultado consolidado
```

> 💰 **Impacto estimado en tokens: +alto**  
> Se ha añadido un coordinador central: los agentes en paralelo más la coordinación añaden rondas de contexto adicionales.  
> _Referencia completa de costes: leer `prompts/shared/orquestacion.md` sección "Guía de Coste de Tokens"_

Mostrar preview y AskUserQuestion:

```json
{
  "questions": [{
    "header": "Forjar Coordinador — Paso 2/3",
    "question": "🛡️  ¿Las instrucciones del coordinador son correctas?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Crear coordinador con estas instrucciones",
        "description": ""
      },
      {
        "label": "✏️  Modificar instrucciones antes de crear",
        "description": "Editar el texto manualmente"
      },
      {
        "label": "🚫 Cancelar",
        "description": ""
      }
    ]
  }]
}
```

### Paso F4 — Crear el agente coordinador

Generar el fichero `.md` del coordinador con frontmatter:

```yaml
---
name: {nombre-coordinador}
description: |
  Coordinador del Agent Team '{team}'. Orquesta, no implementa.
  Invócame para: dirigir equipos paralelos, coordinar SDDs complejos,
  delegar tareas especializadas entre agentes del team.
  Ejemplo: "@{nombre-coordinador} implementa el SDD de la feature X"
tools:
  - Agent
model: claude-sonnet-4-6
---

{instrucciones generadas en F3}
```

Crear en `~/.claude/agents/{nombre-coordinador}.md` con Write.

### Paso F5 — Ofrecer actualizar el lead del team

```json
{
  "questions": [{
    "header": "Forjar Coordinador — Paso 3/3",
    "question": "🛡️  ¿Actualizar el lead del team '{team}' para usar el nuevo coordinador?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Sí, actualizar config.json del team",
        "description": "El coordinador se convertirá en el lead del ejército"
      },
      {
        "label": "⏭️  No por ahora",
        "description": "Mantener el lead actual del team"
      }
    ]
  }]
}
```

Si acepta: leer `.claude/teams/{team}.yml` con Read, actualizar el campo `lead`
al nombre del nuevo coordinador, y escribir con Write/Edit.

Mostrar confirmación épica:

```
══════════════════════════════════════════════════════════════
🛡️  COORDINADOR FORJADO: {nombre-coordinador}
══════════════════════════════════════════════════════════════

  "El ejército de Gondor tiene ahora un general digno de Andúril."

  📂 Fichero:  ~/.claude/agents/{nombre-coordinador}.md
  ⚔️  Team:    {team}
  👑 Lead:    {actualizado / sin cambios}

  Usa "@{nombre-coordinador} [tu misión]" para activarlo.

══════════════════════════════════════════════════════════════
```

AskUserQuestion:
- 🔙 Volver al inventario de teams
- ✨ Crear otro agente asistido

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

**Módulo**: `03e-team-crud.md`
**Invocado desde**: `03a-team-inventory.md` (opciones Ver detalle, Editar, Eliminar, Coordinador, Coherencia)
**Reemplaza**: parte de `03-module-team-builder.md`
**Requiere**: WebFetch on-demand, Read, Bash, Write, Edit
