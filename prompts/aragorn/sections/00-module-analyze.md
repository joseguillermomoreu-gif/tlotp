# 🔍 Módulo: Inspeccionar el Ejército — Análisis de Agentes con Scoring

## Misión

Analizar los agentes instalados en el sistema (global y proyecto), puntuar su calidad
según criterios oficiales, detectar oportunidades y guiar la aplicación de mejoras una a una.

---

## Paso 0 — Documentación y marketplaces (on-the-fly)

**IMPORTANTE**: Comprobar primero si cada fuente ya está cargada en el contexto.

**Si ya está en contexto**: usar directamente sin re-fetchear.

**Si no está en contexto**, hacer WebFetch en paralelo:

> **WebFetch 1**: `https://code.claude.com/docs/en/sub-agents`
> **Extraer**: campos válidos del frontmatter YAML (name, description, tools, model, permissionMode,
> maxTurns, disallowedTools, skills, mcpServers, hooks, memory, background), scopes, invocación
> automática vs explícita, mejores prácticas de description.

> **WebFetch 2**: `https://raw.githubusercontent.com/VoltAgent/awesome-claude-code-subagents/main/README.md`
> **Extraer**: lista completa de agentes por categoría, nombre y descripción de cada uno.

> **WebFetch 3**: `https://aitmpl.com/agents`
> **Extraer**: agentes disponibles con nombre y descripción.

**Fallback si WebFetch 1 falla**: Continuar marcando sugerencias con ⚠️ sin doc oficial.
**Fallback si WebFetch 2 o 3 fallan**: Mostrar en Paso 4 solo las URLs del marketplace como referencia, sin sugerir agentes concretos.

---

## Paso 1 — Detectar agentes instalados y stack del proyecto

Una sola llamada Bash para minimizar confirmaciones:

```bash
{
  echo "=== AGENTES GLOBAL ==="
  ls ~/.claude/agents/ 2>/dev/null || echo "(vacío)"

  echo "=== AGENTES PROYECTO ==="
  ls .claude/agents/ 2>/dev/null || echo "(vacío)"

  echo "=== STACK ==="
  ls package.json composer.json pyproject.toml go.mod Cargo.toml pom.xml 2>/dev/null
  cat package.json 2>/dev/null | head -10
  cat composer.json 2>/dev/null | head -8

  echo "=== ENV AGENT TEAMS ==="
  echo "${CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS:-no-definida}"
} 2>/dev/null
```

**Extraer**:
- **Agentes global**: lista de ficheros `.md` en `~/.claude/agents/`
- **Agentes proyecto**: lista de ficheros `.md` en `.claude/agents/`
- **Stack**: lenguajes, frameworks, DBs detectados
- **Agent Teams**: si está activo el experimental flag

---

## Paso 1b — Leer contenido de cada agente

Para cada fichero `.md` detectado, leerlo con la herramienta Read y extraer:

- `name` del frontmatter
- `description` del frontmatter
- `tools` del frontmatter
- `model` del frontmatter
- `permissionMode` del frontmatter
- `maxTurns` del frontmatter
- Cualquier otro campo relevante

Si un agente no tiene frontmatter delimitado por `---`, marcarlo como sin estructura válida.

---

## Paso 2 — Analizar y puntuar cada agente

Cada agente parte de **10 puntos** y se penaliza según:

### Criterios de scoring

| Criterio | Penalización | Severidad |
|----------|-------------|-----------|
| Sin campo `name` en frontmatter | -4 pts | ❌ Crítico |
| Sin campo `description` en frontmatter | -4 pts | ❌ Crítico |
| `description` demasiado vaga (< 30 chars, sin contexto de invocación) | -3 pts | ❌ Crítico |
| `tools` inválidos o inexistentes (no corresponden a herramientas reales de Claude Code) | -3 pts | ❌ Crítico |
| Sin frontmatter delimitado por `---` | -4 pts | ❌ Crítico |
| Sin campo `tools` (Claude usará todas las herramientas — riesgo de seguridad) | -2 pts | ⚠️ Mejorable |
| Sin campo `model` (Claude usará el modelo por defecto — puede ser subóptimo) | -1 pt | ℹ️ Revisable |
| `description` sin ejemplos de cuándo invocar al agente | -1 pt | ℹ️ Revisable |
| Agente redundante: misma funcionalidad que otro ya instalado | -2 pts | ⚠️ Mejorable |
| Agente relevante para el stack pero no instalado | -1 pt (global) | ℹ️ Oportunidad |

### Niveles de calidad

