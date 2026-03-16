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

## Paso 2 — Analizar y puntuar cada ítem

Cada MCP y plugin parte de **10 puntos** y se penaliza:

### Criterios de scoring

| Criterio | Penalización | Severidad |
|----------|-------------|-----------|
| MCP sin campo `command` o `url` válido | -4 pts | ❌ Crítico |
| MCP con URL/endpoint obsoleto o inaccesible | -3 pts | ❌ Crítico |
| MCP en scope incorrecto (user cuando debería ser project o viceversa) | -2 pts | ⚠️ Mejorable |
| Plugin sin configuración recomendada según docs oficiales | -2 pts | ⚠️ Mejorable |
| Redundancia: MCP + plugin que cubren la misma funcionalidad | -2 pts | ⚠️ Mejorable |
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
    🏹 10/10  github-copilot   — endpoint ✅ · scope correcto ✅
    ⚔️  8/10  sentry           — scope user ⚠️ (recomendado: project)

  📂 Project scope (.mcp.json):
    ❌  5/10  db-explorer      — command inválido ❌

🔌 PLUGINS INSTALADOS
──────────────────────────────────────────────────────────────
  ⚔️  8/10  git-lens          — sin configuración recomendada ⚠️

══════════════════════════════════════════════════════════════
📊 Score global: 7.8/10 ⚔️ — 4 ítems · 1 🏹 · 2 ⚔️ · 1 ❌
══════════════════════════════════════════════════════════════
```

---

## Paso 4 — MCPs y plugins recomendados no instalados

Basado en el stack detectado y la documentación oficial, listar qué podría ser útil:

```
💡 OPORTUNIDADES DETECTADAS PARA TU STACK
──────────────────────────────────────────────────────────────
  Stack: PHP/Symfony · TypeScript · PostgreSQL

  🔗 MCPs recomendados no instalados:
    • slack-mcp       — si usas Slack como equipo
    • postgres-mcp    — acceso directo a tu DB desde Claude

  🔌 Plugins recomendados no instalados:
    • (basado en docs/en/discover-plugins, WebFetch ya cargado)
──────────────────────────────────────────────────────────────
```

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
        "label": "🔌 Buscar e instalar los recomendados",
        "description": "Solo si se detectaron oportunidades"
      },
      {
        "label": "🔙 Volver al menú principal",
        "description": ""
      }
    ]
  }]
}
```

> **Nota**: la opción de instalar recomendados solo aparece si se detectaron oportunidades en el Paso 4.

---

## Paso 7 — Revisor uno a uno

Iterar por cada mejora de la lista del Paso 5, **en orden de severidad** (❌ primero, ⚠️ después, ℹ️ al final).

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
