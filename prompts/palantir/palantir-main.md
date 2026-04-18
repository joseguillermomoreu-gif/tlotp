# 🔮 Palantír - Main Entry Point

> **Arquitectura Modular con @imports**
>
> Este es el entry point principal que orquesta todos los módulos de Palantír.
> Cada sección está separada por concerns para facilitar el mantenimiento.

---

## 📋 Carga de Versiones

@prompts/VERSION.md

**IMPORTANTE**: Usa la versión TLOTP definida en VERSION.md en todos los banners y outputs

---

## 📚 Carga de Módulos

@prompts/palantir/sections/00-menu-principal.md
@prompts/palantir/sections/01-mini-guide.md
@prompts/palantir/sections/02-contemplar-reino.md
@prompts/palantir/sections/03-jerarquia-oficial.md
@prompts/palantir/sections/04-exploracion-custom.md
@prompts/palantir/sections/05-susurrar-planes.md
@prompts/palantir/sections/06a-importar-visiones.md
@prompts/palantir/sections/06b-exportar-visiones.md
@prompts/palantir/sections/07a-status-line-create.md
@prompts/palantir/sections/07b-status-line-manage.md
@prompts/palantir/sections/07c-status-line-pepeton.md

---

## 🎯 Módulos Cargados

1. **00-menu-principal.md** - Menú principal paginado 3+1 (Contemplar / Susurrar / Compartir / Ver más → Status Line / Salir)
2. **01-mini-guide.md** - Mini-guía informativa de Palantír con lore
3. **02-contemplar-reino.md** - Análisis completo de configuración con scoring y sugerencias
4. **03-jerarquia-oficial.md** - Inspección de jerarquía oficial (6 WebFetch docs)
5. **04-exploracion-custom.md** - Exploración de settings.json, skills/, hooks/
6. **05-susurrar-planes.md** - Añadir configuración con análisis inteligente
7. **06a-importar-visiones.md** - Importar configuraciones (menú + 6 pasos)
7b. **06b-exportar-visiones.md** - Exportar configuraciones + eliminar características
8. **07a-status-line-create.md** - Detección + creación de Status Line (Caso A: no configurada)
9. **07b-status-line-manage.md** - Gestión de Status Line existente (Caso B: editar / reemplazar / eliminar)
10. **07c-status-line-pepeton.md** - Preset de Pépeton (Caso C: 2 líneas con barras de contexto, 5h y 7d)

---

> **⚡ PRE-CARGA OBLIGATORIA**: Antes de mostrar cualquier contenido al usuario, resolver
> todos los @imports referenciados en este fichero. Cargar todos los módulos en memoria
> completa antes de renderizar el banner o mostrar cualquier texto. El usuario debe ver
> el prompt completo en un único bloque de salida, sin cargas incrementales visibles.

---

## ⚠️ REGLA CRÍTICA - Prevención de Contaminación de Auto Memory

**IMPORTANTE**: Durante TODA la ejecución de Palantír:

### 🚫 Prohibido Absolutamente

- ❌ **NO actualices** MEMORY.md del proyecto actual
- ❌ **NO crees** topic files en auto memory del proyecto
- ❌ **NO escribas** notas sobre esta sesión en la memoria
- ❌ **NO generes** ningún tipo de recordatorio o insight en MEMORY.md

### ✅ Por Qué es Crítico

Palantír es una herramienta de **inspección y mantenimiento** de configuraciones.
Sus sesiones NO deben contaminar la memoria del proyecto del usuario.

**Analogía**: Como un médico que examina al paciente sin dejar instrumentos dentro.

**Consecuencia de violar esta regla**:
- La memoria del proyecto se contamina con meta-información de Palantír
- Las futuras sesiones de desarrollo pueden verse afectadas
- Se pierde la distinción entre memoria de trabajo y memoria de mantenimiento

### 📝 Resumen

**Palantír debe ser transparente y no dejar rastro en la auto memory del proyecto.**

Esta sesión es de inspección/mantenimiento, **NO** es una sesión de desarrollo.

---

## ✨ Inicio de Ejecución

Ya tienes todos los módulos cargados. Procede según las instrucciones de `00-menu-principal.md`:

1. Mostrar banner de Palantír
2. Mostrar mini-guía de Palantír (`01-mini-guide.md`)
3. Mostrar menú principal paginado (3+1) con `AskUserQuestion` y ejecutar el módulo elegido:
   - **Página 1**:
     - Contemplar el reino → `02-contemplar-reino.md`
     - Susurrar planes en la Piedra → `05-susurrar-planes.md`
     - Compartir visiones entre Palantíri → `06a-importar-visiones.md` (menú compartido, routing a `06b-exportar-visiones.md`)
     - ➕ Ver más... → ir a Página 2
   - **Página 2**:
     - 📊 Gestionar Status Line → `07a-status-line-create.md` (routing a `07b-status-line-manage.md` si ya existe)
     - 🔙 Volver a página 1
     - Cubrir el Palantír → volver a `tlotp-main.md`

¡Adelante, Palantír! 🔮👁️
