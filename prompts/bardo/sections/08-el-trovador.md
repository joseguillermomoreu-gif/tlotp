## Opción 8 — El Trovador: Guía de mis MCPs y Plugins

### Intro de ejecución

```
🏹 Bardo desenvuelve los pergaminos del Puerto...
   No basta con saber qué hay instalado. Hay que saber usarlo.
   Consultando las fuentes oficiales de cada herramienta.
```

### Paso 1 — Obtener inventario instalado

Reutiliza los datos de MCPs y plugins si ya están en memoria de sesión (de opciones 1 y 2).
Si no están disponibles, ejecútalos automáticamente ahora:

```bash
# MCPs scope user
cat ~/.claude.json 2>/dev/null || echo "{}"
# MCPs scope project
cat .mcp.json 2>/dev/null || echo "{}"
# Plugins scope user
ls ~/.claude/plugins/ 2>/dev/null || echo ""
# Plugins scope project
ls .claude/plugins/ 2>/dev/null || echo ""
```

Si no hay **ningún** MCP ni plugin instalado:

```
🏹 Los almacenes del Fuerte están vacíos, señor.
   No hay herramientas instaladas que pueda presentaros.

   → Opción 1: Ver MCPs configurados
   → Opción 2: Ver plugins instalados
   → Opción 4: Explorar el marketplace
   → Opción 6: Instalar MCPs / plugins
```

Pregunta al usuario (AskUserQuestion):
- Volver al menú de Bardo
- Salir

### Paso 2 — Enriquecer con documentación oficial (WebFetch)

Para cada MCP y plugin del inventario, busca su documentación oficial.

#### Fuentes de documentación (en orden de prioridad)

**Para MCPs conocidos**, consulta la página oficial de MCPs de Claude Code:

```
WebFetch: https://code.claude.com/docs/en/mcp.md
```

Del contenido obtenido, extrae la descripción, uso y notas de autenticación del MCP en cuestión.

**Para MCPs o plugins con repositorio propio**, construye la URL del README en GitHub:

```
WebFetch: https://raw.githubusercontent.com/[org]/[repo]/main/README.md
```

Intenta inferir el repositorio a partir del comando o URL del MCP:
- Si el comando contiene `@bytebase/dbhub` → busca `github.com/bytebase/dbhub`
- Si la URL del MCP es `https://mcp.sentry.dev/mcp` → busca doc en `github.com/getsentry/sentry-mcp`
- Si el comando contiene `@modelcontextprotocol/` → busca en `github.com/modelcontextprotocol/servers`

**Para plugins de Claude Code**, consulta la documentación oficial de plugins:

```
WebFetch: https://code.claude.com/docs/en/plugins.md
```

Extrae del contenido la descripción del plugin, cómo se activa y si es automático o manual.

**Si el WebFetch falla** para un ítem concreto:
- Marca como `⚠️ doc no disponible`
- Usa el conocimiento interno para rellenar lo que sea posible
- Indica al usuario que la información puede no estar actualizada

### Paso 3 — Determinar modo de activación

Para cada ítem, determina su modo de activación:

**MCPs**:
- Todos los MCPs son `🟢 Automático` — se cargan al arrancar Claude Code y están disponibles sin invocación explícita
- Si el MCP requiere OAuth pendiente → `🟡 Requiere configuración` (ejecutar `/mcp` para autenticar)

**Plugins**:
- Plugins LSP → `🟢 Automático` — activos en segundo plano mientras Claude edita código
- Plugins de integración → `🟢 Automático` — disponibles como herramientas desde que arrancan
- Plugins de output/workflow → `🟢 Automático` — modifican el comportamiento de Claude sin invocación
- Plugin desactivado (`disabled: true`) → `⏸️ Desactivado` — no está activo hasta que se habilite

### Paso 4 — Mostrar guía completa

Para cada ítem muestra el bloque completo. Ordena: primero MCPs, luego plugins. Dentro de cada grupo, por scope (project antes que user).

