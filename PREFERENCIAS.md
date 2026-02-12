# PREFERENCIAS.md - Catálogo de Configuraciones

> **Propósito**: Documentar todas las preferencias configurables de TLOTP
> **Actualización**: 2026-02-12

Este documento lista todas las características y preferencias que TLOTP puede configurar, clasificadas por categorías y niveles (global vs. proyecto).

---

## 📊 Niveles de Configuración

### **Global** (todos los proyectos)
Preferencias aplicables por defecto a todos los proyectos del usuario.
- Se almacenan en: `~/.claude/CLAUDE.md`

### **Por Proyecto** (específico de cada proyecto)
Preferencias que sobrescriben las globales para un proyecto concreto.
- Se almacenan en: `~/.claude/projects/PROYECTO/memory/MEMORY.md`

---

## 1️⃣ Workflow y Git

### **Estrategia de Branching** (Global / Por Proyecto)
- **Pregunta**: "¿Qué estrategia de branching usas?"
- **Opciones**:
  - `gitflow`: master + develop + feature/hotfix/release
  - `github-flow`: main + feature branches
  - `trunk-based`: solo main/master
  - `custom`: Personalizada (especificar)
- **Por Proyecto**: Algunos proyectos pueden usar estrategia diferente
  - Ejemplo: Proyecto personal usa trunk-based, proyecto empresa usa gitflow

### **Convención de Commits** (Global / Por Proyecto)
- **Pregunta**: "¿Qué convención de commits usas?"
- **Opciones**:
  - `conventional`: feat/fix/docs/chore/refactor/test
  - `simple`: Mensajes descriptivos libres
  - `custom`: Convención personalizada
- **Por Proyecto**: Proyecto con equipo puede requerir conventional, personal puede ser simple

### **Naming de Branches** (Global / Por Proyecto)
- **Pregunta**: "¿Cómo nombras las branches?"
- **Opciones**:
  - `feature/ISSUE-descripcion`: Con número de issue
  - `feature/descripcion`: Sin número
  - `tipo/descripcion`: tipo puede ser feature, bugfix, hotfix
  - `custom`: Patrón personalizado
- **Ejemplo proyecto específico**:
  - Global: `feature/descripcion`
  - Proyecto con Jira: `feature/JIRA-XXX-descripcion`

### **Modo de Commits** (Global)
- **Pregunta**: "¿Cuándo debe Claude hacer commits?"
- **Opciones**:
  - `manual`: Usuario pide explícitamente cuando commitear
  - `auto`: Claude commitea después de cambios significativos
  - `ask`: Preguntar cada vez antes de commitear
- **Consideración**: Puede ser solo global, difícil justificar por proyecto

### **Code Review antes de Commit** (Global / Por Proyecto)
- **Pregunta**: "¿Quién hace la review antes del commit?"
- **Opciones**:
  - `user`: Usuario revisa todos los cambios antes de commit
  - `claude`: Claude hace auto-review y commitea
  - `both`: Claude muestra cambios, usuario aprueba/rechaza
  - `large-changes-only`: Usuario solo revisa cambios grandes (>X archivos)
- **Por Proyecto**: Proyecto crítico puede requerir user review, experimentos pueden ser auto
- **Seguridad**: Importante para evitar commits no deseados

### **Rama Principal** (Por Proyecto)
- **Pregunta**: "¿Cuál es la rama principal del proyecto?"
- **Opciones**:
  - `main`: Rama main (moderno, GitHub default)
  - `master`: Rama master (clásico)
  - `production`: Rama production
  - `custom`: Nombre personalizado
- **Por Proyecto**: Cada repo puede tener diferente
- **Auto-detección**: Puede detectarse con `git branch -r`

### **Rama de Desarrollo** (Por Proyecto)
- **Pregunta**: "¿Cuál es la rama de desarrollo?"
- **Opciones**:
  - `develop`: Rama develop (Gitflow)
  - `dev`: Rama dev
  - `staging`: Rama staging
  - `none`: No hay rama de desarrollo separada
  - `custom`: Nombre personalizado
- **Por Proyecto**: Solo aplica si usa Gitflow o similar
- **Dependencia**: Relacionado con "Estrategia de Branching"

### **Merge Strategy** (Global / Por Proyecto)
- **Pregunta**: "¿Qué estrategia de merge usas?"
- **Opciones**:
  - `squash`: Squash merge (recomendado para historial limpio)
  - `merge-commit`: Merge commits (preserva todo el historial)
  - `rebase`: Rebase antes de merge
- **Por Proyecto**: Proyecto personal puede usar squash, empresa puede requerir merge-commit

