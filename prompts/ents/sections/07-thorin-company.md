# 🪓 Thorin y su Compañía — Agent Team CI/CD

**Módulo**: `07-thorin-company.md`
**Invocado desde**: `00-menu-principal.md` (opción "⚔️ Thorin y su Compañía")
**Misión**: Detectar, crear y convocar un Agent Team especializado en CI/CD para analizar e implementar mejoras en los workflows del proyecto.

---

## Bloque épico de bienvenida (mostrar al entrar)

```
🪓 "Thorin hijo de Thráin ha oído el llamado de los Ents.
   Los Enanos de Erebor, maestros del fuego y el metal,
   traen su sabiduría de forja a los pipelines del reino.

   Pero quien organice esta compañía será Aragorn,
   Rey de Gondor. Él forjará el ejército que conquiste
   los workflows de GitHub Actions."

                              — Bárbol, convocando a Thorin
```

---

## Fase 1 — Detección de teams CI/CD existentes

### Paso F1.1 — Escanear teams en ambos scopes

```bash
echo "=== GLOBAL (~/.claude/teams/) ==="
ls ~/.claude/teams/ 2>/dev/null || echo "(vacío)"
echo "=== PROYECTO (.claude/teams/) ==="
ls .claude/teams/ 2>/dev/null || echo "(vacío)"
```

Para cada fichero encontrado, leer su contenido con Read y extraer:
- Nombre del team
- Descripción (si existe)
- Agentes miembros

### Paso F1.2 — Heurística CI/CD

Un team se considera "CI/CD" si su nombre o descripción contiene alguno de estos términos (case-insensitive):
`cicd`, `ci-cd`, `ci_cd`, `deploy`, `pipeline`, `devops`, `github-actions`, `workflow`, `thorin`

### Paso F1.3 — Resultado de la detección

**Caso A — Se detecta al menos un team CI/CD**: ir a Fase 2b.

**Caso B — Hay teams pero ninguno es CI/CD**: mostrar los teams existentes y preguntar con AskUserQuestion:

```json
{
  "questions": [{
    "header": "La Compañía de Thorin",
    "question": "🪓 No se detectó un team CI/CD. ¿Alguno de estos ejércitos sirve para CI/CD?",
    "multiSelect": false,
    "options": [
      {
        "label": "⚔️ [nombre-team-1] — usarlo para CI/CD",
        "description": "[descripción del team]"
      },
      {
        "label": "🆕 Crear un nuevo team CI/CD",
        "description": "Aragorn forjará un equipo especializado desde cero"
      },
      {
        "label": "🔙 Volver al menú de Ents",
        "description": ""
      }
    ]
  }]
}
```

*(Generar opciones dinámicamente con los teams detectados)*

**Caso C — No hay ningún team**: ir directamente a Fase 2a.

---

## Fase 2a — Crear team CI/CD (no existe)

Mostrar:

```
══════════════════════════════════════════════════════════════
🪓 LA COMPAÑÍA AÚN NO HA SIDO FORMADA
══════════════════════════════════════════════════════════════

  "Los Enanos de Erebor están listos para marchar,
   pero su ejército aún no tiene forma.
   Aragorn, forja la compañía."

══════════════════════════════════════════════════════════════
```

Delegar a Aragorn para crear el team:

```
@prompts/aragorn/sections/03-module-team-builder.md
```

**Contexto para Aragorn**: Sugerir un team con perfil CI/CD:
- Nombre sugerido: `cicd-guard` o `deploy-guard`
- Descripción sugerida: "Agent Team especializado en CI/CD y GitHub Actions"
- Agentes candidatos (según los disponibles): `devops-engineer`, `deployment-engineer`, `security-auditor`

Tras que Aragorn complete la creación, retomar control aquí en la **Fase 3**.

---

## Fase 2b — Confirmar team existente

Mostrar el team detectado:

```
══════════════════════════════════════════════════════════════
🪓 COMPAÑÍA DETECTADA
══════════════════════════════════════════════════════════════

  ⚔️  [nombre-team]
  📝  [descripción si existe]
  🧑‍🤝‍🧑 Guerreros: [N]  ·  [lista de agentes]
  📍  [scope: global / proyecto]

══════════════════════════════════════════════════════════════
```