```
🎵 El Trovador os presenta vuestro arsenal, señor del Fuerte:

════════════════════════════════════════════════════════════

🔌 MCP Servers instalados:

──────────────────────────────────────────────────────────
🔌 github  [MCP · http · scope: project]
   ¿Qué hace?    Integración completa con GitHub desde Claude Code:
                 acceso a PRs, issues, repositorios, code review y CI/CD
   ¿Cómo se usa? De forma natural en lenguaje conversacional:
                 "Revisa el PR #42"  /  "¿Qué issues tengo asignados?"
                 "Crea un PR desde esta rama con descripción automática"
   Activación    🟢 Automático — disponible desde que arranca Claude Code
                 ⚠️  Requiere OAuth → ejecuta /mcp para autenticar con GitHub
   💡 Tip        Úsalo para hacer code review sin salir del editor:
                 "¿Qué cambios introduce el PR #38 y qué riesgos ves?"
   📚 Fuente     https://code.claude.com/docs/en/mcp.md

──────────────────────────────────────────────────────────
🔌 postgresql  [MCP · stdio · scope: user]
   ¿Qué hace?    Permite a Claude ejecutar consultas SQL directamente
                 contra tu base de datos PostgreSQL
   ¿Cómo se usa? "¿Cuántos usuarios se registraron esta semana?"
                 "Muéstrame el esquema de la tabla orders"
                 "Encuentra registros duplicados en products"
   Activación    🟢 Automático — disponible desde que arranca Claude Code
   💡 Tip        Ideal para introspección de esquemas y debugging de datos
                 sin necesidad de abrir un cliente SQL externo
   📚 Fuente     https://raw.githubusercontent.com/bytebase/dbhub/main/README.md

════════════════════════════════════════════════════════════

🧩 Plugins instalados:

──────────────────────────────────────────────────────────
🧩 php-lsp  [Plugin · LSP · scope: user]
   ¿Qué hace?    Language Server Protocol para PHP: detecta errores de tipo,
                 proporciona autocompletado y navega por el código del proyecto
   ¿Cómo se usa? No requiere invocación — Claude lo usa en segundo plano
                 automáticamente al leer y editar archivos .php
   Activación    🟢 Automático — activo en segundo plano mientras Claude edita
   💡 Tip        Claude avisará de errores de tipo PHP antes de que los detecte
                 PHPStan. Especialmente útil en refactorizaciones grandes.
   📚 Fuente     https://code.claude.com/docs/en/plugins.md

──────────────────────────────────────────────────────────
🧩 explanatory-output-style  [Plugin · output · scope: user]  ⏸️ Desactivado
   ¿Qué hace?    Modifica el estilo de respuesta de Claude para incluir
                 explicaciones detalladas paso a paso
   ¿Cómo se usa? No requiere invocación — modifica el comportamiento global
   Activación    ⏸️ Desactivado — activa con: /plugin enable explanatory-output-style
   💡 Tip        Útil en sesiones de aprendizaje o cuando necesitas que Claude
                 justifique cada decisión de implementación
   📚 Fuente     https://code.claude.com/docs/en/plugins.md

════════════════════════════════════════════════════════════

📊 Total: X herramientas documentadas  |  Y MCPs  |  Z plugins
```

### Paso 5 — Ítems no reconocidos

Si hay MCPs o plugins cuya documentación no pudo obtenerse ni está en el conocimiento interno:

```
──────────────────────────────────────────────────────────
🔌 [nombre-desconocido]  [MCP · stdio · scope: user]  ⚠️ Sin documentación
   ¿Qué hace?    Herramienta no reconocida — no se encontró documentación oficial
   ¿Cómo se usa? Desconocido
   Activación    🟢 Automático (asumido)
   💡 Sugerencia Puedes buscar información con la opción 4 (marketplace)
                 o consultar el repositorio del comando: [comando/url del MCP]
```

### Paso 6 — Volver al menú

Tras mostrar toda la guía, preguntar al usuario:

```json
{
  "questions": [{
    "header": "Bardo · El Trovador",
    "question": "🏹 ¿Qué deseas hacer ahora, señor del Fuerte?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔙 Volver al menú de Bardo",
        "description": "Regresar a Lake-town"
      },
      {
        "label": "🔙 Volver a La Comunidad del Código",
        "description": "Regresar al menú principal de TLOTP"
      }
    ]
  }]
}
```

---

