# 🔍 Módulo: Buscar Skills en skills.sh

## Misión

Permitir al usuario buscar skills en el catálogo de skills.sh. Este módulo forma la primera parte de la opción "Buscar e instalar" del menú.

---

## Paso 0 — Mostrar skills ya instaladas

Antes de pedir la búsqueda, mostrar un resumen de lo que el usuario ya tiene instalado (rutas oficiales):

```bash
# Nueva estructura (directorio)
ls ~/.claude/skills/*/SKILL.md 2>/dev/null
ls ./.claude/skills/*/SKILL.md 2>/dev/null

# Estructura legacy (archivo plano)
ls ~/.claude/skills/*.md 2>/dev/null | grep -v "/SKILL.md"
ls ./.claude/skills/*.md 2>/dev/null | grep -v "/SKILL.md"
```

Mostrar resumen compacto:
```
📦 Skills instaladas actualmente:
  🌍 Global (3): playwright-pom, typescript-utils, git-workflow
  📂 Local (1):  php-pro

Esta será la referencia para detectar duplicados.
```

Si no hay ninguna: `Esta será tu primera skill 🎉`

---

## Paso 1 — Solicitar query

```
🔍 Buscar en skills.sh

¿Qué tipo de skill buscas?
Ejemplos: playwright, typescript, react, php, python, docker

Búsqueda: _
```

**Validación**: mínimo 2 caracteres. Si vacío o "q": volver al menú principal.

---

## Paso 2 — Ejecutar búsqueda

```bash
npx skills find <query>
```

Mostrar indicador: `🔍 Buscando "<query>"...`

---

## Paso 3 — Parsear y mostrar resultados

Para cada resultado, extraer: nombre, autor, descripción, instalaciones.
Marcar con ✅ las que ya están instaladas (detectadas en Paso 0).

```
══════════════════════════════════════════════════════════════
🔍 Resultados para "playwright" (12 encontradas)
══════════════════════════════════════════════════════════════

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

... (mostrando 5 de 12)

══════════════════════════════════════════════════════════════
```

---

## Paso 4 — Opciones

Mostrar con `AskUserQuestion`:

```
¿Qué deseas hacer?

1. 📥 Instalar una skill de estos resultados
2. 📄 Ver todos los resultados (12)
3. 🔍 Nueva búsqueda
4. 🔙 Volver al menú principal
```

- **Instalar**: continuar a `08-module-install.md` pasando el contexto de resultados
- **Ver todos**: mostrar lista completa y volver a opciones
- **Nueva búsqueda**: repetir desde Paso 1
- **Volver**: menú principal

---

## Casos especiales

### Sin resultados
```
❌ No se encontraron skills para "<query>"

Sugerencias:
  • Verifica la ortografía
  • Prueba con términos más genéricos (ej: "test" en vez de "e2e-testing")
  • Busca en inglés
```

### Error de red
```
⚠️ No se pudo conectar a skills.sh
   Verifica tu conexión a internet e inténtalo de nuevo.
```

### npx no disponible
```
❌ npx no está disponible. Reinicia Celebrimbor para re-detectar el entorno.
```

---

**Módulo**: `07-module-search.md`
**Invocado desde**: `02-menu-principal.md` (Opción 2)
**Continúa en**: `08-module-install.md`
