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

Si se detectan ficheros en algun scope, mostrar informe breve:

```
  ✅ GSD detectado ({scope})
     Los Gwaith-i-Mirdain reconocen la forja de otro maestro herrero.
```

Donde `{scope}` es `local`, `global` o `local + global` segun corresponda.

### Aviso de consumo de contexto

Tras el mensaje de deteccion, mostrar el siguiente aviso:

```
══════════════════════════════════════════════════════════════
⚠️  GSD ocupa contexto en cada sesion
══════════════════════════════════════════════════════════════
  Ten en cuenta que tener GSD instalado carga sus comandos en
  el contexto de cada sesion, incluso cuando no lo estas usando.

  Si no tienes previsto usar GSD, es recomendable desinstalarlo
  para liberar ese espacio de contexto.
══════════════════════════════════════════════════════════════
```

### Opciones al usuario

```json
{
  "questions": [{
    "header": "Celebrimbor — GSD instalado",
    "question": "⚒️ ¿Que quieres hacer con GSD?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Mantener GSD instalado",
        "description": "Lo uso o tengo previsto usarlo"
      },
      {
        "label": "🗑️ Desinstalar GSD",
        "description": "Quiero liberar contexto de mis sesiones"
      },
      {
        "label": "⏭️ Continuar sin cambios",
        "description": "Decidir mas tarde"
      }
    ]
  }]
}
```

### Routing de opciones

#### Mantener GSD instalado

Mostrar confirmacion breve y continuar al siguiente paso:

```
  ✅ GSD se mantiene en el taller. Las forjas siguen encendidas.
```

#### Desinstalar GSD

Resolver el comando segun el `{scope}` donde GSD fue detectado:

| Scope detectado | Comando a ejecutar |
|-----------------|--------------------|
| `local` | `rm .claude/commands/gsd:*.md` |
| `global` | `rm ~/.claude/commands/gsd:*.md` |
| `local + global` | `rm .claude/commands/gsd:*.md ~/.claude/commands/gsd:*.md` |

**Paso 1 — Previsualizacion del comando**

Mostrar al usuario el comando exacto que se va a ejecutar:

```
══════════════════════════════════════════════════════════════
🗑️  Desinstalacion de GSD ({scope})
══════════════════════════════════════════════════════════════
  Se ejecutara el siguiente comando:
    {comando_resuelto}

  Esto eliminara todos los ficheros `gsd:*.md` del scope
  detectado. La accion no es reversible desde Celebrimbor.
══════════════════════════════════════════════════════════════
```

**Paso 2 — Confirmacion explicita**

```json
{
  "questions": [{
    "header": "Celebrimbor — Confirmar desinstalacion",
    "question": "🗑️ ¿Confirmas la desinstalacion de GSD?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Si, desinstalar",
        "description": "Ejecutar el comando mostrado"
      },
      {
        "label": "🚫 Cancelar",
        "description": "No tocar nada y continuar"
      }
    ]
  }]
}
```

**Paso 3 — Ejecucion y resultado**

- Si el usuario confirma → ejecutar el comando resuelto.
  - Si exito → mostrar:
    ```
      ✅ GSD desinstalado ({scope}). Contexto liberado.
         Las forjas de Eregion recuperan su silencio.
    ```
  - Si error → mostrar el error y continuar sin bloquear el flujo.
- Si el usuario cancela → mostrar:
  ```
    ⏭️ Desinstalacion cancelada. GSD se mantiene en el taller.
  ```

Continuar al siguiente paso.

#### Continuar sin cambios

Continuar directamente al siguiente paso sin accion ni mensajes adicionales.

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
2. **Transparente sobre el coste** si GSD esta presente (aviso de contexto + opcion de desinstalar)
3. **Informativo pero no bloqueante** si GSD no esta presente (el usuario puede saltar)
4. **Destructivo solo bajo doble confirmacion**: cualquier desinstalacion requiere previsualizacion del comando y confirmacion explicita
5. **No modificar** ningun otro modulo ni flujo existente de Celebrimbor

---

**Siguiente modulo**: 02-menu-principal.md (menu principal)
