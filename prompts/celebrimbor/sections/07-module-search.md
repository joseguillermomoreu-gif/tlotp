# 🔍 Módulo de Búsqueda - Celebrimbor

## Misión

Permitir al usuario buscar skills en el catálogo de skills.sh usando el backend seleccionado.

---

## 🎯 Flujo de Búsqueda

### Paso 0: Analizar Skills Instaladas (PRE-BÚSQUEDA)

**IMPORTANTE**: Antes de buscar nuevas skills, mostrar qué tiene el usuario instalado.

**Analizar jerarquía oficial de Claude Code**:

Según documentación oficial, buscar skills en:

1. **User Rules** (global): `~/.claude/rules/`
2. **User Skills** (global): `~/.claude/skills/` (si existe)
3. **Project Rules** (local): `./.claude/rules/`
4. **Project Skills** (local): `./.claude/skills/` (si existe)

**Comando**:
```bash
# Listar skills globales
ls -1 ~/.claude/skills/*.md 2>/dev/null
ls -1 ~/.claude/rules/*.md 2>/dev/null

# Listar skills locales (proyecto actual)
ls -1 ./.claude/rules/*.md 2>/dev/null
ls -1 ./.claude/skills/*.md 2>/dev/null
```

**Parsear archivos**:
- Extraer nombres de archivos (sin extensión .md)
- Contar total de skills
- Agrupar por ubicación (global/local)

**Mostrar resumen al usuario**:
```
═══════════════════════════════════════════════════════════════
📦 Skills Instaladas Actualmente
═══════════════════════════════════════════════════════════════

Global (~/.claude/):
  📁 skills/
    • playwright-pom.md
    • typescript-utils.md

  📁 rules/
    • llms.md
    • git-workflow.md

Proyecto actual (./.claude/):
  📁 rules/
    • php-symfony.md
    • doctrine-best-practices.md

═══════════════════════════════════════════════════════════════
Total: 6 skills instaladas (4 globales, 2 locales)
═══════════════════════════════════════════════════════════════
```

**Si NO hay skills instaladas**:
```
═══════════════════════════════════════════════════════════════
📦 Skills Instaladas Actualmente
═══════════════════════════════════════════════════════════════

No se encontraron skills instaladas.

Esta será tu primera skill 🎉

═══════════════════════════════════════════════════════════════
```

---

### Paso 1: Solicitar Query (DESPUÉS de mostrar instaladas)

**Mostrar prompt**:
```
🔍 Buscar Nuevas Skills en skills.sh

¿Qué tipo de skill buscas?

Ejemplos:
  • playwright     - Skills de Playwright
  • typescript     - Utilidades TypeScript
  • react          - Componentes React
  • php            - Herramientas PHP

💡 Tip: Busca skills que complementen las que ya tienes

Búsqueda: _
```

**Capturar input del usuario**

**Validación**:
- Mínimo 2 caracteres
- Si vacío: volver al menú principal
- Si "q" o "exit": volver al menú

---

### Paso 2: Ejecutar Búsqueda

**Usar Backend CLI** (módulo 04-backend-cli.md):

```bash
npx skills search <query>
```

**Ejemplo**:
```bash
npx skills search playwright
```

**Mostrar indicador de progreso**:
```
🔍 Buscando "playwright"...
```

---

### Paso 3: Parsear Resultados

**Output esperado de npx skills**:
```
🔍 Searching for "playwright"...

Found 12 skills:

  playwright-pom                    vercel-labs/skills
  Page Object Model patterns for Playwright
  1,523 installs

  playwright-fixtures               playwright-community
  Custom test fixtures for Playwright
  892 installs

  playwright-utils                  community/utils
  Utilities for Playwright tests
  456 installs
```

**Parsear**:
- Extraer nombre de skill
- Extraer autor/repositorio
- Extraer descripción
- Extraer número de instalaciones

**Estructura de datos**:
```yaml
results:
  - name: "playwright-pom"
    author: "vercel-labs/skills"
    description: "Page Object Model patterns for Playwright"
    installs: 1523

  - name: "playwright-fixtures"
    author: "playwright-community"
    description: "Custom test fixtures for Playwright"
    installs: 892
```

