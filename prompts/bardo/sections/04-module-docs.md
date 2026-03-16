# 📜 Módulo: Los Pergaminos del Arquero — Guía Completa MCPs y Plugins

## Misión

Proporcionar documentación oficial on-demand sobre MCPs y plugins de Claude Code,
en el nivel de detalle que el viajero necesite.

---

## Paso 1 — Elegir nivel de detalle

Mostrar con `AskUserQuestion`:

```json
{
  "questions": [{
    "header": "Los pergaminos del Arquero",
    "question": "🏹 ¿Cuánto tiempo tienes para estudiar el arsenal, viajero?",
    "multiSelect": false,
    "options": [
      {
        "label": "📖 El grimorio completo — Documentación íntegra",
        "description": ""
      },
      {
        "label": "⚡ El resumen del Arquero — 5 minutos",
        "description": ""
      },
      {
        "label": "🕐 La nota del Hobbit — 2 minutos",
        "description": ""
      },
      {
        "label": "🔙 Volver a Lake-town",
        "description": ""
      }
    ]
  }]
}
```

---

## Paso 2 — Obtener documentación (on-the-fly)

**IMPORTANTE**: Comprobar primero si la documentación ya está cargada en el contexto de esta sesión.

**Si ya está en contexto**: usar directamente sin re-fetchear.

**Si no está en contexto**, hacer WebFetch en este orden:

> **WebFetch 1**: `https://code.claude.com/docs/en/mcp`
> **Extraer**: protocolo MCP, scopes (user/project/local), transports (stdio/SSE/HTTP),
> estructura de configuración en ~/.claude.json y .mcp.json, autenticación, servidores populares.

> **WebFetch 2**: `https://code.claude.com/docs/en/plugins`
> **Extraer**: qué son los plugins, tipos, cómo instalarlos, diferencias con MCPs y skills.

> **WebFetch 3**: `https://code.claude.com/docs/en/discover-plugins`
> **Extraer**: catálogo oficial de plugins, cómo buscarlos, criterios de selección.

> **WebFetch 4**: `https://code.claude.com/docs/en/plugin-marketplaces`
> **Extraer**: marketplaces oficiales, URLs de instalación, proveedores.

**Fallback si WebFetch falla**:
```
⚠️ No se pudo cargar la documentación oficial en este momento.

Puedes consultarla directamente:
  🔗 MCP:               https://code.claude.com/docs/en/mcp
  🔌 Plugins:           https://code.claude.com/docs/en/plugins
  🔍 Discover plugins:  https://code.claude.com/docs/en/discover-plugins
  🏪 Marketplaces:      https://code.claude.com/docs/en/plugin-marketplaces
```

---

## Paso 3 — Generar resumen según nivel

**CRÍTICO**: Los resúmenes de los tres niveles deben construirse **exclusivamente** a partir
del contenido extraído por WebFetch en el Paso 2. No usar conocimiento interno para generar
el contenido. Si el WebFetch falló, mostrar solo el bloque de fallback del Paso 2 y no
intentar resumir desde conocimiento propio.

### 📖 El grimorio completo

Presentar el contenido completo extraído via WebFetch, organizado en capítulos con lore épico:

```
🏹 CAPÍTULO I — El Protocolo MCP: Servidores del Exterior
   [contenido completo sobre MCPs: qué son, scopes, transports, configuración, ejemplos]

🏹 CAPÍTULO II — Los Plugins: Extensiones del Arsenal
   [contenido completo sobre plugins: qué son, tipos, instalación, diferencias]

🏹 CAPÍTULO III — Descubrir Nuevas Flechas
   [catálogo, marketplaces, cómo buscar y evaluar]

🏹 CAPÍTULO IV — Patrones Avanzados
   [combinar MCPs + plugins, seguridad, best practices]
```

### ⚡ El resumen del Arquero (5 minutos)

Construir a partir del contenido de WebFetch. Incluir únicamente:
- Qué es un MCP y para qué sirve (2-3 líneas)
- Qué es un plugin y en qué se diferencia del MCP (2-3 líneas)
- Dónde se configuran los MCPs: `~/.claude.json` (user) y `.mcp.json` (project)
- Estructura mínima de configuración MCP (JSON de ejemplo)
- Los 3 MCPs más populares con descripción breve
- Cómo instalar un plugin (comando/pasos básicos)

### 🕐 La nota del Hobbit (2 minutos)

Construir a partir del contenido de WebFetch. Solo lo imprescindible:
- Una frase: qué es un MCP
- Una frase: qué es un plugin y cuándo elegir uno sobre el otro
- Dónde va la config MCP: `~/.claude.json` (global) / `.mcp.json` (proyecto)
- Cómo instalar: referencia rápida al método oficial

---

## Paso 4 — Presentar con lore

**Introducción** (mostrar antes del contenido):
```
📜 Los pergaminos de Lake-town están listos, viajero.
   Bardo comparte el conocimiento del Arquero.

══════════════════════════════════════════════════════════════
```

**Cierre** (mostrar al finalizar):
```
══════════════════════════════════════════════════════════════

🏹 "El conocimiento es la flecha más valiosa del carcaj.
    Úsalo bien en la Tierra Media."
```

Al finalizar, volver al menú principal de Bardo (sin repetir banner ni permisos).

---

## 🔗 Fuentes

Ver índice completo en `@prompts/docs-sources.md`:
- MCP: `https://code.claude.com/docs/en/mcp`
- Plugins: `https://code.claude.com/docs/en/plugins`
- Discover plugins: `https://code.claude.com/docs/en/discover-plugins`
- Plugin marketplaces: `https://code.claude.com/docs/en/plugin-marketplaces`

---

**Módulo**: `04-module-docs.md`
**Invocado desde**: `bardo-main.md` (opción "Los pergaminos del Arquero")
**Reemplaza**: partes de `08-el-trovador.md`
**Requiere**: WebFetch on-demand
