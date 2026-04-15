# 📊 Gestionar Status Line — Autoasistencia y CRUD

> **IMPORTADO POR**: `00-menu-principal.md` (Opción página 2)
>
> Módulo autocontenido que detecta el estado de la Status Line de Claude Code
> y ofrece autoasistencia (si no existe) o gestión CRUD (si ya está configurada).

---

## PASO 1: Detección del estado

**Leer silenciosamente** los siguientes ficheros (sin formatear ni mostrar nada todavía):

```bash
cat ~/.claude/settings.json 2>/dev/null
cat .claude/settings.json 2>/dev/null
```

Parsear cada uno como JSON y extraer el campo `statusLine`. Contemplar **ambos formatos**:

- **Formato objeto** (recomendado oficialmente):
  ```json
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh"
  }
  ```

- **Formato string** (legacy o plantillas):
  ```json
  "statusLine": "Model: {model} · Tokens: {tokens}"
  ```

Construir el estado en memoria:

```
STATUS_LINE_STATE = {
  global:    { exists: true|false, format: "object"|"string"|null, value: ... , path: "~/.claude/settings.json" },
  project:   { exists: true|false, format: "object"|"string"|null, value: ... , path: ".claude/settings.json" }
}
```

---

## PASO 2: Routing según estado

**Determinar el caso**:

- **Caso A** · `global.exists == false AND project.exists == false` → Autoasistencia inicial
- **Caso B** · al menos uno de los dos existe → Gestión de configuración existente

Ir al **PASO 3** (Caso A) o al **PASO 7** (Caso B).

---

# ═══════════════════════════════════════════════════
# CASO A · Status Line no configurada — Autoasistencia
# ═══════════════════════════════════════════════════

## PASO 3: Ofrecer autoasistencia

Mostrar:

```
📊 Palantír no ve Status Line en tus pergaminos...
══════════════════════════════════════════════════════

He inspeccionado tu configuración de Claude Code:

  🌍 Global  (~/.claude/settings.json)    → sin statusLine
  🏠 Proyecto (.claude/settings.json)     → sin statusLine

La Status Line de Claude Code te permite ver información
personalizada en la barra de estado de tu terminal:
modelo activo, tokens usados, rama Git, directorio actual,
hora, o lo que tú decidas.

══════════════════════════════════════════════════════
```

**AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Status Line",
    "question": "¿Quieres que te ayude a configurarla?",
    "multiSelect": false,
    "options": [
      {
        "label": "✨ Sí, guíame",
        "description": "Consultaré la documentación oficial y te haré unas preguntas"
      },
      {
        "label": "📖 Ver docs primero",
        "description": "Fetchear la documentación oficial antes de decidir"
      },
      {
        "label": "🔙 Volver al menú de Palantír",
        "description": "Dejarlo para más tarde"
      }
    ]
  }]
}
```

- **Sí, guíame** → PASO 4 (fetch) + PASO 5 (entrevista)
- **Ver docs primero** → PASO 4 y después preguntar de nuevo
- **Volver** → cargar `@prompts/palantir/sections/00-menu-principal.md` PASO 2

---

## PASO 4: WebFetch a documentación oficial (con caché de sesión)

**Caché de sesión**: si en esta sesión (dentro de Palantír) ya se ejecutó el
WebFetch a la documentación de Status Line, reutilizar ese contenido sin
re-fetchear. Mostrar:

```
🔮 Pergamino de la Status Line ya conocido — reutilizando visión previa.
```

**Si es la primera vez**, mostrar ANTES de ejecutar el WebFetch:

```
🔮 *"Los reyes visten sus coronas; tú viste tu terminal."* — Palantír
   📜 Consultando el Pergamino de la Status Line...
   🌐 Fuente: https://code.claude.com/docs/en/statusline
   🧠 Buscando: schema, tipos (command/string), variables disponibles,
      hooks internos, limitaciones, ejemplos oficiales