---

### Paso 4: Formatear y Mostrar Resultados

**Formato visual atractivo con detección de duplicados**:

```
═══════════════════════════════════════════════════════════════
🔍 Resultados para "playwright" (12 skills encontradas)
═══════════════════════════════════════════════════════════════

1. playwright-pom ⭐ 1,523 installs
   📦 vercel-labs/skills
   📝 Page Object Model patterns for Playwright
   ✅ YA INSTALADA (global)

2. playwright-fixtures ⭐ 892 installs
   📦 playwright-community
   📝 Custom test fixtures for Playwright

3. playwright-utils ⭐ 456 installs
   📦 community/utils
   📝 Utilities for Playwright tests

4. playwright-api-testing ⭐ 234 installs
   📦 api-testing/skills
   📝 API testing helpers for Playwright

5. playwright-visual-regression ⭐ 189 installs
   📦 visual-testing/skills
   📝 Visual regression testing with Playwright

... (mostrando 5 de 12 resultados)

═══════════════════════════════════════════════════════════════
💡 Nota: 1 skill ya instalada (marcada con ✅)
═══════════════════════════════════════════════════════════════
```

**Opciones después de resultados**:

```
¿Qué deseas hacer?

1. Ver todos los resultados (12)
2. Instalar una skill (ir a módulo de instalación)
3. Nueva búsqueda
4. Volver al menú principal

Elige [1-4]: _
```

---

## 🎨 Manejo de Casos Especiales

### Caso 1: No se encontraron skills

**Output de npx**:
```
🔍 Searching for "nonexistent"...

No skills found for "nonexistent"
```

**Mostrar al usuario**:
```
═══════════════════════════════════════════════════════════════
❌ No se encontraron skills para "nonexistent"
═══════════════════════════════════════════════════════════════

Sugerencias:
  • Verifica la ortografía
  • Prueba con términos más genéricos
  • Busca en inglés (ej: "playwright" en vez de "pruebas")
  • Explora el catálogo: https://skills.sh

¿Deseas hacer otra búsqueda? [s/N]: _
```

---

### Caso 2: Error de conexión

**Error de npx**:
```
Error: Failed to fetch from skills.sh
Network error: ENOTFOUND
```

**Mostrar al usuario**:
```
═══════════════════════════════════════════════════════════════
⚠️ Error de Conexión
═══════════════════════════════════════════════════════════════

No se pudo conectar a skills.sh

Posibles causas:
  • Sin conexión a internet
  • skills.sh temporalmente no disponible
  • Firewall bloqueando la conexión

Soluciones:
  • Verifica tu conexión a internet
  • Reintenta en unos momentos
  • Usa Backend Git (sin conexión) en v2.2.0

¿Reintentar búsqueda? [s/N]: _
```

---

### Caso 3: npx skills no disponible

**Error**:
```
bash: npx: command not found
```

**Acción**:
```
═══════════════════════════════════════════════════════════════
❌ Backend CLI No Disponible
═══════════════════════════════════════════════════════════════

npx no está disponible en tu sistema.

Esto no debería ocurrir - la detección de entorno debió
prevenir esto.

Acciones:
1. Reinstalar npm: https://nodejs.org
2. Reiniciar Celebrimbor para re-detectar entorno
3. Reportar bug: https://github.com/.../issues

Volviendo al menú principal...
```

---

## 🔧 Características Avanzadas

### Filtros de Búsqueda (Futuro v2.2)

**Permitir filtros**:
```
🔍 Búsqueda Avanzada

Query: playwright

Filtros opcionales:
  • Mínimo instalaciones: [100]
  • Autor específico: [vercel-labs]
  • Categoría: [testing]

Buscar con filtros: _
```

### Cache de Resultados

**Para búsquedas repetidas**:

```yaml
# ~/.celebrimbor/cache/search-results.yml

searches:
  - query: "playwright"
    timestamp: "2026-02-15T10:30:00Z"
    ttl: 3600  # 1 hora
    results: [...]
```