| Puntos | Nivel | Descripción |
|--------|-------|-------------|
| 9–10 | 👑 Guerrero de Gondor | Agente perfectamente forjado |
| 7–8 | ⚔️ Soldado experimentado | Solo mejoras menores |
| 5–6 | 🗡️ Recluta | Necesita entrenamiento |
| < 5 | 💀 Caído en combate | Requiere refuerzo urgente |

### Score global

```
Score global = media de puntuaciones individuales (redondeado a 1 decimal)
```

---

## Paso 3 — Generar informe con scoring

```
══════════════════════════════════════════════════════════════
👑  ARAGORN — Inspección del Ejército
══════════════════════════════════════════════════════════════

📦 STACK DETECTADO
──────────────────────────────────────────────────────────────
  PHP/Symfony · TypeScript · PostgreSQL

⚔️  AGENTES INSTALADOS
──────────────────────────────────────────────────────────────
  🌍 Global (~/.claude/agents/):
    👑 10/10  code-reviewer     — name ✅ · description clara ✅ · tools ✅
    ⚔️  7/10  symfony-expert    — name ✅ · description corta ⚠️ · tools ✅
    💀  3/10  old-agent         — sin frontmatter ❌ · sin description ❌

  📁 Proyecto (.claude/agents/):
    ⚔️  8/10  deploy-guardian   — name ✅ · sin tools ⚠️ · sin model ℹ️

══════════════════════════════════════════════════════════════
📊 Score global: 7.0/10 ⚔️ — 4 agentes · 1 👑 · 2 ⚔️ · 1 💀
══════════════════════════════════════════════════════════════
```

---

## Paso 4 — Agentes recomendados no instalados

Usando los datos obtenidos vía WebFetch en el Paso 0 (VoltAgent + aitmpl.com),
cruzar el stack detectado con los agentes disponibles en los marketplaces.

**CRÍTICO**: Los nombres y descripciones de los agentes recomendados deben extraerse
del contenido real de los WebFetch. No hardcodear nombres de agentes.

**Proceso de matching**:
1. Para cada tecnología detectada en el stack (PHP, Symfony, TypeScript, Playwright, etc.)
2. Buscar en los datos de VoltAgent y aitmpl.com agentes cuyo nombre o descripción
   mencione esa tecnología o su dominio (testing, devops, backend, etc.)
3. Excluir los agentes ya instalados (comparar con la lista del Paso 1)
4. Ordenar por relevancia al stack

Mostrar resultado:

```
💡 OPORTUNIDADES PARA TU STACK
──────────────────────────────────────────────────────────────
  Stack: PHP/Symfony · TypeScript · PostgreSQL

  📦 VoltAgent:
    • [nombre real del marketplace] — [descripción real del marketplace]
    • [nombre real del marketplace] — [descripción real del marketplace]

  🤖 aitmpl.com:
    • [nombre real del marketplace] — [descripción real del marketplace]
──────────────────────────────────────────────────────────────
```

**Si el WebFetch del marketplace falló** (fallback):

```
💡 OPORTUNIDADES PARA TU STACK
──────────────────────────────────────────────────────────────
  ⚠️  No se pudo consultar los marketplaces en tiempo real.
      Explóralos directamente para encontrar agentes para tu stack:

  📦 VoltAgent:  https://github.com/VoltAgent/awesome-claude-code-subagents
  🤖 aitmpl.com: https://aitmpl.com/agents
──────────────────────────────────────────────────────────────
```

**Si no hay matches tras el cruce**:

```
💡 Tu stack no tiene coincidencias directas en los marketplaces
   o ya tienes instalados los agentes más relevantes.
   Explora el catálogo completo en "Buscar e instalar desde marketplaces".
```

---

## Paso 5 — Lista de mejoras priorizadas

Construir lista ordenada por severidad:
1. ❌ Críticos primero
2. ⚠️ Mejorables después
3. ℹ️ Oportunidades al final

Mostrar total: `X mejoras encontradas (Y ❌ críticas · Z ⚠️ mejorables · W ℹ️ oportunidades)`

---

## Paso 6 — Opciones al usuario

```json
{
  "questions": [{
    "header": "Tras la inspección",
    "question": "👑 ¿Cuál es tu siguiente orden?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔧 Revisar y aplicar mejoras una a una",
        "description": ""
      },
      {
        "label": "🏪 Buscar e instalar agentes recomendados",
        "description": "Solo si se detectaron oportunidades"
      },
      {
        "label": "🔙 Volver al menú de Aragorn",
        "description": ""
      }
    ]
  }]
}
```

> **Nota**: la opción de instalar recomendados solo aparece si se detectaron oportunidades en el Paso 4.

---

## Paso 7 — Revisor uno a uno

