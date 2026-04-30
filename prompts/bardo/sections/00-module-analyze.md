# 🎯 Módulo: Inspeccionar el Arsenal — Analizar Stack, MCPs y Plugins

## Misión

Detectar el stack tecnológico del proyecto, analizar los MCPs y plugins instalados,
puntuar su estado actual y guiar la aplicación de mejoras una a una.

---

## Paso 0 — Documentación oficial (on-the-fly)

**IMPORTANTE**: Comprobar primero si la documentación ya está cargada en el contexto de esta sesión.

**Si ya está en contexto**: usar directamente sin re-fetchear.

**Si no está en contexto**, hacer WebFetch:

> **WebFetch 1**: `https://code.claude.com/docs/en/mcp`
> **Extraer**: estructura de configuración MCP, scopes (user/project), transports (stdio/SSE/HTTP),
> campos válidos en ~/.claude.json y .mcp.json, autenticación, servidores populares.

> **WebFetch 2**: `https://code.claude.com/docs/en/plugins`
> **Extraer**: estructura de plugins, tipos, diferencias con MCPs y skills, campos de configuración.

> **WebFetch 3**: `https://code.claude.com/docs/en/discover-plugins`
> **Extraer**: cómo descubrir plugins, catálogo oficial, criterios de selección.

**Fallback si WebFetch falla**: Continuar con conocimiento interno marcando sugerencias con ⚠️ sin doc oficial.

---

## Paso 1 — Detectar stack y configuración actual

Una sola pasada para minimizar llamadas Bash:

```bash
{
  echo "=== STACK ==="
  ls package.json composer.json pyproject.toml go.mod Cargo.toml pom.xml 2>/dev/null
  cat package.json 2>/dev/null | head -20
  cat composer.json 2>/dev/null | head -10

  echo "=== MCP USER SCOPE ==="
  cat ~/.claude.json 2>/dev/null || echo "{}"

  echo "=== MCP PROJECT SCOPE ==="
  cat .mcp.json 2>/dev/null || echo "{}"

  echo "=== SETTINGS ==="
  cat .claude/settings.json 2>/dev/null || echo "{}"
  cat ~/.claude/settings.json 2>/dev/null || echo "{}"
} 2>/dev/null
```

**Extraer**:
- **Stack**: lenguajes, frameworks, DBs, servicios detectados
- **MCPs user scope**: lista de servidores MCP en `~/.claude.json → mcpServers`
- **MCPs project scope**: lista de servidores MCP en `.mcp.json → mcpServers`
- **Plugins**: plugins instalados desde settings.json

---

## Paso 1b — Health check de MCPs instalados

Para cada MCP detectado, verificar si realmente está funcionando según su tipo de transport.
Ejecutar todas las comprobaciones en una sola llamada Bash:

```bash
# Para cada MCP con transport stdio: intentar ejecutar el comando con timeout
# Para cada MCP con transport HTTP/SSE: comprobar accesibilidad del endpoint
# Comprobar variables de entorno requeridas

{
  # MCPs stdio — verificar que el comando existe y responde
  # (sustituir [command] por el valor real de cada MCP)
  timeout 3 [command] --version 2>/dev/null && echo "OK" || echo "FAIL"

  # MCPs HTTP/SSE — verificar accesibilidad del endpoint
  curl -s --max-time 3 -o /dev/null -w "%{http_code}" [url] 2>/dev/null

  # Variables de entorno — comprobar que existen
  # (sustituir ENV_VAR por las definidas en el config de cada MCP)
  echo "${ENV_VAR:+defined}" 2>/dev/null
} 2>/dev/null
```

**Estados posibles por MCP**:
- ✅ **Responde** — comando ejecuta correctamente / endpoint accesible (HTTP 2xx)
- ❌ **No responde** — comando falla o timeout / endpoint inaccesible o error HTTP
- ⚠️ **Env var faltante** — variable de entorno requerida no está definida en el entorno actual
- ℹ️ **No verificable** — transport desconocido o configuración incompleta (se marca como revisar)

**Guardar resultado del health check** para usarlo en el scoring del Paso 2.

---

