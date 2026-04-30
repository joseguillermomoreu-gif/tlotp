# 🔌 Módulo: Sugerir e Instalar Plugins Oficiales Recomendados

## Misión

Presentar al usuario, uno a uno, los plugins oficiales de Claude Code que son relevantes
para su stack y no están instalados. Gestionar la instalación asistida con elección de scope
y confirmación post-instalación.

---

## Paso 0 — Recibir contexto

**Si viene desde `00-module-analyze.md`** (flujo normal):
Usar directamente la lista de plugins sugeridos calculada en el Paso 4 de ese módulo.
No repetir el análisis de stack ni la detección de instalados.

**Si llega directamente sin contexto previo** (llegada directa al módulo):
Ejecutar detección mínima en una sola llamada Bash:

```bash
{
  echo "=== STACK ==="
  ls package.json composer.json pyproject.toml go.mod Cargo.toml pom.xml .github 2>/dev/null
  cat package.json 2>/dev/null | head -20
  cat composer.json 2>/dev/null | head -10

  echo "=== PLUGINS INSTALADOS ==="
  cat .claude/settings.json 2>/dev/null || echo "{}"
  cat ~/.claude/settings.json 2>/dev/null || echo "{}"
} 2>/dev/null
```

Cruzar el resultado con el catálogo del Paso 4 de `00-module-analyze.md` para obtener la lista
de plugins sugeridos.

**Si no hay plugins sugeridos** (todos instalados o stack no mapea):
```
🏹 Tu arsenal ya está bien equipado, viajero.

   No se encontraron plugins oficiales pendientes de instalar
   para el stack detectado. Cada flecha de tu carcaj ya está en su sitio.

🏹 "Bardo no dispara flechas que ya han llegado."
```
Ir directamente al Paso 4 (continuación).

---

## Paso 1 — Presentar y gestionar plugins uno a uno

Para cada plugin de la lista de sugeridos (iterar en orden), mostrar:

```
══════════════════════════════════════════════════════════════
🏹 Bardo detectó: [stack disparador del plugin]

  Plugin sugerido ([X]/[N]): [plugin-id]
  ¿Qué hace? [descripción del catálogo en 2-3 líneas]
  Instalaciones: [número o "dato no disponible en este momento"]

══════════════════════════════════════════════════════════════
```

**AskUserQuestion por cada plugin**:

```json
{
  "questions": [{
    "header": "Plugin sugerido [X/N]",
    "question": "🏹 ¿Lo instalamos?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Sí, instalar",
        "description": ""
      },
      {
        "label": "📖 Más información",
        "description": "Ver detalles completos del plugin"
      },
      {
        "label": "⏭️ No, saltar",
        "description": ""
      },
      {
        "label": "🚫 Cancelar todo",
        "description": "Abortar y ver resumen"
      }
    ]
  }]
}
```

**Comportamiento por opción**:

### Si elige "✅ Sí, instalar"
→ Ir al **Paso 2a** (elegir scope).

### Si elige "📖 Más información"
Comprobar si `docs/en/discover-plugins` ya está en contexto de la sesión.
- **Si ya está**: mostrar información detallada del plugin directamente.
- **Si no está**: hacer WebFetch on-demand a `https://code.claude.com/docs/en/discover-plugins`
  y extraer la información específica del plugin.

**Fallback si WebFetch falla**:
```
⚠️ No se pudo cargar la documentación oficial en este momento.
   Descripción disponible: [descripción del catálogo interno]
   Fuente: https://code.claude.com/docs/en/discover-plugins
```

Mostrar la información adicional y volver a preguntar sí/no para **ese mismo plugin**:

```json
{
  "questions": [{
    "header": "Plugin sugerido [X/N] — tras ver más info",
    "question": "🏹 ¿Lo instalamos?",
    "multiSelect": false,
    "options": [
      { "label": "✅ Sí, instalar", "description": "" },
      { "label": "⏭️ No, saltar", "description": "" }
    ]
  }]
}
```

### Si elige "⏭️ No, saltar"
```
🏹 "Esta flecha puede esperar su momento..."
```
Continuar al siguiente plugin de la lista.

### Si elige "🚫 Cancelar todo"
Ir directamente al **Paso 3** (resumen final).

---

## Paso 2a — Elegir scope

```json
{
  "questions": [{
    "header": "Scope de instalación",
    "question": "¿Dónde instalar [plugin-id]?",
    "multiSelect": false,
    "options": [
      {
        "label": "🌍 Global — disponible en todos mis proyectos",
        "description": ""
      },
      {
        "label": "📂 Proyecto — solo en este proyecto",
        "description": ""
      }
    ]
  }]
}
```

