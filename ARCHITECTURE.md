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

## 🔮 Caso de Estudio 1: Palantír v1.7

### Estructura Implementada

```
prompts/palantir/
├── palantir-main.md               ← Entry point
│
└── sections/                       ← 11 módulos separados
    ├── 00-menu-principal.md       ← Menú de selección de modo
    ├── 01-metadata.md             ← Banner, misión, jerarquía
    ├── 02-backup-system.md        ← Sistema de backup (4 opciones)
    ├── 03-jerarquia-oficial.md    ← Inspección 7 niveles oficiales
    ├── 04-exploracion-custom.md   ← Detección genérica (Sección 8)
    ├── 05-formato-output.md       ← Templates y formatos
    ├── 06-reglas-ejecucion.md     ← Flujo y reglas (modo Inspector)
    ├── 07-reset-system.md         ← Sistema de reset
    ├── 08-recovery-system.md      ← Sistema de recovery desde backup
    ├── 09-reconstruction-engine.md← Motor de reconstrucción inteligente
    └── 10-configurator-system.md  ← Configuración asistida (CREATE)
```

### Separación de Concerns en Palantír

| Módulo | Responsabilidad | Concern |
|--------|-----------------|---------|
| **00-menu-principal** | Routing de modos | Navegación |
| **01-metadata** | Identidad del prompt | Metadatos |
| **02-backup-system** | Backup obligatorio (4 paths) | Feature aislada |
| **03-jerarquia-oficial** | Inspección 7 niveles | Lógica principal |
| **04-exploracion-custom** | Detección genérica | Feature secundaria |
| **05-formato-output** | Templates y formatos | Presentación |
| **06-reglas-ejecucion** | Flujo Inspector | Coordinación |
| **07-reset-system** | Reset completo/selectivo | Feature aislada |
| **08-recovery-system** | Recovery desde backup | Feature aislada |
| **09-reconstruction-engine** | Motor de reconstrucción | Core engine |
| **10-configurator-system** | Configuración asistida | Feature aislada |

**Total**: ~3,830 líneas | **CRUD completo**: Inspector · Reset · Recovery · Configurador

### Resultados Validados

- ✅ 100% funcionalidad preservada
- ✅ Sin breaking changes
- ✅ Carga correcta con @imports
- ✅ 4 modos operativos desde un único entry point

---

## ⚒️ Caso de Estudio 2: Celebrimbor v1.0

### Estructura Implementada

```
prompts/celebrimbor/
├── celebrimbor-main.md            ← Entry point
│
└── sections/                       ← 11 módulos separados
    ├── 01-detector-entorno.md     ← Detección Node.js, npm, Git
    ├── 02-menu-principal.md       ← Menú interactivo adaptativo
    ├── 03-abstraction-layer.md    ← Interfaz común para backends
    ├── 04-backend-cli.md          ← Backend CLI (npx skills)
    ├── 05-backend-git.md          ← Backend Git (v4.0.0)
    ├── 06-backend-selector.md     ← Selector inteligente de backend
    ├── 07-module-search.md        ← Búsqueda de skills
    ├── 08-module-install.md       ← Instalación de skills
    ├── 09-module-list.md          ← Listar skills instaladas
    ├── 10-module-remove.md        ← Eliminar skills
    └── 11-module-update.md        ← Actualizar skills
```

### Separación de Concerns en Celebrimbor

| Módulo | Responsabilidad | Concern |
|--------|-----------------|---------|
| **01-detector-entorno** | Detectar Node.js/npm/Git | Detección |
| **02-menu-principal** | Menú adaptativo | Navegación |
| **03-abstraction-layer** | API común backends | Abstracción |
| **04-backend-cli** | npx skills (MVP) | Backend |
| **05-backend-git** | Git directo (v4.0.0) | Backend |
| **06-backend-selector** | Elegir backend | Coordinación |
| **07-module-search** | Buscar en skills.sh | Operación CRUD |
| **08-module-install** | Instalar skill | Operación CRUD |
| **09-module-list** | Listar instaladas | Operación CRUD |
| **10-module-remove** | Eliminar skill | Operación CRUD |
| **11-module-update** | Actualizar skills | Operación CRUD |

**Total**: ~4,500 líneas | **CRUD completo**: Search · Install · List · Update · Remove

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

## 📏 Convenciones de Naming

### Archivos

- **Main**: `[nombre-descriptivo]-main.md`
- **Secciones**: `[NN]-[nombre-concern].md`
- **Templates**: `[nombre-template].md`

### Carpetas

- **Raíz del prompt**: `prompts/[nombre-prompt]/`
- **Secciones**: `prompts/[nombre-prompt]/sections/`
- **Templates**: `prompts/[nombre-prompt]/templates/`

### Ejemplos

```
✅ palantir-main.md
✅ 01-metadata.md
✅ 02-backup-system.md
✅ backup-index-template.md

❌ palantir.md (no indica que es el main)
❌ metadata.md (sin número de orden)
❌ backupSystem.md (camelCase no recomendado)
```

---

## 🎨 Plantilla de Prompt Modular

