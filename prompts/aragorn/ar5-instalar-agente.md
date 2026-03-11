# 👑 AR5 - El Reclutamiento del Ejército: Instalar Agente

## Intro de ejecución

```
👑 Aragorn prepara los contratos de reclutamiento...
   Cada guerrero que se une al ejército debe ser verificado antes de jurar lealtad.
```

---

## Paso 1 — Obtener agente a instalar

Si vienes de AR3 o AR4 con un agente pre-seleccionado: usar ese agente directamente.

Si el usuario llega directo desde el menú, preguntar (AskUserQuestion):
- Ver recomendaciones primero (ir a AR4)
- Buscar en marketplaces (ir a AR3)
- Escribir el nombre del agente manualmente

---

## Paso 2 — Preguntar scope

**Usar AskUserQuestion**:

```
⚔️  Reclutando: [nombre-del-agente]
    Fuente: [VoltAgent / aitmpl.com]

    📝 [descripción del agente]

    ¿Dónde quieres instalarlo?
```

Opciones:
- **🌍 Global** (`~/.claude/agents/`) — disponible en todos tus proyectos
- **📁 Proyecto** (`.claude/agents/`) — solo en este proyecto

---

## Paso 3 — Descargar el agente

### Desde VoltAgent (GitHub raw)

Construir la URL del raw del fichero `.md`:
```
WebFetch: https://raw.githubusercontent.com/VoltAgent/awesome-claude-code-subagents/main/agents/[categoria]/[nombre].md
```

Si la URL exacta no se conoce, buscar en el README de VoltAgent la referencia al agente.

### Desde aitmpl.com

Intentar WebFetch al fichero del agente:
```
WebFetch: https://aitmpl.com/api/agents/[nombre]
```

O indicar al usuario el comando alternativo:
```bash
npx claude-code-templates@latest add agent [nombre]
```

---

## Paso 4 — Mostrar preview y pedir confirmación

Antes de escribir nada, mostrar:

```
📄 PREVIEW DEL AGENTE
══════════════════════════════════════════════════════

Nombre:    symfony-expert
Destino:   ~/.claude/agents/symfony-expert.md
Fuente:    VoltAgent / 08-backend

--- Contenido del fichero ---
---
name: symfony-expert
description: |
  Experto en Symfony para análisis de bundles, services y Doctrine.
tools:
  - Read
  - Write
  - Bash
  - Grep
model: claude-sonnet-4-6
---
[contenido del fichero...]
══════════════════════════════════════════════════════
```

**Usar AskUserQuestion**:
- ✅ Instalar — escribir el fichero en el destino
- ✏️ Ver fichero completo — mostrar todo el contenido antes de decidir
- ❌ Cancelar

---

## Paso 5 — Verificar conflicto de nombre

Antes de escribir, comprobar si ya existe un agente con el mismo nombre:

```bash
ls ~/.claude/agents/[nombre].md 2>/dev/null
# o
ls .claude/agents/[nombre].md 2>/dev/null
```

Si existe, informar y preguntar (AskUserQuestion):
```
⚠️  Ya existe un agente llamado "[nombre]"
    Ubicación: ~/.claude/agents/[nombre].md

¿Qué hacer?
```
- 🔄 Sobreescribir — instalar la versión del marketplace
- 📋 Ver diferencias — mostrar ambos contenidos
- ❌ Cancelar

---

## Paso 6 — Instalar el agente

Crear el directorio si no existe:

```bash
mkdir -p ~/.claude/agents/
# o
mkdir -p .claude/agents/
```

Escribir el fichero `.md` con el contenido descargado usando la herramienta Write.

---

## Paso 7 — Confirmar instalación

```
✅ RECLUTAMIENTO COMPLETADO
══════════════════════════════════════════════════════

  symfony-expert instalado correctamente
  📍 Ubicación: ~/.claude/agents/symfony-expert.md
  🌍 Scope: Global (disponible en todos tus proyectos)

  El agente estará disponible en tu próxima sesión de Claude Code.

  💡 Cómo usarlo:
     • Automático: Claude lo invocará cuando detecte tareas de Symfony
     • Explícito: "@symfony-expert [tu tarea]"
══════════════════════════════════════════════════════
```

**Usar AskUserQuestion**:
- Verificar instalación (ir a AR6)
- Instalar otro agente (volver al Paso 1)
- Volver al menú de Aragorn
- Salir
