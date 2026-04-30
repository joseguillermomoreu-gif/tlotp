# 🪨 Módulo: Caveman — Plugin de tercero (reducción de tokens)

> **Origen: tercero** — `JuliusBrussee/caveman` (~14.000 ⭐) · No es un plugin
> oficial de Claude Code. Bardo lo presenta como herramienta del mercado por su
> impacto medible en tokens de salida.

## Misión

Descubrir, presentar e instalar de forma asistida el plugin Caveman, que
reduce los tokens de salida 65–75% comprimiendo respuestas a "estilo cavernícola".
El usuario decide en cada paso; nada se ejecuta sin confirmación explícita.

---

## Paso 0 — Detectar si Caveman ya está instalado

```bash
claude plugin list 2>/dev/null | grep -i caveman || true
```

**Si la salida contiene `caveman`** → ramificar a **Paso 0b (ya instalado)**.
**Si está vacía** → continuar a Paso 1.

### Paso 0b — Caveman ya instalado

```
══════════════════════════════════════════════════════════════
🪨 Caveman ya está instalado en tu arsenal.
══════════════════════════════════════════════════════════════

   Estado: activo (plugin de tercero, JuliusBrussee/caveman)
   Activar:    /caveman
   Desactivar: stop caveman
   Niveles:    Lite · Full · Ultra · 文言文
```

**AskUserQuestion**:

```json
{
  "questions": [{
    "header": "🪨 Caveman ya instalado",
    "question": "¿Qué quieres hacer?",
    "multiSelect": false,
    "options": [
      { "label": "ℹ️ Ver más información (WebFetch al repo)", "description": "" },
      { "label": "🛑 Mostrar cómo desactivar", "description": "" },
      { "label": "🔙 Volver al menú Bardo", "description": "" }
    ]
  }]
}
```

- **Ver más información** → WebFetch on-demand a `https://github.com/JuliusBrussee/caveman`
  y mostrar resumen. Volver a este AskUserQuestion.
- **Mostrar cómo desactivar** → mostrar `stop caveman` con explicación. Volver al menú Bardo.
- **🔙 Volver al menú Bardo** → menú principal sin re-renderizar banner ni intro.

---

## Paso 1 — Presentación del plugin

```
══════════════════════════════════════════════════════════════
🪨  CAVEMAN — El Cavernícola de Lake-town
══════════════════════════════════════════════════════════════

  📦 Identidad
     Plugin: caveman@caveman
     Repo:   JuliusBrussee/caveman
     ⭐      ~14.000
     Origen: tercero (no es plugin oficial de Claude Code)

  ⚡ Beneficio
     Reduce tokens de salida 65–75% comprimiendo respuestas
     a "estilo cavernícola" (telegráfico, sin florituras).

  🎚️ Niveles disponibles
     • Lite    — recorte suave (~30%)
     • Full    — modo cavernícola completo (~65%)
     • Ultra   — máxima compresión (~75%)
     • 文言文  — modo chino clásico (curiosidad cultural)

  🛠️ Sub-skills incluidos
     /caveman-commit    — mensajes de commit comprimidos
     /caveman-review    — code review en estilo cavernícola
     /caveman-compress  — comprimir cualquier texto a la fuerza
     /caveman-help      — ayuda del plugin

  ▶️ Comandos
     Activar:    /caveman
     Desactivar: stop caveman

  🏹 Lore del Arquero
     "Donde el Arquero gasta una flecha, el Cavernícola gasta una piedra.
      Misma presa. Menos materiales. Lake-town aprueba el trueque."

══════════════════════════════════════════════════════════════
```

---

## Paso 2 — Decisión del usuario

```json
{
  "questions": [{
    "header": "🪨 Caveman — ¿Lo instalamos?",
    "question": "🏹 ¿Qué deseas hacer con esta piedra?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Sí, instalar Caveman",
        "description": "Bardo añadirá el marketplace y ejecutará la instalación"
      },
      {
        "label": "ℹ️ Más información (consultar el repo)",
        "description": "WebFetch on-demand a github.com/JuliusBrussee/caveman"
      },
      {
        "label": "⏭️ No, saltar",
        "description": "Volver al menú Bardo sin instalar"
      },
      {
        "label": "🚫 Cancelar",
        "description": "Volver al menú Bardo"
      }
    ]
  }]
}
```

