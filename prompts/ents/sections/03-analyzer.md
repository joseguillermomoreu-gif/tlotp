# 🔍 Analyzer - Escaneo del CI/CD Actual

## Misión

Escanear el proyecto completo para detectar toda la infraestructura de CI/CD existente.
Generar un inventario exhaustivo de lo que el proyecto posee.

---

## Paso 1: Escaneo de Archivos CI/CD

**Buscar en el proyecto** los siguientes elementos usando las herramientas Glob y Read:

### 1.1 GitHub Actions Workflows

```
Buscar: .github/workflows/*.yml, .github/workflows/*.yaml
```

Para cada workflow encontrado, extraer:
- **Nombre** del workflow (`name:`)
- **Triggers** (`on:`) - push, pull_request, schedule, workflow_dispatch, etc.
- **Jobs** - nombre de cada job y sus steps
- **Runners** (`runs-on:`)
- **Servicios** (`services:`)
- **Matrices** (`strategy.matrix`)
- **Secrets** referenciados (`secrets.*`)
- **Variables** de entorno (`env:`)
- **Caching** (`actions/cache`, `actions/setup-*` con cache)
- **Artifacts** (`actions/upload-artifact`, `actions/download-artifact`)
- **Concurrency** groups
- **Permissions** (`permissions:`)
- **Reusable workflows** (`uses: ./.github/workflows/...` o externos)

### 1.2 Configuración de Branch Protection

```
Buscar: .github/branch-protection.yml, .github/settings.yml (probot settings)
```

**Nota**: Branch protection rules normalmente se configuran en la UI de GitHub o via API.
Informar al usuario que para ver las reglas activas necesita acceso admin al repo.

### 1.3 Otros archivos CI/CD relacionados

```
Buscar:
- .github/dependabot.yml          → Dependabot config
- .github/renovate.json           → Renovate config
- .github/CODEOWNERS              → Code owners
- .github/pull_request_template.md → PR template
- .github/ISSUE_TEMPLATE/         → Issue templates
- .releaserc, .releaserc.json, .releaserc.yml → Semantic release
- release.config.js, release.config.cjs → Semantic release
- .changeset/                     → Changesets config
- Makefile                        → Make targets (pueden tener CI tasks)
- Dockerfile, docker-compose.yml  → Docker (relevante para CI)
- .dockerignore                   → Docker ignore
- .env.example, .env.ci           → Env configs para CI
- .nvmrc, .node-version, .tool-versions → Version pinning
- .editorconfig                   → Editor config
- .pre-commit-config.yaml         → Pre-commit hooks
- .husky/                         → Husky git hooks
- .lintstagedrc, lint-staged.config.* → Lint staged
- commitlint.config.*             → Commit lint
- .eslintrc*, eslint.config.*     → ESLint
- .prettierrc*                    → Prettier
- tsconfig.json                   → TypeScript
- jest.config.*, vitest.config.*  → Tests
- playwright.config.*             → E2E tests
- cypress.config.*                → E2E tests
- phpunit.xml*                    → PHP tests
- phpstan.neon*, psalm.xml        → PHP static analysis
- composer.json                   → PHP dependencies (scripts section)
- package.json                    → Node scripts section
```

### 1.4 Archivos de CI/CD de otras plataformas (detección informativa)

```
Buscar:
- .gitlab-ci.yml                  → GitLab CI
- .circleci/config.yml            → CircleCI
- Jenkinsfile                     → Jenkins
- .travis.yml                     → Travis CI
- azure-pipelines.yml             → Azure DevOps
- bitbucket-pipelines.yml         → Bitbucket
```

Si se encuentran, informar al usuario pero el foco de los Ents es GitHub Actions.

---

## Paso 2: Análisis de Scripts del Proyecto

### 2.1 package.json scripts (si existe)

Leer `package.json` y extraer la sección `scripts`:
- Identificar scripts de: test, lint, build, format, type-check, start, dev
- Detectar si hay scripts de CI específicos (ci:*, test:ci, etc.)

### 2.2 composer.json scripts (si existe)

Leer `composer.json` y extraer la sección `scripts`:
- Identificar scripts de: test, lint, analyse, format, phpstan, psalm

### 2.3 Makefile targets (si existe)

Leer `Makefile` y extraer targets principales.

---

## Paso 3: Generar Inventario

**Formato de salida** - Mostrar al usuario:

```
═══════════════════════════════════════════════════════════════
🔍 Análisis CI/CD - Resultados del Escaneo
═══════════════════════════════════════════════════════════════

📂 Proyecto: [nombre del directorio]
📅 Fecha de análisis: [fecha actual]

───────────────────────────────────────────────────────────────
📊 Resumen Rápido
───────────────────────────────────────────────────────────────

  Workflows GitHub Actions:  [N encontrados / 0 si ninguno]
  Jobs totales:              [N]
  Triggers configurados:     [lista]
  Secrets referenciados:     [N]
  Caching:                   [Sí/No]
  Matrix strategy:           [Sí/No]
  Reusable workflows:        [Sí/No]
  Docker:                    [Sí/No]
  Linting:                   [herramientas encontradas]
  Testing:                   [frameworks encontrados]
  Type checking:             [Sí/No]
  Dependabot/Renovate:       [Sí/No]
  Semantic Release:          [Sí/No]
  Git Hooks (Husky/etc):     [Sí/No]
  Pre-commit:                [Sí/No]
  Branch Protection:         [Detectado/No detectado/Solo via API]

───────────────────────────────────────────────────────────────
📋 Detalle por Workflow
───────────────────────────────────────────────────────────────

[Para cada workflow encontrado:]

  📄 [nombre-archivo.yml]
     Nombre: [name del workflow]
     Triggers: [on: push, pull_request, etc.]
     Jobs:
       - [job_name]: [breve descripción]
         Runner: [ubuntu-latest, etc.]
         Steps: [N steps]
         [Si tiene cache]: Cache: ✅
         [Si tiene matrix]: Matrix: ✅ [dimensiones]
         [Si tiene services]: Services: [lista]

───────────────────────────────────────────────────────────────
🔧 Herramientas del Proyecto
───────────────────────────────────────────────────────────────

  [Lista de herramientas detectadas con sus configuraciones]

═══════════════════════════════════════════════════════════════
```

---

## Paso 4: Guardar Estado Interno

Mantener en memoria el resultado del análisis para que los módulos siguientes
(04-diagram-renderer, 05-improvement-engine, 06-modifier) puedan utilizarlo
sin repetir el escaneo.

**NO guardar en archivos**. Solo mantener en el contexto de la conversación.

---

## Reglas del Analyzer

1. **Ser exhaustivo**: No dejar archivos sin escanear
2. **No modificar nada**: Solo lectura, cero escritura
3. **Informar de ausencias**: Si no hay CI/CD, decirlo claramente
4. **Detectar el tipo de proyecto**: Para contextualizar las sugerencias posteriores
5. **No inventar**: Solo reportar lo que realmente existe

---

*Módulo 03 - Analyzer de CI/CD v1.0*