---

## Paso 2b — Ejecutar instalación

Mostrar el comando antes de ejecutarlo:
```
🔌 Instalando [plugin-id]...
```

Ejecutar según el scope elegido:
- **Global**: `/plugin install [plugin-id]`
- **Proyecto**: `/plugin install [plugin-id] --scope project`

**Si el comando falla** (error de red, plugin no encontrado, etc.):
```
⚠️ No se pudo instalar [plugin-id].

   Puedes intentarlo manualmente:
     /plugin install [plugin-id]

   O consultar el marketplace oficial:
     https://claude.com/plugins/[nombre-sin-scope]
```
Continuar con el siguiente plugin (no abortar el flujo completo).

---

## Paso 2c — Confirmación post-instalación

```
══════════════════════════════════════════════════════════════
✅ Plugin instalado: [plugin-id]
   Se activará automáticamente en tu próximo contexto relevante.
   No necesitas invocar ningún comando.
══════════════════════════════════════════════════════════════

🏹 "Una flecha más en el carcaj de Lake-town.
    Smaug no lo verá venir, viajero."
```

Continuar al siguiente plugin de la lista.

---

## Paso 3 — Resumen final

Tras procesar todos los plugins (o tras "Cancelar todo"):

```
📋 RESUMEN DE PLUGINS
══════════════════════════════════════════════════════════════
  ✅ Instalados: [X]
  ⏭️  Saltados:   [X]
  ❌ Fallidos:   [X]  (solo si hubo errores de instalación)
══════════════════════════════════════════════════════════════
🏹  "El carcaj de Bardo nunca está vacío. Hasta la próxima cacería."
```

Si todos fueron instalados correctamente:
```
🏹 Arsenal completo, viajero. Smaug no tiene escapatoria.
```

---

## Paso 4 — Continuación

```json
{
  "questions": [{
    "header": "Plugins gestionados",
    "question": "🏹 ¿Qué deseas hacer ahora?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔙 Volver al menú de Bardo",
        "description": ""
      },
      {
        "label": "🔙 Volver a La Comunidad del Código",
        "description": ""
      }
    ]
  }]
}
```

**Si elige "Volver a La Comunidad del Código"**: cargar `@prompts/tlotp-main.md`.

---

## Catálogo de referencia (sincronizado con `00-module-analyze.md`)

> **IMPORTANTE**: mantener sincronizado con el catálogo del Paso 4 de `00-module-analyze.md`.

| Plugin ID | Stack disparador | Descripción | Origen | Instalaciones |
|-----------|-----------------|-------------|--------|---------------|
| `frontend-design@claude-plugins-official` | React / Vue / Angular / Svelte | Genera UI con tipografía, paletas y animaciones distintivas. Evita el "AI slop aesthetic". | oficial | 277.000+ |
| `typescript@claude-plugins-official` | TypeScript | Mejora la inferencia y sugerencias para proyectos TypeScript. | oficial | — |
| `python@claude-plugins-official` | Python | Optimiza asistencia en proyectos Python: patrones, idioms, tipado. | oficial | — |
| `github@claude-plugins-official` | GitHub (directorio `.github/` o repo git) | Integración con flujos de GitHub: issues, PRs, Actions. | oficial | — |
| `caveman@caveman` (de `JuliusBrussee/caveman`) | `universal` (cualquier stack) | Reduce tokens de salida 65–75% comprimiendo respuestas a "estilo cavernícola". Niveles Lite/Full/Ultra/文言文. Flujo dedicado en `06-module-caveman.md`. | tercero | ~14.000 ⭐ |

> **AMPLIAR AQUÍ**: añadir nuevas filas manteniendo sincronía con `00-module-analyze.md`.
> Para plugins de tercero, marcar `Origen: tercero` y considerar un módulo dedicado en
> `sections/` si requieren flujo de instalación distinto al estándar.

---

## 🔗 Fuentes

Ver índice completo en `@prompts/docs-sources.md`:
- Plugins: `https://code.claude.com/docs/en/plugins`
- Discover plugins: `https://code.claude.com/docs/en/discover-plugins`
- Marketplace oficial: `https://claude.com/plugins/`

---

**Módulo**: `05-module-suggest-plugins.md`
**Invocado desde**: `00-module-analyze.md` (opción "Instalar plugins recomendados para mi stack")
**Requiere**: Bash (detección mínima si llegada directa), WebFetch on-demand (solo para "más info")
