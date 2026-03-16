# 🔍 Módulo: Analizar Skills Instaladas y Sugerir Mejoras

## Misión

Inspeccionar las skills instaladas del usuario, puntuar su estado actual, comparar con
la documentación oficial y guiar la aplicación de mejoras una a una. Con el Palantír
activo, el análisis se extiende a detectar colisiones y redundancias entre configuraciones
y skills.

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

- **Con Palantír**: ejecutar Pasos 1–6 + Paso 7 (análisis cruzado)
- **Sin Palantír**: ejecutar solo Pasos 1–6

---

## Paso 1 — Descubrir skills instaladas y detectar updates

### 1a — Buscar en todas las rutas oficiales

```bash
# Buscar en todas las rutas oficiales en una sola llamada
{
  ls ~/.claude/skills/*/SKILL.md 2>/dev/null
  ls ~/.claude/skills/*.md 2>/dev/null | grep -v "SKILL.md"
  ls ./.claude/skills/*/SKILL.md 2>/dev/null
  ls ./.claude/skills/*.md 2>/dev/null | grep -v "SKILL.md"
  ls ~/.claude/commands/*.md 2>/dev/null
  ls ./.claude/commands/*.md 2>/dev/null
} 2>/dev/null
```

Para cada skill encontrada, leer su contenido para extraer el frontmatter.

### 1b — Detectar updates disponibles

**Reutilizar si ya está en el contexto del menú** (el menú ejecuta `npx skills check` antes de mostrar opciones).

**Si no está en contexto**, ejecutar:

```bash
source ~/.nvm/nvm.sh 2>/dev/null && nvm use 20 --silent 2>/dev/null
npx skills check 2>&1
```

Guardar la lista de skills con update disponible. Este dato se usará en el scoring del Paso 2.

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
| Update disponible en el catálogo | -2 pts | ⚠️ Mejorable |
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
  ⚒️ 10/10  playwright-pom/SKILL.md    — estructura ✅ · description ✅
  ⚔️  8/10  php-pro/SKILL.md           — update disponible ⚠️
  ⚔️  8/10  git-workflow.md            — archivo plano (legacy) ⚠️
  ❌  6/10  typescript-utils.md        — paths: obsoleto ❌ · archivo plano ⚠️

══════════════════════════════════════════════════════════════
📊 Score global: 8.0/10 ⚔️ — 4 skills · 1 ⚒️ · 2 ⚔️ · 1 ❌
══════════════════════════════════════════════════════════════
```

---

## Paso 4 — Lista de mejoras priorizadas

Construir la lista completa de mejoras, ordenadas por severidad:
1. ❌ Críticos primero
2. ⚠️ Mejorables después
3. ℹ️ Informativos al final

Para cada mejora, preparar internamente:
- Skill afectada (nombre + ruta)
- Problema (descripción clara)
- Solución propuesta (qué se aplicaría exactamente, con comandos si aplica)
- Resultado esperado

Mostrar el total: `X mejoras encontradas (Y ❌ críticas · Z ⚠️ mejorables)`

---

## Paso 5 — Opciones al usuario

Mostrar con `AskUserQuestion` (incluir opción de actualizar dinámicamente si hay updates):

```json
{
  "questions": [{
    "header": "Tras el análisis",
    "question": "¿Qué deseas hacer con los resultados?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔧 Revisar y aplicar mejoras una a una",
        "description": ""
      },
      {
        "label": "🔄 Actualizar las X skills desactualizadas",
        "description": "Solo si hay updates detectados — cargar módulo 11-module-update.md"
      },
      {
        "label": "🔙 Volver al menú principal",
        "description": ""
      }
    ]
  }]
}
```

**Nota**: La opción de actualizar solo aparece si `npx skills check` detectó updates en el Paso 1b. Si no hay updates, el menú tiene 2 opciones (revisar mejoras + volver).

---

## Paso 6 — Revisor uno a uno

Iterar por cada mejora de la lista del Paso 4, **en orden de severidad** (❌ primero, ⚠️ después, ℹ️ al final).

**Mostrar para cada mejora**:

```
⚒️ MEJORA [X/N] — [❌/⚠️/ℹ️] [SEVERIDAD]
══════════════════════════════════════════════════════════════

📍 Skill afectada: [nombre / ruta completa]

❌ Problema:
   [descripción clara del problema detectado]

✅ Solución propuesta:
   [qué se aplicaría exactamente — incluir comandos o fragmentos de código si aplica]

🎯 Resultado esperado:
   [qué mejorará o se corregirá tras aplicar]

