# 🏪 Módulo: Buscar e Instalar desde Marketplaces

## Misión

Buscar agentes en los marketplaces oficiales (VoltAgent + aitmpl.com) en tiempo real
y guiar al usuario para instalarlos con scope correcto y verificación post-instalación.

---

## Paso 0 — Mostrar agentes ya instalados

Una sola llamada Bash para obtener el estado actual:

```bash
{
  echo "=== GLOBAL ==="
  ls ~/.claude/agents/ 2>/dev/null || echo "(vacío)"
  echo "=== PROYECTO ==="
  ls .claude/agents/ 2>/dev/null || echo "(vacío)"
} 2>/dev/null
```

Mostrar resumen compacto:

```
⚔️  Agentes ya instalados:
  🌍 Global:   code-reviewer, symfony-expert
  📁 Proyecto: deploy-guardian

Esta referencia se usará para detectar duplicados.
```

Si no hay ninguno: `"👑 Los campamentos están vacíos — esta será tu primera recluta."`

---

## Paso 1 — Elegir tipo de componente a instalar

Preguntar con AskUserQuestion:

```json
{
  "questions": [{
    "header": "Buscar en marketplaces",
    "question": "🏪 ¿Qué quieres reclutar del mercado?",
    "multiSelect": false,
    "options": [
      {
        "label": "🤖 Agentes — VoltAgent + aitmpl.com",
        "description": "Guerreros especializados: code-reviewer, symfony-expert, playwright-agent..."
      },
      {
        "label": "⚡ Commands — Slash commands de aitmpl.com",
        "description": "Poderes invocables: /run-tests, /ci-status, /db-migrate..."
      },
      {
        "label": "🔙 Volver al menú de Aragorn",
        "description": ""
      }
    ]
  }]
}
```

### Llegada directa con lista pre-cargada (desde análisis)

Si se llega con agentes recomendados pre-cargados, mostrar directamente:

```
👑 Aragorn tiene guerreros recomendados para tu stack:
   [nombre] — [descripción]
```

Y ofrecer selección directa antes de ir al catálogo completo.

### Sub-menú Agentes

Preguntar con AskUserQuestion:

```json
{
  "questions": [{
    "header": "Buscar agente",
    "question": "🤖 ¿Cómo quieres buscar?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔍 Ver catálogo completo (VoltAgent + aitmpl.com)",
        "description": "Aragorn consultará ambos marketplaces en tiempo real"
      },
      {
        "label": "🏷️  Buscar por categoría o tecnología",
        "description": "Filtrar por PHP, TypeScript, testing, devops..."
      },
      {
        "label": "✍️  Escribir el nombre del agente",
        "description": ""
      },
      {
        "label": "🔙 Volver",
        "description": ""
      }
    ]
  }]
}
```

### Sub-menú Commands

Preguntar con AskUserQuestion:

```json
{
  "questions": [{
    "header": "Buscar command",
    "question": "⚡ ¿Qué command buscas?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔍 Ver catálogo de commands (aitmpl.com)",
        "description": "Aragorn consultará aitmpl.com en tiempo real"
      },
      {
        "label": "✍️  Escribir el nombre del command",
        "description": ""
      },
      {
        "label": "🔙 Volver",
        "description": ""
      }
    ]
  }]
}
```

Los commands se instalan en `.claude/commands/[nombre].md` (proyecto) o `~/.claude/commands/[nombre].md` (global).
Los hooks se gestionan vía Palantír — si el usuario quiere instalar un hook, redirigir a `@prompts/palantir/palantir-main.md`.

---

## Paso 2 — Consultar marketplaces (WebFetch)

**IMPORTANTE**: Comprobar primero si los datos ya están en el contexto de la sesión.

**Si ya están en contexto**: usar directamente sin re-fetchear.

**Si no están en contexto**, hacer WebFetch en paralelo:

> **WebFetch 1**: `https://raw.githubusercontent.com/VoltAgent/awesome-claude-code-subagents/main/README.md`
> **Extraer**: lista completa de agentes por categoría, nombre, descripción, enlace al fichero raw.

> **WebFetch 2**: `https://aitmpl.com/agents`
> **Extraer**: agentes disponibles con nombre y descripción.

**Fallback si WebFetch falla**:

```
⚠️  No se pudo contactar con el marketplace.

Puedes consultarlo directamente:
  📦 VoltAgent:  https://github.com/VoltAgent/awesome-claude-code-subagents
  🤖 aitmpl.com: https://aitmpl.com/agents
```

---

## Paso 3 — Mostrar catálogo / resultados

