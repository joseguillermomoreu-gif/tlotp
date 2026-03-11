# 👑 AR10 - Los Poderes Ancestrales: Instalar Superpowers

## Intro de ejecución

```
👑 Aragorn invoca los poderes ancestrales de la Tierra Media...
   Commands que obedecen con un slash. Hooks que vigilan en las sombras.
   El Palantír del Rey activará los más poderosos.
```

---

## Contexto: ¿Qué son los Superpowers?

Los **Superpowers** son componentes de aitmpl.com que potencian al agente principal
(no son instancias independientes como los agentes). Hay dos tipos:

| Tipo | Qué es | Dónde se instala |
|------|--------|-----------------|
| **Command** | Slash command personalizado (`/nombre`) | `.claude/commands/nombre.md` |
| **Hook** | Script que se ejecuta en eventos del lifecycle | Via **Palantír** (gestión de hooks) |

---

## Paso 1 — Preguntar qué tipo de Superpower

**Usar AskUserQuestion**:

```
✨ INSTALAR SUPERPOWER
══════════════════════════════════════════

¿Qué tipo de Superpower quieres instalar?
```

Opciones:
- ⚡ Command — slash command personalizado (`/nombre`)
- 🪝 Hook — script en eventos del lifecycle (PreToolUse, PostCommit...)
- 🔙 Volver al menú de Aragorn

---

## Opción A — Instalar Command

### Paso A1 — Buscar commands en aitmpl.com

```
WebFetch: https://www.aitmpl.com/commands
```

Si el WebFetch falla o devuelve contenido dinámico (aitmpl carga con JS),
mostrar los commands más populares conocidos y ofrecer búsqueda manual:

```
⚠️  aitmpl.com carga dinámicamente — mostrando catálogo conocido.
    Para el catálogo completo: https://www.aitmpl.com/commands
```

**Catálogo base de commands** (actualizar con WebFetch si disponible):

| Command | Descripción | Stack ideal |
|---------|-------------|-------------|
| `run-tests` | Ejecuta la suite de tests con filtro opcional | Cualquiera |
| `e2e-run` | Lanza Playwright con tag o título | Playwright |
| `ci-status` | Consulta estado del CI/CD | GitHub Actions |
| `symfony-lint` | PHPStan + CS-Fixer en un comando | Symfony |
| `docker-clean` | Limpia imágenes y containers huérfanos | Docker |
| `db-migrate` | Ejecuta migraciones pendientes | Doctrine/ORM |
| `coverage-report` | Genera y abre reporte de cobertura | PHPUnit/Jest |
| `pr-review` | Resumen de cambios del PR actual | Git |
| `changelog` | Genera changelog desde commits convencionales | Git |
| `deploy-check` | Verifica estado pre-deploy | CI/CD |

### Paso A2 — Seleccionar command

**Usar AskUserQuestion** mostrando hasta 3 commands relevantes según el stack detectado + "Ver más / escribir nombre".

Si el usuario escribe un nombre manualmente, intentar descargarlo de aitmpl.com:

```
WebFetch: https://www.aitmpl.com/commands/[nombre]
```

### Paso A3 — Preguntar scope

**Usar AskUserQuestion**:

```
⚡ Instalando command: /[nombre]

¿Dónde quieres instalarlo?
```

- **📁 Proyecto** (`.claude/commands/`) — solo en este proyecto (recomendado)
- **🌍 Global** (`~/.claude/commands/`) — disponible en todos tus proyectos

### Paso A4 — Mostrar preview y confirmar

Mostrar el contenido del command antes de instalar:

```
📄 PREVIEW DEL COMMAND
══════════════════════════════════════════════════════

Nombre:    /run-tests
Destino:   .claude/commands/run-tests.md
Fuente:    aitmpl.com / commands

--- Contenido ---
Ejecuta la suite de tests del proyecto...
══════════════════════════════════════════════════════
```

**Usar AskUserQuestion**:
- ✅ Instalar — escribir el fichero en el destino
- ❌ Cancelar

### Paso A5 — Instalar el command

Crear el directorio si no existe:

```bash
mkdir -p .claude/commands/
# o
mkdir -p ~/.claude/commands/
```

Escribir el fichero `.md` con el contenido descargado usando Write.

### Paso A6 — Confirmar instalación

```
✅ SUPERPOWER INSTALADO
══════════════════════════════════════════════════════

  ⚡ Command: /run-tests
  📍 Ubicación: .claude/commands/run-tests.md
  📁 Scope: Proyecto

  💡 Cómo usarlo:
     Escribe /run-tests en Claude Code para ejecutarlo.
     Ejemplo: /run-tests OrderServiceTest

══════════════════════════════════════════════════════
```

**Usar AskUserQuestion**:
- Instalar otro command
- Instalar un hook
- Volver al menú de Aragorn

---

## Opción B — Instalar Hook

Los hooks se gestionan a través de **Palantír** (el guardián de las configuraciones).

Mostrar al usuario:

```
🪝 HOOKS — Gestionados por el Palantír del Rey
══════════════════════════════════════════════════════

Los hooks son scripts que se ejecutan automáticamente
en eventos del lifecycle de Claude Code:

  • PreToolUse   — antes de usar una herramienta
  • PostToolUse  — después de usar una herramienta
  • PreCommit    — antes de hacer commit
  • PostCommit   — después de hacer commit
  • SessionStart — al iniciar una sesión

Los hooks se configuran en settings.json y son
gestionados por Palantír para garantizar backups
y consistencia.

Hooks populares en aitmpl.com:

  🪝 pre-commit-lint     — linter automático antes de commit
  🪝 post-commit-notify  — notificación tras commit exitoso
  🪝 review-on-edit      — ejecuta code-reviewer al guardar ficheros
  🪝 test-on-save        — lanza tests al modificar ficheros de test
  🪝 security-scan       — escaneo de seguridad en PreToolUse Bash
```

**Usar AskUserQuestion**:
- 🔮 Abrir Palantír para gestionar hooks (cargar `@prompts/palantir/palantir-main.md`)
- 📋 Ver documentación de hooks de Claude Code
- 🔙 Volver al menú de Aragorn

Si el usuario elige **ver documentación**:

```
📖 HOOKS EN CLAUDE CODE
══════════════════════════════════════════════════════

Configuración en settings.json:

{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          { "type": "command", "command": "./scripts/lint.sh" }
        ]
      }
    ]
  }
}

Eventos disponibles:
  • PreToolUse / PostToolUse  — por herramienta (matcher)
  • SubagentStart / SubagentStop — lifecycle de agentes
  • SessionStart / SessionEnd — inicio y fin de sesión

Documentación oficial: https://code.claude.com/docs/en/hooks
══════════════════════════════════════════════════════
```

---

## Notas de implementación

- Los commands son ficheros `.md` simples — se instalan igual que los agentes
- Los hooks requieren editar `settings.json` — delegar siempre a Palantír para evitar errores y garantizar backup
- Si aitmpl.com no es accesible (contenido dinámico), usar el catálogo base hardcodeado como fallback
- Siempre verificar si ya existe un command con el mismo nombre antes de sobreescribir
