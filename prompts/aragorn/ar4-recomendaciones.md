# 👑 AR4 - La Visión del Palantír Real: Motor de Recomendaciones

## Intro de ejecución

```
👑 Aragorn consulta el Palantír del Rey...
   Viendo el stack del Fuerte y los guerreros que mejor lo servirían.
   Analizando el proyecto y consultando marketplaces.
```

---

## Paso 1 — Detectar stack tecnológico

Ejecutar para detectar qué tecnologías usa el proyecto:

```bash
ls composer.json package.json requirements.txt pyproject.toml go.mod Cargo.toml pom.xml build.gradle playwright.config.ts phpunit.xml behat.yml .github/workflows/ Dockerfile docker-compose.yml 2>/dev/null
```

Para cada fichero encontrado, leer y extraer tecnologías:

**`composer.json`** → PHP
```bash
cat composer.json 2>/dev/null
```
- `symfony/` en require → **Symfony**
- `laravel/` → **Laravel**
- `doctrine/` → **Doctrine**
- `phpunit/` → **PHPUnit**

**`package.json`** → Node/JS/TS
```bash
cat package.json 2>/dev/null
```
- `typescript` → **TypeScript**
- `react` → **React**
- `next` → **Next.js**
- `vue` → **Vue**
- `@playwright/test` → **Playwright**

**`requirements.txt` / `pyproject.toml`** → **Python**
- `django` → **Django**
- `fastapi` → **FastAPI**
- `pytest` → **pytest**

**`go.mod`** → **Go**
**`Cargo.toml`** → **Rust**
**`playwright.config.ts`** → **Playwright E2E**
**`phpunit.xml`** → **PHPUnit**
**`behat.yml`** → **Behat BDD**
**`.github/workflows/`** → **GitHub Actions**

---

## Paso 2 — Consultar marketplaces (WebFetch)

Reutilizar datos de sesión si ya se consultaron en AR3.
Si no, hacer WebFetch a:
```
WebFetch: https://raw.githubusercontent.com/VoltAgent/awesome-claude-code-subagents/main/README.md
```

---

## Paso 3 — Matching stack → agentes

Para cada tecnología detectada, aplicar estas reglas de matching.
**Excluir siempre** agentes ya instalados (comparando con AR1).

| Stack detectado | Agentes recomendados | Por qué |
|-----------------|----------------------|---------|
| PHP / Symfony | `symfony-expert`, `php-refactor` | Experto en la arquitectura del proyecto |
| PHP / Laravel | `laravel-expert` | Especialista en Laravel |
| PHPUnit | `phpunit-generator` | Acelera la cobertura de tests |
| Behat | `behat-scenario-writer` | Genera escenarios BDD |
| TypeScript | `typescript-expert`, `type-checker` | Mejora tipado y refactor |
| React | `react-component-generator` | Genera componentes con buenas prácticas |
| Next.js | `nextjs-expert` | Optimizaciones y patrones Next.js |
| Playwright | `playwright-test-writer` | Genera E2E tests automáticamente |
| Python | `python-expert` | Mejoras de código Python |
| Django | `django-expert` | Patrones y optimizaciones Django |
| FastAPI | `fastapi-expert` | APIs rápidas con FastAPI |
| GitHub Actions | `github-actions-optimizer` | Optimiza workflows CI/CD |
| Docker | `dockerfile-optimizer` | Mejora Dockerfiles y compose |
| Go | `go-expert` | Patrones idiomáticos de Go |
| Rust | `rust-expert` | Ownership, lifetimes, patrones Rust |

---

## Paso 4 — Mostrar recomendaciones

```
💡 RECOMENDACIONES PARA TU PROYECTO
══════════════════════════════════════════════════════

Stack detectado: PHP/Symfony · PHPUnit · Playwright · GitHub Actions

Agentes recomendados:
──────────────────────────────────────────────────────

  ⭐ symfony-expert  [VoltAgent / 08-backend]
     🎯 Por qué: Tu proyecto usa Symfony — conoce su arquitectura a fondo
     📝 Qué hace: Analiza services, repositorios, bundles y queries Doctrine
     💡 Ejemplo: "Analiza UserRepository y sugiere mejoras de rendimiento"

  ⭐ phpunit-generator  [VoltAgent / 02-testing]
     🎯 Por qué: Tienes phpunit.xml — acelera la cobertura de tests
     📝 Qué hace: Genera tests PHPUnit con mocks y fixtures automáticamente
     💡 Ejemplo: "Genera tests para OrderService cubriendo casos edge"

  ⭐ playwright-test-writer  [VoltAgent / 02-testing]
     🎯 Por qué: Tienes Playwright configurado — genera E2E sin esfuerzo
     📝 Qué hace: Escribe tests E2E siguiendo Page Object Model
     💡 Ejemplo: "Genera el test E2E del flujo de checkout"

  ⭐ github-actions-optimizer  [aitmpl.com]
     🎯 Por qué: Tienes workflows en .github/workflows/
     📝 Qué hace: Analiza y optimiza pipelines CI/CD
     💡 Ejemplo: "Revisa mi CI y reduce el tiempo de ejecución"

══════════════════════════════════════════════════════
📊 4 recomendaciones  |  3 de VoltAgent  |  1 de aitmpl.com
```

Si no hay recomendaciones tras el matching:
```
👑 El Fuerte ya está bien equipado o usa tecnologías poco comunes.
   Puedes explorar el marketplace manualmente (opción 2).
```

---

## Paso 5 — Ofrecer instalación

Tras mostrar recomendaciones, **usar AskUserQuestion**:
- Instalar todos los recomendados (ir a AR5 con lista pre-cargada)
- Seleccionar cuáles instalar (ir a AR5 con selección manual)
- Volver al menú de Aragorn
- Salir
