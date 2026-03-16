# 🔍 Módulo: Analizar Skills Instaladas y Sugerir Mejoras

## Misión

Inspeccionar las skills instaladas del usuario, puntuar su estado actual, comparar con
la documentación oficial y proponer mejoras concretas. Con el Palantír activo, el análisis
se extiende a detectar colisiones y redundancias entre configuraciones y skills.

---

## Paso 0 — Documentación oficial (on-the-fly)

**IMPORTANTE**: Comprobar primero si la documentación ya está cargada en el
contexto de esta sesión (por haber ejecutado previamente otro módulo que haya hecho WebFetch).

**Si ya está en contexto**: usar directamente esa información sin re-fetchear.

**Si no está en contexto**, hacer WebFetch:

> **WebFetch 1**: `https://code.claude.com/docs/en/skills`
> **Extraer**: Estructura oficial de SKILL.md, campos válidos de frontmatter, rutas de instalación,
> control de invocación, patrones recomendados, campos obsoletos.

> **WebFetch 2**: `https://github.com/vercel-labs/skills`
> **Extraer**: Versiones disponibles de skills en el catálogo, comandos de actualización,
> estructura esperada, campos que el CLI gestiona.

**Fallback si WebFetch falla**: Continuar con conocimiento interno marcando sugerencias con ⚠️ sin doc oficial.

---

## Paso 0.5 — ¿Traes tu Palantír?

Preguntar con `AskUserQuestion` antes de iniciar el análisis:

```json
{
  "questions": [{
    "header": "La Piedra Vidente",
    "question": "¿Traes tu Palantír contigo, viajero? Con él, la Forja puede ver mucho más lejos y detectar conflictos entre tus configuraciones y tus skills.",
    "multiSelect": false,
    "options": [
      {
        "label": "🔮 Sí — análisis completo con Palantír",
        "description": ""
      },
      {
        "label": "⚒️ No — análisis estándar de skills",
        "description": ""
      }
    ]
  }]
}
```

- **Con Palantír**: ejecutar Pasos 1–5 + Paso 6 (análisis cruzado)
- **Sin Palantír**: ejecutar solo Pasos 1–5

---

## Paso 1 — Descubrir skills instaladas

Buscar en todas las rutas oficiales:

```bash
# Personal — nueva estructura (directorio)
ls ~/.claude/skills/*/SKILL.md 2>/dev/null

# Personal — estructura legacy (archivo plano)
ls ~/.claude/skills/*.md 2>/dev/null | grep -v "SKILL.md"

# Proyecto — nueva estructura
ls ./.claude/skills/*/SKILL.md 2>/dev/null

# Proyecto — estructura legacy
ls ./.claude/skills/*.md 2>/dev/null | grep -v "SKILL.md"

# Legacy commands (aún válidos según doc oficial)
ls ~/.claude/commands/*.md 2>/dev/null
ls ./.claude/commands/*.md 2>/dev/null
```

Para cada skill encontrada, leer su contenido para extraer el frontmatter.

---

## Paso 2 — Analizar y puntuar cada skill

Para cada skill, evaluar según los siguientes criterios. Cada skill parte de **10 puntos** y se penaliza:

### Criterios de scoring por skill

| Criterio | Penalización | Severidad |
|----------|-------------|-----------|
| Sin `description` en frontmatter | -4 pts | ❌ Crítico |
| `description` demasiado corta (<15 chars) | -2 pts | ⚠️ Mejorable |
| Formato legacy (archivo plano, no directorio) | -2 pts | ⚠️ Mejorable |
| Campo obsoleto en frontmatter (`paths:` u otros no oficiales) | -3 pts | ❌ Crítico |
| Configuración de invocación inconsistente con el tipo de skill | -1 pt | ℹ️ Revisable |

### Niveles de calidad por skill

| Puntos | Nivel | Descripción |
|--------|-------|-------------|
| 9–10 | ⚒️ Obra maestra | Skill perfectamente forjada |
| 7–8 | ⚔️ Bien forjada | Solo mejoras menores |
| 5–6 | 🧙 En proceso | Necesita trabajo |
| < 5 | 🐛 En el horno | Requiere refuerzo urgente |

### Score global

```
Score global = media de puntuaciones individuales (redondeado a 1 decimal)
```

---

## Paso 3 — Generar informe con scoring