```

Ejecutar:

> **WebFetch**: https://code.claude.com/docs/en/statusline
> **Extraer**: schema completo del campo `statusLine` en `settings.json`,
> tipos soportados (command vs string), variables y placeholders disponibles,
> ejemplos canónicos, limitaciones, consideraciones de performance.

**Tras completar el WebFetch**, mostrar:

```
✅ Pergamino de la Status Line — grabado en la Piedra.
```

**Marcar en caché de sesión**: `STATUSLINE_DOCS_CACHED = true` (conceptual —
recordar no re-fetchear en esta sesión).

---

## PASO 5: Entrevista guiada (Motor de Entrevista)

Este paso es un **motor conceptual reutilizable**: se invoca desde Caso A
(partiendo de vacío) y desde Caso B → Editar (partiendo de valores actuales).

**Parámetros del motor**:

- `INITIAL_VALUES` = vacío (Caso A) | `STATUS_LINE_STATE[scope].value` (Caso B)
- `MODE` = "crear" | "editar" | "reemplazar"

**Con la documentación del PASO 4 como fuente de verdad**, formular al usuario:

### 5.1 — Información a mostrar

Mostrar:

```
📝 DISEÑO DE TU STATUS LINE
══════════════════════════════════════════════════════

Según la documentación oficial, tu Status Line puede mostrar
cualquier combinación de información relevante. Las opciones
más habituales son:

  🧠 Modelo activo (p.ej. claude-opus-4)
  🔢 Tokens usados / restantes
  🌿 Rama Git del directorio actual
  📁 Directorio de trabajo
  🕒 Hora actual
  💼 Nombre del workspace
  ⚡ Estado de MCPs conectados

[+ otras variables extraídas del WebFetch]

══════════════════════════════════════════════════════
```

### 5.2 — Preguntas secuenciales

Formular en orden:

**Pregunta 1 · Formato de Status Line** — `AskUserQuestion`:

```json
{
  "questions": [{
    "header": "Status Line · Formato",
    "question": "¿Qué tipo de Status Line quieres?",
    "multiSelect": false,
    "options": [
      {
        "label": "⚙️ Comando externo (recomendado)",
        "description": "Apunta a un script shell que Claude ejecutará en cada refresh"
      },
      {
        "label": "🧵 Plantilla string",
        "description": "Cadena simple con placeholders (más sencillo, menos flexible)"
      },
      {
        "label": "🎁 Plantilla de ejemplo",
        "description": "Usar una Status Line de ejemplo que luego puedes ajustar"
      }
    ]
  }]
}
```

**Pregunta 2 · Contenido a mostrar** — input libre:

```
📦 ¿Qué información quieres ver en tu Status Line?

Descríbelo con tus palabras (puedes mencionar varios elementos):
```

**Pregunta 3 · Scope donde guardar** — `AskUserQuestion`:

```json
{
  "questions": [{
    "header": "Status Line · Scope",
    "question": "¿Dónde guardamos esta Status Line?",
    "multiSelect": false,
    "options": [
      {
        "label": "🌍 Global (~/.claude/settings.json)",
        "description": "La tendrás en todos tus proyectos de Claude Code"
      },
      {
        "label": "🏠 Proyecto (.claude/settings.json)",
        "description": "Solo aplica a este proyecto"
      }
    ]
  }]
}
```

### 5.3 — Generación de la propuesta

Con las respuestas del usuario y la documentación oficial, **generar la
configuración** respetando el schema del WebFetch.

Si el usuario eligió "Comando externo":

```json
{
  "statusLine": {
    "type": "command",
    "command": "[comando generado o path al script]"
  }
}
```

Si el usuario eligió "Plantilla string":

```json
{
  "statusLine": "[plantilla con variables]"
}
```

---

## PASO 6: Propuesta + confirmación + escritura

### 6.1 — Mostrar propuesta final

```
📋 PROPUESTA FINAL
══════════════════════════════════════════════════════

📝 Status Line propuesta:

   [bloque JSON formateado de la propuesta]

📍 Fichero destino:
   [ruta completa según scope]

⚠️  Impacto:
   [si el fichero existe: se añadirá el campo `statusLine`,
    preservando el resto de configuración]
   [si el fichero NO existe: se creará con solo este campo]