Usando la información obtenida vía WebFetch, mostrar agentes disponibles.
Marcar con ✅ los ya instalados:

```
══════════════════════════════════════════════════════════════
🏪 Agentes disponibles
══════════════════════════════════════════════════════════════

📦 VoltAgent (X encontrados):
──────────────────────────────────────────────────────────────
  1. code-reviewer
     📝 [descripción oficial]
     🏷️  code-quality
     ✅ YA INSTALADO

  2. phpunit-generator
     📝 [descripción oficial]
     🏷️  testing

aitmpl.com (X encontrados):
──────────────────────────────────────────────────────────────
  1. behat-writer
     📝 [descripción oficial]
     🏷️  testing

══════════════════════════════════════════════════════════════
```

Si no hay resultados para el filtro aplicado:

```
👑 Los mercados no tienen guerreros con ese perfil todavía.
   Prueba con otra búsqueda o consulta el catálogo completo.
```

---

## Paso 4 — Seleccionar agente a instalar

**Si el agente ya está instalado**: avisar y preguntar si reinstalar/actualizar o elegir otro.

**Si no está instalado**, confirmar con AskUserQuestion:

```json
{
  "questions": [{
    "header": "Reclutar agente",
    "question": "⚔️  ¿Confirmas el reclutamiento de \"[nombre]\"?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Sí, reclutar",
        "description": "[descripción breve del agente]"
      },
      {
        "label": "📄 Ver fichero completo antes de decidir",
        "description": ""
      },
      {
        "label": "🔍 Elegir otro",
        "description": "Volver al catálogo"
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

## Paso 5 — Elegir scope

```json
{
  "questions": [{
    "header": "Scope de instalación",
    "question": "👑 ¿Dónde instalar a este guerrero?",
    "multiSelect": false,
    "options": [
      {
        "label": "🌍 Global (~/.claude/agents/)",
        "description": "Disponible en todos tus proyectos"
      },
      {
        "label": "📁 Proyecto (.claude/agents/)",
        "description": "Solo en este repositorio"
      }
    ]
  }]
}
```

---

## Paso 6 — Descargar e instalar

### Desde VoltAgent

Construir URL raw del fichero `.md`:

```
WebFetch: https://raw.githubusercontent.com/VoltAgent/awesome-claude-code-subagents/main/agents/[categoria]/[nombre].md
```

Si no se conoce la ruta exacta, buscar en el README de VoltAgent la referencia al agente.

### Desde aitmpl.com

```
WebFetch: https://aitmpl.com/api/agents/[nombre]
```

Fallback — indicar al usuario:
```bash
npx claude-code-templates@latest add agent [nombre]
```

### Verificar conflicto de nombre

Antes de escribir, comprobar si ya existe:

```bash
ls ~/.claude/agents/[nombre].md 2>/dev/null
ls .claude/agents/[nombre].md 2>/dev/null
```

Si existe, preguntar (AskUserQuestion):
- 🔄 Sobreescribir — instalar la versión del marketplace
- 📋 Ver diferencias — mostrar ambos contenidos
- ❌ Cancelar

### Crear directorio si no existe

```bash
mkdir -p ~/.claude/agents/
# o
mkdir -p .claude/agents/
```

Escribir el fichero `.md` con el contenido descargado usando Write.

---

## Paso 7 — Confirmación post-instalación

```
══════════════════════════════════════════════════════════════
✅ RECLUTAMIENTO COMPLETADO
══════════════════════════════════════════════════════════════

  Nombre:   [nombre]
  Scope:    🌍 Global / 📁 Proyecto
  Fichero:  [ruta completa]
  Fuente:   VoltAgent / aitmpl.com

══════════════════════════════════════════════════════════════
👑 "Un guerrero más bajo el estandarte del Rey.
    Sauron lo notará en el próximo asalto."
```

---

## Paso 8 — Acciones posteriores

```json
{
  "questions": [{
    "header": "Guerrero reclutado",
    "question": "👑 ¿Cuál es tu siguiente orden?",
    "multiSelect": false,
    "options": [
      {
        "label": "⚔️  Instalar otro agente",
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
- VoltAgent: `https://github.com/VoltAgent/awesome-claude-code-subagents`
- aitmpl.com: `https://aitmpl.com/agents`

---

**Módulo**: `01-module-marketplace.md`
**Invocado desde**: `aragorn-main.md` (opción "Buscar e instalar desde marketplaces")
**Reemplaza**: `ar3-buscar-agentes.md` + `ar5-instalar-agente.md`
**Requiere**: WebFetch on-demand, Read, Bash, Write
