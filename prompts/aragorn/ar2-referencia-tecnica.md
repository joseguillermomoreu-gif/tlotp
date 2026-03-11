# 👑 AR2 - El Consejo de Guerra: Referencia Técnica

## Intro de ejecución

```
👑 Aragorn despliega los mapas de guerra sobre la mesa...
   Todo general debe conocer a sus soldados antes de la batalla.
   Consultando la documentación oficial de Claude Code.
```

---

## Paso 1 — Consultar documentación oficial (WebFetch)

Antes de mostrar nada, obtener la documentación actualizada:

```
WebFetch: https://code.claude.com/docs/en/sub-agents.md
```

Si el WebFetch falla, usar el conocimiento interno marcando con ⚠️ "información puede no estar actualizada".

---

## Paso 2 — Mostrar referencia completa

### 1. ¿Qué son los Subagents?

Explica con la información obtenida de la documentación oficial qué son los subagents de Claude Code, cómo se definen y para qué sirven.

---

### 2. Campos del YAML Frontmatter

Muestra la tabla completa de campos disponibles para definir un agente en su fichero `.md`:

```
---
name: nombre-del-agente
description: |
  Para qué sirve este agente y cuándo Claude lo invoca.
  Cuanto más detallada, mejor la invocación automática.
tools:
  - Read
  - Write
  - Bash
  - Grep
  - Glob
model: claude-sonnet-4-6
permissionMode: default
maxTurns: 10
---

Instrucciones adicionales para el agente en Markdown...
```

| Campo | Tipo | Obligatorio | Descripción |
|-------|------|-------------|-------------|
| `name` | string | ✅ | Nombre único del agente |
| `description` | string | ✅ | Para qué sirve — clave para invocación automática |
| `tools` | lista | Recomendado | Herramientas permitidas (Read, Write, Bash, Grep, Glob...) |
| `disallowedTools` | lista | No | Herramientas explícitamente prohibidas |
| `model` | string | No | Modelo a usar (ej: `claude-opus-4-6`, `claude-sonnet-4-6`) |
| `permissionMode` | string | No | `default`, `acceptEdits`, `bypassPermissions` |
| `maxTurns` | int | No | Límite de turnos. Sin valor: sin límite |
| `skills` | lista | No | Skills inyectadas al agente |
| `mcpServers` | map | No | MCPs específicos del agente |
| `hooks` | map | No | Hooks específicos del agente |
| `memory` | lista | No | Ficheros de memoria del agente |
| `background` | bool | No | Si corre en background |

---

### 3. Scopes y Jerarquía

```
~/.claude/agents/       ← Global (todos los proyectos)
.claude/agents/         ← Proyecto (solo este repositorio)
```

El scope **proyecto** tiene prioridad sobre **global** si existe un agente con el mismo `name`.

---

### 4. Cómo se Invocan los Subagents

**Automático** — Claude decide:
- Claude lee la `description` de todos los agentes instalados
- Si la tarea encaja con la descripción, lo invoca solo
- Ejemplo: si hay un `symfony-expert`, Claude lo usará al tocar código Symfony

**Explícito** — El usuario decide:
- Mencionar `@nombre-agente` en el mensaje
- Ejemplo: `@code-reviewer revisa este PR`

---

### 5. Subagents vs Agent Teams

| Aspecto | Subagents | Agent Teams |
|---------|-----------|-------------|
| Contexto | Compartido con el agente padre | Independiente por agente |
| Estabilidad | Estable | Experimental |
| Uso ideal | Tareas delegadas simples | Trabajo paralelo complejo |
| Overhead | Bajo | Alto (múltiples instancias) |
| Activación | Automático desde `~/.claude/agents/` | `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` |
| Fichero | `.md` en `agents/` | `.md` en `agents/` |

---

### 6. Agent Teams (Experimental)

Agent Teams permite ejecutar múltiples agentes en paralelo, cada uno con su propio contexto independiente.

**Activación**:
```bash
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
```

**Diferencia clave**: cada agente en un Team es una instancia Claude Code independiente. Se coordinan mediante una lista de tareas y un mailbox compartido. Úsalos para trabajo genuinamente paralelo (ej: analizar backend y frontend simultáneamente).

---

### 7. Ejemplo Completo de Agente

```markdown
---
name: symfony-expert
description: |
  Experto en Symfony y PHP para este proyecto.
  Invócame cuando necesites analizar servicios, repositorios,
  configuración de bundles, queries Doctrine u optimizaciones PHP.
tools:
  - Read
  - Write
  - Bash
  - Grep
  - Glob
model: claude-sonnet-4-6
permissionMode: acceptEdits
maxTurns: 20
---

Eres un experto senior en Symfony 7 y PHP 8.3.

Cuando analices código, prioriza:
1. Principios SOLID y arquitectura hexagonal
2. Tipado estricto (PHPStan level 9)
3. Buenas prácticas de Doctrine ORM
4. Performance y seguridad
```

---

## Paso 3 — Volver al menú

Tras mostrar la referencia, pregunta al usuario (AskUserQuestion):
- Volver al menú de Aragorn
- Buscar agentes en marketplaces (ir a Opción 2)
- Salir