══════════════════════════════════════════════════════
```

### 6.2 — Confirmación explícita

**AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Aplicar Status Line",
    "question": "¿Aplicamos esta configuración?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Sí, aplicar",
        "description": "Escribir en el fichero mostrado"
      },
      {
        "label": "✏️ Modificar antes",
        "description": "Ajustar la propuesta y volver a mostrarla"
      },
      {
        "label": "🔄 Cambiar scope",
        "description": "Guardar en el otro scope en lugar del elegido"
      },
      {
        "label": "🚫 Cancelar",
        "description": "No escribir nada y volver al menú de Palantír"
      }
    ]
  }]
}
```

### 6.3 — Escritura segura

**Si el usuario confirma**, ejecutar la escritura respetando estas reglas:

1. **Leer** el `settings.json` existente (si existe) con Read tool.
2. **Parsear** el JSON completo en memoria.
3. **Mutar** únicamente el campo `statusLine`.
4. **Reserializar** el JSON preservando orden e indentación (2 espacios).
5. **Escribir** el fichero completo con Write tool.
6. **Nunca** hacer text-replace parcial sobre el JSON.
7. Si el fichero **no existe**, crear un JSON mínimo: `{"statusLine": ...}`.

**Confirmar** con frase épica:
- *"El reino ahora lleva su corona en la barra de estado."*
- *"Palantír ha tallado tu Status Line en los muros de Gondor."*
- *(Variar según el caso)*

Volver automáticamente al **menú principal de Palantír** (`00-menu-principal.md` PASO 2).

---

# ═══════════════════════════════════════════════════
# CASO B · Status Line ya configurada — Gestión
# ═══════════════════════════════════════════════════

## PASO 7: Mostrar configuración actual

Para cada scope donde `STATUS_LINE_STATE[scope].exists == true`, mostrar:

```
📊 TU STATUS LINE ACTUAL
══════════════════════════════════════════════════════

🌍 Global (~/.claude/settings.json)
   ──────────────────────────────────
   Formato: [objeto command / string]
   Valor:
     [contenido exacto del campo `statusLine`]

🏠 Proyecto (.claude/settings.json)
   ──────────────────────────────────
   [o `sin configuración específica`]

══════════════════════════════════════════════════════
```

**Si solo existe uno** de los dos scopes, omitir la sección vacía.

**Si existen ambos**, indicar también qué scope prevalece según la jerarquía
oficial: *Proyecto prevalece sobre Global* cuando Claude Code se ejecuta
dentro de un proyecto.

---

## PASO 8: WebFetch condicional a documentación oficial

**Si `STATUSLINE_DOCS_CACHED == false`**, ejecutar el WebFetch del PASO 4
ahora (con la misma lógica de caché). Esto garantiza que el usuario dispone
de información actualizada sobre schema y variables antes de editar.

**Si ya está en caché**, saltar este paso silenciosamente.

---

## PASO 9: Menú de gestión

**AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Status Line · Gestión",
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
        "label": "🔙 Volver al menú de Palantír",
        "description": ""
      }
    ]
  }]
}
```

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

2. **Invocar el Motor de Entrevista** (PASO 5) con:
   - `INITIAL_VALUES` = contenido actual del `statusLine` elegido
   - `MODE` = `"editar"`
3. Al generar la propuesta en 5.3, **mostrar diff** entre valor actual y
   valor propuesto antes de pedir confirmación en PASO 6.
4. Continuar al PASO 6 (confirmación + escritura segura).

### Opción · Reemplazar desde cero

1. Si hay configuración en ambos scopes, preguntar cuál reemplazar (mismo
   AskUserQuestion que en "Editar").
2. **Mostrar** la configuración actual que se va a reemplazar para que el
   usuario la vea antes de perder.
3. **Invocar el Motor de Entrevista** (PASO 5) con:
   - `INITIAL_VALUES` = vacío
   - `MODE` = `"reemplazar"`
4. Continuar al PASO 6 (confirmación + escritura segura).

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

*Gestionar Status Line — Palantír Módulo 07 v1.0*