## Paso 2 — Analizar y puntuar cada ítem

Cada MCP y plugin parte de **10 puntos** y se penaliza:

### Criterios de scoring

| Criterio | Penalización | Severidad |
|----------|-------------|-----------|
| MCP sin campo `command` o `url` válido | -4 pts | ❌ Crítico |
| MCP no responde (comando falla o timeout) | -4 pts | ❌ Crítico |
| MCP endpoint HTTP inaccesible (error de red, 4xx o 5xx) | -3 pts | ❌ Crítico |
| Variable de entorno requerida no definida en el entorno | -3 pts | ❌ Crítico |
| MCP en scope incorrecto (user cuando debería ser project o viceversa) | -2 pts | ⚠️ Mejorable |
| Plugin sin configuración recomendada según docs oficiales | -2 pts | ⚠️ Mejorable |
| Redundancia: MCP + plugin que cubren la misma funcionalidad | -2 pts | ⚠️ Mejorable |
| MCP no verificable (transport desconocido o config incompleta) | -1 pt | ℹ️ Revisable |
| MCP relevante para el stack pero no instalado | -1 pt (global) | ℹ️ Oportunidad |

### Niveles de calidad

| Puntos | Nivel | Descripción |
|--------|-------|-------------|
| 9–10 | 🏹 Flecha Negra | Arsenal perfectamente afinado |
| 7–8 | ⚔️ Bien afilado | Solo mejoras menores |
| 5–6 | 🗡️ En proceso | Necesita trabajo |
| < 5 | 🐉 Presa del dragón | Requiere refuerzo urgente |

### Score global

```
Score global = media de puntuaciones individuales (redondeado a 1 decimal)
```

---

## Paso 3 — Generar informe con scoring

```
══════════════════════════════════════════════════════════════
🏹  BARDO — Inspección del Arsenal
══════════════════════════════════════════════════════════════

📦 STACK DETECTADO
──────────────────────────────────────────────────────────────
  PHP/Symfony · TypeScript · PostgreSQL

🔗 MCPs INSTALADOS
──────────────────────────────────────────────────────────────
  🌍 User scope (~/.claude.json):
    🏹 10/10  github-copilot   — responde ✅ · scope correcto ✅
    ⚔️  7/10  sentry           — responde ✅ · scope user ⚠️ (recomendado: project)

  📂 Project scope (.mcp.json):
    ❌  3/10  db-explorer      — no responde ❌ · env DB_URL no definida ❌
    ❌  2/10  old-api-mcp      — endpoint inaccesible ❌ · command inválido ❌

🔌 PLUGINS INSTALADOS
──────────────────────────────────────────────────────────────
  ⚔️  8/10  git-lens          — sin configuración recomendada ⚠️

══════════════════════════════════════════════════════════════
📊 Score global: 6.0/10 🗡️ — 5 ítems · 1 🏹 · 2 ⚔️ · 2 ❌
══════════════════════════════════════════════════════════════
```

---

## Paso 4 — MCPs y plugins recomendados no instalados

### Catálogo de plugins oficiales (AMPLIAR AQUÍ con nuevos plugins)

Cruzar el stack detectado contra este catálogo. Para cada plugin:
- Si su stack disparador está presente en el stack detectado **Y** el plugin **no** está instalado → incluir en sugeridos.
- Stack disparador `universal` → aplicable a cualquier stack (siempre se evalúa).
- Si ya está instalado → no mencionar nunca (aplica también a Caveman: si `claude plugin list` lo detecta, se excluye de sugerencias).

| Stack disparador | Plugin ID | Descripción | Origen | Instalaciones |
|-----------------|-----------|-------------|--------|---------------|
| React / Vue / Angular / Svelte | `frontend-design@claude-plugins-official` | Genera UI con tipografía, paletas y animaciones distintivas. Evita el "AI slop aesthetic". | oficial | 277.000+ |
| TypeScript | `typescript@claude-plugins-official` | Mejora la inferencia y sugerencias para proyectos TypeScript. | oficial | — |
| Python | `python@claude-plugins-official` | Optimiza asistencia en proyectos Python: patrones, idioms, tipado. | oficial | — |
| GitHub (directorio `.github/` detectado o repo git) | `github@claude-plugins-official` | Integración con flujos de GitHub: issues, PRs, Actions. | oficial | — |
| `universal` (cualquier stack) | `caveman@caveman` (de `JuliusBrussee/caveman`) | Reduce tokens de salida 65–75% comprimiendo respuestas a "estilo cavernícola". Niveles Lite/Full/Ultra/文言文. Flujo dedicado en `06-module-caveman.md`. | tercero | ~14.000 ⭐ |

