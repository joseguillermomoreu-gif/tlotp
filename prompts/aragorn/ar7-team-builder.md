# 👑 AR7 - Los Ejércitos de Gondor: Team Builder

## Intro de ejecución

```
👑 Aragorn convoca a los ejércitos de Gondor...
   Cada team es un batallón que marcha unido hacia la victoria.
```

---

## Paso 1 — Menú principal del Team Builder

Mostrar el menú:

```
⚔️  TEAM BUILDER - Configurar Agent Teams
══════════════════════════════════════════

Los Agent Teams permiten que múltiples agentes trabajen
en paralelo, cada uno con su propio contexto independiente.

¿Qué quieres hacer?
```

**Usar AskUserQuestion** con estas opciones:
- 🆕 Crear nuevo team
- 📋 Ver teams configurados
- 🔧 Editar team existente
- 🗑️  Eliminar team
- ❓ ¿Qué son los Agent Teams?
- 🔙 Volver al menú de Aragorn

---

## Opción A — Crear nuevo team

### Paso A1 — Recopilar agentes disponibles

Ejecutar AR1 en modo silencioso para obtener la lista de agentes instalados:

```bash
ls ~/.claude/agents/ 2>/dev/null
ls .claude/agents/ 2>/dev/null
```

Si no hay ningún agente instalado:

```
⚠️  No hay agentes instalados todavía.
    Para crear un team necesitas tener al menos 2 agentes instalados.

    → Opción: Instalar agentes primero (ir a AR5)
    → Opción: Volver al menú
```

### Paso A2 — Nombre del team

**Usar AskUserQuestion** para pedir el nombre:

```
🆕 NUEVO TEAM — Paso 1/4
══════════════════════════════════════════

¿Cómo se llamará este team?
(ej: full-stack-review, deploy-guard, security-audit)
```

Validar el nombre:
- Solo letras minúsculas, números y guiones
- Sin espacios ni caracteres especiales
- Si inválido, pedir de nuevo con indicación del formato correcto

### Paso A3 — Seleccionar agentes

Mostrar todos los agentes disponibles (global + proyecto) y pedir selección:

```
🆕 NUEVO TEAM — Paso 2/4
══════════════════════════════════════════

Agentes disponibles para incluir en el team:

🌍 Global (~/.claude/agents/):
  • code-reviewer    — Revisa código buscando bugs y mejoras
  • test-writer      — Genera tests unitarios y E2E
  • symfony-expert   — Experto en Symfony/PHP
  • security-auditor — Auditoría de seguridad

📁 Proyecto (.claude/agents/):
  • deploy-guardian  — Supervisa deploys

Selecciona los agentes para "[nombre-del-team]"
(necesitas al menos 2 para que tenga sentido un team)
```

**Usar AskUserQuestion** con multiSelect: true listando todos los agentes disponibles.

Si el usuario selecciona menos de 2: advertir y volver a preguntar.

### Paso A4 — Descripción del team

**Usar AskUserQuestion**:

```
🆕 NUEVO TEAM — Paso 3/4
══════════════════════════════════════════

Team: [nombre]
Agentes: [agente1], [agente2], ...

¿Para qué se usará este team?
(ej: Revisión completa de código Symfony: calidad + seguridad)
```

### Paso A5 — Activación de Agent Teams

Comprobar si la variable de entorno ya está activa:

```bash
echo $CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS
```

Si NO está activa, mostrar:

```
🆕 NUEVO TEAM — Paso 4/4
══════════════════════════════════════════

Para usar Agent Teams necesitas activar la feature experimental:

  export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1

¿Qué quieres hacer con esta variable?
```

**Usar AskUserQuestion**:
- ✅ Añadir permanentemente a `.bashrc`/`.zshrc`
- 📋 Copiar el comando (lo haré yo manualmente)
- ⏭️  Saltar por ahora (lo añadiré después)

Si elige **añadir permanentemente**, detectar el shell del usuario:

```bash
echo $SHELL
```

- Si es `zsh`: añadir a `~/.zshrc`
- Si es `bash`: añadir a `~/.bashrc`

Añadir la línea al final del fichero:

```bash
echo '' >> ~/.zshrc
echo '# Agent Teams (Claude Code experimental)' >> ~/.zshrc
echo 'export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1' >> ~/.zshrc
```

Confirmar con:
```
✅ Variable añadida a ~/.zshrc
   Recarga tu terminal o ejecuta: source ~/.zshrc
```

Si ya estaba activa, mostrar:
```
✅ Agent Teams ya está activado en tu entorno.
```

### Paso A6 — Generar fichero de configuración

Crear el directorio si no existe:

```bash
mkdir -p .claude/teams/
```

Comprobar si ya existe un team con ese nombre:

```bash
ls .claude/teams/[nombre].yml 2>/dev/null
```

Si ya existe, preguntar (AskUserQuestion):
- 🔄 Sobreescribir — reemplazar la configuración existente
- 📋 Ver configuración actual — mostrar el contenido antes de decidir
- ❌ Cancelar

Generar el fichero `.claude/teams/[nombre].yml`:

```yaml
# .claude/teams/[nombre].yml
# Generado por Aragorn Team Builder
name: [nombre]
description: [descripción introducida por el usuario]
agents:
  - [agente1]
  - [agente2]
experimental: true
```

