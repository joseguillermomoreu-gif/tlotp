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

## 🔮 Caso de Estudio: Palantír v1.3

### Estructura Implementada

```
prompts/palantir/
├── palantir-main.md              ← Entry point
│
└── sections/                      ← 6 módulos separados
    ├── 01-metadata.md            ← Banner, misión, jerarquía (28 líneas)
    ├── 02-backup-system.md       ← Sistema de backup (119 líneas)
    ├── 03-jerarquia-oficial.md   ← Inspección 7 niveles (173 líneas)
    ├── 04-exploracion-custom.md  ← Detección genérica (107 líneas)
    ├── 05-formato-output.md      ← Templates y formatos (229 líneas)
    └── 06-reglas-ejecucion.md    ← Flujo y reglas (104 líneas)
```

### Numeración de Módulos

Usar prefijos numéricos para indicar orden de carga:
- `01-` a `09-`: Orden secuencial claro
- `10-` +: Para extensiones futuras

### Separación de Concerns en Palantír

| Módulo | Responsabilidad | Líneas | Concern |
|--------|-----------------|--------|---------|
| **01-metadata** | Identidad del prompt | 28 | Metadatos |
| **02-backup-system** | Lógica de backup | 119 | Feature aislada |
| **03-jerarquia-oficial** | Inspección core | 173 | Lógica principal |
| **04-exploracion-custom** | Detección genérica | 107 | Feature secundaria |
| **05-formato-output** | Templates y formatos | 229 | Presentación |
| **06-reglas-ejecucion** | Flujo y validaciones | 104 | Coordinación |

**Total**: 760 líneas modularizadas (vs 884 líneas monolíticas)

### Resultados Validados

- ✅ 100% funcionalidad preservada
- ✅ Sin breaking changes
- ✅ Carga correcta con @imports
- ✅ Mantenimiento más fácil

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

1. ✅ **Palantír** (v1.3) - Completado
2. ⏳ **Gollum** (Playwright E2E) - Siguiente
3. ⏳ **Elrond** (Global Config) - Futuro
4. ⏳ **Gandalf** (Autonomous PHP) - Futuro

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

## 🏆 Caso de Éxito: Palantír v1.3

**Antes**:
- 1 archivo monolítico (884 líneas)
- Difícil de mantener
- Cambios afectan todo

**Después**:
- 7 archivos modulares (760 líneas + docs)
- Fácil de mantener
- Cambios localizados
- 100% funcionalidad preservada

**Resultado**: ✅ Arquitectura validada y lista para replicar

---

*Arquitectura definida por la Fellowship del Teclado* 🥔🤖
*Sprint P1 - Base para todas las futuras épicas* 🏗️
*Última actualización: 2026-02-13*
