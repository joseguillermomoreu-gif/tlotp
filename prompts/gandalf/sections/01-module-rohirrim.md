# 🏇 Módulo G1 — Los Exploradores Rohirrim

## Misión

Desplegar 5 agentes en paralelo usando el Agent tool para explorar el proyecto
antes de hacer ninguna pregunta al usuario. El mapa se traza en silencio,
como los jinetes de Rohan al galope.

---

## Modo de despliegue

### Con Agent Team (GANDALF_EXPLORERS definido)

Si `GANDALF_TEAM` está definido y `GANDALF_EXPLORERS` tiene agentes:

Mostrar animación adaptada:

```
⚡ GANDALF — Convocando al Consejo de Exploradores...
══════════════════════════════════════════════════════════════

  Los jinetes del team cabalgan hacia el horizonte.
  Sus especialidades guían la exploración.

  🏇 [nombre-agente-1] ([tipo]) ....  ⚔️  en misión
  🏇 [nombre-agente-2] ([tipo]) ....  ⚔️  en misión
  ...

══════════════════════════════════════════════════════════════
  "¡Los Rohirrim del Consejo cabalgan! La exploración ha comenzado."
```

Los roles de exploración se adaptan según el tipo de agente:
- `php-pro` → explora stack backend PHP
- `qa-expert` → explora testing y calidad
- `devops-engineer` → explora CI/CD e infraestructura
- `frontend-developer` → explora stack frontend
- `python-pro` → explora stack Python
- `typescript-pro` → explora stack TypeScript
- `database-administrator` → explora bases de datos y schemas
- Cualquier otro → exploración genérica del proyecto

Lanzar un Agent por cada explorador de `GANDALF_EXPLORERS` en paralelo, adaptando
el prompt de exploración según el tipo de agente listado arriba.

Tras recoger resultados, continuar a G2 normalmente.

### Sin Agent Team (modo clásico)

Si NO hay `GANDALF_TEAM` o el usuario eligió "Continuar sin team" o
eligió "Rohirrim clásicos", mostrar lore épico antes de los 5 Rohirrim clásicos:

```
╔════════════════════════════════════════════════════════════╗
║  ⚡ GANDALF — El Mago Blanco cabalga en solitario          ║
╚════════════════════════════════════════════════════════════╝

  "Ningún jinete de Rohan me acompaña hoy.
   Pero el Mago Blanco no necesita escolta para
   llegar a las bibliotecas de Minas Tirith."

  🧙 Gandalf parte hacia el Archivo del Saber...
  Los 5 Rohirrim cabalgan en su nombre.
```

Continuar con la animación y los 5 Rohirrim clásicos tal como están a continuación.

---

## Animación de despliegue

Mostrar antes de lanzar los agentes:

```
⚡ GANDALF — Desplegando los Exploradores Rohirrim...
══════════════════════════════════════════════════════════════

  Los cinco jinetes cabalgan hacia el horizonte.
  Mientras exploran, Gandalf aguarda en la Torre Blanca.

  🏇 Éowyn del Stack...........  ⚔️  en misión
  🏇 Théoden del Dominio.......  ⚔️  en misión
  🏇 Merry de la Forja.........  ⚔️  en misión
  🏇 Pippin de los Ents........  ⚔️  en misión
  🏇 Gamling de los Nexos......  ⚔️  en misión

══════════════════════════════════════════════════════════════
  "¡Jinetes de Théoden, alzaos! La exploración ha comenzado."
```

---

## Los 5 Rohirrim — Prompts del Agent tool

Lanzar los 5 usando Agent tool **en paralelo** (un solo mensaje con 5 tool calls):

### 🏇 Éowyn del Stack

```
Eres un explorador de stack tecnológico. Analiza el proyecto actual y devuelve
un JSON estructurado con: lenguajes detectados (con versiones si hay config),
frameworks y librerías principales, base de datos (si hay config), herramientas
de testing, herramientas de build/bundler.

Busca: package.json, composer.json, requirements.txt, pyproject.toml, go.mod,
Gemfile, pom.xml, build.gradle, .nvmrc, .tool-versions, tsconfig.json.

Devuelve SOLO JSON válido, sin texto adicional:
{
  "languages": [],
  "frameworks": [],
  "databases": [],
  "testing_tools": [],
  "build_tools": [],
  "versions": {}
}
```

### 🏇 Théoden del Dominio

