# 🔗 Módulo: Conseguir un MCP en el Mercado

## Misión

Guiar al usuario para buscar e instalar servidores MCP, con elección de scope
y transport, configuración de variables de entorno y verificación post-instalación.

---

## Paso 0 — Documentación oficial (on-the-fly)

**IMPORTANTE**: Comprobar primero si la documentación ya está en el contexto de esta sesión.

**Si ya está en contexto**: usar directamente sin re-fetchear.

**Si no está en contexto**, hacer WebFetch:

> **WebFetch**: `https://code.claude.com/docs/en/mcp`
> **Extraer**: estructura de configuración MCP, scopes (user/project), transports (stdio/SSE/HTTP),
> campos válidos en ~/.claude.json y .mcp.json, autenticación, env vars, ejemplos de configuración.

**Fallback si WebFetch falla**: Continuar con conocimiento interno marcando con ⚠️.

---

## Paso 1 — Mostrar MCPs ya configurados

```bash
{
  echo "=== USER SCOPE ==="
  cat ~/.claude.json 2>/dev/null || echo "{}"
  echo "=== PROJECT SCOPE ==="
  cat .mcp.json 2>/dev/null || echo "{}"
} 2>/dev/null
```

Mostrar resumen:
```
🔗 MCPs ya configurados:
  🌍 User scope (2):  github-copilot · sentry
  📂 Project scope (1): db-explorer

Esta será la referencia para detectar duplicados.
```

---

## Paso 2 — Obtener MCP a instalar

Dos vías de llegada:

### Desde recomendaciones del análisis (00-module-analyze.md)
Usar lista pre-cargada directamente.

### Llegada directa
AskUserQuestion:

```json
{
  "questions": [{
    "header": "Buscar MCP",
    "question": "🔗 ¿Qué tipo de MCP buscas?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔍 Ver MCPs populares para mi stack",
        "description": "Bardo seleccionará los más relevantes para tu proyecto"
      },
      {
        "label": "✍️ Escribir el nombre o URL del MCP",
        "description": ""
      },
      {
        "label": "💡 Ver todos los MCPs recomendados oficialmente",
        "description": "Basado en docs/en/mcp"
      },
      {
        "label": "🔙 Volver al menú principal",
        "description": ""
      }
    ]
  }]
}
```

---

## Paso 3 — Mostrar opciones de MCP

Basado en la documentación oficial obtenida via WebFetch, mostrar MCPs relevantes
para el stack detectado. Marcar con ✅ los ya instalados:

```
══════════════════════════════════════════════════════════════
🔗 MCPs disponibles para tu stack ([stack])
══════════════════════════════════════════════════════════════

  1. github-copilot-mcp
     📝 GitHub Copilot MCP oficial
     🚌 Transport: HTTP
     🔐 Requiere: token de GitHub
     ✅ YA INSTALADO (si aplica)

  2. sentry-mcp
     📝 Acceso a errores y releases de Sentry
     🚌 Transport: HTTP
     🔐 Requiere: API key de Sentry

  3. [nombre]
     📝 [descripción]
     🚌 Transport: [stdio/SSE/HTTP]
     🔐 [autenticación si aplica]

══════════════════════════════════════════════════════════════
```

---

## Paso 4 — Elegir scope

```json
{
  "questions": [{
    "header": "Scope del MCP",
    "question": "📍 ¿Dónde configurar \"[nombre]\"?",
    "multiSelect": false,
    "options": [
      {
        "label": "🌍 User scope (~/.claude.json)",
        "description": "Disponible en TODOS tus proyectos — recomendado para MCPs globales (GitHub, Slack...)"
      },
      {
        "label": "📂 Project scope (.mcp.json)",
        "description": "Solo para ESTE proyecto — recomendado para MCPs específicos (DB local, API interna...)"
      }
    ]
  }]
}
```

---

## Paso 5 — Configurar transport y variables de entorno

Según el tipo de MCP detectado en las docs oficiales:

### Transport stdio
```json
{
  "mcpServers": {
    "[nombre]": {
      "command": "[comando]",
      "args": ["[arg1]", "[arg2]"],
      "env": {
        "API_KEY": "[valor]"
      }
    }
  }
}
```

### Transport HTTP / SSE
```json
{
  "mcpServers": {
    "[nombre]": {
      "url": "[endpoint-url]",
      "headers": {
        "Authorization": "Bearer [token]"
      }
    }
  }
}
```

Si el MCP requiere variables de entorno, preguntar los valores al usuario
antes de escribir la configuración.

**IMPORTANTE**: Mostrar siempre la ruta exacta del archivo que se modificará antes de escribir.

---

## Paso 6 — Aplicar configuración

Escribir la configuración en el archivo de scope elegido:
- **User scope**: editar `~/.claude.json` (clave `mcpServers`)
- **Project scope**: crear/editar `.mcp.json`

Mostrar progreso:
```
🔗 Configurando "[nombre]"...
   📍 Archivo: [ruta exacta]
   ✓ Añadiendo configuración MCP
   ✓ Variables de entorno configuradas
```

---

## Paso 7 — Verificación post-instalación

Comprobar que el MCP quedó correctamente registrado:

```bash
{
  cat ~/.claude.json 2>/dev/null || echo "{}"
  cat .mcp.json 2>/dev/null || echo "{}"
} 2>/dev/null
```

```
══════════════════════════════════════════════════════════════
✅ MCP configurado correctamente
══════════════════════════════════════════════════════════════

  Nombre:   [nombre]
  Scope:    [user / project]
  Transport:[stdio / HTTP / SSE]
  Archivo:  [ruta]

💡 Recarga Claude Code para que el MCP esté disponible.

══════════════════════════════════════════════════════════════
```

---

## Paso 8 — Lore épico al finalizar

```
🏹 "La Flecha Negra apuntó. Y no falló.

    [nombre] ha sido añadido al arsenal de Lake-town.
    El dragón no tiene escapatoria ahora, viajero."
```

---

## Paso 9 — Acciones posteriores

```json
{
  "questions": [{
    "header": "MCP configurado",
    "question": "🏹 ¿Qué deseas hacer ahora?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔗 Configurar otro MCP",
        "description": ""
      },
      {
        "label": "🔌 Buscar un plugin",
        "description": ""
      },
      {
        "label": "🔙 Volver al menú principal",
        "description": ""
      }
    ]
  }]
}
```

---

## Manejo de errores

### MCP ya configurado
```
⚠️ "[nombre]" ya está configurado en [scope].

¿Qué deseas hacer?
```
AskUserQuestion: Reconfigurar / Añadir también en otro scope / Cancelar

### Error de permisos al escribir ~/.claude.json
```
❌ Sin permisos para editar ~/.claude.json
   Solución: chown $USER ~/.claude.json
   O bien: instala en project scope (.mcp.json)
```

---

## 🔗 Fuentes

Ver índice completo en `@prompts/docs-sources.md`:
- MCP: `https://code.claude.com/docs/en/mcp`

---

**Módulo**: `03-module-install-mcps.md`
**Invocado desde**: `bardo-main.md` (opción "Conseguir un MCP en el mercado")
**Requiere**: WebFetch on-demand, Read, Bash, Write/Edit