```
══════════════════════════════════════════════════════════════
⚒️  CELEBRIMBOR — Análisis de Skills
══════════════════════════════════════════════════════════════

🌍 PERSONAL (~/.claude/skills/)
──────────────────────────────────────────────────────────────
  ⚒️ 10/10  playwright-pom/SKILL.md    — estructura correcta, description OK
  ⚔️  8/10  git-workflow.md            — archivo plano (legacy), migrar a directorio
  ❌  6/10  php-pro/SKILL.md           — sin description en frontmatter

📂 PROYECTO (./.claude/skills/)
──────────────────────────────────────────────────────────────
  🧙  4/10  typescript-utils.md        — paths: obsoleto + archivo plano

📁 LEGACY COMMANDS
──────────────────────────────────────────────────────────────
  ℹ️  —     deploy.md                  — legacy command, funciona igual que skill

══════════════════════════════════════════════════════════════
📊 Score global: 7.0/10 ⚔️ — 5 skills · 1 ⚒️ · 1 ⚔️ · 1 🧙 · 1 ❌ crítica
══════════════════════════════════════════════════════════════
```

---

## Paso 4 — Sugerencias accionables (basadas en doc oficial)

Para cada issue encontrado, mostrar la sugerencia específica derivada de la documentación oficial cargada en el Paso 0.

Ordenar: ❌ Críticos primero, ⚠️ Mejorables después, ℹ️ Informativos al final.

### ❌ Sin description
```
skill: php-pro/SKILL.md
Problema: Sin campo description en el frontmatter
Impacto: Claude no sabe cuándo activar esta skill automáticamente
Fuente: documentación oficial skills (Paso 0)

Sugerencia: Añadir al frontmatter:
  description: "Aplica cuando trabajas con PHP 8.3+, Laravel o Symfony.
                Usa cuando el código importe namespace Symfony o Laravel."
```

### ⚠️ Archivo plano (legacy)
```
skill: git-workflow.md
Problema: Archivo plano — formato antiguo
Impacto: Funciona, pero no puede tener archivos de soporte ni scripts

Sugerencia: Migrar a directorio:
  mkdir ~/.claude/skills/git-workflow
  mv ~/.claude/skills/git-workflow.md ~/.claude/skills/git-workflow/SKILL.md
```

### ❌ Campo obsoleto
```
skill: typescript-utils.md
Problema: Tiene paths: en el frontmatter — campo obsoleto según doc oficial
Impacto: El campo es ignorado por Claude Code

Sugerencia: Eliminar el bloque paths: del frontmatter
```

---

## Paso 5 — Opciones al usuario

Mostrar con `AskUserQuestion`:

```json
{
  "questions": [{
    "header": "Tras el análisis",
    "question": "¿Qué deseas hacer con los resultados?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔧 Aplicar sugerencias una a una",
        "description": ""
      },
      {
        "label": "📋 Ver detalles completos de una skill",
        "description": ""
      },
      {
        "label": "🔙 Volver al menú principal",
        "description": ""
      }
    ]
  }]
}
```

### Si elige "Aplicar sugerencias una a una"

Para cada issue (ordenados: ❌ primero, ⚠️ después):

```
Ítem X/N — [nombre de la skill]
Problema: [descripción del problema]
Acción propuesta: [qué se va a hacer]

¿Aplicar?
  ✅ Aplicar
  ⏭️ Saltar
  🚫 Cancelar todo
```

Ejecutar la acción y confirmar resultado antes de pasar al siguiente.

Al finalizar, mostrar resumen:
```
Análisis completado:
  ✅ Aplicadas: X
  ⏭️ Saltadas: Y
  Total revisadas: Z
```

---

## Paso 6 — Análisis cruzado con Palantír (solo si usuario aceptó en Paso 0.5)

### Paso 6.1 — Documentación de Palantír (on-the-fly)

**IMPORTANTE**: Comprobar si la documentación de memoria/configuración ya está en contexto.

**Si ya está en contexto**: usar directamente sin re-fetchear.

**Si no está en contexto**, hacer WebFetch:

> **WebFetch**: `https://code.claude.com/docs/en/memory`
> **Extraer**: Jerarquía de memoria (7 niveles), tipos de archivos de configuración,
> precedencia, cómo interactúan las rules y las skills.

### Paso 6.2 — Leer configuraciones del usuario

