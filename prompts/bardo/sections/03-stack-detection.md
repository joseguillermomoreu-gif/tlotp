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