### Crear Nuevo Prompt Modular

1. **Crear estructura**:
```bash
mkdir -p prompts/[nombre]/sections
mkdir -p prompts/[nombre]/templates  # Opcional
```

2. **Crear main.md**:
```markdown
# 🎯 [Nombre] v1.0

> Descripción breve del prompt

## 📚 Carga de Módulos
@prompts/[nombre]/sections/01-[concern].md
@prompts/[nombre]/sections/02-[concern].md

## ✨ Inicio de Ejecución
[Instrucciones de inicio...]
```

3. **Crear módulos** en `sections/`:
```markdown
# [Título del Concern]

[Contenido del módulo...]
```

4. **Alias en raíz** (opcional):
```markdown
# [Nombre] - Entry Point

@prompts/[nombre]/[nombre]-main.md
```

---

## 📊 Versionado de Prompts

### Esquema de Versiones

Cada prompt mantiene su versión en el **banner del main.md**:

```markdown
# 🎯 Prompt Name v1.3.0

## Changelog
- v1.3.0: Arquitectura modular
- v1.2.0: Feature X añadida
- v1.1.0: Mejoras en Y
```

### Semantic Versioning

- **MAJOR** (X.0.0): Breaking changes
- **MINOR** (1.X.0): Nuevas features (compatible)
- **PATCH** (1.0.X): Bug fixes

---

## 🚀 Próximos Prompts a Modularizar

### Roadmap de Modularización

1. ✅ **Palantír** (v1.7) - Completado — 11 módulos, CRUD completo
2. ✅ **Celebrimbor** (v1.0) - Completado — 11 módulos, CRUD skills
3. ⏳ **Gollum** (Playwright E2E) - Siguiente
4. ⏳ **Elrond** (Setup por tipo de proyecto) - Futuro
5. ⏳ **Gandalf** (Autonomous PHP) - Futuro

### Template para Nuevas Épicas

Cada nueva épica debe:
1. Seguir la estructura `prompts/[nombre]/`
2. Usar `[nombre]-main.md` como entry point
3. Separar concerns en `sections/`
4. Documentar módulos en el main
5. Mantener módulos < 250 líneas ideal

---

## 🎯 Beneficios de la Arquitectura

### Para Desarrollo

| Beneficio | Descripción |
|-----------|-------------|
| **Modularidad** | Un cambio = un archivo |
| **Legibilidad** | Archivos pequeños y enfocados |
| **Mantenibilidad** | Localizar problemas rápido |
| **Colaboración** | PRs más fáciles de revisar |

### Para Usuarios

| Beneficio | Descripción |
|-----------|-------------|
| **Mismo comportamiento** | Sin breaking changes |
| **Transparencia** | Ven la carga de módulos |
| **Confiabilidad** | Menos bugs por complejidad |

### Para el Proyecto

| Beneficio | Descripción |
|-----------|-------------|
| **Escalabilidad** | Fácil añadir features |
| **Reutilización** | Módulos compartibles |
| **Documentación** | Estructura auto-documentada |
| **Estándar** | Patrón consistente en todas las épicas |

---

## 📚 Recursos

### Referencias

- **Claude Code @imports**: Sistema nativo de composición de archivos
- **Palantír v1.3**: Primer prompt modularizado (caso de estudio)
- **TLOTP.md**: Especificación completa del proyecto

### Issues Relacionados

- **#5**: Definir estructura de datos (arquitectura) - ✅ Completado
- **#6**: Utilidades de lectura - ✅ Completado (implícito en módulos)
- **#35**: Modularizar sistema de versionado - ✅ Completado

---

## ✅ Checklist de Modularización

Cuando modularices un prompt, verifica:

- [ ] Estructura de carpetas creada (`prompts/[nombre]/sections/`)
- [ ] Entry point `[nombre]-main.md` con @imports
- [ ] Módulos numerados secuencialmente (`01-`, `02-`, etc.)
- [ ] Cada módulo < 250 líneas (ideal)
- [ ] Concerns claramente separados
- [ ] Documentación en el main sobre qué hace cada módulo
- [ ] Alias en raíz (opcional, para compatibilidad)
- [ ] Testing: funcionalidad preservada
- [ ] Commit con mensaje descriptivo
- [ ] PR con comparación antes/después

---

## 🏆 Casos de Éxito

### Palantír v1.7
- 11 módulos (~3,830 líneas) — CRUD completo de configuraciones
- 4 modos operativos desde un único entry point
- Detección de conflictos + propuestas iterativas en el Configurador

### Celebrimbor v1.0
- 11 módulos (~4,500 líneas) — CRUD completo de skills
- Arquitectura dual-backend (CLI activo, Git planificado v4.0.0)
- Abstraction layer desacopla operaciones del backend concreto

**Resultado**: ✅ Patrón validado en 2 épicas production-ready — listo para replicar en Gollum y siguientes

---

*Arquitectura definida por la Comunidad del Código* 🥔🤖
*Base para todas las futuras épicas* 🏗️
*Última actualización: 2026-02-19*
