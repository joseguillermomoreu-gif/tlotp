# 🗺️ Módulo: Consultar al Contrabandista — Guía Interactiva de MCPs y Plugins

## Misión

Analizar el arsenal actual del usuario y guiarle de forma interactiva sobre cómo
sacar el máximo partido a sus MCPs y plugins instalados, con ejemplos reales
basados en el stack detectado del proyecto.

---

## Paso 0 — Documentación oficial (on-the-fly)

**IMPORTANTE**: Comprobar primero si la documentación ya está en el contexto de esta sesión.

**Si ya está en contexto**: usar directamente sin re-fetchear.

**Si no está en contexto**, hacer WebFetch:

> **WebFetch 1**: `https://code.claude.com/docs/en/mcp`
> **Extraer**: qué herramientas expone cada tipo de MCP, cómo invocarlas, casos de uso reales.

> **WebFetch 2**: `https://code.claude.com/docs/en/plugins`
> **Extraer**: qué capacidades añade cada tipo de plugin, cómo configurarlos, ejemplos de uso.

> **WebFetch 3**: `https://code.claude.com/docs/en/discover-plugins`
> **Extraer**: catálogo de plugins disponibles, descripciones, compatibilidad.

**Fallback si WebFetch falla**: NO usar conocimiento interno. Mostrar:
```
⚠️ No se pudo cargar la documentación oficial en este momento.
   Las explicaciones requieren las docs oficiales de Claude Code.

   Puedes consultarlas directamente:
     🔗 MCP:              https://code.claude.com/docs/en/mcp
     🔌 Plugins:          https://code.claude.com/docs/en/plugins
     🔍 Discover plugins: https://code.claude.com/docs/en/discover-plugins
```
→ Ofrecer AskUserQuestion: reintentar WebFetch / volver al menú.

---

## Paso 1 — Leer arsenal actual

```bash
{
  echo "=== MCP USER ==="
  cat ~/.claude.json 2>/dev/null || echo "{}"
  echo "=== MCP PROJECT ==="
  cat .mcp.json 2>/dev/null || echo "{}"
  echo "=== SETTINGS ==="
  cat .claude/settings.json 2>/dev/null || echo "{}"
  cat ~/.claude/settings.json 2>/dev/null || echo "{}"
} 2>/dev/null
```

Extraer lista de MCPs y plugins instalados. Detectar también el stack del proyecto
(reutilizar si ya está en contexto del análisis previo).

---

## Paso 2 — Mostrar resumen del arsenal

```
══════════════════════════════════════════════════════════════
🗺️  BARDO — Tu Arsenal de Lake-town
══════════════════════════════════════════════════════════════

🔗 MCPs instalados (3):
   • github-copilot  [user scope]
   • sentry          [user scope]
   • db-explorer     [project scope]

🔌 Plugins instalados (1):
   • git-lens

📦 Stack detectado: PHP/Symfony · TypeScript · PostgreSQL

══════════════════════════════════════════════════════════════
🏹 "Conozco cada flecha de tu carcaj. Pregúntame lo que necesites."
```

---

## Paso 3 — Explicar diferencias MCP vs Plugin (si no se mostró antes)

Si el usuario llegó aquí directamente sin haber visto la intro de bardo-main.md,
mostrar brevemente:

```
💡 Recordatorio rápido:

   🔗 MCP    → servidor externo que expone herramientas a Claude
               (GitHub, Sentry, DBs, APIs externas)

   🔌 Plugin → extensión local de Claude Code, sin servidor externo
               (integración directa, más ligero)
```

---

## Paso 4 — Menú interactivo (generado dinámicamente)

Generar las opciones a partir de los MCPs y plugins detectados.
Si hay más de 2 ítems, paginar (máx 4 opciones por pantalla incluyendo "Ver más" y "Volver").

```json
{
  "questions": [{
    "header": "Consultar al Contrabandista",
    "question": "🏹 ¿Sobre qué flecha quieres saber más?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔗 Cómo usar [nombre-mcp]",
        "description": "Herramientas que expone, comandos, ejemplos con tu stack"
      },
      {
        "label": "🔌 Cómo usar [nombre-plugin]",
        "description": "Qué añade, cómo configurarlo, ejemplos con tu stack"
      },
      {
        "label": "💡 ¿Qué más debería instalar para mi stack?",
        "description": ""
      },
      {
        "label": "🔙 Volver al menú principal",
        "description": ""
      }
    ]
  }]
}
```

