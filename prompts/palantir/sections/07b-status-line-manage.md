# 📊 Status Line — Gestión de Configuración Existente (Caso B)

> **IMPORTADO POR**: `palantir-main.md`
>
> Módulo de gestión CRUD cuando la Status Line ya está configurada (Caso B):
> mostrar actual, editar, reemplazar, eliminar.

---

# ═══════════════════════════════════════════════════
# CASO B · Status Line ya configurada — Gestión
# ═══════════════════════════════════════════════════

## PASO 6b: Banner informativo

**Mostrar sin interacción** antes de mostrar la configuración actual:

```
══════════════════════════════════════════════════════════════════
🔮 Palantír — Status Line

  El Status Line de Claude Code es un script de shell que se ejecuta
  en cada actualización y muestra lo que tú quieras en la barra inferior.

  ✅ Palantír puede ayudarte a:
     · Crear un Status Line desde cero (asistido o desde preset)
     · Ver, editar o reemplazar el script actual
     · Eliminar la configuración existente
     · Consultar la documentación oficial en tiempo real

  ❌ Palantír NO puede:
     · Garantizar que tu terminal soporte colores ANSI o Nerd Fonts
     · Acceder a datos que Claude Code no exponga en el JSON de entrada
     · Configurar el Status Line de forma retroactiva para sesiones pasadas

  💡 Campos disponibles en el JSON: model, workspace, cost, context_window,
     rate_limits (Pro/Max), session_id, git_worktree, vim.mode y más.
══════════════════════════════════════════════════════════════════
```

Tras mostrarlo, continuar al PASO 7.

---

## PASO 7: Mostrar configuración actual

Para cada scope donde `STATUS_LINE_STATE[scope].exists == true`, mostrar:

```
📊 TU STATUS LINE ACTUAL
══════════════════════════════════════════════════════

🌍 Global (~/.claude/settings.json)
   ──────────────────────────────────
   Formato: [objeto command / string]
   Shell:   [🐧 bash · 🪟 powershell · 🧵 (string)]
   Valor:
     [contenido exacto del campo `statusLine`]

🏠 Proyecto (.claude/settings.json)
   ──────────────────────────────────
   [o `sin configuración específica`]

══════════════════════════════════════════════════════
```

