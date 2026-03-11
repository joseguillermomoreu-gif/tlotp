## Opción 2 — Analizar plugins instalados

### Intro de ejecución

Antes de leer nada, muestra este texto al usuario:

```
🏹 Bardo revisa los almacenes del Fuerte...
   Contando el arsenal de herramientas instaladas.
```

### Paso 1 — Leer plugins en scope user

Ejecuta:
```bash
ls ~/.claude/plugins/ 2>/dev/null || echo ""
```

Cada subdirectorio es un plugin instalado en scope **user**.

### Paso 2 — Leer plugins en scope project

Ejecuta:
```bash
ls .claude/plugins/ 2>/dev/null || echo ""
```

Cada subdirectorio es un plugin instalado en scope **project**.

### Paso 3 — Leer estado (activo/desactivado) desde settings

Ejecuta:
```bash
cat ~/.claude/settings.json 2>/dev/null || echo "{}"
```

Busca la clave `plugins` en el JSON. Cada entrada puede tener `"disabled": true`.
Si un plugin aparece con `disabled: true` → estado ⏸️ desactivado.
Si no aparece o `disabled` es false/ausente → estado ✅ activo.

También ejecuta para el proyecto:
```bash
cat .claude/settings.json 2>/dev/null || echo "{}"
```

### Paso 4 — Clasificar tipo de plugin

Para cada plugin encontrado, determina su tipo leyendo el nombre:
- Termina en `-lsp` o contiene `lsp` → **LSP** (language server)
- Nombres conocidos de integración (github, gitlab, slack, jira, linear, notion, figma, sentry, vercel, firebase, supabase, stripe, asana) → **integración**
- Contiene `output-style` → **output**
- Resto → **workflow**

Si existe el archivo `~/.claude/plugins/<nombre>/plugin.json` léelo para obtener la descripción real.

### Paso 5 — Mostrar resultado

Formatea el output así:

```
🏹 Inventario de almacenes del Fuerte:

👤 Scope: user  (~/.claude/plugins/)
  ✅ php-lsp              [LSP]         → PHP Language Server
  ✅ typescript-lsp       [LSP]         → TypeScript Language Server
  ✅ github               [integración] → GitHub MCP bundled
  ⏸️  explanatory-output-style  [output] → Desactivado

📁 Scope: project  (.claude/plugins/)
  ✅ sentry               [integración] → Error monitoring

📊 Total: 5 plugins  |  4 activos  |  1 desactivado
     LSPs: 2  |  Integraciones: 2  |  Output: 1
```

Si no hay ningún plugin instalado en ningún scope:

```
🏹 El Fuerte no tiene herramientas adicionales instaladas todavía.
   Usa la opción 4 para explorar el marketplace y la opción 6 para instalar.
```

### Paso 6 — Volver al menú

Tras mostrar el inventario, pregunta al usuario (AskUserQuestion):
- Volver al menú de Bardo
- Salir

---

