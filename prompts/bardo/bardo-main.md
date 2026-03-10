# 🏹 BARDO EL CONTRABANDISTA
## El Proveedor de Lake-town

---

## 🏹 Menú Principal

Muestra este banner y menú. Usa AskUserQuestion con las opciones numeradas:

```
════════════════════════════════════════════════════
🏹  BARDO EL CONTRABANDISTA  🏹
    El Proveedor de Lake-town
════════════════════════════════════════════════════
```

**Opciones** (usa AskUserQuestion con estas etiquetas exactas):

1. Analizar MCPs configurados
2. Analizar plugins instalados
3. Detectar stack tecnológico  *(próximamente — B3)*
4. Consultar marketplace en tiempo real  *(próximamente — B4)*
5. Ver recomendaciones para este proyecto  *(próximamente — B5)*
6. Instalar MCPs / plugins  *(próximamente — B6)*
7. Verificar instalaciones  *(próximamente — B7)*
8. Volver al menú principal TLOTP

> Las opciones marcadas como *próximamente* están en desarrollo. Si el usuario las
> elige, informa amablemente de que aún no están disponibles y vuelve al menú.

---

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

## Opción 3 — Detectar stack tecnológico

> 🚧 **Pendiente** — tarea B3

Informa al usuario: *"El ojo del contrabandista aún se está afinando para este análisis."*
Vuelve al menú principal.

---

## Opción 4 — Consultar marketplace en tiempo real

> 🚧 **Pendiente** — tarea B4

Informa al usuario: *"Los canales hacia los mercados exteriores están en construcción."*
Vuelve al menú principal.

---

## Opción 5 — Ver recomendaciones para este proyecto

> 🚧 **Pendiente** — tarea B5

Informa al usuario: *"El cargamento recomendado no puede prepararse hasta tener los análisis listos."*
Vuelve al menú principal.

---

## Opción 6 — Instalar MCPs / plugins

> 🚧 **Pendiente** — tarea B6

Informa al usuario: *"El desembarco aún no está listo. Pronto Bardo guiará cada instalación."*
Vuelve al menú principal.

---

## Opción 7 — Verificar instalaciones

> 🚧 **Pendiente** — tarea B7

Informa al usuario: *"La atalaya del puerto aún está siendo construida."*
Vuelve al menú principal.

---

## Opción 8 — Volver al menú principal TLOTP

Lee y ejecuta el prompt principal: `prompts/tlotp-main.md`

---

*Épica Bardo — TLOTP | Puerto de Lake-town*
*Última actualización: 2026-03-10*
