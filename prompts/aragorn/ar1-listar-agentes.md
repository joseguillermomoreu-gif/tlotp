# 👑 AR1 - El Heraldo del Rey: Listar Agentes Instalados

## Intro de ejecución

```
👑 El Heraldo del Rey recorre los campamentos...
   Tomando nota de cada guerrero bajo el estandarte de Aragorn.
```

---

## Paso 1 — Detectar agentes en scope global

```bash
ls ~/.claude/agents/ 2>/dev/null || echo ""
```

Cada fichero `.md` es un agente instalado en scope **global** (disponible en todos los proyectos).

Si el directorio no existe o está vacío: anota "0 agentes en scope global".

---

## Paso 2 — Detectar agentes en scope proyecto

```bash
ls .claude/agents/ 2>/dev/null || echo ""
```

Cada fichero `.md` es un agente instalado en scope **proyecto** (solo en este repositorio).

Si el directorio no existe o está vacío: anota "0 agentes en scope proyecto".

---

## Paso 3 — Leer metadata de cada agente

Para cada fichero `.md` encontrado, leer su contenido y extraer el YAML frontmatter:

```bash
cat ~/.claude/agents/<nombre>.md 2>/dev/null
# o
cat .claude/agents/<nombre>.md 2>/dev/null
```

Del frontmatter YAML (delimitado por `---`) extraer:
- `name` — nombre del agente (si no existe, usar el nombre del fichero sin `.md`)
- `description` — para qué sirve
- `tools` — lista de herramientas permitidas
- `model` — modelo asignado (opcional)
- `permissionMode` — nivel de permisos (opcional)

---

## Paso 4 — Mostrar inventario

Formatea el output así:

```
👑 AGENTES INSTALADOS
═══════════════════════════════════════════════

🌍 Scope: global  (~/.claude/agents/) — 3 agentes
────────────────────────────────────────────────
  1. code-reviewer
     📝 Revisa código buscando bugs, security issues y mejoras de calidad
     🔧 Tools: Read, Grep, Glob
     🤖 Model: (por defecto)

  2. test-writer
     📝 Genera tests unitarios y E2E para el código indicado
     🔧 Tools: Read, Write, Bash
     🤖 Model: claude-sonnet-4-6

  3. symfony-expert
     📝 Experto en Symfony/PHP para análisis de bundles y services
     🔧 Tools: Read, Write, Bash, Grep
     🔐 Mode: acceptEdits

📁 Scope: proyecto  (.claude/agents/) — 1 agente
────────────────────────────────────────────────
  1. deploy-guardian
     📝 Supervisa deploys y verifica que los checks pasen antes de mergear
     🔧 Tools: Bash, Read

═══════════════════════════════════════════════
📊 Total: 4 agentes  |  global: 3  |  proyecto: 1
```

---

## Paso 5 — Caso sin agentes

Si no hay ningún agente instalado en ningún scope:

```
👑 Los campamentos están vacíos, señor.
   No hay agentes bajo tu estandarte todavía.

   → Opción 2: Buscar agentes en marketplaces
   → Opción 3: Instalar un agente
```

---

## Paso 6 — Volver al menú

Tras mostrar el inventario, pregunta al usuario (AskUserQuestion):
- Volver al menú de Aragorn
- Instalar un agente nuevo (ir a Opción 3)
- Salir