### **Auto-merge cuando CI pasa** (Por Proyecto)
- **Pregunta**: "¿Auto-merge automático cuando CI pasa?"
- **Opciones**:
  - `always`: Sí, siempre
  - `develop-only`: Solo en branch develop/staging
  - `never`: No, siempre manual
- **Por Proyecto**: Varía según criticidad del proyecto

---

## 2️⃣ Interacciones con Repositorio

### **Tiene Repositorio Git/GitHub** (Por Proyecto)
- **Pregunta**: "¿Este proyecto tiene repositorio Git?"
- **Opciones**:
  - `yes`: Sí, repositorio local y remoto
  - `local-only`: Sí, solo local (no remote)
  - `no`: No usa Git
- **Crítico**: No todos los proyectos tienen repo
  - Experimentos locales
  - Scripts temporales
  - Proyectos legacy sin versionado

### **Permisos de Push** (Global / Por Proyecto)
- **Pregunta**: "¿Claude puede hacer push automáticamente?"
- **Opciones**:
  - `never`: No, nunca hacer push (solo commits locales)
  - `ask`: Preguntar antes de cada push
  - `auto-staging`: Push automático solo a staging/develop
  - `auto-all`: Push automático a cualquier branch
- **Seguridad**: Importante para evitar pushes no deseados

### **Uso de GitHub CLI (gh)** (Global)
- **Pregunta**: "¿Permitir uso de GitHub CLI (gh) para PRs, issues, etc.?"
- **Opciones**:
  - `enabled`: Sí, usar gh para crear PRs, issues
  - `read-only`: Solo lectura (ver PRs, issues)
  - `disabled`: No usar gh CLI
- **Casos de uso**:
  - Crear PRs automáticamente
  - Listar issues
  - Ver estado de CI checks

### **Creación de PRs** (Global / Por Proyecto)
- **Pregunta**: "¿Cuándo crear Pull Requests?"
- **Opciones**:
  - `manual`: Usuario pide explícitamente
  - `ask`: Preguntar cuando branch está lista
  - `auto-feature`: Crear PR automáticamente al pushear feature branch
- **Por Proyecto**: Workflow de equipo puede diferir

---

## 3️⃣ Testing y QA

### **Dónde Ejecutar Tests** (Por Proyecto)
- **Pregunta**: "¿Dónde ejecutar los tests?"
- **Opciones**:
  - `local`: npm test, pytest, phpunit (directamente)
  - `docker`: docker exec CONTAINER npm test
  - `docker-compose`: docker-compose exec SERVICE npm test
  - `ci-only`: Solo en CI, no localmente
- **Por Proyecto**: Cada proyecto puede tener entorno diferente

### **Testing Framework** (Por Proyecto - Auto-detectado)
- **Detección automática** desde:
  - `package.json`: Jest, Vitest, Mocha, Playwright
  - `composer.json`: PHPUnit, Pest, Behat
  - `pyproject.toml` / `requirements.txt`: pytest, unittest
- **Pregunta si no detecta**: "¿Qué framework de testing usas?"

### **Cuándo Ejecutar Tests** (Global / Por Proyecto)
- **Pregunta**: "¿Cuándo ejecutar los tests?"
- **Opciones**:
  - `before-commit`: Siempre antes de cada commit
  - `before-push`: Antes de push
  - `manual`: Solo cuando se pida explícitamente
  - `ci-only`: Dejar que CI los ejecute
- **Por Proyecto**: Proyecto crítico puede requerir before-commit, experimento puede ser manual

### **Linting** (Global / Por Proyecto)
- **Pregunta**: "¿Ejecutar linting automáticamente?"
- **Opciones**:
  - `before-commit`: Sí, antes de commit
  - `ci-only`: Solo en CI
  - `manual`: Solo cuando se pida
  - `disabled`: No usar linting
- **Framework**: ESLint, PHPStan, Pylint, etc. (auto-detectado)

### **Coverage Mínimo** (Por Proyecto)
- **Pregunta**: "¿Coverage de tests mínimo requerido?"
- **Opciones**:
  - `80`: 80% (recomendado)
  - `70`: 70%
  - `60`: 60%
  - `none`: Sin mínimo
  - `custom`: Valor personalizado
- **Por Proyecto**: Varía según criticidad

### **Pre-commit Hooks** (Por Proyecto)
- **Pregunta**: "¿Usar pre-commit hooks?"
- **Opciones**:
  - `yes`: Ejecutar hooks (tests, linting)
  - `skip-on-wip`: Ejecutar excepto en commits WIP
  - `no`: No usar hooks