### Comportamiento por opción

- **✅ Sí, instalar Caveman** → ir al **Paso 3**.
- **ℹ️ Más información**:
  - WebFetch on-demand a `https://github.com/JuliusBrussee/caveman`
  - Mostrar resumen extraído (descripción extendida, ejemplos, niveles)
  - **Volver a este Paso 2** (re-preguntar instalar / saltar / cancelar)
- **⏭️ No, saltar**:
  ```
  🏹 "Hoy el Cavernícola se queda en la cueva. Otro día, viajero."
  ```
  Volver al menú Bardo (sin re-renderizar banner ni intro).
- **🚫 Cancelar** → volver al menú Bardo (sin re-renderizar banner ni intro).

---

## Paso 3 — Instalación asistida

> **Confirmación explícita ya recibida en Paso 2**. Solo se ejecuta tras `✅ Sí`.

Mostrar antes de ejecutar:

```
🪨 Instalando Caveman (plugin de tercero)...

   Comandos a ejecutar:
     1) claude plugin marketplace add JuliusBrussee/caveman
     2) claude plugin install caveman@caveman
```

Ejecutar en orden estricto:

```bash
claude plugin marketplace add JuliusBrussee/caveman
claude plugin install caveman@caveman
```

**Si el primer comando falla** (marketplace ya añadido, error de red, etc.):
- Capturar el mensaje y continuar al segundo solo si el error es "marketplace already added".
- Si es otro error, abortar y mostrar el fallback (ver más abajo).

**Si el segundo comando falla**:
```
⚠️ No se pudo instalar Caveman.

   Puedes intentarlo manualmente:
     claude plugin marketplace add JuliusBrussee/caveman
     claude plugin install caveman@caveman

   Repo oficial (origen tercero): https://github.com/JuliusBrussee/caveman
```
Volver al menú Bardo.

---

## Paso 4 — Activación post-instalación

```
══════════════════════════════════════════════════════════════
✅ Caveman instalado correctamente
══════════════════════════════════════════════════════════════

  ▶️ Para activarlo:
     /caveman

  🛑 Para desactivarlo:
     stop caveman

  🎚️ Niveles disponibles:
     Lite · Full · Ultra · 文言文

  🛠️ Sub-skills disponibles:
     /caveman-commit    — commits comprimidos
     /caveman-review    — code review cavernícola
     /caveman-compress  — comprimir texto a la fuerza
     /caveman-help      — ayuda del plugin

══════════════════════════════════════════════════════════════

🏹 "Una piedra más en el carcaj. Smaug arderá igual,
    pero esta vez con la mitad de tokens, viajero."
```

---

## Paso 5 — Continuación

Volver al menú principal de Bardo **sin re-renderizar banner, intro ni permisos**.
El loop continuo del módulo principal toma el control.

---

## Notas de mantenimiento

- **Versión observada**: comandos verificados en abril 2026. Si el plugin cambia su
  flujo de instalación o activación, actualizar este módulo.
- **Origen tercero**: marcado explícitamente en cabecera, Paso 1, Paso 2 (descripción
  de "Sí, instalar") y fallback de Paso 3.
- **Sin scripts externos**: solo se usan los comandos oficiales `claude plugin
  marketplace add` y `claude plugin install`. No se ejecuta código del repo de tercero.
- **Sin persistencia de credenciales**: Caveman no requiere ni almacena secretos.

---

## 🔗 Fuentes

- Repo oficial (tercero): `https://github.com/JuliusBrussee/caveman`
- Plugins Claude Code: `https://code.claude.com/docs/en/plugins`

---

**Módulo**: `06-module-caveman.md`
**Invocado desde**: `bardo-main.md` (submenú "🛒 El mercado" → "🪨 Caveman")
**Requiere**: Bash (detección + instalación), WebFetch on-demand (solo en "Más información")
