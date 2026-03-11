## Opción 7 — Verificar instalaciones

### Intro de ejecución

```
🏹 Bardo sube a la atalaya del puerto...
   Inspeccionando que toda la mercancía llegó en buen estado.
```

### Paso 1 — Releer estado actual de MCPs

Ejecuta de nuevo (estado fresco, no desde sesión):

```bash
cat ~/.claude.json 2>/dev/null || echo "{}"
cat .mcp.json 2>/dev/null || echo "{}"
```

Para cada MCP encontrado, verifica según su transport:

**MCP tipo `stdio`**:
```bash
which [comando_del_mcp] 2>/dev/null || echo "NOT_FOUND"
```
- Comando encontrado en PATH → ✅
- No encontrado → ❌ con instrucción: *"Instala [paquete] con npm/pip/brew según corresponda"*

**MCP tipo `http` o `sse`**:
- Marca como ✅ configurado
- Añade nota ⚠️ si la URL es conocida por requerir OAuth:
  *"Ejecuta `/mcp` en tu próxima sesión para completar la autenticación"*
- Las URLs que requieren OAuth son las de servicios con login: github, sentry, slack, linear, notion, figma, asana, stripe, vercel, supabase, firebase, hubspot, atlassian

### Paso 2 — Releer estado actual de plugins

```bash
ls ~/.claude/plugins/ 2>/dev/null || echo ""
ls .claude/plugins/ 2>/dev/null || echo ""
cat ~/.claude/settings.json 2>/dev/null || echo "{}"
cat .claude/settings.json 2>/dev/null || echo "{}"
```

Para cada plugin encontrado:

**Plugin LSP** (termina en `-lsp`):
- Busca en `plugin.json` del plugin el binario que usa:
  ```bash
  cat ~/.claude/plugins/[nombre]/plugin.json 2>/dev/null
  ```
- Verifica si el binario LSP está en PATH:
  ```bash
  which [binario_lsp] 2>/dev/null || echo "NOT_FOUND"
  ```
- Binario encontrado → ✅
- No encontrado → ⚠️ con instrucción de instalación del binario (ej: `npm install -g intelephense` para php-lsp)

**Plugin de integración / workflow / output**:
- Aparece en directorio y no está en `disabled: true` → ✅ activo
- Aparece con `disabled: true` → ⏸️ desactivado (con nota: *"Activa con `/plugin enable [nombre]`"*)

### Paso 3 — Construir informe de semáforos

```
✅ Verificación del Puerto completada:

🔌 MCP Servers:

  ✅ github      [http]   → Configurado
                            ⚠️  Requiere OAuth → ejecuta /mcp para autenticar

  ✅ sentry      [http]   → Configurado
                            ⚠️  Requiere OAuth → ejecuta /mcp para autenticar

  ✅ postgresql  [stdio]  → Comando npx disponible en PATH

  ❌ slack       [http]   → Configurado pero URL no alcanzable
                            → Verifica tu conexión o revisa la URL en ~/.claude.json

🧩 Plugins:

  ✅ php-lsp         → intelephense encontrado en PATH (v1.12.4)
  ✅ typescript-lsp  → tsserver encontrado en PATH (v5.4.2)
  ⚠️  python-lsp     → pyright no encontrado en PATH
                        → Instala con: npm install -g pyright
  ⏸️  explanatory-output-style → Desactivado
                                  → Activa con: /plugin enable explanatory-output-style

════════════════════════════════════════
📊 MCPs: X/Y operativos  |  Plugins: A/B operativos
```

### Paso 4 — Cierre épico

Si todos los ítems están en ✅ (sin ❌ ni ⚠️):

```
🏹 "El Puerto está en perfecto estado, señor del Fuerte.
    Todos los canales abiertos, toda la mercancía intacta.
    Cuando me necesitéis de nuevo, ya sabéis dónde encontrarme."

    — Bardo el Contrabandista, despidiéndose en los muelles
```

Si hay ⚠️ o ❌:

```
🏹 "El cargamento llegó, pero hay algunos bultos que necesitan atención.
    Sigue las instrucciones de arriba y el Puerto quedará en orden."

    — Bardo el Contrabandista, señalando los problemas
```

### Paso 5 — Volver al menú

Pregunta al usuario (AskUserQuestion):
- Volver al menú de Bardo
- Salir

---

