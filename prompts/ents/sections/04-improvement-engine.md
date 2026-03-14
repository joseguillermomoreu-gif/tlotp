# 💡 Improvement Engine — Motor de Mejoras

## Misión

Analizar el CI/CD actual, calcular una puntuación 0-100, sugerir mejoras priorizadas
y guiar al usuario en su aplicación una a una — con la voz de Bárbol en cada paso.

---

## PASO 1: Consultar Documentación Oficial

**IMPORTANTE**: Comprobar primero si la documentación oficial ya está cargada en el
contexto de esta sesión (por haber ejecutado previamente otro módulo que haya hecho WebFetch).

**Si ya está en contexto**: usar directamente esa información sin re-fetchear.

**Si no está en contexto**, consultar en este orden:

**Primarias — Claude Code** (cargar primero):

> **WebFetch 1**: `https://code.claude.com/docs/en/github-actions`
> **Extraer**: Integración Claude Code + GitHub Actions, mejores prácticas recomendadas

> **WebFetch 2**: `https://code.claude.com/docs/en/code-review`
> **Extraer**: Code review automatizado, qué verificar en pipelines

> **WebFetch 3**: `https://code.claude.com/docs/en/gitlab-ci-cd`
> **Extraer**: Patrones CI/CD aplicables (aunque el proyecto use GitHub Actions)

**Secundarias — GitHub Actions** (solo si se necesita información específica):

| Área | URL |
|---|---|
| Seguridad | `https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions` |
| Caching | `https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/caching-dependencies-to-speed-up-workflows` |
| Concurrencia | `https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/control-the-concurrency-of-workflows-and-jobs` |
| Matrix | `https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/running-variations-of-jobs-in-a-workflow` |
| Reusable workflows | `https://docs.github.com/en/actions/sharing-automations/reusing-workflows` |
| Branch protection | `https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches` |

### Regla de Fallback

Si WebFetch falla: informar al usuario, ofrecer sugerencias basadas en conocimiento general
marcándolas con ⚠️ y proporcionar los enlaces para consulta manual.

---

## PASO 2: Consultar protección de ramas (GitHub API)

**La preferencia del usuario ya fue recogida al inicio** (variable de contexto `gh_disponible`).

**Si `gh_disponible = true`**, ejecutar para cada rama principal detectada (main, master, develop):

```bash
gh api repos/{owner}/{repo}/branches/{branch}/protection 2>/dev/null || echo "NO_PROTECTION"
```

Extraer y registrar:
- `required_pull_request_reviews` → ¿exige PR?
- `required_status_checks` → ¿qué checks son obligatorios?
- `enforce_admins.enabled` → ¿aplica también a admins?
- Si el comando devuelve `NO_PROTECTION` → rama sin protección

Para obtener `{owner}/{repo}`:
```bash
git remote get-url origin
```

**Si `gh_disponible = false`**: marcar todos los ítems de "Protección de Ramas" como ❓ y excluirlos del scoring.

---

## PASO 3: Análisis y Scoring 0-100

Comparar lo detectado por el Analyzer con las mejores prácticas oficiales.

### Regla de Scoring para ➖ (No aplica)

**Los ítems marcados como ➖ se excluyen del denominador.**
Los puntos de esa categoría se redistribuyen proporcionalmente entre los ítems aplicables.

> Ejemplo: CALIDAD tiene 5 ítems (25 pts). Si 3 son ➖ y los 2 aplicables son ✅,
> la puntuación es 25/25 — los N/A no penalizan.

Fórmula por categoría:
```
puntuación_categoría = (puntos_ganados / puntos_aplicables) × puntos_máximos_categoría
```

Los ítems ❓ (no verificables sin API) también se excluyen del scoring si el usuario rechazó la consulta.

### Checklist de Evaluación

Para cada área: ✅ Implementado | ⚠️ Parcial | ❌ Ausente | ➖ No aplica | ❓ No verificado

