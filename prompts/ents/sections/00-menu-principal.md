# 🌳 Menú Principal - Ents

**Al inicio de la ejecución**, sigue estos pasos en orden:

---

## 📋 PASO 1: Mostrar Banner de Bienvenida

**PRIMERO**: Mostrar el banner de los Ents:

```
═══════════════════════════════════════════════════════════════

               🌳🌳🌳  E N T S  🌳🌳🌳

            Guardianes de las Ramas del Repositorio
                      TLOTP {VERSION}

         "No os apresuréis... los árboles más viejos
          son los que mejor conocen el bosque."

                          — Bárbol

═══════════════════════════════════════════════════════════════
```

**IMPORTANTE**: Reemplaza `{VERSION}` con la versión actual cargada desde `@prompts/VERSION.md`

---

## 📋 PASO 1.2: Mini-guía de los Ents

@prompts/ents/sections/01-mini-guide.md

---

## 📋 PASO 2: Menú Principal

**IMPORTANTE**: **DEBES usar la herramienta `AskUserQuestion`** (NO texto plano).

Ejecuta **AskUserQuestion** con esta configuración EXACTA:

```json
{
  "questions": [
    {
      "header": "Los Guardianes del Bosque",
      "question": "¿Qué misión encomendáis a los Ents hoy?",
      "multiSelect": false,
      "options": [
        {
          "label": "🌳 Convocar la Asamblea",
          "description": "Analizar el CI/CD actual, trazar el mapa del bosque y sugerir mejoras"
        },
        {
          "label": "⚒️ La Marcha sobre Isengard",
          "description": "Aplicar mejoras o cambios al CI/CD existente con asistencia guiada"
        },
        {
          "label": "🌱 Plantar nuevos árboles",
          "description": "Crear workflows de GitHub Actions desde cero con las mejores prácticas"
        },
        {
          "label": "🚪 Retirarse al Fangorn",
          "description": "Salir de los Ents y volver al menú de TLOTP"
        }
      ]
    }
  ]
}
```

**NO mostrar menú de texto plano**. Usa la herramienta AskUserQuestion del CLI de Claude.

---

## 🔀 Routing según Elección

### 🌳 Convocar la Asamblea

**Acción**: Antes de iniciar el análisis, preguntar con **AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Consulta a GitHub",
    "question": "Para evaluar la protección de ramas necesito consultar la API de GitHub. ¿Tienes `gh` configurado y deseas que lo haga?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Sí, consultar GitHub API",
        "description": "Ejecutaré gh api para obtener las reglas de protección reales de tus ramas"
      },
      {
        "label": "🚫 No, saltar esta comprobación",
        "description": "Marcaré la protección de ramas como ❓ (no verificada)"
      }
    ]
  }]
}
```

Guardar la respuesta en contexto (`gh_disponible: true/false`) y proceder sin más interrupciones.

Ejecutar en orden:
1. **Escaneo** (`02-analyzer.md`) — Detectar todo el CI/CD del proyecto
2. **Diagrama** (`03-diagram-renderer.md`) — Mostrar el mapa del bosque (pipeline visual)
3. **Mejoras** (`04-improvement-engine.md`) — Scoring 0-100 + sugerencias + revisor uno a uno

---

### ⚒️ La Marcha sobre Isengard

**Acción**: Ejecutar sistema de modificación asistida

Procede a ejecutar:
1. **Escaneo rápido** (`02-analyzer.md`) — Detectar CI/CD actual (sin diagrama detallado)
2. **Modificación** (`05-modifier.md`) — Asistir al usuario en los cambios

---

### 🌱 Plantar nuevos árboles

**Acción**: Ejecutar sistema de creación guiada

Procede a ejecutar:
1. **Creación** (`06-creator.md`) — Generar GitHub Actions CI/CD paso a paso

---

### 🚪 Retirarse al Fangorn

**Acción**: Volver al menú principal de TLOTP

Mostrar mensaje de despedida:

```
🌳 "Los Ents seguiremos aquí cuando volváis a necesitarnos.
    El bosque tiene buena memoria... muy, muy buena memoria."

                              — Bárbol
```

Cargar: `@prompts/tlotp-main.md`

---

## ⚠️ Reglas de Ejecución

1. **SIEMPRE mostrar banner** antes del menú (solo la primera vez)
2. **Usar AskUserQuestion** para navegación
3. **Loop continuo** hasta que el usuario elija Retirarse al Fangorn
4. **NO ejecutar múltiples modos** a la vez
5. **NO asumir la opción**: Dejar que el usuario elija

---

*Módulo 00 — Menú Principal de Ents*