**Lógica**:
- Si búsqueda < 1 hora: usar cache
- Si búsqueda > 1 hora: ejecutar de nuevo

**Mostrar al usuario**:
```
🔍 Buscando "playwright"...
✅ Usando resultados en cache (actualizado hace 15 min)

(Para forzar nueva búsqueda, usa opción "Limpiar cache")
```

---

## 🔗 Integración con Otros Módulos

### Con Módulo Listar (09)

**IMPORTANTE**: Usar ANTES de solicitar query

```python
# PASO 0: Listar skills instaladas
installed_skills = module_list.get_installed_skills()
display_installed_summary(installed_skills)

# PASO 1: Solicitar query
query = ask_user("¿Qué skill buscas?")

# PASO 2: Buscar
results = backend.search(query)

# PASO 3: Marcar duplicados
for result in results:
    if result.name in installed_skills:
        result.already_installed = True
```

### Con Backend Selector (06)

```python
# Obtener backend seleccionado
backend = selector.get_backend()

# Ejecutar búsqueda usando backend
results = backend.search(query)
```

### Con Backend CLI (04)

```python
# Backend CLI implementa search()
def search(query, filters=None):
    # Ejecutar: npx skills search {query}
    output = bash("npx skills search " + query)

    # Parsear output
    results = parse_npx_output(output)

    return results
```

### Con Menú Principal (02)

```python
# Usuario elige "1. Buscar skills"
menu.option_1_selected():
    # Cargar módulo de búsqueda
    load_module("07-module-search.md")

    # Ejecutar flujo de búsqueda
    search_flow()
```

### Con Módulo Instalar (08) - Futuro

```python
# Después de mostrar resultados
if user_selects("2. Instalar una skill"):
    # Pasar resultados al módulo de instalación
    install_module.run(selected_skill)
```

---

## 🎯 Reglas de Ejecución

1. **SIEMPRE validar query** (mínimo 2 caracteres)
2. **Mostrar indicador de progreso** mientras busca
3. **Formatear resultados** de forma visual y clara
4. **Limitar resultados iniciales** a 5-10 (ofrecer "ver más")
5. **Capturar y manejar errores** gracefully
6. **Permitir acciones posteriores** (instalar, nueva búsqueda, etc.)
7. **Loop continuo** hasta que usuario decida salir

---

## 📊 Ejemplo de Output Completo

```
═══════════════════════════════════════════════════════════════
    🔮 Celebrimbor - Buscar Skills ⚒️
═══════════════════════════════════════════════════════════════

Backend: CLI ⚡ (Node.js v20.11.0)

🔍 ¿Qué tipo de skill buscas?

Búsqueda: playwright

═══════════════════════════════════════════════════════════════

🔍 Buscando "playwright"... ✓

═══════════════════════════════════════════════════════════════
🔍 Resultados para "playwright" (12 skills encontradas)
═══════════════════════════════════════════════════════════════

1. playwright-pom ⭐ 1,523 installs
   📦 vercel-labs/skills
   📝 Page Object Model patterns for Playwright

2. playwright-fixtures ⭐ 892 installs
   📦 playwright-community
   📝 Custom test fixtures for Playwright

3. playwright-utils ⭐ 456 installs
   📦 community/utils
   📝 Utilities for Playwright tests

4. playwright-api-testing ⭐ 234 installs
   📦 api-testing/skills
   📝 API testing helpers for Playwright

5. playwright-visual-regression ⭐ 189 installs
   📦 visual-testing/skills
   📝 Visual regression testing with Playwright

... (mostrando 5 de 12)

═══════════════════════════════════════════════════════════════

¿Qué deseas hacer?

1. Ver todos los resultados (12)
2. Instalar una skill
3. Nueva búsqueda
4. Volver al menú principal

Elige [1-4]: _
```

---

**Módulo anterior**: 06-backend-selector.md
**Módulo siguiente**: 08-module-install.md (Tarea #4)
**Integra con**: 02-menu-principal.md, 04-backend-cli.md, 06-backend-selector.md
**Tarea**: #3 - Módulo Buscar (120 XP)
