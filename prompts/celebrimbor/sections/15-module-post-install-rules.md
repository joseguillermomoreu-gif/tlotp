# 📐 Módulo Post-Instalación: Rules con Paths - Celebrimbor

## Misión

Tras instalar una skill, ofrecer al usuario crear una **rule con frontmatter `paths:`** en `.claude/rules/` para que la skill se active automáticamente solo cuando se trabaja con ficheros relevantes.

---

## Contexto: Por qué Rules con Paths

Las rules con `paths:` son el **mecanismo nativo de Claude Code** para activación contextual de skills:

| Mecanismo | Activación | Coste de contexto | Nativo |
|-----------|-----------|-------------------|--------|
| CLAUDE.md | Siempre (cada request) | Alto (siempre cargado) | Sí, pero no ideal |
| Skill sin paths | Cuando Claude decide o se invoca | Medio (descripción siempre) | Sí |
| **Rule con paths** | **Solo al tocar ficheros que matchean** | **Zero hasta activación** | **Sí, recomendado** |

**Ventajas**:
- Se activan **solo cuando tocas esos ficheros**, no siempre
- **Zero coste de contexto** hasta que se activa
- Mejor organización: una rule por dominio
- Fichero separado, no modifica la skill original

---

## Flujo de Ejecución

### Cuándo se ejecuta este módulo

Se invoca **después del Paso 6 (Verificar Instalación)** del módulo `08-module-install.md`, antes de las acciones posteriores.

---

### Paso 1: Ofrecer crear Rule con Paths

**Preguntar al usuario** (AskUserQuestion):

```
📐 Configurar activación contextual

La skill "{skill_name}" se ha instalado correctamente.

¿Quieres crear una rule con paths para que se active
solo al trabajar con ficheros específicos?

Opciones:
1. ✅ Sí, crear rule con paths (recomendado)
2. ⏭️ No, la skill se activará siempre
```

**Si elige "2. No"**: Saltar al Paso 7 del módulo 08 (acciones posteriores).

**Si elige "1. Sí"**: Continuar con Paso 2.

---

### Paso 2: Sugerir Patrón Glob Inteligente

**Detectar tipo de skill** por su nombre/descripción y sugerir globs:

#### Tabla de Sugerencias por Tipo de Skill

| Keyword en skill name | Globs sugeridos | Nombre rule sugerido |
|-----------------------|-----------------|----------------------|
| `typescript`, `ts` | `src/**/*.ts`, `src/**/*.tsx` | `typescript.md` |
| `playwright`, `e2e`, `test` | `tests/**/*.spec.ts`, `e2e/**/*.spec.ts` | `e2e-testing.md` |
| `react`, `jsx`, `frontend` | `src/**/*.tsx`, `src/**/*.jsx` | `react.md` |
| `python`, `py`, `ai`, `llm` | `**/*.py` | `python.md` |
| `php`, `symfony`, `laravel` | `src/**/*.php` | `php.md` |
| `github-actions`, `ci`, `cd`, `workflow` | `.github/workflows/**` | `ci.md` |
| `docker`, `container` | `Dockerfile*`, `docker-compose*` | `docker.md` |
| `css`, `style`, `tailwind` | `**/*.css`, `**/*.scss` | `styles.md` |
| `sql`, `database`, `migration` | `**/*.sql`, `migrations/**` | `database.md` |
| `api`, `rest`, `graphql` | `src/api/**`, `src/routes/**` | `api.md` |

**Si se detecta match**, mostrar sugerencia:

```
📝 Sugerencia de paths para "{skill_name}"

Skill detectada como: TypeScript
Paths sugeridos:
  • src/**/*.ts
  • src/**/*.tsx

Opciones:
1. ✅ Usar paths sugeridos
2. ✏️ Personalizar paths
3. 🚫 Cancelar (no crear rule)
```

**Si NO se detecta match** (skill genérica):

```
📝 Configurar paths para "{skill_name}"

No se ha detectado un tipo específico para esta skill.

Introduce los patrones glob (uno por línea, vacío para terminar):

Ejemplos comunes:
  • src/**/*.ts        (TypeScript)
  • **/*.py            (Python)
  • .github/workflows/** (CI/CD)

Path 1: _
```

---

### Paso 3: Personalizar Paths (si elige "Personalizar")

**Flujo interactivo**:

```
📝 Personalizar paths para "{skill_name}"

Paths actuales sugeridos:
  • src/**/*.ts
  • src/**/*.tsx

¿Qué quieres hacer?

1. ➕ Añadir un path
2. ❌ Eliminar un path
3. ✅ Confirmar estos paths
4. 🚫 Cancelar

Elige [1-4]: _
```

**Repetir hasta que confirme o cancele**.

---

### Paso 4: Verificar Rules Existentes

**Antes de crear**, comprobar si ya existe una rule para esta skill:

```bash
# Buscar rules existentes en el proyecto
ls -1 .claude/rules/*.md 2>/dev/null

# Buscar rules globales
ls -1 ~/.claude/rules/*.md 2>/dev/null
```

**Buscar dentro de cada rule** si ya referencia la skill:

```bash
grep -l "{skill_name}" .claude/rules/*.md 2>/dev/null
grep -l "{skill_name}" ~/.claude/rules/*.md 2>/dev/null
```

#### Si ya existe una rule que referencia la skill:

```
⚠️ Rule existente detectada

La skill "{skill_name}" ya está referenciada en:
  📄 .claude/rules/typescript.md

Contenido actual:
  paths: src/**/*.ts, src/**/*.tsx
  Skills: enforcing-typescript-standards

Opciones:
1. ✏️ Actualizar rule existente (añadir paths/skills)
2. 📄 Crear rule nueva independiente
3. 🚫 Cancelar

Elige [1-3]: _
```

#### Si existe una rule con los mismos paths (posible agrupación):

```
📦 Rule con paths similares detectada

La rule ".claude/rules/typescript.md" ya usa estos paths:
  • src/**/*.ts
  • src/**/*.tsx

¿Quieres agrupar "{skill_name}" en esa rule?

Opciones:
1. ✅ Sí, agrupar (añadir skill a la rule existente)
2. 📄 No, crear rule nueva independiente
3. 🚫 Cancelar

Elige [1-3]: _
```

---

### Paso 5: Generar y Crear el Fichero Rule

#### Ubicación del fichero

Las rules se crean **siempre en el proyecto** (`.claude/rules/`), no en global.
Esto permite versionarlas con el repo y compartirlas con el equipo.

```bash
mkdir -p .claude/rules
```

#### Formato del fichero generado

**Rule nueva**:

```markdown
---
paths:
  - "src/**/*.ts"
  - "src/**/*.tsx"
---
Invocar la skill `enforcing-typescript-standards` al trabajar con estos ficheros.
```

**Rule con múltiples skills agrupadas**:

```markdown
---
paths:
  - "src/**/*.ts"
  - "src/**/*.tsx"
---
Invocar las skills `enforcing-typescript-standards` y `typescript-advanced-types` al trabajar con estos ficheros.
```

#### Escribir fichero

```bash
cat > .claude/rules/{rule_name}.md << 'EOF'
---
paths:
  - "{path_1}"
  - "{path_2}"
---
Invocar la skill `{skill_name}` al trabajar con estos ficheros.
EOF
```

#### Actualizar rule existente (agrupación)

Si se agrupa con una rule existente:
1. Leer contenido actual de la rule
2. Añadir referencia a la nueva skill en el texto
3. Añadir paths nuevos si hay (sin duplicar)
4. Escribir fichero actualizado

---

### Paso 6: Confirmar Creación

**Mostrar resultado**:

```
═══════════════════════════════════════════════════════════════
✅ Rule con Paths Creada
═══════════════════════════════════════════════════════════════

Fichero: .claude/rules/typescript.md
Paths:
  • src/**/*.ts
  • src/**/*.tsx
Skills vinculadas:
  • enforcing-typescript-standards

La skill se activará automáticamente cuando trabajes
con ficheros que coincidan con estos patrones.

═══════════════════════════════════════════════════════════════
```

---

## Ejemplos Completos de Rules Generadas

### TypeScript

```markdown
# .claude/rules/typescript.md
---
paths:
  - "src/**/*.ts"
  - "src/**/*.tsx"
---
Invocar las skills `enforcing-typescript-standards` y `typescript-advanced-types` al trabajar con estos ficheros.
```

### Playwright E2E

```markdown
# .claude/rules/e2e-testing.md
---
paths:
  - "tests/**/*.spec.ts"
  - "e2e/**/*.spec.ts"
  - "pages/**/*.ts"
---
Invocar la skill `playwright-expert` al trabajar con estos ficheros.
```

### Python/AI

```markdown
# .claude/rules/python.md
---
paths:
  - "**/*.py"
---
Invocar la skill `llm-evaluation` al trabajar con prompts y scoring del AI Service.
```

### CI/CD

```markdown
# .claude/rules/ci.md
---
paths:
  - ".github/workflows/**"
---
Invocar la skill `github-actions-templates` al trabajar con workflows de CI/CD.
```

### PHP/Symfony

```markdown
# .claude/rules/php.md
---
paths:
  - "src/**/*.php"
  - "config/**/*.yaml"
---
Invocar la skill `php-pro` al trabajar con estos ficheros.
```

---

## Reglas de Ejecución

1. **SIEMPRE ofrecer** crear rule tras instalación exitosa (no forzar)
2. **Sugerir globs inteligentes** basados en el nombre/tipo de la skill
3. **Permitir personalización** completa de los paths
4. **Detectar duplicados**: buscar rules existentes antes de crear
5. **Ofrecer agrupación**: si ya existe rule con mismos paths, proponer agrupar
6. **Rules en proyecto**: siempre en `.claude/rules/`, no en global (versionable)
7. **No modificar la skill**: la rule es un fichero independiente
8. **Frontmatter correcto**: siempre con `paths:` en YAML válido

---

**Módulo anterior**: 08-module-install.md (Paso 6)
**Módulo siguiente**: 08-module-install.md (Paso 7 - Acciones posteriores)
**Tarea**: #53 - Post-instalación: rules con paths