> 🆕 **Detección de shell** (issue #478): para el campo `Shell:` analizar
> el `statusLine.command` actual del scope:
>
> - si empieza por `powershell` o `pwsh` → 🪟 powershell
> - si empieza por `bash`, `sh`, `zsh` o un path absoluto a `.sh` → 🐧 bash
> - si `statusLine` es un string plano (no objeto) → 🧵 (string)
> - en cualquier otro caso → `Shell: ⚙️ <interpretar manualmente>`

**Si solo existe uno** de los dos scopes, omitir la sección vacía.

**Si existen ambos**, indicar también qué scope prevalece según la jerarquía
oficial: *Proyecto prevalece sobre Global* cuando Claude Code se ejecuta
dentro de un proyecto.

---

## PASO 8: WebFetch condicional a documentación oficial

**Si `STATUSLINE_DOCS_CACHED == false`**, ejecutar el WebFetch del PASO 4
(definido en `07a-status-line-create.md`) ahora (con la misma lógica de caché).
Esto garantiza que el usuario dispone de información actualizada sobre schema
y variables antes de editar.

**Si ya está en caché**, saltar este paso silenciosamente.

---

## PASO 9: Menú de gestión (paginado 3+1)

**Pantalla 1** (1/2 — mostrar primero) — `AskUserQuestion`:

```json
{
  "questions": [{
    "header": "Status Line · Gestión (1/2)",
    "question": "¿Qué quieres hacer con tu Status Line?",
    "multiSelect": false,
    "options": [
      {
        "label": "✏️ Editar",
        "description": "Modificar la configuración actual guiado por docs oficiales"
      },
      {
        "label": "🔄 Reemplazar desde cero",
        "description": "Descartar la actual y diseñar una nueva con el asistente"
      },
      {
        "label": "🗑️ Eliminar",
        "description": "Quitar la configuración de Status Line (requerirá confirmación)"
      },
      {
        "label": "➕ Ver más...",
        "description": "Presets y volver"
      }
    ]
  }]
}
```

**Si elige `➕ Ver más...`**, mostrar **Pantalla 2** (2/2):

```json
{
  "questions": [{
    "header": "Status Line · Gestión (2/2)",
    "question": "¿Qué quieres hacer con tu Status Line?",
    "multiSelect": false,
    "options": [
      {
        "label": "🥔 Usar el status line de Pépeton, hijo de Móreuton",
        "description": "Instalar el preset de 2 líneas (contexto · 5h · 7d)"
      },
      {
        "label": "🔙 Volver al menú de Palantír",
        "description": ""
      },
      {
        "label": "⬅️ Volver a pantalla 1",
        "description": "Editar · Reemplazar · Eliminar"
      }
    ]
  }]
}
```

**Routing**:

- `✏️ Editar` → PASO 10 · Opción Editar
- `🔄 Reemplazar desde cero` → PASO 10 · Opción Reemplazar
- `🗑️ Eliminar` → PASO 10 · Opción Eliminar
- `🥔 Usar el status line de Pépeton` → cargar `@prompts/palantir/sections/07c-status-line-pepeton.md` y ejecutar PASO P1
- `🔙 Volver al menú de Palantír` → PASO 10 · Opción Volver
- `⬅️ Volver a pantalla 1` → mostrar Pantalla 1 de nuevo

---

## PASO 10: Ejecutar acción elegida

### Opción · Editar

1. **Si hay Status Line en ambos scopes**, preguntar primero cuál editar:

   ```json
   {
     "questions": [{
       "header": "Status Line · Scope",
       "question": "¿Cuál deseas editar?",
       "multiSelect": false,
       "options": [
         { "label": "🌍 La global", "description": "~/.claude/settings.json" },
         { "label": "🏠 La del proyecto", "description": ".claude/settings.json" },
         { "label": "🚫 Cancelar", "description": "Volver al menú anterior" }
       ]
     }]
   }
   ```

2. **Invocar el Motor de Entrevista** (PASO 5 de `07a-status-line-create.md`) con:
   - `INITIAL_VALUES` = contenido actual del `statusLine` elegido
   - `MODE` = `"editar"`
3. Al generar la propuesta en 5.3, **mostrar diff** entre valor actual y
   valor propuesto antes de pedir confirmación en PASO 6.
4. Continuar al PASO 6 (confirmación + escritura segura de `07a-status-line-create.md`).

### Opción · Reemplazar desde cero

1. Si hay configuración en ambos scopes, preguntar cuál reemplazar (mismo
   AskUserQuestion que en "Editar").
2. **Mostrar** la configuración actual que se va a reemplazar para que el
   usuario la vea antes de perder.
3. **Invocar el Motor de Entrevista** (PASO 5 de `07a-status-line-create.md`) con:
   - `INITIAL_VALUES` = vacío
   - `MODE` = `"reemplazar"`
4. Continuar al PASO 6 (confirmación + escritura segura de `07a-status-line-create.md`).

### Opción · Eliminar

1. Si hay configuración en ambos scopes, preguntar cuál eliminar:

   ```json
   {
     "questions": [{
       "header": "Status Line · Eliminar",
       "question": "¿Cuál deseas eliminar?",
       "multiSelect": false,
       "options": [
         { "label": "🌍 La global", "description": "~/.claude/settings.json" },
         { "label": "🏠 La del proyecto", "description": ".claude/settings.json" },
         { "label": "🌐 Ambas", "description": "Eliminar de los dos ficheros" },
         { "label": "🚫 Cancelar", "description": "No borrar nada" }
       ]
     }]
   }
   ```

2. **Confirmación explícita** — mostrar qué se va a borrar:

   ```
   ⚠️  CONFIRMA LA ELIMINACIÓN
   ══════════════════════════════════════════════════════

   📍 Fichero:  [ruta completa]
   🗑️ Campo a eliminar:
      "statusLine": [valor actual completo]

   El resto del fichero se preservará intacto.

   ══════════════════════════════════════════════════════
   ```

3. **AskUserQuestion**:

   ```json
   {
     "questions": [{
       "header": "Confirmar eliminación",
       "question": "¿Eliminamos la Status Line?",
       "multiSelect": false,
       "options": [
         { "label": "🗑️ Sí, eliminar", "description": "Borrar solo el campo statusLine" },
         { "label": "🚫 Cancelar", "description": "No tocar nada" }
       ]
     }]
   }
   ```

4. **Si confirma**:
   - Leer el `settings.json` con Read tool
   - Parsear JSON
   - Eliminar la clave `statusLine`
   - Reserializar y escribir con Write tool
   - Si tras eliminar el fichero queda `{}`, dejarlo así (válido) o
     eliminar el fichero si el usuario lo prefiere (preguntar)
5. Confirmar con frase épica:
   - *"Palantír ha retirado el estandarte de la Status Line."*
   - *"El reino vuelve a su barra de estado ancestral."*

Volver al **menú principal de Palantír**.

### Opción · Volver al menú de Palantír

Cargar `@prompts/palantir/sections/00-menu-principal.md` y ejecutar PASO 2.

---

## ⚠️ Reglas globales del módulo

1. **Nunca escribir** `settings.json` sin confirmación explícita del usuario
2. **Preservar** siempre los demás campos del `settings.json`
3. **Usar solo** `Read` + `Write` tools (o equivalentes) sobre JSON, nunca
   `sed`/`awk`/text-replace
4. **Caché de sesión** del WebFetch: una sola fetch por sesión, independiente
   de cuántas veces se entre al módulo
5. **No contaminar** `MEMORY.md` ni auto memory durante este flujo
6. **Soportar ambos formatos**: objeto `{type, command}` y string plano
7. **Lore épico** en frases de confirmación, variando para no repetir

---

*Status Line — Gestión · Palantír Módulo 07b v1.0*
