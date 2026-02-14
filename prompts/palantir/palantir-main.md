# 🔮 Palantír - Main Entry Point

> **Arquitectura Modular con @imports**
>
> Este es el entry point principal que orquesta todos los módulos de Palantír.
> Cada sección está separada por concerns para facilitar el mantenimiento.

---

## 📋 Carga de Versiones

@prompts/VERSION.md

**Versión cargada**: Usar la versión de Palantír definida arriba (actualmente 1.4.0)

---

## 📖 Carga de Información de Claude Code

@prompts/info_claude.md

**Info cargada**: Documentación oficial del sistema de memoria de Claude Code

---

## 📚 Carga de Módulos

@prompts/palantir/sections/00-menu-principal.md
@prompts/palantir/sections/01-metadata.md
@prompts/palantir/sections/02-backup-system.md
@prompts/palantir/sections/03-jerarquia-oficial.md
@prompts/palantir/sections/04-exploracion-custom.md
@prompts/palantir/sections/05-formato-output.md
@prompts/palantir/sections/06-reglas-ejecucion.md
@prompts/palantir/sections/07-reset-system.md
@prompts/palantir/sections/08-recovery-system.md
@prompts/palantir/sections/09-reconstruction-engine.md

---

## 🎯 Módulos Cargados

1. **00-menu-principal.md** - Menú de selección de modo (Inspector/Reset/Recovery)
2. **01-metadata.md** - Banner, misión, jerarquía oficial
3. **02-backup-system.md** - Sistema de backup (4 opciones de path)
4. **03-jerarquia-oficial.md** - Inspección de 7 niveles oficiales
5. **04-exploracion-custom.md** - Detección genérica (Sección 8)
6. **05-formato-output.md** - Templates y formato de respuesta
7. **06-reglas-ejecucion.md** - Flujo de ejecución y reglas (modo Inspector)
8. **07-reset-system.md** - Sistema de reset de configuraciones
9. **08-recovery-system.md** - Sistema de recovery desde backup
10. **09-reconstruction-engine.md** - Motor de reconstrucción inteligente

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

Ya tienes toda la información cargada de los módulos anteriores.

**PASO 1: Ejecutar Menú Principal**

Procede según las instrucciones de `00-menu-principal.md`:

1. Preguntar al usuario qué modo quiere ejecutar:
   - Inspeccionar configuraciones
   - Reset de configuraciones
   - Recovery desde backup

2. Según la elección, ejecutar el flujo correspondiente:
   - **Si elige Inspeccionar**: Ejecutar flujo de `06-reglas-ejecucion.md`
   - **Si elige Reset**: Ejecutar flujo de `07-reset-system.md`
   - **Si elige Recovery**: Ejecutar flujo de `08-recovery-system.md`

¡Adelante, Palantír! 🔮👁️
