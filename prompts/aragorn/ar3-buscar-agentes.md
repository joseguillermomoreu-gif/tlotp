# 👑 AR3 - Los Mercados de las Tierras Libres: Buscar Agentes

## Intro de ejecución

```
👑 Aragorn parte hacia los mercados de las Tierras Libres...
   VoltAgent y aitmpl.com guardan ejércitos enteros esperando ser reclutados.
   Consultando fuentes en tiempo real.
```

---

## Paso 1 — Preguntar qué busca el usuario

**Usar AskUserQuestion**:

```
🔍 BUSCAR AGENTES EN MARKETPLACES

¿Cómo quieres buscar?
```

Opciones:
1. **Por categoría** — código, testing, devops, seguridad, base de datos...
2. **Por tecnología** — PHP, TypeScript, Python, Go, Rust...
3. **Por palabra clave** — búsqueda libre
4. **Ver todos los disponibles** — listar catálogo completo
5. **🔙 Volver al menú de Aragorn**

---

## Paso 2 — Consultar VoltAgent (WebFetch)

Consultar el repositorio oficial de VoltAgent en tiempo real:

```
WebFetch: https://raw.githubusercontent.com/VoltAgent/awesome-claude-code-subagents/main/README.md
```

Del contenido extraer:
- Lista de agentes por categoría
- Nombre, descripción y enlace de cada agente

Si el WebFetch falla:
```
⚠️  No se pudo contactar con VoltAgent.
    URL alternativa: https://github.com/VoltAgent/awesome-claude-code-subagents
```

### Categorías de VoltAgent

| Categoría | Descripción |
|-----------|-------------|
| code-quality | Linters, reviewers, refactoring |
| testing | Test generators, E2E, coverage |
| documentation | Doc writers, README generators |
| devops | CI/CD, deploy, monitoring |
| security | Audit, SAST, vulnerability scan |
| database | Migrations, queries, schema |
| frontend | UI, components, accessibility |
| backend | APIs, services, architecture |
| meta-orchestration | Coordinadores de agentes |
| specialized | Dominio específico |

---

## Paso 3 — Consultar aitmpl.com (WebFetch)

```
WebFetch: https://aitmpl.com/agents
```

Extraer agentes disponibles con nombre y descripción.

Si el WebFetch falla, informar con URL alternativa: `https://aitmpl.com`

---

## Paso 4 — Filtrar según búsqueda

### Si busca por categoría
Mostrar solo agentes de la categoría seleccionada de ambos marketplaces.

### Si busca por tecnología
Filtrar agentes cuyo nombre o descripción mencione la tecnología (PHP, Symfony, TypeScript, React, Python, etc.).

### Si busca por keyword
Filtrar agentes cuyo nombre o descripción contenga la palabra clave.

### Si quiere ver todos
Mostrar listado completo agrupado por marketplace y categoría.

---

## Paso 5 — Mostrar resultados

```
🔍 Resultados para "php testing"
══════════════════════════════════════════════════════

VoltAgent (2 encontrados):
──────────────────────────
  1. phpunit-generator
     📝 Genera tests PHPUnit con mocks y fixtures para clases PHP
     🔧 Tools: Read, Write, Bash
     📦 VoltAgent / 02-testing

  2. symfony-test-writer
     📝 Tests de integración para bundles Symfony con Fixtures y Faker
     🔧 Tools: Read, Write, Bash, Grep
     📦 VoltAgent / 02-testing

aitmpl.com (1 encontrado):
──────────────────────────
  1. behat-scenario-writer
     📝 Escribe escenarios Behat BDD desde criterios de aceptación
     🔧 Tools: Read, Write
     📦 aitmpl.com / agents

══════════════════════════════════════════════════════
📊 Total: 3 agentes encontrados
```

Si no hay resultados:
```
👑 Los mercados no tienen guerreros con ese perfil todavía.
   Prueba con otra búsqueda o consulta el catálogo completo (opción 4).
```

---

## Paso 6 — Acciones desde resultados

Tras mostrar resultados, **usar AskUserQuestion**:
- Instalar un agente de la lista (pedir cuál → ir a AR5)
- Ver detalle de un agente (pedir cuál → WebFetch al README del agente)
- Nueva búsqueda
- Volver al menú de Aragorn
