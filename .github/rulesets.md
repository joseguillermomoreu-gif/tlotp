# GitHub Rulesets — TLOTP

Documentación de los Rulesets activos en el repositorio.
Migrado desde branch protection clásica en v3.16.2.

## protect-master (id: 13914962)

**Rama**: `master`
**Objetivo**: gate de producción — todas las releases pasan por aquí.

| Regla | Valor |
|---|---|
| Deletion | ✅ bloqueado |
| Non-fast-forward (force push) | ✅ bloqueado |
| Pull request requerida | ✅ sí |
| Code owner review | ✅ requerida |
| Dismiss stale reviews | ✅ sí |
| Required status checks | Validar Markdown · links internos · links externos · compilacion de prompts · Validar templates statusline (bash + PS 5.1)¹ |
| Strict status checks | ✅ sí |
| Bypass actors | ninguno |

## protect-develop (id: 13914965)

**Rama**: `develop`
**Objetivo**: integración continua — backmerges y PRs automáticas del bot.

| Regla | Valor |
|---|---|
| Deletion | ✅ bloqueado |
| Non-fast-forward (force push) | ✅ bloqueado |
| Pull request requerida | ✅ sí |
| Code owner review | ❌ no requerida (permite auto-merge del bot) |
| Required status checks | Validar Markdown · links internos · links externos · compilacion de prompts · Validar templates statusline (bash + PS 5.1)¹ |
| Strict status checks | ✅ sí |
| Bypass actors | ninguno |

## Por qué develop no requiere code owner review

En repos personales de GitHub, `actor_type: Integration` no puede usarse
como bypass actor en Rulesets. La solución arquitectónica: `develop` es
rama de integración (el gate real está en `master`). Sin review obligatoria
en develop, `github-actions[bot]` puede auto-mergear backmerges y PRs de
release-prep sin intervención manual.

¹ El check **Validar templates statusline (bash + PS 5.1)** se añadió en
issue #478 (PowerShell 5.1 compat + template externalizado). Tras mergear
#478, añadirlo manualmente a los required status checks de `master` y
`develop` desde la UI de GitHub o vía `gh api`.

## Gestión de Rulesets

Los Rulesets **no** se gestionan como código en este repo (no hay Rulesets-as-code).
Están configurados directamente en GitHub vía API. Para recrearlos:

```bash
# Ver rulesets actuales
gh api repos/joseguillermomoreu-gif/tlotp/rulesets --jq '.[].name'

# Ver detalle de un ruleset
gh api repos/joseguillermomoreu-gif/tlotp/rulesets/{id}
```
