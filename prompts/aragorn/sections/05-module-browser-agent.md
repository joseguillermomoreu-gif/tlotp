# 🌐 Módulo: Browser Agent — Los Montaraces del Norte

```
══════════════════════════════════════════════════════════════
  🗺️  LOS MONTARACES DEL NORTE  🗺️
══════════════════════════════════════════════════════════════
    Browser Agent — Playwright MCP embedded · TLOTP
──────────────────────────────────────────────────────────────
  "He recorrido caminos que ningún hombre ha transitado."
        — Aragorn, Capitán de los Dúnedain

  Los Montaraces del Norte son los exploradores del Rey:
  abren rutas, navegan tierras remotas y traen noticias.
══════════════════════════════════════════════════════════════
```

## Misión

Gestionar el agente oficial **`browser`** de Anthropic, que embebe
**Playwright MCP** (`@playwright/mcp@latest`) en su frontmatter. No requiere
`claude mcp add` global — el agente lo trae consigo.

## ⚠️ Regla Inviolable — `mcpServers` NUNCA se modifica

> El bloque `mcpServers` da poder al agente. **Ningún sub-flujo lo ofrece
> como editable**. Es inviolable por construcción.
>
> **Constante**: `PLAYWRIGHT_MCP_REPO = https://github.com/microsoft/playwright-mcp`
> (WebFetch + fallback — punto único de actualización).
>
> **Frontmatter observado**: plantilla del marketplace oficial de Anthropic.
> Para actualizar, usar "♻️ Sobrescribir con la versión oficial".
> **No tocar `mcpServers` ni siquiera al actualizar**.

---

## Paso 1 — Menú interno

```json
{
  "questions": [{
    "header": "Browser Agent",
    "question": "🗺️  ¿Qué orden tienes para los Montaraces, señor?",
    "multiSelect": false,
    "options": [
      {"label": "📥 Instalar el browser agent oficial", "description": "Crear ~/.claude/agents/browser-agent.md"},
      {"label": "✏️  Personalizar el agente instalado", "description": "Editar campos editables (mcpServers intacto)"},
      {"label": "📜 Documentación: cuándo usarlo", "description": "Embedded vs Playwright MCP global"},
      {"label": "🔙 Volver al menú Aragorn", "description": ""}
    ]
  }]
}
```

Tras **cualquier** sub-flujo → volver a este menú.
"🔙 Volver al menú Aragorn" → `@prompts/aragorn/aragorn-main.md`.

---

## Sub-flujo 1 — 📥 Instalar

**1.1 Detección**: `ls -la ~/.claude/agents/browser-agent.md 2>/dev/null`

**1.2 Si NO existe**: mostrar el frontmatter oficial completo (con `mcpServers`
resaltado como **intacto**) y preguntar:

```json
{
  "questions": [{
    "header": "Instalar Browser Agent",
    "question": "🗺️  ¿Reclutamos al explorador en ~/.claude/agents/browser-agent.md?",
    "multiSelect": false,
    "options": [
      {"label": "✅ Instalar — forjar el agente", "description": "Crea fichero con Playwright MCP embedded"},
      {"label": "🚫 Cancelar", "description": ""}
    ]
  }]
}
```

**1.3 Si SÍ existe**:

```json
{
  "questions": [{
    "header": "Browser Agent — ya existe",
    "question": "⚠️  Ya existe ~/.claude/agents/browser-agent.md — ¿qué hacemos?",
    "multiSelect": false,
    "options": [
      {"label": "♻️  Sobrescribir con la versión oficial", "description": "Crea backup .bak antes de escribir"},
      {"label": "✏️  Personalizar el existente", "description": "Saltar al Sub-flujo 2"},
      {"label": "🚫 Cancelar", "description": ""}
    ]
  }]
}
```

**1.4 Backup + Escritura**: antes de sobrescribir, **siempre**:

```bash
cp ~/.claude/agents/browser-agent.md ~/.claude/agents/browser-agent.md.bak
```

Después `Write` con el contenido oficial. **Nunca tocar `mcpServers`**.

**1.5 Errores**: si la escritura falla → mostrar `⚠️ El explorador no ha podido tomar puesto en Gondor. Error: {detalle} — Ningún fichero ha quedado a medias.` → menú interno.

**1.6 Éxito**: confirmar con ruta del fichero, `🛡️  mcpServers: intacto (apunta a @playwright/mcp@latest)`, y ruta del `.bak` si hubo backup. → menú interno.

---

## Sub-flujo 2 — ✏️ Personalizar

**2.1 Detección**: si el fichero **no existe**, avisar y ofrecer:

```json
{
  "questions": [{
    "header": "Browser Agent — no instalado",
    "question": "⚠️  Aún no hay Montaraces en Gondor — primero hay que reclutarlos. ¿Instalamos ahora?",
    "multiSelect": false,
    "options": [
      {"label": "📥 Sí, ir al sub-flujo de instalación", "description": "Saltar al Sub-flujo 1"},
      {"label": "🔙 Volver al menú interno", "description": ""}
    ]
  }]
}
```