Iterar por cada mejora de la lista del Paso 5, **en orden de severidad** (❌ primero, ⚠️ después, ℹ️ al final).

**Soluciones concretas por tipo de problema**:

| Problema detectado | Solución propuesta |
|--------------------|--------------------|
| Sin frontmatter | Mostrar estructura mínima correcta + proponer añadirla |
| Sin `name` | Proponer nombre basado en el fichero |
| Sin `description` o vaga | Proponer description detallada con ejemplos de cuándo invocar |
| Sin `tools` | Sugerir lista mínima según el tipo de agente |
| `tools` inválidos | Mostrar valor actual + lista de tools válidos de las docs |
| Description sin cuándo invocar | Proponer versión mejorada con ejemplos de triggers |

**Mostrar para cada mejora**:

```
👑 MEJORA [X/N] — [❌/⚠️/ℹ️] [SEVERIDAD]
══════════════════════════════════════════════════════════════

📍 Agente afectado: [nombre] ([ruta completa])

❌ Problema:
   [descripción clara del problema detectado]

✅ Solución propuesta:
   [qué se aplicaría exactamente — incluir frontmatter o contenido si aplica]

🎯 Resultado esperado:
   [qué mejorará — ej: "Claude lo invocará automáticamente en contexto PHP"]

══════════════════════════════════════════════════════════════
```

**AskUserQuestion por cada mejora**:

```json
{
  "questions": [{
    "header": "Mejora [X/N]",
    "question": "👑 ¿Qué hacemos con este guerrero?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aplicar",
        "description": "Aragorn aplicará esta mejora ahora"
      },
      {
        "label": "✏️ Modificar propuesta",
        "description": "Ajustar la solución antes de aplicar"
      },
      {
        "label": "⏭️ Saltar",
        "description": "Dejar sin cambios y pasar al siguiente"
      },
      {
        "label": "🚫 Cancelar todo",
        "description": "Abortar el revisor y ver resumen parcial"
      }
    ]
  }]
}
```

**Comportamiento por opción**:

- **✅ Aplicar**: Ejecutar el cambio (Edit/Write). Confirmar con frase épica variada:
  - *"👑 El guerrero ha sido forjado de nuevo."*
  - *"👑 Gondor aprueba. El ejército es más fuerte."*
  - *"👑 Un soldado más listo para la batalla."*
  - *"👑 Bien. Sauron no sobreviviría a este ejército."*
  - Luego pasar a la siguiente mejora.
- **✏️ Modificar propuesta**: Preguntar qué cambiar. Mostrar propuesta actualizada y confirmar antes de aplicar.
- **⏭️ Saltar**: `👑 "Este guerrero puede esperar su entrenamiento..."` y pasar al siguiente.
- **🚫 Cancelar todo**: Saltar al resumen final (Paso 7b).

**IMPORTANTE**: Antes de aplicar cualquier cambio, indicar siempre la ruta exacta del archivo que se modificará.

### Paso 7b — Resumen final del revisor

```
📋 RESUMEN DEL EJÉRCITO
══════════════════════════════════════════════════════════════
  ✅ Aplicadas:   [X]
  ✏️  Modificadas: [X]
  ⏭️  Saltadas:    [X]
══════════════════════════════════════════════════════════════
👑  "El ejército está listo. Gondor resistirá."
```

AskUserQuestion con opciones de continuación:
- `🔙 Volver al menú de Aragorn`
- `🔙 Volver a La Comunidad del Código`

---

## Casos especiales

### Sin agentes instalados

```
👑 Los campamentos están vacíos, señor.

   No se encontraron agentes en ningún scope.

   Rutas verificadas:
     • ~/.claude/agents/ (global)
     • .claude/agents/ (proyecto)

💡 Usa "Buscar e instalar desde marketplaces" o "Crear un agente asistido"
   para reclutar tu primer guerrero.
```

### Arsenal perfecto

```
👑 Los heraldos inspeccionan el ejército...

✅ Todos los agentes están correctamente forjados.
   Sauron no tiene ninguna posibilidad, señor.

Score global: 10/10 👑 — todos en estado Guerrero de Gondor
```

---

## 🔗 Fuentes

Ver índice completo en `@prompts/docs-sources.md`:
- Sub-agents: `https://code.claude.com/docs/en/sub-agents`
- VoltAgent:  `https://github.com/VoltAgent/awesome-claude-code-subagents`
- aitmpl.com: `https://aitmpl.com/agents`

---

**Módulo**: `00-module-analyze.md`
**Invocado desde**: `aragorn-main.md` (opción "Inspeccionar arsenal de agentes")
**Requiere**: WebFetch on-demand, Read, Bash, Glob, Edit/Write (para aplicar mejoras)