```
Eres un explorador de arquitectura y dominio. Analiza la estructura del proyecto
y devuelve un JSON con: tipo de aplicación (API/CLI/web/library/monolith/microservice),
patrón arquitectónico detectado (hexagonal/MVC/clean/layered/etc.),
módulos o bounded contexts identificados, tipo de frontend si existe.

Busca estructura de carpetas (máx 3 niveles), README.md, docs/, ficheros de config.
NO leas lógica de negocio en detalle — solo estructura y nombres de carpetas/clases.

Devuelve SOLO JSON válido:
{
  "app_type": "",
  "architecture_pattern": "",
  "modules": [],
  "has_frontend": false,
  "frontend_type": "",
  "notes": ""
}
```

### 🏇 Merry de la Forja

```
Eres un explorador de testing y calidad. Analiza la configuración de tests del
proyecto y devuelve un JSON con: frameworks de test detectados, tipos de tests
presentes (unit/integration/e2e/mutation), configuración de cobertura si existe,
herramientas de calidad (linters, static analysis).

Busca: phpunit.xml, jest.config.*, playwright.config.*, pytest.ini, .eslintrc,
phpstan.neon, sonar*, Makefile (targets de test), .github/workflows/ (jobs de test).

Devuelve SOLO JSON válido:
{
  "test_frameworks": [],
  "test_types": [],
  "coverage_configured": false,
  "coverage_threshold": null,
  "quality_tools": [],
  "test_commands": []
}
```

### 🏇 Pippin de los Ents

```
Eres un explorador de CI/CD e infraestructura. Analiza la configuración de
pipelines y entorno del proyecto y devuelve un JSON con: herramienta CI/CD,
workflows/pipelines detectados (nombres y triggers), Docker presente, cloud/hosting
detectado, entornos definidos, scripts de deploy.

Busca: .github/workflows/, .gitlab-ci.yml, Jenkinsfile, Dockerfile, docker-compose*,
.env.*, Makefile (targets de deploy), fly.toml, railway.toml, vercel.json.

Devuelve SOLO JSON válido:
{
  "ci_tool": "",
  "workflows": [],
  "has_docker": false,
  "cloud": "",
  "environments": [],
  "deploy_scripts": []
}
```

### 🏇 Gamling de los Nexos

```
Eres un explorador de integraciones externas. Analiza las conexiones externas
del proyecto y devuelve un JSON con: MCPs de Claude Code instalados,
agentes Claude Code presentes, APIs externas referenciadas (sin valores secretos),
sistemas de auth detectados, webhooks o event buses.

Busca: .claude.json, ~/.claude.json (si accesible), .mcp.json, agents/ en
.claude/ o raíz, .env.* (solo claves, no valores), config/services.yaml (Symfony),
package.json (dependencias de API clients).

Devuelve SOLO JSON válido:
{
  "mcps_installed": [],
  "agents_installed": [],
  "external_apis": [],
  "auth_systems": [],
  "event_systems": [],
  "notes": ""
}
```

---

## Timeout y manejo de fallos

- Timeout por Rohirrim: 60 segundos
- Si un agente no devuelve JSON válido o falla: marcar como `⚠️ sin datos`
- El flujo continúa incluso con Rohirrim fallidos — el informe indica cuáles fallaron

---

## Caso Greenfield

Si la carpeta está vacía o solo contiene README/LICENSE/gitignore y no hay
código fuente: los Rohirrim regresan con datos mínimos y se detecta automáticamente.

Indicadores de greenfield:
- Ningún `package.json`, `composer.json`, `requirements.txt`, etc.
- Sin carpetas `src/`, `app/`, `lib/`
- Sin archivos `.php`, `.ts`, `.py`, `.go`, etc.

En este caso: continuar a G2 con plantilla greenfield y nota especial:
```
⚡ "Tierra en blanco. El lienzo está vacío.
   La historia que escribas aquí comenzará desde cero.
   Como la Comarca antes de que llegaran los hobbits."
```

---

## Transición automática

Tras lanzar los agentes y recoger sus resultados, **sin preguntar al usuario**,
continuar automáticamente a:

- Si es exploración completa (venía de "Iniciar nueva aventura"):
  → Cargar `@prompts/gandalf/sections/02-module-field-report.md`

- Si es "Solo exploración Rohirrim":
  → Mostrar informe G2 y volver al menú sin continuar al G3

---

**Módulo**: `01-module-rohirrim.md`
**Invocado desde**: `gandalf-main.md`
**Requiere**: Agent tool (x5 en paralelo), Bash, Glob
