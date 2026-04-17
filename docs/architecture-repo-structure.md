# 🏗️ TLOTP - Estructura del Repositorio

> Estructura de directorios, convenciones de nombres y plantillas.
> Documento complementario a [ARCHITECTURE.md](../ARCHITECTURE.md).

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

## 📚 Recursos

### Referencias

- **Claude Code @imports**: Sistema nativo de composición de archivos
- **Palantír v1.3**: Primer prompt modularizado (caso de estudio)
- **TLOTP.md**: Especificación completa del proyecto

### Issues Relacionados

- **#5**: Definir estructura de datos (arquitectura) - ✅ Completado
- **#6**: Utilidades de lectura - ✅ Completado (implícito en módulos)
- **#35**: Modularizar sistema de versionado - ✅ Completado
