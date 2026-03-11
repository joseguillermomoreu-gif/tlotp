## Opción 4 — Consultar marketplace en tiempo real

### Intro de ejecución

```
🏹 Bardo parte por los canales ocultos hacia los mercados exteriores...
   Trayendo información fresca. No confío en mapas viejos.
```

### Parte A — MCP Servers (WebFetch en tiempo real)

Ejecuta un WebFetch a la documentación oficial de MCP:

**URL**: `https://code.claude.com/docs/en/mcp.md`

Del contenido obtenido, extrae y presenta:
- La lista de MCP servers disponibles con sus nombres y descripciones
- El comando de instalación para cada uno (`claude mcp add ...`)
- Cualquier nota sobre autenticación requerida

Muestra el resultado así:

```
🌊 MCP Servers disponibles (fuente oficial — tiempo real):

  github        → Integración con GitHub: PRs, issues, code review
                  claude mcp add --transport http github https://api.githubcopilot.com/mcp/

  sentry        → Monitoreo de errores en producción
                  claude mcp add --transport http sentry https://mcp.sentry.dev/mcp

  postgresql    → Consultas directas a bases de datos PostgreSQL
                  claude mcp add --transport stdio postgresql -- npx ...

  [... lista completa según la página oficial ...]
```

Si el WebFetch falla (sin conexión o URL cambiada):

```
⚠️  Bardo no pudo llegar a los mercados exteriores.
    Verifica tu conexión o consulta directamente:
    → https://code.claude.com/docs/en/mcp.md
```

### Parte B — Plugins (marketplace interactivo)

A diferencia de los MCPs, el catálogo de plugins **no tiene una página web estática**.
El marketplace oficial de plugins vive dentro del propio Claude Code.

Informa al usuario:

```
🧩 Plugins disponibles — Marketplace oficial de Claude Code:

  El catálogo de plugins se navega directamente en Claude Code.
  Para explorar y instalar plugins disponibles, ejecuta:

    /plugin

  Desde ahí puedes:
    → Pestaña "Discover": ver todos los plugins del marketplace oficial
    → Buscar por nombre o categoría
    → Instalar con un solo comando eligiendo el scope

  Plugins destacados del marketplace oficial:
    • php-lsp, typescript-lsp, python-lsp... → Code intelligence (LSP)
    • github, gitlab, slack, sentry...       → Integraciones externas
    • commit-commands, pr-review-toolkit...  → Workflow de desarrollo
```

### Parte C — Guardar en memoria de sesión

Guarda la lista de MCPs obtenida en memoria de sesión para que la Opción 5 pueda
hacer el matching con el stack sin necesidad de repetir el WebFetch.

### Paso final — Volver al menú

Tras mostrar ambas partes, pregunta al usuario (AskUserQuestion):
- Volver al menú de Bardo
- Ver recomendaciones ahora (ir a Opción 5)
- Salir

---