```
───────────────────────────────────────────────────────────────
🌳 La Asamblea evalúa el bosque...
───────────────────────────────────────────────────────────────

SEGURIDAD (25 puntos)
  [✅/⚠️/❌/➖] Permissions mínimos (least privilege)
  [✅/⚠️/❌/➖] Secrets en lugar de valores hardcoded
  [✅/⚠️/❌/➖] Pin de acciones por versión (actions/checkout@v4)
  [✅/⚠️/❌/➖] CODEOWNERS configurado
  [✅/⚠️/❌/➖] Dependabot o Renovate para updates de acciones

RENDIMIENTO (20 puntos)
  [✅/⚠️/❌/➖] Caching de dependencias        ← ➖ si el proyecto no tiene dependencias
  [✅/⚠️/❌/➖] Jobs paralelos donde sea posible
  [✅/⚠️/❌/➖] Concurrency groups (cancelar runs obsoletos)
  [✅/⚠️/❌/➖] Timeouts configurados

CALIDAD (25 puntos)
  [✅/⚠️/❌/➖] Linting automatizado
  [✅/⚠️/❌/➖] Tests automatizados
  [✅/⚠️/❌/➖] Type checking   ← ➖ si el stack no lo requiere (ej: markdown puro)
  [✅/⚠️/❌/➖] Build verification   ← ➖ si no hay proceso de build
  [✅/⚠️/❌/➖] Coverage reports   ← ➖ si no hay suite de tests medible

MANTENIBILIDAD (15 puntos)
  [✅/⚠️/❌/➖] Workflows reutilizables   ← ➖ si no hay duplicación real
  [✅/⚠️/❌/➖] Nombres descriptivos en jobs y steps
  [✅/⚠️/❌/➖] Filtros de paths (no ejecutar en cambios irrelevantes)

PROTECCIÓN DE RAMAS (15 puntos)
  [✅/⚠️/❌/❓] Branch protection en main/master   ← via gh api o ❓
  [✅/⚠️/❌/❓] Required status checks             ← via gh api o ❓
  [✅/⚠️/❌/❓] Enforce admins activado            ← via gh api o ❓
  [✅/⚠️/❌/➖] PR template configurado            ← detectable en archivos
```

### Mostrar Scoring

```
📊 PUNTUACIÓN DEL BOSQUE: [X]/100

  🌳 Fortalezas: [lista breve de lo que está bien]
  🍂 Áreas de mejora: [lista breve de carencias]
  ℹ️  N/A excluidos del cálculo: [lista de ítems no aplicables]
```

---

## PASO 4: Generar Lista de Mejoras

**Formato de salida**:

```
🌳 LA ASAMBLEA HA DELIBERADO — [X] mejoras detectadas
══════════════════════════════════════════════════════

🔴 ALTA PRIORIDAD ([X])
  1. [descripción del problema — Seguridad / Correctitud]

🟡 PRIORIDAD MEDIA ([X])
  2. [descripción del problema — Rendimiento / Calidad]

🟢 BAJA PRIORIDAD ([X])
  3. [descripción del problema — Nice to have]

══════════════════════════════════════════════════════
```

Si no hay mejoras:

```
✅ EL BOSQUE ESTÁ EN ORDEN
   Bárbol asiente lentamente. Puntuación: [X]/100
   "Bien cuidado... bien cuidado. Así deben estar las ramas."
```

---

## PASO 5: Menú post-análisis

Tras mostrar el scoring y las mejoras priorizadas, **usar AskUserQuestion**:

```json
{
  "questions": [{
    "header": "La Asamblea ha deliberado",
    "question": "¿Qué hacemos con lo encontrado?",
    "multiSelect": false,
    "options": [
      {
        "label": "⚒️ Aplicar mejoras",
        "description": "Revisaremos cada mejora una a una — confirmarás antes de aplicar cualquier cambio"
      },
      {
        "label": "🔙 Volver al menú de los Ents",
        "description": "Volver sin aplicar cambios"
      },
      {
        "label": "🚪 Retirarse al Fangorn",
        "description": "Salir de los Ents y TLOTP"
      }
    ]
  }]
}
```

---

## PASO 6: Revisor uno a uno (si elige "Aplicar mejoras")

Iterar por cada mejora **en orden de prioridad** (🔴 primero, luego 🟡, luego 🟢).

**Mostrar para cada mejora** (contador visible):