Basado en el stack detectado, la documentación oficial y el catálogo anterior, listar qué podría ser útil:

```
💡 OPORTUNIDADES DETECTADAS PARA TU STACK
──────────────────────────────────────────────────────────────
  Stack: PHP/Symfony · TypeScript · PostgreSQL

  🔗 MCPs recomendados no instalados:
    • slack-mcp       — si usas Slack como equipo
    • postgres-mcp    — acceso directo a tu DB desde Claude

  🔌 Plugins recomendados no instalados:
    • frontend-design@claude-plugins-official
      Genera UI con tipografía, paletas y animaciones distintivas.
      (Stack disparador: React detectado · 277.000+ instalaciones)
    • typescript@claude-plugins-official
      Mejora la inferencia y sugerencias para proyectos TypeScript.
      (Stack disparador: TypeScript detectado)
    • 🪨 caveman@caveman  (Origen: tercero · ~14.000 ⭐)
      Reduce tokens de salida 65–75% (universal, cualquier stack).
      Flujo dedicado: submenú "🛒 El mercado" → "🪨 Caveman".
──────────────────────────────────────────────────────────────
```

Si no hay plugins sugeridos (todos instalados o el stack no mapea a ninguno del catálogo):
```
  🔌 Plugins: tu carcaj ya está bien equipado para el stack detectado.
```

**Guardar la lista de plugins sugeridos en el contexto de sesión** para pasarla a
`sections/05-module-suggest-plugins.md` si el usuario elige instalarlos.

---

## Paso 5 — Lista de mejoras priorizadas

Construir lista completa ordenada por severidad:
1. ❌ Críticos primero
2. ⚠️ Mejorables después
3. ℹ️ Oportunidades al final

Mostrar total: `X mejoras encontradas (Y ❌ críticas · Z ⚠️ mejorables · W ℹ️ oportunidades)`

---

## Paso 6 — Opciones al usuario

```json
{
  "questions": [{
    "header": "Tras la inspección",
    "question": "🏹 ¿Qué deseas hacer con los resultados?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔧 Revisar y aplicar mejoras una a una",
        "description": ""
      },
      {
        "label": "🔌 Instalar plugins recomendados para mi stack",
        "description": "Solo si se detectaron plugins sugeridos en el Paso 4"
      },
      {
        "label": "🔙 Volver al menú principal",
        "description": ""
      }
    ]
  }]
}
```

> **Nota**: la opción de instalar plugins recomendados solo aparece si hay plugins sugeridos en el Paso 4
> (es decir, plugins del catálogo cuyo stack disparador fue detectado y no están ya instalados).
>
> **Acción al elegir "Instalar plugins recomendados"**: cargar `sections/05-module-suggest-plugins.md`
> pasando la lista de plugins sugeridos calculada en el Paso 4.

---

## Paso 7 — Revisor uno a uno

Iterar por cada mejora de la lista del Paso 5, **en orden de severidad** (❌ primero, ⚠️ después, ℹ️ al final).

**Soluciones concretas para problemas de health check**:

| Problema detectado | Solución propuesta en el revisor |
|--------------------|----------------------------------|
| MCP no responde (stdio) | Verificar que el comando está en PATH; reinstalar si es necesario |
| Endpoint HTTP inaccesible | Mostrar la URL configurada + sugerir verificarla manualmente; actualizar si hay nueva URL |
| Env var no definida | Mostrar exactamente qué variable falta + cómo definirla (`export VAR=valor` en `.env` o `~/.profile`) |
| Command inválido | Mostrar el valor actual + proponer corrección según docs oficiales del MCP |