══════════════════════════════════════════════════════════════
```

**AskUserQuestion por cada mejora**:

```json
{
  "questions": [{
    "header": "Mejora [X/N]",
    "question": "¿Qué hacemos con esta pieza de la Forja?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aplicar",
        "description": "Celebrimbor aplicará esta mejora ahora"
      },
      {
        "label": "✏️ Modificar propuesta",
        "description": "Ajustar la solución antes de aplicar"
      },
      {
        "label": "⏭️ Saltar",
        "description": "Dejar esta mejora sin cambios y pasar a la siguiente"
      },
      {
        "label": "🚫 Cancelar todo",
        "description": "Abortar el revisor y ver resumen parcial"
      }
    ]
  }]
}
```

**Comportamiento por opción**:

- **✅ Aplicar**: Ejecutar el cambio usando las herramientas disponibles (Edit/Write/Bash). Confirmar éxito con una frase de lore de Eregion, variada según la mejora:
  - *"⚒️ La pieza ha sido reforjada. Los Gwaith-i-Mírdain aprueban."*
  - *"⚒️ Bien. Así debe lucir una skill en la Forja de Eregion."*
  - *"⚒️ El metal estaba frío — ahora arde como debe."*
  - *"⚒️ Eregion recuerda cada arma que mejora entre sus manos."*
  - *(Variar la frase — breve, con el tono inconfundible de la Forja)*
  - Luego pasar a la siguiente mejora.
- **✏️ Modificar propuesta**: Preguntar qué cambiar. Mostrar propuesta actualizada y confirmar antes de aplicar.
- **⏭️ Saltar**: Mostrar `⚒️ "Esta pieza puede esperar su momento..."` y pasar a la siguiente.
- **🚫 Cancelar todo**: Detener el revisor y saltar al resumen final (Paso 6b).

**IMPORTANTE**: Antes de aplicar cualquier cambio, indicar siempre la ruta exacta del archivo que se modificará.

### Paso 6b — Resumen final del revisor

```
📋 RESUMEN DE LA FORJA
══════════════════════════════════════════════════════════════
  ✅ Aplicadas:   [X]
  ✏️  Modificadas: [X]
  ⏭️  Saltadas:    [X]
══════════════════════════════════════════════════════════════
⚒️  "Eregion recuerda cada arma que pasa por sus manos."
```

AskUserQuestion con opciones de continuación:
- `🔙 Volver al menú de Celebrimbor`
- `🔙 Volver a La Comunidad del Código`

---

## Paso 7 — Análisis cruzado con Palantír (solo si usuario aceptó en Paso 0.5)

### Paso 7.1 — Documentación de Palantír (on-the-fly)

**IMPORTANTE**: Comprobar si la documentación de memoria/configuración ya está en contexto.

**Si ya está en contexto**: usar directamente sin re-fetchear.

**Si no está en contexto**, hacer WebFetch:

> **WebFetch**: `https://code.claude.com/docs/en/memory`
> **Extraer**: Jerarquía de memoria (7 niveles), tipos de archivos de configuración,
> precedencia, cómo interactúan las rules y las skills.

### Paso 7.2 — Leer configuraciones del usuario

```bash
# Configuración global
cat ~/.claude/CLAUDE.md 2>/dev/null
ls ~/.claude/rules/*.md 2>/dev/null
ls ~/.claude/memory/*.md 2>/dev/null

# Configuración del proyecto actual
cat ./.claude/CLAUDE.md 2>/dev/null || cat ./CLAUDE.md 2>/dev/null
ls ./.claude/rules/*.md 2>/dev/null
```

### Paso 7.3 — Análisis cruzado

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

  ⚠️ Skills globales sin uso aparente en este proyecto:
     • react-patterns — no hay archivos .tsx ni .jsx detectados
     💡 Nota: Skills globales son normales aunque no se usen en este proyecto.

  💡 Skills recomendadas para este stack (no instaladas):
     • (basado en catálogo oficial, WebFetch ya cargado)
```

#### 🟢 Calidad de instalación
```
🟢 CALIDAD DE INSTALACIÓN:
  ✅ playwright-pom — estructura correcta, path correcto
  ⚠️ git-workflow — archivo plano, considera migrar (ya señalado en análisis base)
```

### Paso 7.4 — Informe cruzado

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

Las mejoras detectadas aquí se añaden al revisor del Paso 6 (se procesan después de las del análisis base).

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

### Todas las skills están perfectas y actualizadas
```
⚒️ Los Gwaith-i-Mírdain inspeccionan el arsenal...

✅ Todas las skills están correctas, bien configuradas y actualizadas.
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
**Requiere**: WebFetch on-demand, Read, Edit (para aplicar sugerencias), Bash (npx skills check)
**Opcional**: Read (configs de Palantír)