```
🌳 Bárbol examina la mejora #[X]...

⚒️ MEJORA [X/N] — [🔴/🟡/🟢] [PRIORIDAD]
══════════════════════════════════════════════════════

📍 Archivo afectado: [ruta completa]

❌ Problema:
   [descripción clara del problema detectado]

✅ Solución propuesta:
   [descripción exacta de qué se aplicaría, con código si aplica]

🎯 Resultado esperado:
   [qué mejorará o se corregirá tras aplicar]

📚 Referencia: [URL oficial consultada]

══════════════════════════════════════════════════════
```

**AskUserQuestion por cada mejora**:

```json
{
  "questions": [{
    "header": "Mejora [X/N]",
    "question": "¿Qué hacemos con esta rama del bosque?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aplicar",
        "description": "Los Ents aplicarán esta mejora ahora"
      },
      {
        "label": "✏️ Modificar propuesta",
        "description": "Ajustar la solución antes de aplicar"
      },
      {
        "label": "🔎 Buscar alternativa en docs",
        "description": "Razonar sobre la documentación ya cargada para proponer otra solución"
      },
      {
        "label": "⏭️ Saltar",
        "description": "Dejar esta mejora sin cambios y pasar a la siguiente"
      }
    ]
  }]
}
```

**Comportamiento por opción**:

- **Aplicar**: Ejecutar el cambio usando Edit/Write, confirmar éxito y mostrar frase de Bárbol, variada según la mejora:
  - *"Hmm. Una rama más sana. El bosque lo agradece."*
  - *"Bien... bien. Eso es lo que hacen los Ents — proteger."*
  - *"Ahora las raíces están más fuertes. Se nota."*
  - *"No era urgente... pero los árboles viejos no dejamos nada a medias."*
  - *"El bosque recuerda esta mejora. Siempre lo hace."*
  - *(Variar la frase — breve, pausada, con el tono inconfundible de Bárbol)*
  - Luego pasar a la siguiente.
- **Modificar propuesta**: Preguntar qué cambiar. Mostrar propuesta actualizada y confirmar antes de aplicar.
- **Buscar alternativa en docs**: **NO re-fetchear** — releer y razonar explícitamente sobre la documentación ya cargada en contexto. Proponer solución alternativa al mismo problema y volver a preguntar.
- **Saltar**: Mostrar `🌳 "Esta rama puede esperar..." — Bárbol` y pasar a la siguiente mejora.

**IMPORTANTE**: Antes de aplicar cualquier cambio, indicar siempre:
- La ruta exacta del archivo que se modificará
- Si el cambio crea un archivo nuevo o modifica uno existente

---

## PASO 7: Resumen final

Al terminar el revisor, mostrar:

```
📋 RESUMEN DE LA ASAMBLEA
══════════════════════════════════════════════════════
  ✅ Aplicadas:   [X]
  ✏️  Modificadas: [X]
  ⏭️  Saltadas:    [X]
══════════════════════════════════════════════════════

🌳 "El bosque ha cambiado hoy. Para bien."
                              — Bárbol
```

**AskUserQuestion**:

```json
{
  "questions": [{
    "header": "La Asamblea concluye",
    "question": "¿Qué deseas hacer ahora?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔙 Volver al menú de los Ents",
        "description": "Continuar con otras opciones"
      },
      {
        "label": "🏠 Volver al menú de TLOTP",
        "description": "Volver al menú principal"
      },
      {
        "label": "🚪 Retirarse al Fangorn",
        "description": "Salir de los Ents y TLOTP"
      }
    ]
  }]
}
```

---

## Reglas del Improvement Engine

1. **Siempre citar fuentes**: Cada mejora debe tener su URL oficial
2. **No inventar prácticas**: Si no puedes consultar la doc, decirlo con ⚠️
3. **Priorizar por impacto**: Seguridad primero, luego rendimiento, luego nice-to-have
4. **Contextualizar**: Las mejoras deben ser relevantes al tipo de proyecto
5. **No duplicar**: Si algo ya está bien configurado, reconocerlo en el scoring
6. **WebFetch inteligente**: Nunca re-fetchear lo que ya está en contexto

---

*Módulo 04 — Improvement Engine*
