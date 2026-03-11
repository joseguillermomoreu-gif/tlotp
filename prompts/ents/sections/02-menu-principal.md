# 🎯 Menú Principal - Ents

## Misión

Mostrar menú interactivo con las tres operaciones principales de los Ents.

**NOTA**: En todos los banners, reemplaza `{VERSION}` con la versión TLOTP cargada desde `@prompts/VERSION.md`.

---

## 📋 Permisos de Ents

**CRÍTICO**: Antes del menú, solicitar aprobación de permisos con `AskUserQuestion`:

```
🌳 Permisos necesarios para los Ents

  🖥️  Bash     — Ejecutar comandos del sistema
                  (ls, cat, git para leer/detectar workflows)

  📖  Read     — Leer workflows y configuración del proyecto
                  (.github/workflows/, package.json, composer.json...)

  📝  Write    — Crear nuevos workflows de GitHub Actions
                  (.github/workflows/)  ← Solo opciones 2 y 3

  ✏️  Edit     — Modificar workflows existentes
                  (.github/workflows/)  ← Solo opciones 2 y 3

  🌐  WebFetch — Consultar documentación oficial en tiempo real
                  • docs.github.com (GitHub Actions docs)
```

**Opciones** (AskUserQuestion):
1. **✅ Aprobar todos** (Recomendado) — Los Ents trabajarán sin interrupciones
2. **🔍 Revisar uno a uno** — Se pedirá permiso individual para cada acción
3. **🚫 Cancelar** — Salir de Ents

- **Aprobar todos**: Registrar permisos pre-aprobados. Continuar al menú.
- **Revisar uno a uno**: Continuar al menú. Se pedirá confirmación en cada acción.
- **Cancelar**: Mostrar despedida y terminar.

---

## Menú de Selección

**IMPORTANTE**: **DEBES usar la herramienta `AskUserQuestion`** (NO texto plano).

Ejecuta **AskUserQuestion** con esta configuración EXACTA:

```json
{
  "questions": [
    {
      "header": "Ents CI/CD",
      "question": "¿Qué deseas hacer con los Ents?",
      "multiSelect": false,
      "options": [
        {
          "label": "Analizar CI/CD actual",
          "description": "Escanear el proyecto, generar diagrama del pipeline actual y sugerir mejoras basadas en documentación oficial"
        },
        {
          "label": "Modificar CI/CD existente",
          "description": "Aplicar mejoras o cambios al CI/CD actual con asistencia guiada y buenas prácticas"
        },
        {
          "label": "Crear CI/CD desde cero",
          "description": "Generar workflows de GitHub Actions paso a paso según las mejores prácticas oficiales"
        },
        {
          "label": "Salir",
          "description": "Volver al menú principal de TLOTP"
        }
      ]
    }
  ]
}
```

**NO mostrar menú de texto plano**. Usa la herramienta AskUserQuestion del CLI de Claude.

---

## 🔀 Routing según Elección

### Opción 1: Analizar CI/CD actual

**Acción**: Ejecutar flujo completo de análisis

Procede a ejecutar en orden:
1. **Escaneo** (`03-analyzer.md`) - Detectar todo el CI/CD del proyecto
2. **Diagrama** (`04-diagram-renderer.md`) - Mostrar esquema visual del pipeline
3. **Mejoras** (`05-improvement-engine.md`) - Consultar docs oficiales y sugerir mejoras
4. **Pregunta de acción** - Ofrecer al usuario:
   - Aplicar mejoras sugeridas → redirigir a `06-modifier.md`
   - Volver al menú de Ents
   - Salir

---

### Opción 2: Modificar CI/CD existente

**Acción**: Ejecutar sistema de modificación asistida

Procede a ejecutar:
1. **Escaneo rápido** (`03-analyzer.md`) - Detectar CI/CD actual (sin diagrama detallado)
2. **Modificación** (`06-modifier.md`) - Asistir al usuario en los cambios

---

### Opción 3: Crear CI/CD desde cero

**Acción**: Ejecutar sistema de creación guiada

Procede a ejecutar:
1. **Creación** (`07-creator.md`) - Generar GitHub Actions CI/CD paso a paso

---

### Opción 4: Salir

**Acción**: Volver al menú principal de TLOTP

Mostrar mensaje de despedida:
```
🌳 Los Ents seguirán vigilando las ramas del bosque...
```

---

## Reglas de Ejecución

1. **SIEMPRE mostrar banner** antes del menú (solo la primera vez)
2. **Usar AskUserQuestion** para navegación
3. **Loop continuo** hasta que el usuario elija Salir
4. **NO ejecutar múltiples modos** a la vez
5. **NO asumir la opción**: Dejar que el usuario elija

---

*Módulo 02 - Menú Principal de Ents v1.0*
