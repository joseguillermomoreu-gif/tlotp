# 📜 Módulo G9 — Los Pergaminos del Mago

## Misión

Documentación oficial on-demand sobre SDD, Plan Mode, Kiro y EARS.
Todo vía WebFetch — nunca hardcodeado. Solo cuando el usuario lo pide.

---

## Paso 0 — Documentación oficial (on-the-fly)

**IMPORTANTE**: Comprobar primero si la documentación ya está en contexto.

**Si ya está en contexto**: usar directamente sin re-fetchear.

**Si no está en contexto**, hacer WebFetch según lo que el usuario pida:

> **WebFetch 1** (si pide Plan Mode): `https://code.claude.com/docs/en/plan-mode`
> **Extraer**: qué es Plan Mode, cómo usarlo con ficheros de spec/SDD,
> cómo activarlo, flujo recomendado, ejemplos de uso con requirements/tasks.

> **WebFetch 2** (si pide Kiro): `https://docs.kiro.dev`
> **Extraer**: estructura del directorio spec/, steering files, formato tasks.md de Kiro,
> diferencias con el formato TLOTP, cómo integrar Kiro con Claude Code.

**Fallback si WebFetch falla**:

```
⚠️  No se pudo cargar la documentación oficial.
   Los Pergaminos del Mago requieren conexión a las fuentes.

   Puedes consultarlas directamente:
     🔮 Plan Mode: https://code.claude.com/docs/en/plan-mode
     ⚗️  Kiro:     https://docs.kiro.dev
```

---

## Menú del módulo

```json
{
  "questions": [{
    "header": "Los Pergaminos del Mago",
    "question": "📜 ¿Qué pergamino consultas, viajero?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔮 Claude Code Plan Mode — SDD + Plan Mode",
        "description": "Cómo usar requirements/tasks con el modo plan de Claude Code"
      },
      {
        "label": "⚗️  Amazon Kiro — spec/ format y steering files",
        "description": "Estándar emergente de spec-driven development"
      },
      {
        "label": "📖 Qué es EARS y cuándo usarlo",
        "description": "Easy Approach to Requirements Syntax — los 5 patrones"
      },
      {
        "label": "🔙 Volver al menú de Gandalf",
        "description": ""
      }
    ]
  }]
}
```

---

## Opción A — Claude Code Plan Mode

Hacer WebFetch 1 (si no está en contexto) y mostrar:

```
══════════════════════════════════════════════════════════════
🔮 PLAN MODE — Claude Code
══════════════════════════════════════════════════════════════

[Insertar aquí el contenido extraído del WebFetch sobre Plan Mode]

══════════════════════════════════════════════════════════════
💡 Cómo combinar Plan Mode con tu SDD de Gandalf:

  1. Genera requirements.md y tasks.md con Gandalf
  2. Activa Plan Mode: /plan o Shift+Tab
  3. Carga el contexto: "@docs/requirements.md @docs/tasks.md"
  4. Claude Code planificará basándose en tu SDD
  5. Revisa el plan → aprueba → implementa

══════════════════════════════════════════════════════════════
```

---

## Opción B — Amazon Kiro

Hacer WebFetch 2 (si no está en contexto) y mostrar:

```
══════════════════════════════════════════════════════════════
⚗️  AMAZON KIRO — Spec-Driven Development
══════════════════════════════════════════════════════════════

[Insertar aquí el contenido extraído del WebFetch sobre Kiro]

══════════════════════════════════════════════════════════════
💡 Kiro vs Gandalf/TLOTP:

  Kiro usa el directorio .kiro/specs/ con:
    - requirements.md (similar al de Gandalf)
    - design.md (similar al de Gandalf)
    - tasks.md (formato ligeramente diferente)
    + steering files (.kiro/steering/*.md)

  El SDD generado por Gandalf es compatible con Kiro.
  Puedes mover los ficheros a .kiro/specs/ si usas Kiro.

══════════════════════════════════════════════════════════════
```

---

## Opción C — EARS

**EARS no requiere WebFetch** — es un estándar público. Mostrar con conocimiento interno:

```
══════════════════════════════════════════════════════════════
📖 EARS — Easy Approach to Requirements Syntax
══════════════════════════════════════════════════════════════

EARS define 5 patrones para escribir requisitos precisos:

1️⃣  UBIQUITOUS (siempre aplica):
    THE SYSTEM SHALL [acción]
    → "THE SYSTEM SHALL registrar todos los errores en el log"

2️⃣  EVENT-DRIVEN (disparado por evento):
    WHEN [disparador] THE SYSTEM SHALL [acción]
    → "WHEN el usuario envía el formulario THE SYSTEM SHALL
       validar los datos y mostrar errores inline"

3️⃣  UNWANTED (condición no deseada):
    IF [condición no deseada] THEN THE SYSTEM SHALL [acción]
    → "IF la conexión a la BD falla THEN THE SYSTEM SHALL
       devolver 503 con mensaje de retry"

4️⃣  OPTION (feature opcional):
    WHERE [feature activa] THE SYSTEM SHALL [acción]
    → "WHERE el módulo de notificaciones está habilitado
       THE SYSTEM SHALL enviar email de confirmación"

5️⃣  COMPLEX (estado + evento):
    WHILE [estado] WHEN [disparador] THE SYSTEM SHALL [acción]
    → "WHILE el usuario está autenticado WHEN accede a /admin
       THE SYSTEM SHALL verificar el rol ADMIN"

══════════════════════════════════════════════════════════════
💡 Cuándo usar EARS:
   - Siempre que escribas requisitos en un SDD
   - Evita ambigüedades como "el sistema gestionará X"
   - Facilita los acceptance criteria de G7

══════════════════════════════════════════════════════════════
```

---

## AskUserQuestion tras cada sección

- 📖 Consultar otra sección
- ✨ Volver a iniciar una aventura SDD
- 🔙 Volver al menú de Gandalf

---

**Módulo**: `09-module-docs.md`
**Invocado desde**: `gandalf-main.md`
**Requiere**: WebFetch (condicional, solo Plan Mode y Kiro)