- **Consideración**: Puede ralentizar el desarrollo

---

## 4️⃣ Deploy y CI/CD

### **Estrategia de Deploy** (Por Proyecto)
- **Pregunta**: "¿Cómo se despliega este proyecto?"
- **Opciones**:
  - `github-actions`: CI/CD con GitHub Actions
  - `gitlab-ci`: CI/CD con GitLab CI
  - `manual-scripts`: Scripts bash/deploy.sh
  - `manual-ssh`: SSH manual / FTP
  - `none`: No se despliega (librería, CLI tool, etc.)
- **Por Proyecto**: Cada proyecto tiene su estrategia

### **Cuándo Desplegar** (Por Proyecto)
- **Pregunta**: "¿Cuándo desplegar?"
- **Opciones**:
  - `auto-main`: Automático al merge a main/master
  - `auto-develop`: Automático al merge a develop (staging)
  - `manual-command`: Con comando manual (make deploy, ./deploy.sh)
  - `ask`: Preguntar cada vez
- **Dependencias**: Requiere que "Estrategia de Deploy" no sea "none"

### **Ambientes** (Por Proyecto)
- **Pregunta**: "¿Qué ambientes tiene el proyecto?"
- **Opciones**:
  - `prod-only`: Solo producción
  - `staging-prod`: Staging + Production
  - `dev-staging-prod`: Development + Staging + Production
  - `custom`: Ambientes personalizados
- **Casos de uso**:
  - Proyecto simple: solo prod
  - Proyecto empresarial: dev + staging + prod

### **Deploy Requiere Aprobación** (Por Proyecto)
- **Pregunta**: "¿Deploy a producción requiere aprobación manual?"
- **Opciones**:
  - `always`: Siempre preguntar antes de deploy a prod
  - `auto`: Automático si CI pasa
  - `team-approval`: Requiere aprobación de equipo (en PRs)

---

## 5️⃣ Stack Tecnológico

### **Backend Framework** (Por Proyecto - Auto-detectado)
- **Detección desde**:
  - `composer.json`: Symfony, Laravel, etc.
  - `package.json`: NestJS, Express, etc.
  - `pyproject.toml`: Django, FastAPI, Flask
  - `go.mod`: Go frameworks
- **Pregunta si múltiples o no detecta**: "¿Qué framework backend usas?"
- **Opciones**:
  - `symfony`, `laravel`, `django`, `fastapi`, `nestjs`, `express`, `go`, `none`, `other`

### **Frontend Framework** (Por Proyecto - Auto-detectado)
- **Detección desde**: `package.json`
- **Opciones**:
  - `react`, `vue`, `angular`, `svelte`, `vanilla-ts`, `none`, `other`

### **Testing E2E** (Por Proyecto - Auto-detectado)
- **Detección desde**: `playwright.config.ts`, `cypress.json`
- **Opciones**:
  - `playwright`, `cypress`, `selenium`, `none`

### **Database** (Por Proyecto - Auto-detectado)
- **Detección desde**: `.env`, `docker-compose.yml`, config files
- **Opciones**:
  - `postgresql`, `mysql`, `sqlite`, `mongodb`, `redis`, `none`, `other`

### **Package Manager** (Por Proyecto - Auto-detectado)
- **Detección desde**: lockfiles
- **Opciones**:
  - Node: `npm`, `yarn`, `pnpm`, `bun`
  - PHP: `composer`
  - Python: `pip`, `poetry`, `pipenv`

---

## 6️⃣ Convenciones de Código

### **Naming Conventions** (Global / Por Proyecto)
- **Pregunta**: "¿Qué naming conventions usas?"
- **Por lenguaje**:
  - PHP: `camelCase`, `snake_case`, `PascalCase` para clases
  - Python: `snake_case`, `PascalCase` para clases
  - JavaScript/TypeScript: `camelCase`, `PascalCase` para clases
  - Go: `PascalCase` para exports, `camelCase` para privados
- **Detección**: Puede detectarse del código existente
- **Por Proyecto**: Proyecto legacy puede tener convenciones diferentes

### **Arquitectura** (Por Proyecto)
- **Pregunta**: "¿Qué arquitectura sigue el proyecto?"
- **Opciones**:
  - `hexagonal`: Hexagonal (Ports & Adapters)
  - `clean`: Clean Architecture
  - `mvc`: MVC tradicional
  - `microservices`: Microservicios
  - `none`: Sin arquitectura definida
- **Por Proyecto**: Cada proyecto tiene su arquitectura

