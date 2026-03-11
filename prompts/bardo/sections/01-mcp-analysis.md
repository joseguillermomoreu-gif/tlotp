## Opción 1 — Analizar MCPs configurados

### Intro de ejecución

Antes de leer nada, muestra este texto al usuario:

```
🏹 Bardo se adentra en los canales del Fuerte...
   Comprobando qué conexiones están abiertas hacia el exterior.
```

### Paso 1 — Leer scope user/local (~/.claude.json)

Ejecuta:
```bash
cat ~/.claude.json 2>/dev/null || echo "{}"
```

Del JSON resultante extrae la clave `mcpServers` del nivel raíz.
Esos son los MCPs en scope **user** (disponibles en todos los proyectos).

Si no existe el archivo o la clave está vacía: anota "0 MCPs en scope user".

### Paso 2 — Leer scope project (.mcp.json)

Ejecuta:
```bash
cat .mcp.json 2>/dev/null || echo "{}"
```

Del JSON resultante extrae la clave `mcpServers`.
Esos son los MCPs en scope **project** (específicos de este repositorio).

Si no existe el archivo o la clave está vacía: anota "0 MCPs en scope project".

### Paso 3 — Construir el inventario

Para cada MCP encontrado, extrae y muestra:
- **Nombre**: la clave del objeto
- **Transport**: campo `type` dentro de la config (`http`, `sse`, `stdio`)
  - Si no hay campo `type`, inferir: si hay campo `command` → `stdio`; si hay `url` → `http`
- **Scope**: de dónde viene (`user` o `project`)
- **Estado**: usa estas reglas:
  - `stdio`: muestra el comando. Si el binario del comando no existe en PATH → ⚠️ binario no encontrado
  - `http` / `sse`: marca como ✅ configurado. Añade nota "(verifica con `/mcp` si necesita OAuth)"
- **URL o comando**: el valor de `url` o `command` según corresponda

### Paso 4 — Mostrar resultado

Formatea el output así:

```
🏹 Inventario de canales abiertos:

📁 Scope: project  (.mcp.json)
  ✅ github       [http]   → https://api.githubcopilot.com/mcp/
  ✅ sentry       [http]   → https://mcp.sentry.dev/mcp

👤 Scope: user  (~/.claude.json)
  ✅ postgresql   [stdio]  → npx @bytebase/dbhub
  ⚠️  slack        [http]   → https://mcp.slack.com/mcp
                             (verifica con `/mcp` si necesita OAuth)

📊 Total: 4 MCPs  |  project: 2  |  user: 2
```

Si no hay ningún MCP configurado en ningún scope:

```
🏹 El Fuerte no tiene canales abiertos hacia el exterior todavía.
   Usa la opción 4 para consultar el marketplace y la opción 6 para instalar.
```

### Paso 5 — Volver al menú

Tras mostrar el inventario, pregunta al usuario (AskUserQuestion):
- Volver al menú de Bardo
- Salir

---

