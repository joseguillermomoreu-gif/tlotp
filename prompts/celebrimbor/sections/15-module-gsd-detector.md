# 🚀 Detector de GSD — Celebrimbor

## Mision

Detectar si el framework GSD (Get Shit Done) esta instalado en el entorno del usuario,
informar del resultado e invitar a instalarlo si no esta presente.

Este modulo se ejecuta automaticamente durante el arranque de Celebrimbor,
despues del detector de entorno (Node.js) y antes del menu principal.

---

## Deteccion de GSD

**Ejecutar comandos de deteccion en paralelo**:

```bash
# Scope local (proyecto actual)
ls .claude/commands/gsd:*.md 2>/dev/null

# Scope global (usuario)
ls ~/.claude/commands/gsd:*.md 2>/dev/null
```

**Interpretar resultados**:
- Si se encuentran ficheros en scope local → GSD instalado (local)
- Si se encuentran ficheros en scope global → GSD instalado (global)
- Si se encuentran en ambos → GSD instalado (local + global)
- Si no se encuentran en ninguno → GSD no instalado

---

## Caso 1: GSD Instalado

Si se detectan ficheros en algun scope, mostrar informe breve y continuar:

```
  ✅ GSD detectado ({scope})
     Los Gwaith-i-Mirdain reconocen la forja de otro maestro herrero.
```

Donde `{scope}` es `local`, `global` o `local + global` segun corresponda.

**No interrumpir el flujo** — continuar directamente al siguiente paso.

---

## Caso 2: GSD No Instalado

Mostrar mensaje informativo y ofrecer opciones:

```
══════════════════════════════════════════════════════════════
🚀 GSD (Get Shit Done) — No detectado
══════════════════════════════════════════════════════════════

  Los herreros de Eregion han buscado en las forjas conocidas
  y no encuentran rastro de GSD en tu taller.

  GSD es un framework de context engineering que delega tareas
  a subagentes con contextos frescos, evitando el degradado
  de calidad en sesiones largas.

  Repo: https://github.com/gsd-build/get-shit-done/

══════════════════════════════════════════════════════════════
```

```json
{
  "questions": [{
    "header": "Celebrimbor — GSD",
    "question": "🚀 ¿Quieres instalar GSD en tu taller?",
    "multiSelect": false,
    "options": [
      {
        "label": "🌍 Instalar global (todos los proyectos)",
        "description": "npx get-shit-done-cc@latest --claude --global"
      },
      {
        "label": "📁 Instalar local (solo este proyecto)",
        "description": "npx get-shit-done-cc@latest --claude --local"
      },
      {
        "label": "⏭️ Saltar",
        "description": "Continuar sin instalar GSD"
      }
    ]
  }]
}
```

### Routing de opciones

#### Instalar global

```bash
npx get-shit-done-cc@latest --claude --global
```

Tras la ejecucion:
- Si exito → mostrar `✅ GSD instalado (global). Las forjas de Eregion celebran.`
- Si error → mostrar el error y sugerir consultar `npx get-shit-done-cc@latest --help`

Continuar al siguiente paso.

#### Instalar local

```bash
npx get-shit-done-cc@latest --claude --local
```

Tras la ejecucion:
- Si exito → mostrar `✅ GSD instalado (local). Las forjas de Eregion celebran.`
- Si error → mostrar el error y sugerir consultar `npx get-shit-done-cc@latest --help`

Continuar al siguiente paso.

#### Saltar

Continuar directamente al siguiente paso sin accion.

---

## Reglas de ejecucion

1. **Siempre ejecutar** durante el arranque, despues de la deteccion de Node.js
2. **Rapido y silencioso** si GSD esta presente (una linea, sin interrupcion)
3. **Informativo pero no bloqueante** si GSD no esta presente (el usuario puede saltar)
4. **No modificar** ningun otro modulo ni flujo existente de Celebrimbor

---

**Siguiente modulo**: 02-menu-principal.md (menu principal)
