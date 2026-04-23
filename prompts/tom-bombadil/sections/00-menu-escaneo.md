# 🌾 Módulo 00 — Menú de Escaneo

## Propósito

Preguntar al usuario qué modo de escaneo de seguridad quiere ejecutar y,
si elige selección manual, qué territorios concretos escanear.

---

## PASO 1 — Pregunta principal

Mostrar esta cabecera antes del `AskUserQuestion`:

```
══════════════════════════════════════════════════════════════
🌾 TOM BOMBADIL — ¿QUÉ TERRITORIO PATRULLAMOS HOY?
══════════════════════════════════════════════════════════════
  "El Bosque Antiguo es vasto, viajero. Tom puede patrullar
   todas tus tierras, solo las tuyas, o también los caminos
   por los que llegaste hasta aquí. Tú decides."
──────────────────────────────────────────────────────────────

  🛡️  Escaneo estándar
     Agentes, skills, MCPs, CLAUDE.md y rules/ locales
     (lo que tú has instalado en tu reino)

  🔭 Escaneo completo
     Todo lo anterior + auto-análisis de TLOTP
     (Tom se audita también a sí mismo via WebFetch)

  🗺️  Elegir territorios
     Tú eliges qué scopes escanear, uno a uno

══════════════════════════════════════════════════════════════
```

```json
{
  "questions": [{
    "header": "Tom Bombadil — Modo de escaneo",
    "question": "🌾 ¿Qué territorio patrullamos hoy, viajero?",
    "multiSelect": false,
    "options": [
      {
        "label": "🛡️  Escaneo estándar",
        "description": "Agentes + skills + MCPs + CLAUDE.md + rules/ locales"
      },
      {
        "label": "🔭 Escaneo completo (estándar + auto-análisis TLOTP)",
        "description": "Tom también audita los prompts de TLOTP via WebFetch"
      },
      {
        "label": "🗺️  Elegir territorios",
        "description": "Selección manual de scopes a escanear"
      },
      {
        "label": "🔙 Volver a La Comunidad del Código",
        "description": "Regresar a tlotp-main"
      }
    ]
  }]
}
```

---

## PASO 2 — Routing según respuesta

### 🛡️ Escaneo estándar

Registrar `TOM_MODE=estandar` y ejecutar los scanners:
- `@prompts/tom-bombadil/sections/01-scanner-agentes.md`
- `@prompts/tom-bombadil/sections/02-scanner-skills.md`
- `@prompts/tom-bombadil/sections/03-scanner-mcps.md`
- `@prompts/tom-bombadil/sections/04-scanner-configs.md`

### 🔭 Escaneo completo

Registrar `TOM_MODE=completo` y ejecutar los scanners estándar +
`@prompts/tom-bombadil/sections/05-autoanal-tlotp.md`.

Antes de lanzar el auto-análisis, el módulo 05 muestra una advertencia
previa obligatoria (ver su propio contenido).

### 🗺️ Elegir territorios — selección manual

Registrar `TOM_MODE=manual` y mostrar un segundo `AskUserQuestion`
**multiSelect** con los territorios disponibles:

```
──────────────────────────────────────────────────────────────
🗺️  TOM BOMBADIL — TERRITORIOS DEL BOSQUE ANTIGUO
──────────────────────────────────────────────────────────────
  Marca los territorios que quieras que Tom patrulle.
  Puedes seleccionar varios.
──────────────────────────────────────────────────────────────
```

```json
{
  "questions": [{
    "header": "Tom Bombadil — Territorios",
    "question": "🗺️ ¿Qué territorios quieres que patrulle Tom?",
    "multiSelect": true,
    "options": [
      {
        "label": "🏇 Agentes (~/.claude/agents/ + .claude/agents/)",
        "description": "Escanea todos los agentes globales y de proyecto"
      },
      {
        "label": "⚒️  Skills y plugins",
        "description": "Escanea ~/.claude/plugins/ y variantes de skills"
      },
      {
        "label": "🏹 MCPs (.claude.json + .mcp.json)",
        "description": "Escanea configuraciones de MCPs en ambos scopes"
      },
      {
        "label": "📜 CLAUDE.md y rules/",
        "description": "Escanea CLAUDE.md global+proyecto y reglas"
      },
      {
        "label": "🌾 Auto-análisis de TLOTP (WebFetch)",
        "description": "Tom se audita a sí mismo desde josemoreupeso.es/tlotp/"
      }
    ]
  }]
}
```

Mapear cada territorio seleccionado a su scanner:

| Territorio seleccionado              | Scanner a ejecutar                                    |
|--------------------------------------|-------------------------------------------------------|
| 🏇 Agentes                           | `@prompts/tom-bombadil/sections/01-scanner-agentes.md` |
| ⚒️ Skills y plugins                  | `@prompts/tom-bombadil/sections/02-scanner-skills.md`  |
| 🏹 MCPs                              | `@prompts/tom-bombadil/sections/03-scanner-mcps.md`    |
| 📜 CLAUDE.md y rules/                | `@prompts/tom-bombadil/sections/04-scanner-configs.md` |
| 🌾 Auto-análisis de TLOTP            | `@prompts/tom-bombadil/sections/05-autoanal-tlotp.md`  |

### 🔙 Volver a La Comunidad del Código

Cargar `@prompts/tlotp-main.md`.

---

## PASO 3 — Pasar al score

Tras ejecutar los scanners seleccionados (pueden lanzarse en paralelo si
son independientes), continuar con el módulo `06-score-estado.md` del flujo
definido en `tom-bombadil-main.md`.

---

**Módulo**: `00-menu-escaneo.md`
**Invocado desde**: `tom-bombadil-main.md`
**Siguiente**: scanners 01-05 según modo elegido