### **Style Guide** (Global / Por Proyecto)
- **Pregunta**: "¿Qué style guide sigues?"
- **Opciones**:
  - PHP: `psr-12`, `symfony`, `laravel`
  - Python: `pep8`, `black`, `google`
  - JavaScript: `airbnb`, `standard`, `google`
  - TypeScript: `airbnb`, `google`, `custom`
- **Enforcement**: ESLint, Prettier, PHPStan, etc.

### **Indentación** (Global / Por Proyecto - Auto-detectado)
- **Detección desde**: `.editorconfig`, archivos existentes
- **Opciones**:
  - `2-spaces`, `4-spaces`, `tabs`
- **Por lenguaje**: Puede variar (JS: 2 espacios, Python: 4 espacios)

---

## 7️⃣ Comportamiento de Claude Code

### **Nivel de Proactividad** (Global)
- **Pregunta**: "¿Qué tan proactivo debe ser Claude?"
- **Opciones**:
  - `high`: Sugiere mejoras automáticamente
  - `medium`: Pregunta antes de sugerir
  - `low`: Solo hacer lo pedido exactamente
- **Afecta**:
  - Sugerencias de refactoring
  - Mejoras de código
  - Optimizaciones

### **Documentación** (Global / Por Proyecto)
- **Pregunta**: "¿Nivel de documentación en el código?"
- **Opciones**:
  - `extensive`: Documentar todo (funciones, clases, módulos)
  - `complex-only`: Solo lo complejo
  - `minimal`: Mínima documentación
  - `none`: Sin documentación inline
- **Por Proyecto**: Proyecto público/librería puede requerir extensive

### **Emojis** (Global)
- **Pregunta**: "¿Usar emojis en commits/documentación?"
- **Opciones**:
  - `yes`: Sí, usar emojis
  - `commits-only`: Solo en commits
  - `no`: Nunca
- **Preferencia personal**

### **Code Review** (Global / Por Proyecto)
- **Pregunta**: "¿Pedir code review antes de commit?"
- **Opciones**:
  - `always`: Siempre mostrar cambios antes de commit
  - `large-changes`: Solo en cambios grandes
  - `never`: No necesario
- **Por Proyecto**: Proyecto crítico puede requerir always

### **Explicaciones** (Global)
- **Pregunta**: "¿Nivel de explicación de los cambios?"
- **Opciones**:
  - `detailed`: Explicar cada cambio en detalle
  - `summary`: Resumen de cambios principales
  - `minimal`: Solo decir qué se hizo
- **Preferencia de aprendizaje**

### **Manejo de Errores** (Global)
- **Pregunta**: "¿Qué hacer cuando hay errores?"
- **Opciones**:
  - `fix-auto`: Intentar arreglar automáticamente
  - `ask`: Preguntar qué hacer
  - `stop`: Detenerse y reportar
- **Contexto**: Tests fallando, linting errors, etc.

---

## 8️⃣ Seguridad y Privacidad

### **Manejo de Secretos** (Global)
- **Pregunta**: "¿Cómo manejar secretos/credenciales?"
- **Opciones**:
  - `env-only`: Solo en .env (nunca commitear)
  - `ask-before-commit`: Preguntar si archivo tiene secretos
  - `auto-detect`: Detectar automáticamente y avisar
- **Crítico**: Evitar commits de credenciales

### **Archivos Sensibles** (Por Proyecto)
- **Configuración**: Lista de archivos que nunca deben commitearse
- **Ejemplos**:
  - `.env`, `.env.local`
  - `credentials.json`
  - `*.key`, `*.pem`
  - `config/secrets.yml`

### **Datos Personales en Código** (Global)
- **Pregunta**: "¿Evitar datos personales en código/commits?"
- **Opciones**:
  - `strict`: Nunca incluir emails, nombres reales, IPs
  - `relaxed`: Permitir en contexto apropiado
- **GDPR/Privacidad**

---

## 9️⃣ Colaboración y Equipo

### **Trabajo en Equipo** (Por Proyecto)
- **Pregunta**: "¿Este proyecto tiene equipo?"
- **Opciones**:
  - `solo`: Solo yo
  - `team`: Equipo colaborativo
- **Afecta**:
  - Necesidad de comunicación (PRs, issues)
  - Convenciones estrictas
  - Code review

### **Issue Tracking** (Por Proyecto)
- **Pregunta**: "¿Sistema de issues?"
- **Opciones**:
  - `github-issues`: GitHub Issues
  - `jira`: Jira
  - `linear`: Linear
  - `none`: Sin tracking
- **Uso**: Referenciar issues en commits/PRs

