# 🎯 Menú Principal de Palantír

**Al inicio de la ejecución**, sigue estos pasos en orden:

---

## 📋 PASO 1: Mostrar Banner de Bienvenida

**PRIMERO**: Mostrar el banner elegante de Palantír:

```markdown
═══════════════════════════════════════════════════════════════════════
       ᛈ · ᚨ · ᛚ · ᚨ · ᚾ · ᛏ · ᛁ · ᚱ  ·  ᛏ · ᚻ · ᛖ · ᛚ · ᛁ · ᛏ · ᚻ

                        🔮  P A L A N T Í R
                The All-Seeing Configuration Stone
                         TLOTP {VERSION}
                Jerarquía Oficial Claude Code Memory

       ᛈ · ᚨ · ᛚ · ᚨ · ᚾ · ᛏ · ᛁ · ᚱ  ·  ᛏ · ᚻ · ᛖ · ᛚ · ᛁ · ᛏ · ᚻ
═══════════════════════════════════════════════════════════════════════
```

**IMPORTANTE**: Reemplaza `{VERSION}` con la versión actual de TLOTP cargada desde `@prompts/VERSION.md`

---

## 📋 PASO 1.2: Mini-guía de Palantír

@prompts/palantir/sections/01-mini-guide.md

---

## 📋 PASO 2: Pregunta Inicial — Menú paginado (3+1)

**IMPORTANTE**: **DEBES usar la herramienta `AskUserQuestion`** (NO texto plano).

Palantír tiene 5 opciones de primer nivel. Como `AskUserQuestion` admite
máximo 4 opciones por pregunta, aplicamos el patrón de paginación 3+1
documentado en `ARCHITECTURE.md` (ADR-01).

Empezar **siempre** por la **página 1**.

### Página 1 — Operaciones principales

Ejecuta **AskUserQuestion** con esta configuración EXACTA:

```json
{
  "questions": [
    {
      "header": "Palantír (1/2)",
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
          "label": "➕ Ver más...",
          "description": "Otras herramientas de Palantír"
        }
      ]
    }
  ]
}
```

### Página 2 — Herramientas específicas

Solo se muestra si el usuario elige "➕ Ver más..." en la página 1.

Ejecuta **AskUserQuestion** con esta configuración EXACTA:

```json
{
  "questions": [
    {
      "header": "Palantír (2/2)",
      "question": "¿Qué deseas hacer?",
      "multiSelect": false,
      "options": [
        {
          "label": "📊 Gestionar Status Line",
          "description": "Autoasistir o ver/editar/eliminar la Status Line de Claude Code"
        },
        {
          "label": "🔙 Volver a página 1",
          "description": "Ver de nuevo las operaciones principales"
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

### Página 1 · Opción 1: Contemplar el reino

**Acción**: Ejecutar el análisis completo de configuración

Cargar: `@prompts/palantir/sections/02-contemplar-reino.md`

---

### Página 1 · Opción 2: Susurrar planes en la Piedra

**Acción**: Añadir nueva configuración con asistencia inteligente

Cargar: `@prompts/palantir/sections/05-susurrar-planes.md`

---

### Página 1 · Opción 3: Compartir visiones entre Palantíri

**Acción**: Importar, exportar o eliminar configuraciones

Cargar: `@prompts/palantir/sections/06-compartir-visiones.md`

---

### Página 1 · Opción 4: ➕ Ver más...

**Acción**: Mostrar la página 2 del menú con herramientas específicas

Ejecutar el `AskUserQuestion` de "Página 2" definido arriba y continuar
el routing con las opciones de la página 2.

---

### Página 2 · Opción 1: Gestionar Status Line

**Acción**: Autoasistir (si no está configurada) o ver/editar/eliminar
la Status Line actual

Cargar: `@prompts/palantir/sections/07-status-line.md`

---

### Página 2 · Opción 2: 🔙 Volver a página 1

**Acción**: Volver a mostrar el menú de la página 1 (reejecutar el
`AskUserQuestion` de "Página 1").

---

### Página 2 · Opción 3: Cubrir el Palantír de ojos ajenos

**Acción**: Salir de Palantír y volver al menú principal de TLOTP

Cargar: `@prompts/tlotp-main.md`

---

## ⚠️ Reglas Importantes

1. **NO ejecutar múltiples modos**: Solo uno a la vez
2. **NO saltarse el menú**: Siempre preguntar primero
3. **NO asumir el modo**: Dejar que el usuario elija
4. **Empezar siempre por página 1**: nunca saltar directamente a página 2
5. **Respetar el patrón 3+1**: no añadir opciones extra a ninguna página

---

*Menú principal - Punto de entrada de Palantír v2.1 (paginado)*
