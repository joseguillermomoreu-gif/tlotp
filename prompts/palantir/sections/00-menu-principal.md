# 🎯 Menú Principal de Palantír

**Al inicio de la ejecución**, sigue estos pasos en orden:

---

## 📋 PASO 1: Mostrar Banner de Bienvenida

**PRIMERO**: Mostrar el banner elegante de Palantír (desde 05-formato-output.md):

```markdown
═══════════════════════════════════════════════════════════

                     🔮 P A L A N T Í R

             The All-Seeing Configuration Stone
                  TLOTP {VERSION}

             Jerarquía Oficial Claude Code Memory

═══════════════════════════════════════════════════════════
```

**IMPORTANTE**: Reemplaza `{VERSION}` con la versión actual de TLOTP cargada desde `@prompts/VERSION.md` (actualmente v2.1.0)

---

## 📋 PASO 1.2: Mini-guía de Palantír

@prompts/palantir/sections/12-mini-guide.md

---

## 📋 PASO 2: Pregunta Inicial

**IMPORTANTE**: **DEBES usar la herramienta `AskUserQuestion`** (NO texto plano).

Ejecuta **AskUserQuestion** con esta configuración EXACTA:

```json
{
  "questions": [
    {
      "header": "Palantír",
      "question": "¿Qué deseas hacer?",
      "multiSelect": false,
      "options": [
        {
          "label": "🔍 Contemplar el reino",
          "description": "Analizar todas las configuraciones actuales de Claude Code"
        },
        {
          "label": "🗣️ Susurrar planes en la Piedra",
          "description": "Añadir o eliminar registros de configuración"
        },
        {
          "label": "📤 Compartir visiones entre Palantíri",
          "description": "Importar o exportar configuraciones"
        },
        {
          "label": "🫣 Cubrir el Palantír de ojos ajenos",
          "description": "Salir de Palantír y volver al menú de TLOTP"
        }
      ]
    }
  ]
}
```

**NO mostrar menú de texto plano**. Usa la herramienta AskUserQuestion del CLI de Claude.

---

## 🔀 Routing según Elección

### Opción 1: Contemplar el reino

**Acción**: Ejecutar el análisis completo de configuración

Cargar: `@prompts/palantir/sections/03-contemplar-reino.md`

---

### Opción 2: Susurrar planes en la Piedra

**Acción**: Añadir nueva configuración con asistencia inteligente

Cargar: `@prompts/palantir/sections/13-susurrar-planes.md`

---

### Opción 3: Compartir visiones entre Palantíri

**Acción**: Importar, exportar o eliminar configuraciones

Cargar: `@prompts/palantir/sections/14-compartir-visiones.md`

---

### Opción 4: Cubrir el Palantír de ojos ajenos

**Acción**: Salir de Palantír y volver al menú principal de TLOTP

Cargar: `@prompts/tlotp-main.md`

---

## ⚠️ Reglas Importantes

1. **NO ejecutar múltiples modos**: Solo uno a la vez
2. **NO saltarse el menú**: Siempre preguntar primero
3. **NO asumir el modo**: Dejar que el usuario elija

---

*Menú principal - Punto de entrada de Palantír v2.0*
