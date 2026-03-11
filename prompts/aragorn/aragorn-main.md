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

## 🗺️ Menú Principal

Después del banner, mostrar el menú con **AskUserQuestion**:

```
👑 ARAGORN - El Gestor de Agentes
══════════════════════════════════════════════════════

1. 📋 Listar agentes instalados
   Ver todos los agentes en ~/.claude/agents/ y .claude/agents/

2. 🔍 Buscar agentes en marketplaces
   VoltAgent (127+ agentes) + aitmpl.com (600+ componentes)

3. 📥 Instalar agente (guiado)
   Instalar desde marketplace con selección de scope

4. 🗑️  Eliminar agente
   Eliminar un agente instalado con confirmación

5. 🔄 Actualizar agentes
   Comprobar versiones nuevas en los marketplaces

6. ⚔️  Team Builder
   Configurar Agent Teams para trabajo paralelo (experimental)

7. 📖 Guía: Subagents vs Agent Teams
   Referencia técnica + cuándo usar cada uno

8. 🔙 Volver al menú TLOTP
```

---

## 🚀 Routing a Módulos

### Opción 1 — Listar agentes instalados
Cargar: `@prompts/aragorn/ar1-listar-agentes.md`

### Opción 2 — Buscar en marketplaces
Cargar: `@prompts/aragorn/ar3-buscar-agentes.md`

### Opción 3 — Instalar agente
Cargar: `@prompts/aragorn/ar5-instalar-agente.md`

### Opción 4 — Eliminar agente

Ejecutar flujo integrado:

**Paso 4.1** — Listar agentes instalados (modo silencioso):

```bash
ls ~/.claude/agents/ 2>/dev/null
ls .claude/agents/ 2>/dev/null
```

Si no hay ninguno:
```
🗑️  No hay agentes instalados que eliminar.
```

**Paso 4.2** — Preguntar cuál eliminar (AskUserQuestion) con la lista de agentes encontrados.

**Paso 4.3** — Confirmar eliminación (AskUserQuestion):

```
🗑️  ELIMINAR AGENTE: [nombre]
══════════════════════════════════
  📍 Ubicación: [ruta completa]
  ⚠️  Esta acción no se puede deshacer.

¿Confirmas la eliminación?
```

**Paso 4.4** — Ejecutar:

```bash
rm ~/.claude/agents/[nombre].md
# o
rm .claude/agents/[nombre].md
```

Confirmar al usuario y volver al menú.

### Opción 5 — Actualizar agentes

Ejecutar flujo integrado:

**Paso 5.1** — Listar agentes instalados con sus fuentes conocidas.

**Paso 5.2** — Para cada agente instalado, intentar obtener la versión más reciente del marketplace:

- Si tiene frontmatter con `source` o `version`: comparar con la versión en el marketplace
- Si no tiene metadatos de versión: informar que no se puede verificar automáticamente

**Paso 5.3** — Mostrar resumen:

```
🔄 ESTADO DE ACTUALIZACIONES
══════════════════════════════════════════
  ✅ code-reviewer      — actualizado (v1.2.0)
  ⬆️  symfony-expert     — actualización disponible (v1.0 → v1.3)
  ❓ test-writer        — sin información de versión
══════════════════════════════════════════
```

**Paso 5.4** — Para cada agente con actualización disponible, preguntar si instalar.
Redirigir a AR5 para la instalación con scope ya pre-seleccionado.

### Opción 6 — Team Builder
Cargar: `@prompts/aragorn/ar7-team-builder.md`

### Opción 7 — Guía técnica
Cargar: `@prompts/aragorn/ar2-referencia-tecnica.md`

### Opción 8 — Volver al menú TLOTP
Cargar: `@prompts/tlotp-main.md`

---

## 🔄 Loop Continuo

Tras completar cualquier módulo, volver al menú principal de Aragorn con **AskUserQuestion** hasta que el usuario elija la opción 8 o salir.

---

## 🔗 Acceso Directo desde TLOTP

Este prompt se carga desde `tlotp-main.md` como:
`@prompts/aragorn/aragorn-main.md`
