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
3. Detectar stack tecnológico
4. Consultar marketplace en tiempo real
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

### Intro de ejecución

```
🏹 Bardo sube a los tejados del Fuerte...
   Observando qué se forja en sus talleres.
```

### Paso 1 — Detectar lenguajes y frameworks

Ejecuta estos comandos para comprobar qué archivos de configuración existen:

```bash
ls composer.json package.json requirements.txt pyproject.toml go.mod Cargo.toml pom.xml build.gradle 2>/dev/null
```

Para cada archivo encontrado, lee su contenido y extrae:

**`composer.json`** → PHP
```bash
cat composer.json 2>/dev/null
```
- Presencia de `symfony/` en require → **Symfony**
- Presencia de `laravel/` en require → **Laravel**
- Presencia de `doctrine/` → **Doctrine ORM**
- Campo `php` en require → versión de PHP

**`package.json`** → Node/JavaScript/TypeScript
```bash
cat package.json 2>/dev/null
```
- `typescript` en dependencies/devDependencies → **TypeScript**
- `react` → **React**
- `next` → **Next.js**
- `vue` → **Vue**
- `@angular/core` → **Angular**
- `express` → **Express**
- `nestjs` → **NestJS**

**`requirements.txt` o `pyproject.toml`** → Python
```bash
cat requirements.txt pyproject.toml 2>/dev/null
```
- `django` → **Django**
- `fastapi` → **FastAPI**
- `flask` → **Flask**
- `pytest` → tiene testing con pytest

**`go.mod`** → **Go** (leer para detectar frameworks como Gin, Echo)

**`Cargo.toml`** → **Rust** (leer para detectar Actix, Axum)

**`pom.xml` o `build.gradle`** → **Java** (leer para detectar Spring)

### Paso 2 — Detectar base de datos e infraestructura

```bash
ls docker-compose.yml docker-compose.yaml Dockerfile .env.example .env 2>/dev/null
```

Leer los archivos encontrados y detectar:
- `postgres` / `postgresql` → **PostgreSQL**
- `mysql` / `mariadb` → **MySQL**
- `mongodb` / `mongo` → **MongoDB**
- `redis` → **Redis**
- `elasticsearch` → **Elasticsearch**

También buscar en `composer.json` / `package.json` / `requirements.txt`:
- `doctrine/dbal`, `pg`, `psycopg2` → **PostgreSQL**
- `mysql2`, `doctrine/orm` con mysql → **MySQL**
- `redis`, `predis` → **Redis**

### Paso 3 — Detectar herramientas de proyecto y servicios externos

```bash
ls .github/ .gitlab/ 2>/dev/null
```
- `.github/` → **GitHub**
- `.gitlab/` → **GitLab**

Buscar en dependencias (package.json, composer.json, requirements.txt):
- `@sentry/` o `sentry-sdk` → **Sentry**
- `@linear/` → **Linear**
- `jira` en scripts/README → **Jira**
- `@slack/` o `slack-sdk` → **Slack**
- `stripe` → **Stripe**
- `@vercel/` o `vercel.json` → **Vercel**
- `firebase` → **Firebase**
- `@supabase/` → **Supabase**
- `figma` en README → **Figma**

```bash
ls vercel.json firebase.json .netlify/ 2>/dev/null
```

### Paso 4 — Mostrar resultado

```
🔭 Stack detectado en el Fuerte:

💻 Lenguajes:       PHP 8.3, TypeScript
🏗️  Frameworks:     Symfony 7, React 18
🗄️  Base de datos:  PostgreSQL, Redis
🔧 Herramientas:   GitHub, Sentry
🐳 Infraestructura: Docker

→ Stack guardado en memoria para las recomendaciones (opción 5).
```

Si no se detecta nada:

```
🏹 Bardo no reconoce el stack de este Fuerte.
   Puede que sea un proyecto vacío o que use tecnologías poco comunes.
   Puedes igualmente consultar el marketplace (opción 4) para explorar manualmente.
```

### Paso 5 — Guardar en memoria de sesión

Guarda el stack detectado en una variable de contexto para que la Opción 5 pueda usarlo
sin necesidad de relanzar el análisis.

### Paso 6 — Volver al menú

Tras mostrar el resultado, pregunta al usuario (AskUserQuestion):
- Volver al menú de Bardo
- Ver recomendaciones ahora (ir a Opción 5)
- Salir

---

## Opción 4 — Consultar marketplace en tiempo real

### Intro de ejecución

```
🏹 Bardo parte por los canales ocultos hacia los mercados exteriores...
   Trayendo información fresca. No confío en mapas viejos.
```

### Parte A — MCP Servers (WebFetch en tiempo real)

Ejecuta un WebFetch a la documentación oficial de MCP:

**URL**: `https://code.claude.com/docs/en/mcp.md`

Del contenido obtenido, extrae y presenta:
- La lista de MCP servers disponibles con sus nombres y descripciones
- El comando de instalación para cada uno (`claude mcp add ...`)
- Cualquier nota sobre autenticación requerida

Muestra el resultado así:

```
🌊 MCP Servers disponibles (fuente oficial — tiempo real):

  github        → Integración con GitHub: PRs, issues, code review
                  claude mcp add --transport http github https://api.githubcopilot.com/mcp/

  sentry        → Monitoreo de errores en producción
                  claude mcp add --transport http sentry https://mcp.sentry.dev/mcp

  postgresql    → Consultas directas a bases de datos PostgreSQL
                  claude mcp add --transport stdio postgresql -- npx ...

  [... lista completa según la página oficial ...]
```

Si el WebFetch falla (sin conexión o URL cambiada):

```
⚠️  Bardo no pudo llegar a los mercados exteriores.
    Verifica tu conexión o consulta directamente:
    → https://code.claude.com/docs/en/mcp.md
```

### Parte B — Plugins (marketplace interactivo)

A diferencia de los MCPs, el catálogo de plugins **no tiene una página web estática**.
El marketplace oficial de plugins vive dentro del propio Claude Code.

Informa al usuario:

```
🧩 Plugins disponibles — Marketplace oficial de Claude Code:

  El catálogo de plugins se navega directamente en Claude Code.
  Para explorar y instalar plugins disponibles, ejecuta:

    /plugin

  Desde ahí puedes:
    → Pestaña "Discover": ver todos los plugins del marketplace oficial
    → Buscar por nombre o categoría
    → Instalar con un solo comando eligiendo el scope

  Plugins destacados del marketplace oficial:
    • php-lsp, typescript-lsp, python-lsp... → Code intelligence (LSP)
    • github, gitlab, slack, sentry...       → Integraciones externas
    • commit-commands, pr-review-toolkit...  → Workflow de desarrollo
```

### Parte C — Guardar en memoria de sesión

Guarda la lista de MCPs obtenida en memoria de sesión para que la Opción 5 pueda
hacer el matching con el stack sin necesidad de repetir el WebFetch.

### Paso final — Volver al menú

Tras mostrar ambas partes, pregunta al usuario (AskUserQuestion):
- Volver al menú de Bardo
- Ver recomendaciones ahora (ir a Opción 5)
- Salir

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
