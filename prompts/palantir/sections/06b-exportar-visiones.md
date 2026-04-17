# 📤 Exportar Visiones y Eliminar Características

> **IMPORTADO POR**: `palantir-main.md`
>
> Opción 2 (exportar configuraciones) y Opción 3 (eliminar característica)
> del módulo Compartir Visiones.

---

## OPCIÓN 2: Exportar visiones

### PASO 1: Seleccionar scope

**Usar AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Exportar",
    "question": "¿Qué configuraciones deseas exportar?",
    "multiSelect": false,
    "options": [
      {
        "label": "🏠 Solo local (.claude/)",
        "description": "Exportar únicamente la configuración del proyecto actual"
      },
      {
        "label": "🌍 Solo global (~/.claude/)",
        "description": "Exportar únicamente la configuración global del usuario"
      },
      {
        "label": "🌐 Local y global",
        "description": "Exportar toda la configuración disponible"
      }
    ]
  }]
}
```

---

### PASO 2: Leer configuración del scope elegido

Leer silenciosamente todos los ficheros relevantes según el scope:

- `CLAUDE.md` (global y/o proyecto según scope)
- `settings.json` (global y/o proyecto)
- `rules/*.md` (global y/o proyecto)
- Hooks definidos en settings.json
- `MEMORY.md` (solo 200 primeras líneas)

---

### PASO 3: Pedir path de destino

Mostrar:

```
📤 Exportación lista.

¿Dónde deseas guardar el fichero exportado?
Ejemplo: ~/tlotp-backup-2026-03-12.md

Path de destino:
```

Obtener input libre del usuario.

---

### PASO 4: Generar fichero exportado

Crear el fichero `.md` con la siguiente estructura:

```markdown
# 📤 Exportación de Configuración Claude Code
# Generado por Palantír — TLOTP
# Fecha: [fecha actual]
# Scope: [Local / Global / Local y Global]

---

## 📄 CLAUDE.md — [scope]
# Fichero: [ruta completa]

[contenido completo]

---

## ⚙️ settings.json — [scope]
# Fichero: [ruta completa]

[contenido completo]

---

## 📁 rules/ — [scope]
# Directorio: [ruta completa]

### [nombre-regla.md]
# Fichero: [ruta completa]
[contenido completo]

---

## 🪝 Hooks — [scope]
# Definidos en: [ruta settings.json]

[sección hooks extraída del settings.json]

---

## 🧠 MEMORY.md
# Fichero: [ruta completa]
# Nota: Solo se exportan las primeras 200 líneas (límite de carga de Claude Code)

[primeras 200 líneas]
```

Crear el fichero en la ruta indicada y confirmar con frase épica:
*"Las visiones han sido grabadas en piedra. El Palantír las guardará para la eternidad."*

Volver automáticamente al **menú principal de Compartir visiones**.

---

## OPCIÓN 3: Eliminar característica

### PASO 1: Seleccionar scope

**Usar AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Eliminar",
    "question": "¿Qué configuraciones deseas inspeccionar para eliminar?",
    "multiSelect": false,
    "options": [
      {
        "label": "🏠 Local (.claude/)",
        "description": "Ver solo configuraciones del proyecto actual"
      },
      {
        "label": "🌍 Global (~/.claude/)",
        "description": "Ver solo configuraciones globales del usuario"
      },
      {
        "label": "🌐 Mostrar todas",
        "description": "Ver todas las configuraciones disponibles (local y global)"
      }
    ]
  }]
}
```

---

### PASO 2: Construir lista numerada de características

Leer todos los ficheros del scope elegido y extraer cada característica individualmente (no por fichero). Mostrar en formato listado:

```
🗑️ CARACTERÍSTICAS DISPONIBLES
══════════════════════════════════════════════════════

   #   TIPO              FICHERO                      DESCRIPCIÓN
  ───────────────────────────────────────────────────────────────────
   1.  Instrucción       CLAUDE.md [global]           "No usar sudo directamente"
   2.  Instrucción       CLAUDE.md [global]           "Conventional Commits: type(scope)"
   3.  Rule (paths:*.ts) rules/typescript.md [global] "Strict typing en TypeScript"
   4.  Permiso           settings.json [global]       allowedTools: Bash
   5.  Hook              settings.json [global]       PostToolUse → git-commit-check.sh
   6.  Instrucción       CLAUDE.md [proyecto]         "Stack: PHP/Symfony hexagonal"
   ...

══════════════════════════════════════════════════════

Indica el número de la característica que deseas eliminar:
```

Obtener número del usuario.

---

### PASO 3: Cargar documentación oficial (condicional)

Si no está en contexto de esta sesión, obtener los 6 WebFetch en el mismo orden que en el módulo de Importar (PASO 2 de Importar).

---

### PASO 4: Análisis de eliminación

Con la característica seleccionada y la documentación oficial:

1. **¿Es seguro eliminarla?** — ¿Qué impacto tendría en el comportamiento de Claude?
2. **¿Está duplicada?** — ¿Existe otra regla/config que cubra lo mismo?
3. **¿Hay dependencias?** — ¿Algún otro ítem de la config depende de este?
4. **¿Alternativa posible?** — ¿Podría modificarse en lugar de eliminarse para mejor resultado?

Mostrar:

```
🔍 ANÁLISIS DE ELIMINACIÓN
══════════════════════════════════════════════════════

📍 Característica: [descripción]
📁 Fichero:        [ruta completa]

⚠️  Impacto de eliminar:
   [qué cambiaría en el comportamiento de Claude Code]

💡 Recomendación:
   [✅ Seguro eliminar / ⚠️ Eliminar con precaución / ❌ No recomendado]
   [justificación según docs oficiales]

══════════════════════════════════════════════════════
```

---

### PASO 5: Menú de decisión

**Usar AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Eliminar característica",
    "question": "¿Qué hacemos con esta característica?",
    "multiSelect": false,
    "options": [
      {
        "label": "🗑️ Eliminar",
        "description": "Borrar definitivamente esta característica"
      },
      {
        "label": "✏️ Proponer alternativa",
        "description": "Claude sugerirá una modificación en lugar de eliminar"
      },
      {
        "label": "🚫 Cancelar",
        "description": "No tocar nada y volver al menú"
      }
    ]
  }]
}
```

**Si elige Eliminar**: aplicar, confirmar con frase épica breve, volver al menú de Compartir visiones

**Si elige Proponer alternativa**:
- Mostrar propuesta de modificación en lugar de eliminación
- AskUserQuestion: `✅ Aplicar alternativa` / `🗑️ Eliminar igualmente` / `🚫 Cancelar`
- Aplicar según elección

**Si elige Cancelar**: `🔮 Palantír retuvo esta visión.` — volver al menú de Compartir visiones

---

## OPCIÓN 4: Volver al menú de Palantír

Volver a `@prompts/palantir/sections/00-menu-principal.md` (PASO 2).

---

*Exportar Visiones y Eliminar — Palantír Módulo 06b v1.0*
