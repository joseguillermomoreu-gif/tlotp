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
@prompts/palantir/sections/06-compartir-visiones.md

---

## 🎯 Módulos Cargados

1. **00-menu-principal.md** - Menú principal (Contemplar / Susurrar / Compartir / Salir)
2. **01-mini-guide.md** - Mini-guía de Palantír con lore + solicitud de permisos
3. **02-contemplar-reino.md** - Análisis completo de configuración con scoring y sugerencias
4. **03-jerarquia-oficial.md** - Inspección de jerarquía oficial (6 WebFetch docs)
5. **04-exploracion-custom.md** - Exploración de settings.json, skills/, hooks/
6. **05-susurrar-planes.md** - Añadir configuración con análisis inteligente
7. **06-compartir-visiones.md** - Importar, exportar y eliminar configuraciones

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
2. Mostrar mini-guía y solicitar permisos (`01-mini-guide.md`)
3. Mostrar menú principal con `AskUserQuestion` y ejecutar el módulo elegido:
   - **Contemplar el reino** → `02-contemplar-reino.md`
   - **Susurrar planes en la Piedra** → `05-susurrar-planes.md`
   - **Compartir visiones entre Palantíri** → `06-compartir-visiones.md`
   - **Cubrir el Palantír** → volver a `tlotp-main.md`

¡Adelante, Palantír! 🔮👁️