**Mostrar para cada mejora**:

```
🏹 MEJORA [X/N] — [❌/⚠️/ℹ️] [SEVERIDAD]
══════════════════════════════════════════════════════════════

📍 Ítem afectado: [nombre / ruta completa]

❌ Problema:
   [descripción clara del problema detectado]

✅ Solución propuesta:
   [qué se aplicaría exactamente — incluir configuración JSON si aplica]

🎯 Resultado esperado:
   [qué mejorará tras aplicar]

══════════════════════════════════════════════════════════════
```

**AskUserQuestion por cada mejora**:

```json
{
  "questions": [{
    "header": "Mejora [X/N]",
    "question": "🏹 ¿Qué hacemos con esta flecha?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aplicar",
        "description": "Bardo aplicará esta mejora ahora"
      },
      {
        "label": "✏️ Modificar propuesta",
        "description": "Ajustar la solución antes de aplicar"
      },
      {
        "label": "⏭️ Saltar",
        "description": "Dejar sin cambios y pasar a la siguiente"
      },
      {
        "label": "🚫 Cancelar todo",
        "description": "Abortar el revisor y ver resumen parcial"
      }
    ]
  }]
}
```

**Comportamiento por opción**:

- **✅ Aplicar**: Ejecutar el cambio (Edit/Write/Bash). Confirmar con frase de lore de Lake-town, variada:
  - *"🏹 La flecha ha encontrado su blanco."*
  - *"🏹 Bien. Smaug no sobreviviría a este arsenal."*
  - *"🏹 Lake-town aprueba. El dragón no tiene escapatoria."*
  - *"🏹 Una flecha más afinada en el carcaj."*
  - *(Variar — breve, con el tono del Arquero)*
  - Luego pasar a la siguiente mejora.
- **✏️ Modificar propuesta**: Preguntar qué cambiar. Mostrar propuesta actualizada y confirmar antes de aplicar.
- **⏭️ Saltar**: `🏹 "Esta flecha puede esperar su momento..."` y pasar a la siguiente.
- **🚫 Cancelar todo**: Saltar al resumen final (Paso 7b).

**IMPORTANTE**: Antes de aplicar cualquier cambio, indicar siempre la ruta exacta del archivo que se modificará.

### Paso 7b — Resumen final del revisor

```
📋 RESUMEN DEL ARSENAL
══════════════════════════════════════════════════════════════
  ✅ Aplicadas:   [X]
  ✏️  Modificadas: [X]
  ⏭️  Saltadas:    [X]
══════════════════════════════════════════════════════════════
🏹  "El carcaj de Bardo nunca está vacío. Hasta la próxima cacería."
```

AskUserQuestion con opciones de continuación:
- `🔙 Volver al menú de Bardo`
- `🔙 Volver a La Comunidad del Código`

---

## Casos especiales

### Sin MCPs ni plugins instalados
```
🏹 El arsenal está vacío, viajero.

   No se encontraron MCPs ni plugins configurados.

   Rutas verificadas:
     • ~/.claude.json (MCPs user scope)
     • .mcp.json (MCPs project scope)
     • .claude/settings.json (plugins)

💡 Usa "Conseguir un MCP" o "Conseguir un plugin" para equipar tu arsenal.
```

### Arsenal perfecto
```
🏹 Los arqueros de Lake-town inspeccionan el carcaj...

✅ Todos los MCPs y plugins están correctamente configurados.
   Smaug no tiene ninguna posibilidad, viajero.

Score global: 10/10 🏹 — todos en estado Flecha Negra
```

---

## 🔗 Fuentes

Ver índice completo en `@prompts/docs-sources.md`:
- MCP: `https://code.claude.com/docs/en/mcp`
- Plugins: `https://code.claude.com/docs/en/plugins`
- Discover plugins: `https://code.claude.com/docs/en/discover-plugins`

---

**Módulo**: `00-module-analyze.md`
**Invocado desde**: `bardo-main.md` (opción "Inspeccionar el arsenal")
**Requiere**: WebFetch on-demand, Read, Bash, Edit/Write (para aplicar mejoras)