```bash
# Configuración global
cat ~/.claude/CLAUDE.md 2>/dev/null
ls ~/.claude/rules/*.md 2>/dev/null
ls ~/.claude/memory/*.md 2>/dev/null

# Configuración del proyecto actual
cat ./.claude/CLAUDE.md 2>/dev/null || cat ./CLAUDE.md 2>/dev/null
ls ./.claude/rules/*.md 2>/dev/null
```

### Paso 6.3 — Análisis cruzado

Con las configuraciones y skills cargadas, detectar:

#### 🔴 Colisiones — instrucciones que se contradicen
Instrucciones en CLAUDE.md o rules que contradicen o solapan instrucciones de una skill activa.

```
🔴 COLISIÓN detectada:
  Config:  CLAUDE.md línea 12 → "Usa siempre TypeScript strict"
  Skill:   typescript-utils/SKILL.md → "Permite JS cuando el proyecto no tiene tsconfig"
  Impacto: Comportamiento inconsistente según qué instrucción prevalezca
  Jerarquía: La skill tiene precedencia sobre CLAUDE.md global (doc oficial)
```

#### 🟡 Redundancias — instrucciones duplicadas
Instrucciones en las configs que ya están cubiertas completamente por una skill activa.

```
🟡 REDUNDANCIA detectada:
  Config:  ~/.claude/CLAUDE.md → bloque de convenciones de commits
  Skill:   git-workflow/SKILL.md → cubre exactamente las mismas convenciones
  Acción:  Puedes eliminar el bloque de CLAUDE.md y dejar que la skill lo gestione
```

#### 🔵 Pertinencia — skills vs scope del proyecto
Comparar las skills instaladas contra el stack y propósito del proyecto actual.

```
🔵 ANÁLISIS DE PERTINENCIA:
  Proyecto detectado: PHP/Symfony (por CLAUDE.md y estructura de archivos)

  ✅ Skills relevantes para este proyecto:
     • php-pro — directamente aplicable
     • git-workflow — universal, siempre útil

  ⚠️ Skills sin uso aparente en este proyecto:
     • react-patterns — no hay archivos .tsx ni .jsx detectados

  💡 Skills recomendadas para este stack (no instaladas):
     • php-pro (si no está) — mejores prácticas PHP 8.3+/Symfony
     • (basado en catálogo oficial, WebFetch ya cargado)
```

#### 🟢 Calidad de instalación
```
🟢 CALIDAD DE INSTALACIÓN:
  ✅ playwright-pom — estructura correcta, path correcto
  ⚠️ git-workflow — archivo plano, considera migrar (ya señalado en análisis base)
```

### Paso 6.4 — Informe cruzado

```
══════════════════════════════════════════════════════════════
🔮 ANÁLISIS CRUZADO — Forja + Palantír
══════════════════════════════════════════════════════════════

🔴 Colisiones:    X encontradas
🟡 Redundancias:  X encontradas
🔵 Pertinencia:   X skills sin uso aparente · X recomendadas
🟢 Instalación:   X correctas · X mejorables

══════════════════════════════════════════════════════════════
```

Ofrecer las mismas opciones del Paso 5 para aplicar correcciones.

---

## Casos especiales

### Sin skills instaladas
```
No se encontraron skills instaladas en las rutas oficiales.

Rutas verificadas:
  • ~/.claude/skills/
  • ./.claude/skills/
  • ~/.claude/commands/
  • ./.claude/commands/

💡 Usa "Buscar e instalar skills" para añadir skills desde skills.sh
   o "Crear una skill" para crear la tuya propia.
```

### Todas las skills están correctas
```
⚒️ Los Gwaith-i-Mírdain inspeccionan el arsenal...

✅ Todas las skills están correctas y bien configuradas.
   Eregion aprueba tu colección, viajero.

Score global: 10/10 ⚒️ — X skills · todas obras maestras
```

---

## 🔗 Fuentes

Ver índice completo en `@prompts/docs-sources.md`:
- Skills nativas: `https://code.claude.com/docs/en/skills`
- CLI skills.sh: `https://github.com/vercel-labs/skills`
- Memoria/configuración (Palantír): `https://code.claude.com/docs/en/memory`

---

**Módulo**: `07-module-analyze.md`
**Invocado desde**: `02-menu-principal.md` (opción "Examinar las forjas de Eregion")
**Requiere**: WebFetch on-demand, Read, Edit (para aplicar sugerencias)
**Opcional**: Bash (para listar archivos), Read (configs de Palantír)