### **Comunicación de Cambios** (Por Proyecto)
- **Pregunta**: "¿Cómo comunicar cambios importantes?"
- **Opciones**:
  - `changelog`: Mantener CHANGELOG.md
  - `pr-descriptions`: Descripciones detalladas en PRs
  - `commit-messages`: Solo mensajes de commit detallados
  - `none`: No necesario
- **Por Proyecto**: Librería pública necesita CHANGELOG

---

## 🔟 Proyecto-Específico

### **Características del Proyecto**

Estas son características que SOLO aplican por proyecto:

#### **Nombre del Proyecto**
- Usado en mensajes, documentación

#### **Tipo de Proyecto**
- `web-app`: Aplicación web
- `api`: API backend
- `library`: Librería/paquete
- `cli`: Herramienta CLI
- `mobile`: Aplicación móvil
- `desktop`: Aplicación desktop
- `script`: Script/automatización

#### **Estado del Proyecto**
- `production`: En producción
- `development`: En desarrollo
- `prototype`: Prototipo
- `archived`: Archivado

#### **Licencia**
- `mit`, `apache`, `gpl`, `proprietary`, `none`

#### **Visibilidad**
- `public`: Repositorio público
- `private`: Repositorio privado

---

## 📋 Matriz de Preferencias

| Preferencia | Global | Por Proyecto | Auto-detectable | Crítica |
|-------------|--------|--------------|-----------------|---------|
| Estrategia branching | ✅ | ✅ | ❌ | ⭐⭐⭐ |
| Convención commits | ✅ | ✅ | ❌ | ⭐⭐⭐ |
| Modo commits | ✅ | ❌ | ❌ | ⭐⭐ |
| Tiene repositorio | ❌ | ✅ | ✅ | ⭐⭐⭐ |
| Permisos push | ✅ | ✅ | ❌ | ⭐⭐⭐ |
| Uso gh CLI | ✅ | ❌ | ✅ | ⭐⭐ |
| Dónde ejecutar tests | ❌ | ✅ | ✅ | ⭐⭐⭐ |
| Testing framework | ❌ | ✅ | ✅ | ⭐⭐ |
| Cuándo ejecutar tests | ✅ | ✅ | ❌ | ⭐⭐⭐ |
| Linting | ✅ | ✅ | ✅ | ⭐⭐ |
| Estrategia deploy | ❌ | ✅ | ✅ | ⭐⭐⭐ |
| Backend framework | ❌ | ✅ | ✅ | ⭐⭐ |
| Frontend framework | ❌ | ✅ | ✅ | ⭐⭐ |
| Naming conventions | ✅ | ✅ | ✅ | ⭐⭐⭐ |
| Arquitectura | ❌ | ✅ | ❌ | ⭐⭐ |
| Nivel proactividad | ✅ | ❌ | ❌ | ⭐⭐ |
| Documentación | ✅ | ✅ | ❌ | ⭐⭐ |
| Manejo secretos | ✅ | ❌ | ❌ | ⭐⭐⭐ |

**Leyenda**:
- ⭐⭐⭐ Crítica (preguntar siempre)
- ⭐⭐ Importante (preguntar o auto-detectar)
- ⭐ Opcional (usar default inteligente)

---

## 🎯 Uso en TLOTP

### **Flujo de Preguntas**

1. **Auto-detectar** todo lo posible
2. **Preguntar** solo lo crítico que no se puede detectar
3. **Usar defaults inteligentes** para lo opcional
4. **Permitir personalizar** después

### **Orden Sugerido de Preguntas**

1. Características del proyecto (nombre, tipo, tiene repo)
2. Workflow y Git (branching, commits)
3. Testing y QA
4. Deploy (si aplica)
5. Stack tecnológico (confirmar detección)
6. Convenciones de código
7. Comportamiento de Claude
8. Preferencias personales

### **Ejemplo de Flujo**

```
🔍 Analizando proyecto...

Detectado:
✓ package.json → Node.js project
✓ tsconfig.json → TypeScript
✓ playwright.config.ts → Playwright E2E
✓ No hay repositorio Git → Proyecto nuevo

=== Configuración Inicial ===

1. ¿Nombre del proyecto? _
2. ¿Este proyecto tendrá repositorio Git? (sí/no) _
3. ¿Qué estrategia de branching? (gitflow/github-flow/trunk-based) _
4. ¿Convención de commits? (conventional/simple) _
5. ¿Claude puede hacer commits? (manual/auto/ask) _
...
```

---

*Documento vivo: Se actualiza según evolucione TLOTP*
*Última actualización: 2026-02-12*
