# 📊 Diagram Renderer - Visualización del Pipeline

## Misión

Renderizar un diagrama visual del pipeline CI/CD actual del proyecto,
basándose en los datos recopilados por el Analyzer (módulo 03).

---

## Formato del Diagrama

Generar un diagrama ASCII/Unicode que muestre el flujo completo del CI/CD.

### Diagrama de Triggers y Workflows

```
═══════════════════════════════════════════════════════════════
📊 Diagrama CI/CD del Proyecto
═══════════════════════════════════════════════════════════════

  🔀 TRIGGERS
  ├── push → [branches]
  ├── pull_request → [branches]
  ├── schedule → [cron]
  └── workflow_dispatch (manual)
       │
       ▼
  ┌─────────────────────────────────────────────────────────┐
  │  📄 WORKFLOW: [nombre-workflow.yml]                      │
  │                                                         │
  │  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐ │
  │  │  Job: lint   │───▶│  Job: test   │───▶│  Job: build  ││
  │  │  [runner]    │    │  [runner]    │    │  [runner]    ││
  │  │             │    │             │    │             ││
  │  │ ○ checkout  │    │ ○ checkout  │    │ ○ checkout  ││
  │  │ ○ setup-node│    │ ○ setup-node│    │ ○ setup-node││
  │  │ ○ npm ci    │    │ ○ npm ci    │    │ ○ npm ci    ││
  │  │ ○ npm lint  │    │ ○ npm test  │    │ ○ npm build ││
  │  │ ⚡ cache: ✅ │    │ ⚡ cache: ✅ │    │ ⚡ cache: ✅ ││
  │  └─────────────┘    └─────────────┘    └─────────────┘ │
  │                                              │          │
  │                                              ▼          │
  │                                    ┌─────────────┐      │
  │                                    │  Job: deploy │      │
  │                                    │  [runner]    │      │
  │                                    │ ○ deploy     │      │
  │                                    │ 🔒 env: prod │      │
  │                                    └─────────────┘      │
  └─────────────────────────────────────────────────────────┘

═══════════════════════════════════════════════════════════════
```

---

## Reglas de Renderizado

### 1. Dependencias entre Jobs

- Si un job tiene `needs: [otro_job]`, mostrar flecha de dependencia `───▶`
- Si los jobs son paralelos (sin `needs`), mostrarlos en la misma fila
- Si hay cadenas de dependencia, mostrar flujo vertical `▼`

### 2. Indicadores Visuales

Usar estos iconores para cada característica detectada:

| Icono | Significado |
|---|---|
| ⚡ | Cache habilitado |
| 🔒 | Usa secrets o environment |
| 📦 | Genera/consume artifacts |
| 🔄 | Matrix strategy |
| ♻️ | Reusable workflow |
| 🛡️ | Permissions restringidos |
| 🐳 | Usa Docker/services |
| ⏰ | Tiene timeout configurado |
| 🔀 | Concurrency group |

### 3. Múltiples Workflows

Si hay más de un workflow, mostrar cada uno en su propio bloque,
con una sección superior que muestre qué trigger activa qué workflow:

```
  🔀 MAPA DE TRIGGERS → WORKFLOWS
  ───────────────────────────────────────
  push (main)         → ci.yml, deploy.yml
  pull_request        → ci.yml
  schedule (cron)     → nightly.yml
  workflow_dispatch   → deploy.yml
  release (published) → release.yml
```

### 4. Proyecto sin CI/CD

Si no se encontró ningún workflow, mostrar:

```
═══════════════════════════════════════════════════════════════
📊 Diagrama CI/CD del Proyecto
═══════════════════════════════════════════════════════════════

  ⚠️ No se detectaron workflows de GitHub Actions

  El proyecto no tiene pipelines de CI/CD configurados.

  📁 .github/workflows/ → No existe o está vacío

  💡 Recomendación: Usa la opción "Crear CI/CD desde cero"
     para generar workflows adaptados a tu proyecto.

═══════════════════════════════════════════════════════════════
```

---

## Después del Diagrama

Una vez mostrado el diagrama, el flujo continúa con:
- **04-improvement-engine.md** → Sugerir mejoras basadas en documentación oficial

---

*Módulo 03 — Diagram Renderer*