AskUserQuestion:

```json
{
  "questions": [{
    "header": "La Compañía de Thorin",
    "question": "🪓 ¿Qué hacemos con este ejército?",
    "multiSelect": false,
    "options": [
      {
        "label": "⚔️ Convocar este team para CI/CD",
        "description": "Proceder con [nombre-team] para analizar e implementar mejoras"
      },
      {
        "label": "🆕 Crear un team nuevo",
        "description": "Aragorn forjará un equipo especializado desde cero"
      },
      {
        "label": "🔙 Volver al menú de Ents",
        "description": ""
      }
    ]
  }]
}
```

- Si elige "Convocar": ir a Fase 3 con el team seleccionado.
- Si elige "Crear nuevo": ir a Fase 2a.
- Si elige volver: cargar `@prompts/ents/sections/00-menu-principal.md`.

---

## Fase 3 — Convocatoria

### Paso F3.1 — Detectar workflows del proyecto

```bash
ls .github/workflows/ 2>/dev/null || echo "(no hay workflows)"
```

### Paso F3.2 — Mostrar convocatoria épica

```
══════════════════════════════════════════════════════════════
⚔️  LA COMPAÑÍA DE THORIN ESTÁ LISTA
══════════════════════════════════════════════════════════════

  🪓 "[Frase épica de Thorin — elegir una, no repetir]"

  Guerreros convocados:
  [Para cada agente del team]:
    ⚔️  [nombre-agente] — "[rol breve]"

  🎯 Misión: Analizar e implementar mejoras en los workflows
             de CI/CD del proyecto.

  📁 Workflows detectados:
  [Lista de archivos en .github/workflows/ o "(ninguno detectado)"]

══════════════════════════════════════════════════════════════
```

**Frases épicas de Thorin** (rotar, no repetir):
- *"¡Erebor no cayó ante un dragón! Los pipelines rotos tampoco nos detendrán."*
- *"El oro de la Montaña Solitaria fue recuperado. Los workflows también lo serán."*
- *"¡A la carga, Compañía! El CI/CD nos necesita."*
- *"Dwalin, Balin, Fíli, Kíli — todos al frente. Los tests no se corren solos."*

### Paso F3.3 — Instrucciones de invocación

Mostrar cómo usar el team según el formato de Agent Teams de Claude Code:

```
══════════════════════════════════════════════════════════════
🪄 CÓMO CONVOCAR A LA COMPAÑÍA
══════════════════════════════════════════════════════════════

  En una nueva sesión de Claude Code, usa:

    @[nombre-team] Analiza los workflows en .github/workflows/
    y propón mejoras de seguridad, rendimiento y fiabilidad.

  O para una misión específica:

    @[nombre-team] Revisa [nombre-workflow.yml] y corrige
    los jobs que fallen en rama develop.

══════════════════════════════════════════════════════════════
```

### Paso F3.4 — Opciones finales

AskUserQuestion:

```json
{
  "questions": [{
    "header": "Compañía convocada",
    "question": "⚔️ ¿Qué quieres hacer ahora?",
    "multiSelect": false,
    "options": [
      {
        "label": "🌳 Volver al menú de los Ents",
        "description": "Continuar con las misiones habituales de Ents"
      },
      {
        "label": "🚪 Retirarse al Fangorn",
        "description": "Salir de los Ents y volver al menú de TLOTP"
      }
    ]
  }]
}
```

- Si elige volver al menú: cargar `@prompts/ents/sections/00-menu-principal.md` (desde PASO 2).
- Si elige Fangorn: cargar `@prompts/tlotp-main.md`.

---

## ⚠️ Reglas de Ejecución

1. **NO reimplementar** la lógica de creación de teams — delegar siempre a Aragorn.
2. **Siempre usar AskUserQuestion** para interacción con el usuario.
3. **Siempre detectar** workflows en `.github/workflows/` antes de la convocatoria.
4. **Retornar control** a Ents tras completar (no dejar al usuario colgado en Aragorn).

---

*Módulo 07 — Thorin y su Compañía*
*Diseñado para: tlotp-sdd-team · tarea #301*
*Aragorn Team Builder: `@prompts/aragorn/sections/03-module-team-builder.md`*
