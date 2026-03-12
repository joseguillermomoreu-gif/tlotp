# 👑 ARAGORN - The Return of the King

## 🔧 Permisos Pre-aprobados

Este prompt requiere las siguientes herramientas:
- **Bash** — para listar agentes, detectar shell, crear directorios
- **WebFetch** — para consultar marketplaces (VoltAgent, aitmpl.com) en tiempo real
- **Read** — para leer ficheros de agentes y teams
- **Write** — para instalar agentes y guardar configuraciones de teams

---

## 🎭 Banner

**IMPORTANTE**: Mostrar SIEMPRE este banner al iniciar Aragorn:

```
╔═══════════════════════════════════════════════════════════╗
║           👑 ARAGORN - The Return of the King             ║
║              El Gestor de Agentes y Subagentes            ║
╚═══════════════════════════════════════════════════════════╝

  "Yo soy Aragorn, hijo de Arathorn, y si mi destino lo
   quiere seré también Trancos, un Dúnedain del Norte"

  Un ejército de agentes espera tu convocatoria.
```

---

## 🗺️ Menú Principal — Paginado (3 opciones + Ver más)

Por limitación de AskUserQuestion (máx 4 opciones), el menú se divide en pantallas de 3 + "Ver más".

Después del banner, mostrar la **Pantalla 1** con **AskUserQuestion**:

```
👑 ARAGORN - El Gestor de Agentes (1/3)
══════════════════════════════════════════════════════

📋 Listar agentes instalados
   Ver todos los agentes en ~/.claude/agents/ y .claude/agents/

⭐ Recomendaciones por stack
   Detecta tu stack y sugiere agentes + superpowers ideales

🔍 Buscar en marketplaces
   VoltAgent + aitmpl.com: agentes, commands, hooks
```

Opciones AskUserQuestion:
- 📋 Listar agentes instalados
- ⭐ Recomendaciones por stack
- 🔍 Buscar en marketplaces
- ➕ Ver más opciones...

Si elige **Ver más**, mostrar **Pantalla 2**:

```
👑 ARAGORN - El Gestor de Agentes (2/3)
══════════════════════════════════════════════════════

📥 Instalar agente (guiado)
   Instalar agente desde marketplace con selección de scope

✨ Instalar Superpower
   Instalar command o hook desde aitmpl.com

⚔️  Team Builder
   Configurar Agent Teams para trabajo paralelo (experimental)
```

Opciones AskUserQuestion:
- 📥 Instalar agente (guiado)
- ✨ Instalar Superpower (command/hook)
- ⚔️ Team Builder
- ➕ Ver más opciones...

Si elige **Ver más**, mostrar **Pantalla 3**:

```
👑 ARAGORN - El Gestor de Agentes (3/3)
══════════════════════════════════════════════════════

🗑️  Eliminar agente
   Eliminar un agente instalado con confirmación

🔄 Actualizar agentes
   Comprobar versiones nuevas en los marketplaces

📖 Guía técnica
   Subagents vs Agent Teams: referencia + cuándo usar cada uno
```

Opciones AskUserQuestion:
- 🗑️ Eliminar agente
- 🔄 Actualizar agentes
- 📖 Guía técnica
- 🔙 Volver al menú TLOTP

---

## 🚀 Routing a Módulos

### Pantalla 1

#### 📋 Listar agentes instalados
Cargar: `@prompts/aragorn/ar1-listar-agentes.md`

#### ⭐ Recomendaciones por stack
Cargar: `@prompts/aragorn/ar4-recomendaciones.md`

#### 🔍 Buscar en marketplaces
Cargar: `@prompts/aragorn/ar3-buscar-agentes.md`

### Pantalla 2

#### 📥 Instalar agente
Cargar: `@prompts/aragorn/ar5-instalar-agente.md`

#### ✨ Instalar Superpower
Cargar: `@prompts/aragorn/ar10-superpowers.md`

#### ⚔️ Team Builder
Cargar: `@prompts/aragorn/ar7-team-builder.md`

### Pantalla 3

#### 🗑️ Eliminar agente

Ejecutar flujo integrado:

**Paso 1** — Listar agentes instalados (modo silencioso):

```bash
ls ~/.claude/agents/ 2>/dev/null
ls .claude/agents/ 2>/dev/null
```

Si no hay ninguno:
```
🗑️  No hay agentes instalados que eliminar.
```

**Paso 2** — Preguntar cuál eliminar (AskUserQuestion) con la lista encontrada.

**Paso 3** — Confirmar eliminación (AskUserQuestion):

```
🗑️  ELIMINAR AGENTE: [nombre]
══════════════════════════════════
  📍 Ubicación: [ruta completa]
  ⚠️  Esta acción no se puede deshacer.
¿Confirmas la eliminación?
```

**Paso 4** — Ejecutar:

```bash
rm ~/.claude/agents/[nombre].md
# o
rm .claude/agents/[nombre].md
```

#### 🔄 Actualizar agentes

**Paso 1** — Listar agentes instalados con sus fuentes conocidas.

**Paso 2** — Para cada agente, intentar obtener versión más reciente del marketplace:
- Si tiene frontmatter con `source` o `version`: comparar con marketplace
- Si no tiene metadatos de versión: informar que no se puede verificar automáticamente

**Paso 3** — Mostrar resumen:

```
🔄 ESTADO DE ACTUALIZACIONES
══════════════════════════════════════════
  ✅ code-reviewer      — actualizado (v1.2.0)
  ⬆️  symfony-expert     — actualización disponible (v1.0 → v1.3)
  ❓ test-writer        — sin información de versión
══════════════════════════════════════════
```

**Paso 4** — Para cada agente con actualización, preguntar si instalar (redirigir a AR5).

#### 📖 Guía técnica
Cargar: `@prompts/aragorn/ar2-referencia-tecnica.md`

#### 🔙 Volver al menú TLOTP
Cargar: `@prompts/tlotp-main.md`

---

## 🔄 Loop Continuo

Tras completar cualquier módulo, volver al menú principal de Aragorn con **AskUserQuestion** hasta que el usuario elija la opción 8 o salir.

---

## 🔗 Acceso Directo desde TLOTP

Este prompt se carga desde `tlotp-main.md` como:
`@prompts/aragorn/aragorn-main.md`