**2.2 Lectura y parseo**: `Read` del fichero. Separar:
- **Editable**: `name`, `description`, `tools`, `model`, system prompt (cuerpo).
- **Bloque `mcpServers` → BLOQUEADO**: se preserva tal cual y se re-inyecta al final.

**2.3 Selección de campo (paginado)** — Pantalla 1:

```json
{
  "questions": [{
    "header": "Personalizar Browser Agent (1/2)",
    "question": "✏️  ¿Qué campo del Montaraz quieres reentrenar?",
    "multiSelect": false,
    "options": [
      {"label": "🏷️  name", "description": "Nombre con el que se invoca"},
      {"label": "📝 description", "description": "Cuándo se invoca automáticamente"},
      {"label": "🛠️  tools", "description": "Herramientas permitidas"},
      {"label": "➕ Más campos...", "description": "model · system prompt · terminar"}
    ]
  }]
}
```

Pantalla 2 (si elige Más):

```json
{
  "questions": [{
    "header": "Personalizar Browser Agent (2/2)",
    "question": "✏️  ¿Qué campo del Montaraz quieres reentrenar?",
    "multiSelect": false,
    "options": [
      {"label": "🤖 model", "description": "sonnet | opus | haiku | inherit"},
      {"label": "📜 system prompt", "description": "Cuerpo del agente"},
      {"label": "🔙 Volver", "description": "Pantalla anterior"},
      {"label": "✅ Terminar y revisar diff", "description": "Aplicar cambios acumulados"}
    ]
  }]
}
```

> 🛡️ `mcpServers` **no aparece** en ninguna pantalla. Bloqueado por construcción.

**2.4 Edición asistida**: por cada campo → mostrar valor actual → pedir nuevo
valor → validar:
- `name`: `/^[a-z0-9-]+$/` · `description`: ≥ 10 caracteres · `tools`: lista
  separada por comas o `*` · `model`: `sonnet | opus | haiku | inherit` ·
  `system prompt`: no vacío.

**2.5 Diff visible**: antes de escribir, mostrar diff antes/después.
Marcar siempre: `🛡️  mcpServers: SIN CAMBIOS (bloque preservado íntegro)`.

**2.6 Confirmación**:

```json
{
  "questions": [{
    "header": "Personalizar — confirmar",
    "question": "✏️  ¿Aplicamos los cambios al agente?",
    "multiSelect": false,
    "options": [
      {"label": "✅ Aplicar — con backup .bak", "description": "Escribe + crea backup previo"},
      {"label": "↩️  Editar otro campo", "description": "Volver a la selección"},
      {"label": "🚫 Cancelar — descartar cambios", "description": ""}
    ]
  }]
}
```

**2.7 Escritura**: si confirma → `cp` a `.bak`, `Write` con el contenido nuevo
re-inyectando el bloque `mcpServers` original **sin tocar**. → menú interno.

---

## Sub-flujo 3 — 📜 Documentación (WebFetch on-demand)

**3.1 WebFetch** a `PLAYWRIGHT_MCP_REPO` extrayendo: qué es Playwright MCP,
casos de uso, instalación (`npx @playwright/mcp@latest`), embedded vs global.

**3.2 Si éxito**, presentar:

1. **Resumen del README oficial** (siempre actualizado, extraído del WebFetch).
2. **Tabla comparativa**:

   | Aspecto | 🌐 Browser Agent (embedded) | 🌍 Playwright MCP global |
   |---------|----------------------------|--------------------------|
   | Instalación | Fichero `~/.claude/agents/browser-agent.md` | `claude mcp add playwright npx @playwright/mcp@latest` |
   | Scope | Subagente global a usuario | Por proyecto o usuario, vía `claude mcp` |
   | Visibilidad | Solo al invocar el subagente `browser` | Siempre disponible para Claude principal |
   | Aislamiento | Contexto separado (subagente) | Comparte contexto con la sesión |
   | Cuándo usarlo | Tareas puntuales (scrape, screenshot, formularios) | Trabajo continuo donde la web es central |

3. **Verificación**:

   ```bash
   ls ~/.claude/agents/ | grep browser-agent   # agente instalado
   claude mcp list                              # MCPs globales
   ```

4. **Repo oficial**: `📖 https://github.com/microsoft/playwright-mcp`

**3.3 Si falla (fallback)**:

```
⚠️  No se ha podido consultar la documentación oficial de Playwright MCP.
    Puedes consultarla manualmente en:
    📖 https://github.com/microsoft/playwright-mcp
```

> No degradar a documentación inline obsoleta — el repo oficial es la fuente
> de verdad (ADR-2).

**3.4 Vuelta** → menú interno (no al menú de Aragorn).

## 🛡️ Recordatorio final

> Ningún sub-flujo edita `mcpServers`. Toda sobrescritura preserva el bloque
> íntegro o lo restaura desde la plantilla oficial.

**Módulo**: `05-module-browser-agent.md` · **Invocado desde**: `aragorn-main.md`
**Requiere**: Read, Write, Bash (cp/ls), AskUserQuestion, WebFetch on-demand