> **Generación dinámica**: cada MCP/plugin instalado genera una opción propia.
> Si hay 0 ítems, mostrar directamente la opción "¿Qué debería instalar?" + "Volver".

---

## Paso 5 — Asistencia en profundidad

**CRÍTICO**: Todo el contenido de las explicaciones debe extraerse de la documentación oficial
cargada en el Paso 0 (WebFetch). No generar descripciones, capacidades ni ejemplos desde
conocimiento interno — usar exclusivamente lo obtenido de las docs oficiales de Claude Code.

Para cada ítem seleccionado, presentar:

### Si es un MCP

```
══════════════════════════════════════════════════════════════
🔗 [NOMBRE DEL MCP]
══════════════════════════════════════════════════════════════

📋 Qué es:
   [descripción en 2-3 líneas extraída de docs oficiales]

🛠️  Herramientas que expone a Claude:
   • [herramienta 1] — [para qué sirve]
   • [herramienta 2] — [para qué sirve]
   ...

💡 Ejemplos con tu stack ([stack detectado]):
   • "Oye Claude, abre el issue #42 en GitHub y asígnalo a mí"
   • "Muéstrame los errores de Sentry de las últimas 2 horas"
   • [ejemplos concretos según el MCP y el stack real]

⚙️  Scope actual: [user / project]
   [explicar si es el scope recomendado para este MCP]

🔗 Cómo combinarlo con otros MCPs/plugins que tienes:
   • Con [otro-mcp-instalado]: [sinergia concreta]

══════════════════════════════════════════════════════════════
```

### Si es un Plugin

```
══════════════════════════════════════════════════════════════
🔌 [NOMBRE DEL PLUGIN]
══════════════════════════════════════════════════════════════

📋 Qué añade a Claude Code:
   [descripción en 2-3 líneas extraída de docs oficiales]

🛠️  Capacidades nuevas:
   • [capacidad 1]
   • [capacidad 2]
   ...

💡 Ejemplos con tu stack ([stack detectado]):
   • [ejemplo concreto 1]
   • [ejemplo concreto 2]

⚙️  Configuración recomendada:
   [si hay opciones de configuración, mostrarlas]

══════════════════════════════════════════════════════════════
```

### Si elige "¿Qué más debería instalar?"

Basado en el stack y los MCPs/plugins ya instalados, recomendar:

```
🏹 Para tu stack ([stack detectado]) te recomendaría:

🔗 MCPs que no tienes:
   • [nombre] — [por qué es útil para tu stack]
   • [nombre] — [por qué es útil para tu stack]

🔌 Plugins que no tienes:
   • [nombre] — [por qué es útil para tu stack]

💡 Usa "Conseguir un MCP/plugin en el mercado" para instalarlos.
```

---

## Paso 6 — Loop de vuelta al Paso 4

Tras cada explicación, volver automáticamente al menú del Paso 4 para que el usuario
pueda consultar otro ítem o salir.

---

## Casos especiales

### Sin MCPs ni plugins instalados

```
🏹 Tu carcaj está vacío, viajero.

   No tienes MCPs ni plugins instalados aún.

   💡 Usa "Conseguir un MCP" o "Conseguir un plugin"
      para equipar tu arsenal de Lake-town.
```

Ofrecer AskUserQuestion:
- `🔗 Conseguir un MCP ahora`
- `🔌 Conseguir un plugin ahora`
- `🔙 Volver al menú principal`

---

## 🔗 Fuentes

Ver índice completo en `@prompts/docs-sources.md`:
- MCP: `https://code.claude.com/docs/en/mcp`
- Plugins: `https://code.claude.com/docs/en/plugins`
- Discover plugins: `https://code.claude.com/docs/en/discover-plugins`

---

**Módulo**: `01-module-guide.md`
**Invocado desde**: `bardo-main.md` (opción "Consultar al Contrabandista")
**Reemplaza**: `08-el-trovador.md`
**Requiere**: WebFetch on-demand, Read, Bash
