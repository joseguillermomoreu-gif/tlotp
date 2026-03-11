## Opción 5 — Ver recomendaciones para este proyecto

### Intro de ejecución

```
🏹 Bardo despliega su catálogo sobre la mesa...
   Seleccionando solo lo que el Fuerte realmente necesita.
```

### Paso 1 — Verificar datos disponibles en sesión

Comprueba si ya tienes en memoria de sesión:
- Stack detectado (de Opción 3)
- MCPs ya instalados (de Opción 1)
- Plugins ya instalados (de Opción 2)
- Lista de MCPs del marketplace (de Opción 4)

Si falta el **stack**: ejecuta automáticamente la Opción 3 antes de continuar.
Informa al usuario: *"Primero necesito conocer el Fuerte. Lanzando análisis de stack..."*

Si falta la **lista del marketplace**: ejecuta automáticamente la Opción 4.
Informa al usuario: *"Consultando los mercados exteriores antes de recomendar..."*

### Paso 2 — Aplicar reglas de matching

Para cada tecnología detectada en el stack, aplica estas reglas.
**Excluye siempre lo que ya está instalado** (comparando con listas de B1 y B2).

#### Reglas MCP Servers

| Stack detectado | MCP recomendado | Por qué |
|----------------|-----------------|---------|
| PHP / Symfony / Laravel | — | No hay MCP específico de PHP |
| TypeScript / Node | — | No hay MCP específico de Node |
| Python | — | No hay MCP específico de Python |
| PostgreSQL | `postgresql` (o similar en marketplace) | Permite consultar la BD directamente desde Claude |
| MySQL / MariaDB | MCP de MySQL si aparece en marketplace | Idem |
| GitHub detectado | `github` | Gestión de PRs, issues y code review desde Claude |
| GitLab detectado | `gitlab` | Idem para GitLab |
| Sentry en deps | `sentry` | Analizar errores de producción directamente |
| Slack en deps | `slack` | Leer canales, enviar mensajes desde Claude |
| Linear en deps | `linear` | Gestionar issues de Linear desde Claude |
| Jira referenciado | `atlassian` | Gestionar tickets de Jira/Confluence |
| Figma referenciado | `figma` | Acceder a diseños directamente |
| Vercel / vercel.json | `vercel` | Gestionar deploys desde Claude |
| Firebase | `firebase` | Gestionar Firebase desde Claude |
| Supabase | `supabase` | Gestionar Supabase desde Claude |
| Stripe en deps | `stripe` | Gestionar pagos desde Claude |

#### Reglas Plugins

| Stack detectado | Plugin recomendado | Por qué |
|----------------|--------------------|---------|
| PHP | `php-lsp` | Detecta errores de tipo PHP en tiempo real mientras Claude edita |
| TypeScript | `typescript-lsp` | Soporte completo de tipos TypeScript |
| Python | `pyright-lsp` | Type checking Python en tiempo real |
| Go | `gopls-lsp` | LSP oficial de Go |
| Rust | `rust-analyzer-lsp` | LSP de Rust |
| Java | `jdtls-lsp` | LSP de Java |
| C# | `csharp-lsp` | LSP de C# |
| C/C++ | `clangd-lsp` | LSP de C/C++ |
| GitHub detectado | `github` (plugin) | PR reviews, issues, CI desde Claude |
| GitLab detectado | `gitlab` (plugin) | Idem para GitLab |
| Jira referenciado | `atlassian` (plugin) | Tickets desde Claude |

### Paso 3 — Formatear recomendaciones con contexto completo

Para **cada ítem recomendado** muestra: qué es, por qué se recomienda, para qué sirve y un ejemplo de uso real.

Usa este formato:

```
📦 Cargamento recomendado para tu Fuerte:

════════════════════════════════════════

🔌 MCP Servers sugeridos:

  ⭐ github  [MCP]
     📌 Por qué: Se detectó .github/ en el proyecto
     🎯 Para qué: Acceder a PRs, issues, CI y code review directamente desde Claude
     💡 Ejemplo: "Revisa el PR #42 y sugiere mejoras en los tests"
                 "¿Qué issues están asignados a mí esta semana?"
                 "Crea un PR desde esta rama con descripción automática"
     ⚙️  Instalar: claude mcp add --transport http github https://api.githubcopilot.com/mcp/

  ⭐ sentry  [MCP]
     📌 Por qué: Se detectó @sentry/ en las dependencias
     🎯 Para qué: Analizar errores de producción y correlacionarlos con el código
     💡 Ejemplo: "¿Cuáles son los 3 errores más frecuentes en producción esta semana?"
                 "Encuentra el código que causa este Sentry error y propón un fix"
     ⚙️  Instalar: claude mcp add --transport http sentry https://mcp.sentry.dev/mcp

════════════════════════════════════════

🧩 Plugins sugeridos:

  ⭐ php-lsp  [Plugin LSP]
     📌 Por qué: Se detectó PHP/Symfony en el stack
     🎯 Para qué: Claude detecta errores de tipo PHP en tiempo real al editar código
     💡 Ejemplo: Claude avisa de un tipo incorrecto al escribir un método antes de que
                 lo detecte PHPStan. Autocompletado de clases y métodos del proyecto.
     ⚙️  Instalar: /plugin install php-lsp@claude-plugins-official

  ⭐ typescript-lsp  [Plugin LSP]
     📌 Por qué: Se detectó TypeScript en el stack
     🎯 Para qué: Soporte completo de tipos TypeScript mientras Claude trabaja
     💡 Ejemplo: "Refactoriza esta función y asegúrate de que los tipos siguen siendo correctos"
     ⚙️  Instalar: /plugin install typescript-lsp@claude-plugins-official

════════════════════════════════════════

📊 Total: X recomendaciones  |  Y MCPs  |  Z plugins
```

Si después del matching no hay nada nuevo que recomendar:

```
🏹 El Fuerte ya está bien equipado.
   No hay mercancía nueva relevante para tu stack que no tengas ya instalada.
```

### Paso 4 — Ofrecer instalación directa

Tras mostrar las recomendaciones, pregunta al usuario (AskUserQuestion):
- Instalar todo lo recomendado (ir a Opción 6 con la lista pre-cargada)
- Seleccionar qué instalar (ir a Opción 6 con selección manual)
- Volver al menú de Bardo
- Salir

---

