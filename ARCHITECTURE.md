# 🏗️ TLOTP - Arquitectura de Prompts

> **Patrón de Modularización para Prompts con @imports**
>
> Este documento define la arquitectura estándar para todos los prompts de TLOTP.

---

## 🎯 Filosofía: Separation of Concerns

Cada prompt grande se modulariza usando **Separation of Concerns** con el sistema de `@imports` nativo de Claude Code.

### Principios

1. **Un concern = Un archivo**: Cada módulo tiene una responsabilidad única
2. **Composición > Monolitos**: Usar @imports para componer funcionalidad
3. **Legibilidad**: Archivos pequeños (< 250 líneas ideal)
4. **Mantenibilidad**: Cambios localizados sin afectar todo el prompt
5. **Reutilización**: Módulos pueden compartirse entre prompts

---

## 📂 Estructura Estándar

### Patrón Base

```
prompts/
└── [nombre-prompt]/
    ├── [nombre]-main.md          ← Entry point (orquestador)
    │
    ├── sections/                  ← Concerns separados
    │   ├── 01-[concern].md
    │   ├── 02-[concern].md
    │   └── ...
    │
    └── templates/                 ← Templates opcionales
        └── [template].md
```

### Entry Point: `[nombre]-main.md`

El archivo principal que:
- Usa `@imports` para cargar módulos
- Define el orden de carga
- Incluye documentación del prompt
- Inicia la ejecución

**Ejemplo**:
```markdown
# 🎯 Prompt Name v1.0

@prompts/[nombre]/sections/01-metadata.md
@prompts/[nombre]/sections/02-core-logic.md
@prompts/[nombre]/sections/03-output-format.md

---

## Inicio de Ejecución
[Instrucciones de inicio...]
```

---

## 📋 Guía de Modularización

### ¿Cuándo Modularizar?

**Modularizar cuando**:
- ✅ Prompt > 300 líneas
- ✅ Múltiples concerns claramente separables
- ✅ Features que pueden evolucionar independientemente
- ✅ Lógica reutilizable en otros prompts

**NO modularizar cuando**:
- ❌ Prompt < 200 líneas
- ❌ Lógica muy acoplada (difícil separar)
- ❌ Prompt simple de una sola función

### Cómo Identificar Concerns

Pregúntate:
1. **¿Qué hace cada sección?** → Concern funcional
2. **¿Cómo se presenta?** → Concern de output
3. **¿Qué reglas aplican?** → Concern de validación
4. **¿Cuál es el flujo?** → Concern de coordinación

### Ejemplo de Separación

**Antes (monolítico)**:
```markdown
# Prompt Grande (500 líneas)
- Metadata (10 líneas)
- Feature A (150 líneas)
- Feature B (120 líneas)
- Output format (100 líneas)
- Reglas (120 líneas)
```

**Después (modular)**:
```
01-metadata.md       (10 líneas)
02-feature-a.md      (150 líneas)
03-feature-b.md      (120 líneas)
04-output-format.md  (100 líneas)
05-reglas.md         (120 líneas)
main.md              (30 líneas - orquestador)
```

---

## 🔧 Sistema de @imports

### Sintaxis

```markdown
@path/relativo/al/archivo.md
```

### Características

- ✅ **Carga secuencial**: Se cargan en orden de aparición
- ✅ **Path relativo**: Desde la raíz del proyecto
- ✅ **Contenido inline**: Como si estuviera pegado en el main
- ✅ **Sin límite**: Puedes importar cuantos archivos necesites

### Ejemplo Completo

**main.md**:
```markdown
# Mi Prompt v1.0

## Carga de Módulos
@prompts/mi-prompt/sections/01-setup.md
@prompts/mi-prompt/sections/02-logic.md
@prompts/mi-prompt/sections/03-output.md

## Inicio
Ahora ejecuta el prompt...
```

**01-setup.md**:
```markdown
# Setup
Configuración inicial...
```

**02-logic.md**:
```markdown
# Lógica Principal
Procesamiento...
```

---

## 🏷️ Sistema de Versionado

### Fuente Única de Verdad

Todas las versiones de prompts se centralizan en **`prompts/VERSION.md`**:

```markdown
# 🏷️ TLOTP - Versiones de Prompts

## 📊 Versiones Actuales

### Palantír
- **Versión**: 1.3.0
- **Versión corta**: v1.3
- **Fecha release**: 2026-02-13

### Gollum
- **Versión**: (pendiente)
...
```

### Carga en Prompts

Cada `*-main.md` importa VERSION.md:

```markdown
## 📋 Carga de Versiones

@prompts/VERSION.md

**Versión cargada**: Usar la versión de [Prompt] definida arriba
```

### Actualización de Versiones

**Automática** con script:

```bash
./scripts/update-version.sh palantir 1.4.0
```

El script:
1. Actualiza `prompts/VERSION.md`
2. Busca y reemplaza en todos los archivos del prompt
3. Muestra comandos para commit y tag

**Manual**:
1. Editar `prompts/VERSION.md`
2. Buscar y reemplazar en archivos del prompt
3. Commit y tag: `git tag vX.Y.Z`

### Formato de Versiones

**Semantic Versioning** (MAJOR.MINOR.PATCH):
- **MAJOR**: Breaking changes
- **MINOR**: Nuevas features (compatible)
- **PATCH**: Bug fixes

**En banners**:
- Versión completa: `v1.3.0` (tags, VERSION.md)
- Versión corta: `v1.3` (banners, displays)

### Ubicaciones con Versión

En cada prompt, la versión aparece típicamente en:
- Banner header (versión corta)
- Banner footer (versión corta)
- Metadata de backups/outputs (versión completa)
- Título del `*-main.md` (versión corta)

---

## 📂 Documentación Complementaria

Para mantener este documento enfocado, el contenido detallado se ha separado en:

- **[Casos de Estudio](docs/architecture-case-studies.md)** — Modularización de Palantír y Celebrimbor con resultados validados
- **[Estructura del Repo](docs/architecture-repo-structure.md)** — Convenciones de naming, plantillas, checklist de modularización, roadmap
- **[CI/CD y Patrones UI](docs/architecture-cicd-deploy.md)** — Patrón de pre-carga, paginación 3+1+navegación

---

*Arquitectura definida por la Comunidad del Código* 🥔🤖
*Base para todas las futuras épicas* 🏗️
*Última actualización: 2026-04-17*