Usar la herramienta Write para crear el fichero.

### Paso A7 — Confirmar creación

```
✅ TEAM CREADO CORRECTAMENTE
══════════════════════════════════════════

  🏛️  Team: [nombre]
  📝  [descripción]
  ⚔️  Agentes: [agente1], [agente2], ...
  📍  Fichero: .claude/teams/[nombre].yml
  ⚗️  Feature: CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1

  💡 Cómo usar este team:
     Invoca a los agentes normalmente y Claude Code
     los ejecutará en paralelo con contextos independientes.

══════════════════════════════════════════
```

**Usar AskUserQuestion**:
- Crear otro team
- Ver todos los teams configurados
- Volver al menú de Aragorn
- Salir

---

## Opción B — Ver teams configurados

### Paso B1 — Escanear teams existentes

```bash
ls .claude/teams/ 2>/dev/null
```

Si no hay ninguno:

```
📋 No hay teams configurados todavía.
   → Opción: Crear nuevo team
   → Opción: Volver al menú
```

### Paso B2 — Mostrar inventario de teams

Para cada fichero `.yml` encontrado, leer su contenido y mostrar:

```
📋 TEAMS CONFIGURADOS
══════════════════════════════════════════

  1. full-stack-review
     📝 Revisión completa de código Symfony: calidad + seguridad
     ⚔️  Agentes: code-reviewer, symfony-expert
     📍 .claude/teams/full-stack-review.yml

  2. security-audit
     📝 Auditoría de seguridad antes de releases
     ⚔️  Agentes: security-auditor, code-reviewer
     📍 .claude/teams/security-audit.yml

══════════════════════════════════════════
📊 Total: 2 teams configurados
```

**Usar AskUserQuestion**:
- Crear nuevo team
- Editar un team (ir a Opción C)
- Eliminar un team (ir a Opción D)
- Volver al menú de Aragorn

---

## Opción C — Editar team existente

### Paso C1 — Seleccionar team

Listar teams disponibles y preguntar (AskUserQuestion) cuál editar.

### Paso C2 — Mostrar configuración actual

```
🔧 EDITAR TEAM: [nombre]
══════════════════════════════════════════

Configuración actual:
  📝 Descripción: [descripción actual]
  ⚔️  Agentes: [lista actual]

¿Qué quieres modificar?
```

**Usar AskUserQuestion**:
- Cambiar agentes del team
- Cambiar descripción
- Volver sin cambios

### Paso C3 — Aplicar cambios

Reutilizar los pasos A3/A4 según lo que el usuario quiera editar.

Reescribir el fichero `.yml` con la nueva configuración usando Write.

Confirmar los cambios al usuario.

---

## Opción D — Eliminar team

### Paso D1 — Seleccionar team

Listar teams disponibles y preguntar (AskUserQuestion) cuál eliminar.

### Paso D2 — Confirmar eliminación

```
🗑️  ELIMINAR TEAM: [nombre]
══════════════════════════════════════════

  📝 [descripción]
  ⚔️  Agentes: [lista]

  ⚠️  Esta acción no se puede deshacer.
  ¿Confirmas la eliminación?
```

**Usar AskUserQuestion**:
- ✅ Sí, eliminar
- ❌ Cancelar

### Paso D3 — Ejecutar eliminación

```bash
rm .claude/teams/[nombre].yml
```

Confirmar al usuario:

```
✅ Team "[nombre]" eliminado correctamente.
```

---

## Opción E — ¿Qué son los Agent Teams?

Mostrar la sección educativa:

```
❓ AGENT TEAMS vs SUBAGENTS
══════════════════════════════════════════

Agent Teams es una feature EXPERIMENTAL de Claude Code
que permite ejecutar múltiples agentes EN PARALELO.

┌─────────────────────────────────────────────────────┐
│  SUBAGENTS                  AGENT TEAMS             │
│  ─────────────────          ──────────────────────  │
│  Secuencial                 Paralelo                │
│  Un agente orquesta         Todos arrancan a la vez │
│  al resto                   con contextos propios   │
│  Coordinados                Independientes          │
│  Contexto compartido        Contexto aislado        │
└─────────────────────────────────────────────────────┘

📋 Requisitos:
  • Variable de entorno: CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
  • Agentes definidos en ~/.claude/agents/ o .claude/agents/
  • Cada agente = instancia de Claude Code independiente

💡 Cuándo usar cada uno:
  • Subagents: tareas que requieren coordinación o resultados
    de un agente para alimentar al siguiente
  • Agent Teams: análisis paralelos independientes donde
    quieres múltiples perspectivas simultáneas

══════════════════════════════════════════
```

**Usar AskUserQuestion**:
- Crear un team ahora
- Volver al menú de Aragorn

---

## Notas de implementación

- Los ficheros de teams se guardan en **scope proyecto** (`.claude/teams/`) porque son específicos del contexto de trabajo
- Si el directorio `.claude/teams/` no existe, crearlo automáticamente antes de guardar
- Los agentes referenciados en un team deben existir en `~/.claude/agents/` o `.claude/agents/`; si alguno no se encuentra al cargar la configuración, advertir al usuario
- La variable `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` es a nivel de entorno y afecta a toda la sesión de terminal, no solo a Claude Code
