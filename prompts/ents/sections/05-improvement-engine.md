# 💡 Improvement Engine - Motor de Mejoras

## Misión

Analizar el CI/CD actual del proyecto y sugerir mejoras concretas basándose
en la **documentación oficial de GitHub Actions**, consultada en tiempo real.

---

## Paso 1: Consultar Documentación Oficial

**IMPORTANTE**: Antes de sugerir mejoras, consultar fuentes oficiales relevantes al proyecto.

### Protocolo de Consulta

Usar **WebFetch** para consultar las URLs oficiales según lo que se necesite:

| Área de mejora | URL a consultar |
|---|---|
| Buenas prácticas generales | `https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions` |
| Caching | `https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/caching-dependencies-to-speed-up-workflows` |
| Matrix strategy | `https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/running-variations-of-jobs-in-a-workflow` |
| Reusable workflows | `https://docs.github.com/en/actions/sharing-automations/reusing-workflows` |
| Secrets | `https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions` |
| Environments | `https://docs.github.com/en/actions/managing-workflow-runs-and-deployments/managing-deployments/managing-environments-for-deployment` |
| Concurrency | `https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/control-the-concurrency-of-workflows-and-jobs` |
| Permissions | `https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions#using-least-privilege-for-workflow-permissions` |
| Branch protection | `https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches` |

**NO consultar todas las URLs**: Solo las relevantes según las carencias detectadas por el Analyzer.

### Regla de Fallback

Si WebFetch falla o no está disponible:
1. Informar al usuario que no se pudo consultar la documentación oficial
2. Ofrecer sugerencias basadas en el conocimiento general pero marcándolas claramente
3. Proporcionar los enlaces para que el usuario consulte manualmente

Si WebFetch devuelve 404 en una URL:
1. Intentar variantes del path (añadir o quitar segmentos intermedios como `/security-guides/`, `/writing-workflows/`, etc.)
2. Si sigue fallando, intentar la URL raíz de la sección (ej: `https://docs.github.com/en/actions`)
3. Si ninguna variante funciona, marcar la sugerencia con ⚠️ y proporcionar la URL para consulta manual

---

## Paso 2: Análisis de Carencias

Comparar lo detectado por el Analyzer con las mejores prácticas oficiales.

### Checklist de Evaluación

Para cada área, evaluar con: ✅ Implementado | ⚠️ Parcial | ❌ Ausente | ➖ No aplica

```
───────────────────────────────────────────────────────────────
💡 Evaluación de Mejores Prácticas
───────────────────────────────────────────────────────────────

SEGURIDAD
  [✅/⚠️/❌] Permissions mínimos (least privilege)
  [✅/⚠️/❌] Secrets en lugar de valores hardcoded
  [✅/⚠️/❌] Pin de acciones por SHA (actions/checkout@SHA)
  [✅/⚠️/❌] CODEOWNERS configurado
  [✅/⚠️/❌] Dependabot o Renovate para updates de acciones

RENDIMIENTO
  [✅/⚠️/❌] Caching de dependencias
  [✅/⚠️/❌] Jobs paralelos donde sea posible
  [✅/⚠️/❌] Concurrency groups (cancelar runs obsoletos)
  [✅/⚠️/❌] Timeouts configurados
  [✅/⚠️/❌] Filtros de paths (no ejecutar en cambios irrelevantes)

CALIDAD
  [✅/⚠️/❌] Linting automatizado
  [✅/⚠️/❌] Tests automatizados
  [✅/⚠️/❌] Type checking (si aplica)
  [✅/⚠️/❌] Build verification
  [✅/⚠️/❌] Coverage reports

MANTENIBILIDAD
  [✅/⚠️/❌] Workflows reutilizables (si hay duplicación)
  [✅/⚠️/❌] Composite actions (si hay steps repetidos)
  [✅/⚠️/❌] Nombres descriptivos en jobs y steps
  [✅/⚠️/❌] Matrix strategy (si soporta múltiples versiones)

PROTECCIÓN DE RAMAS
  [✅/⚠️/❌] Branch protection rules en main/master
  [✅/⚠️/❌] Required status checks
  [✅/⚠️/❌] Required reviews
  [✅/⚠️/❌] PR template

VERSIONADO Y RELEASES
  [✅/⚠️/❌] Auto-versioning (semantic release, changesets, etc.)
  [✅/⚠️/❌] Conventional commits enforcement
  [✅/⚠️/❌] Changelog automático
  [✅/⚠️/❌] Release automation
```

---

## Paso 3: Generar Lista de Mejoras

**Formato de salida**:

```
═══════════════════════════════════════════════════════════════
💡 Mejoras Sugeridas (basadas en documentación oficial)
═══════════════════════════════════════════════════════════════

🔴 PRIORIDAD ALTA (Seguridad / Correctitud)
──────────────────────────────────────────────

  1. [Título de la mejora]
     Problema: [Qué se detectó]
     Solución: [Qué se recomienda]
     Referencia: [URL oficial consultada]

🟡 PRIORIDAD MEDIA (Rendimiento / Calidad)
──────────────────────────────────────────────

  2. [Título de la mejora]
     ...

🟢 PRIORIDAD BAJA (Nice to have)
──────────────────────────────────────────────

  3. [Título de la mejora]
     ...

───────────────────────────────────────────────────────────────
📊 Resumen: N mejoras detectadas
   🔴 N alta | 🟡 N media | 🟢 N baja
───────────────────────────────────────────────────────────────
```

---

## Paso 4: Ofrecer Acción

Después de mostrar las mejoras, preguntar al usuario con **AskUserQuestion**:

```json
{
  "questions": [
    {
      "header": "Acción",
      "question": "¿Qué deseas hacer con las mejoras sugeridas?",
      "multiSelect": false,
      "options": [
        {
          "label": "Aplicar mejoras seleccionadas",
          "description": "Elegir qué mejoras aplicar y ejecutarlas con asistencia guiada"
        },
        {
          "label": "Ver detalle de una mejora",
          "description": "Profundizar en una mejora específica con más contexto y código ejemplo"
        },
        {
          "label": "Volver al menú de Ents",
          "description": "Regresar al menú principal de los Ents"
        }
      ]
    }
  ]
}
```

### Routing

- **Aplicar mejoras** → Preguntar cuáles, luego ejecutar `06-modifier.md`
- **Ver detalle** → Consultar WebFetch para más contexto, mostrar código ejemplo, volver a preguntar
- **Volver** → Regresar al menú de Ents (`02-menu-principal.md`)

---

## Reglas del Improvement Engine

1. **Siempre citar fuentes**: Cada mejora debe tener su URL oficial
2. **No inventar prácticas**: Si no puedes consultar la doc, decirlo
3. **Priorizar por impacto**: Seguridad primero, luego rendimiento, luego nice-to-have
4. **Contextualizar**: Las mejoras deben ser relevantes al tipo de proyecto
5. **No duplicar**: Si algo ya está bien configurado, reconocerlo

---

*Módulo 05 - Improvement Engine v1.0*
