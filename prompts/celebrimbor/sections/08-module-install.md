# 📥 Módulo de Instalación - Celebrimbor

## Misión

Instalar skills desde skills.sh con configuración automática y validación completa.

---

## 🎯 Flujo de Instalación

### Paso 1: Seleccionar Skill a Instalar

**Dos formas de llegar aquí**:

#### Opción A: Desde Resultados de Búsqueda

**Usuario ha buscado y ve resultados**:
```
🔍 Resultados para "playwright" (5 skills)

1. playwright-pom ⭐ 1,523 installs
2. playwright-fixtures ⭐ 892 installs
3. playwright-utils ⭐ 456 installs

¿Qué deseas hacer?
1. Instalar una skill ← Usuario elige esto
```

**Preguntar**:
```
¿Qué skill quieres instalar?

Introduce el número [1-3] o el nombre completo: _
```

**Validar**:
- Si número: verificar rango (1-3)
- Si nombre: verificar que existe en resultados

#### Opción B: Instalación Directa

**Usuario viene del menú principal** → "2. Instalar Skill"

**Preguntar**:
```
📥 Instalar Skill

Introduce el nombre completo de la skill:

Ejemplos:
  • playwright-pom
  • vercel-labs/skills/playwright-pom
  • https://skills.sh/vercel-labs/skills/playwright-pom

Skill: _
```

---

### Paso 2: Verificar si Ya Existe

**Usar módulo 09-module-list.md**:
```python
installed_skills = get_installed_skills()

if skill_name in installed_skills:
    location = installed_skills[skill_name].location  # "global" o "local"
    show_already_installed_warning(skill_name, location)
```

**Mostrar al usuario**:
```
⚠️ Skill Ya Instalada

La skill "playwright-pom" ya está instalada en:
  📍 Global: ~/.claude/skills/playwright-pom.md

¿Qué deseas hacer?

1. Cancelar instalación
2. Reinstalar (sobreescribir) en la misma ubicación
3. Instalar en otra ubicación (global ↔ local)

Elige [1-3]: _
```

**Si elige "1. Cancelar"**: Volver al menú

**Si elige "2. Reinstalar"**: Continuar con misma ubicación

**Si elige "3. Otra ubicación"**: Continuar y permitir elegir ubicación diferente

---

### Paso 3: Elegir Ubicación

**Preguntar al usuario**:
```
📍 ¿Dónde instalar "playwright-pom"?

┌─────────────────────────────────────────────────────────────┐
│ 1. 🌍 Global (~/.claude/skills/)                            │
│    • Disponible en TODOS tus proyectos                     │
│    • Recomendado para skills generales                     │
│    • Ejemplo: llms, git-workflow, typescript               │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ 2. 📂 Local (./.claude/rules/)                              │
│    • Solo para ESTE proyecto                               │
│    • Recomendado para skills específicas del proyecto      │
│    • Ejemplo: php-symfony, custom-validators               │
└─────────────────────────────────────────────────────────────┘

Elige [1-2]: _
```

**Guardar elección**:
```yaml
install_config:
  skill_name: "playwright-pom"
  location: "global"  # o "local"
  path: "~/.claude/skills/playwright-pom.md"  # o "./.claude/rules/playwright-pom.md"
```

**Nota sobre directorios**:
- Global: Se usa `~/.claude/skills/` (convención moderna)
- Local: Se usa `./.claude/rules/` (jerarquía oficial)

---

### Paso 4: Ejecutar Instalación con Backend CLI

**Comando npx skills**:
```bash
# Si el CLI de skills soporta flags de ubicación:
npx skills add <skill-name> --location <global|local>

# Si NO soporta (más probable):
# Instalar manualmente copiando archivo
```

**Proceso de instalación manual** (más confiable):

#### 4.1: Descargar Skill

```bash
# Opción 1: npx skills add descarga temporalmente
npx skills add vercel-labs/skills/playwright-pom

# Opción 2: Descargar directamente del repo
curl -o /tmp/skill.md \
  https://raw.githubusercontent.com/vercel-labs/skills/main/skills/playwright-pom/SKILL.md
```

#### 4.2: Crear Directorio si No Existe

```bash
# Global
mkdir -p ~/.claude/skills

# Local
mkdir -p ./.claude/rules
```

#### 4.3: Copiar Archivo

```bash
# Global
cp /tmp/skill.md ~/.claude/skills/playwright-pom.md

# Local
cp /tmp/skill.md ./.claude/rules/playwright-pom.md
```

**Mostrar progreso**:
```
📥 Instalando "playwright-pom"...

✓ Descargando skill desde skills.sh
✓ Creando directorio ~/.claude/skills/
✓ Copiando archivo
✓ Verificando instalación

✅ Instalación completada
```

---

### Paso 5: Configurar paths: (Si Necesario)

**Detectar si la skill requiere paths:**

**Leer archivo instalado**:
```bash
cat ~/.claude/skills/playwright-pom.md
```

**Buscar frontmatter con paths:**
```yaml
---
name: playwright-pom
paths:
  - "tests/**/*.spec.ts"
  - "pages/**/*.ts"
---
```

**Si tiene paths: predefinidos**:
```
✅ Skill instalada con paths: configurados automáticamente

Paths detectados:
  • tests/**/*.spec.ts
  • pages/**/*.ts

Esta skill se activará en archivos que coincidan con estos patrones.
```

**Si NO tiene paths:**
```
⚙️ Configuración de paths:

Esta skill NO tiene paths: configurados.

Opciones:
1. Usar sin paths: (se activará siempre)
2. Configurar paths: manualmente (avanzado)
3. Configurar más tarde

Elige [1-3]: _
```

**Si elige "2. Configurar paths: manualmente"**:
```
📝 Configurar paths:

Introduce patrones de archivos (uno por línea, vacío para terminar):

Ejemplo:
  tests/**/*.spec.ts
  pages/**/*.ts

Path 1: tests/**/*.spec.ts
Path 2: pages/**/*.ts
Path 3: [Enter para terminar]

Guardando configuración...
```

**Actualizar archivo con paths:**
```bash
# Insertar frontmatter al inicio del archivo
cat > ~/.claude/skills/playwright-pom.md << 'EOF'
---
paths:
  - "tests/**/*.spec.ts"
  - "pages/**/*.ts"
---

# [Contenido original de la skill...]
EOF
```

---

### Paso 6: Verificar Instalación

**Verificar que el archivo existe**:
```bash
if [ -f ~/.claude/skills/playwright-pom.md ]; then
  echo "✅ Archivo creado correctamente"
else
  echo "❌ Error: Archivo no encontrado"
fi
```

**Leer metadata**:
```bash
# Extraer nombre y descripción del frontmatter
head -20 ~/.claude/skills/playwright-pom.md
```

**Confirmar al usuario**:
```
═══════════════════════════════════════════════════════════════
✅ Skill Instalada Exitosamente
═══════════════════════════════════════════════════════════════

Skill: playwright-pom
Descripción: Page Object Model patterns for Playwright
Ubicación: Global (~/.claude/skills/)
Archivo: ~/.claude/skills/playwright-pom.md
Paths: tests/**/*.spec.ts, pages/**/*.ts

La skill estará disponible en tu próxima sesión de Claude Code
o cuando recargues la ventana.

═══════════════════════════════════════════════════════════════
```

---

### Paso 6.5: Ofrecer Rule con Paths (Post-Instalación)

**Módulo**: `sections/15-module-post-install-rules.md`

Tras verificar la instalación, invocar el módulo 15 para ofrecer al usuario crear
una **rule con frontmatter `paths:`** en `.claude/rules/`.

Esto permite que la skill se active **solo al tocar ficheros específicos**
en vez de estar siempre activa (zero coste de contexto hasta activación).

**Flujo resumido**:
1. Preguntar si quiere crear rule con paths (recomendado)
2. Si acepta: sugerir globs inteligentes según tipo de skill
3. Detectar rules existentes (evitar duplicados, ofrecer agrupación)
4. Crear fichero `.claude/rules/<nombre>.md` con frontmatter correcto
5. Confirmar creación

**Ver flujo completo**: `sections/15-module-post-install-rules.md`

---

### Paso 7: Acciones Posteriores

**Preguntar al usuario**:
```
¿Qué deseas hacer ahora?

1. Instalar otra skill
2. Ver skills instaladas (listar)
3. Buscar más skills
4. Volver al menú principal

Elige [1-4]: _
```

---

## 🎨 Manejo de Errores

### Error 1: Skill No Encontrada

**npx skills falla**:
```bash
npx skills add non-existent-skill
# Error: Skill not found
```

**Mostrar**:
```
❌ Skill No Encontrada

La skill "non-existent-skill" no existe en skills.sh

Verificaciones:
  • ✓ Nombre correcto
  • ✓ Formato: nombre-skill (sin espacios)
  • ✓ Busca primero con "1. Buscar Skills"

¿Deseas buscar skills similares? [s/N]: _
```

### Error 2: Sin Permisos

**Falla al crear directorio**:
```bash
mkdir -p ~/.claude/skills
# Error: Permission denied
```

**Mostrar**:
```
❌ Error de Permisos

No se pudo crear el directorio ~/.claude/skills/

Solución:
  sudo chown -R $USER ~/.claude/

O instalar en ubicación local (./.claude/rules/)

¿Intentar instalación local? [s/N]: _
```

### Error 3: Network Error

**No se puede descargar**:
```
❌ Error de Conexión

No se pudo descargar la skill desde skills.sh

Posibles causas:
  • Sin conexión a internet
  • skills.sh temporalmente no disponible
  • Firewall bloqueando conexión

Soluciones:
  • Verifica tu conexión
  • Reintenta en unos momentos
  • Usa Backend Git en v2.2.0 (funciona offline)

¿Reintentar? [s/N]: _
```

---

## 🔧 Características Avanzadas

### Instalación en Batch (Futuro)

**Instalar múltiples skills de una vez**:
```
📥 Instalación en Batch

Skills a instalar:
  1. playwright-pom
  2. playwright-fixtures
  3. typescript-utils

Total: 3 skills
Ubicación: Global

¿Confirmar instalación? [s/N]: _

Instalando...
  ✓ playwright-pom
  ✓ playwright-fixtures
  ✓ typescript-utils

✅ 3 skills instaladas exitosamente
```

### Plantillas de paths: por Tipo de Proyecto

**Detectar tipo de proyecto** y sugerir paths:
```
📝 Paths: Sugeridos

Proyecto detectado: Playwright E2E

Paths recomendados:
  • tests/**/*.spec.ts
  • tests/**/*.test.ts
  • pages/**/*.ts
  • fixtures/**/*.ts

¿Usar estos paths:? [S/n]: _
```

---

## 🔗 Integración con Otros Módulos

### Con Módulo de Búsqueda (07)

```python
# Desde búsqueda
search_results = search("playwright")
user_selects = "2. Instalar una skill"

# Llamar instalación con contexto
install_module.run(
    skill_name=search_results[selected_index].name,
    from_search=True
)
```

### Con Módulo de Listar (09)

```python
# Antes de instalar, verificar duplicados
installed = list_module.get_installed_skills()

if skill_name in installed:
    handle_already_installed()
```

### Con Backend CLI (04)

```python
# Usar backend para instalación
backend = selector.get_backend()
result = backend.install(skill_name, location, config)
```

---

## 🎯 Reglas de Ejecución

1. **SIEMPRE verificar duplicados** antes de instalar
2. **Crear directorios** si no existen (mkdir -p)
3. **Validar instalación** después de copiar archivo
4. **Configurar paths:** si la skill lo requiere
5. **Confirmar al usuario** instalación exitosa con detalles
6. **Ofrecer acciones posteriores** (instalar otra, listar, etc.)
7. **Manejo robusto de errores** (network, permisos, skill no encontrada)

---

## 📊 Ejemplo Completo de Ejecución

```
Usuario: "2. Instalar Skill"

═══════════════════════════════════════════════════════════════
    📥 Instalar Skill
═══════════════════════════════════════════════════════════════

Skill: playwright-pom

Verificando...
⚠️ Skill ya instalada en Global

¿Reinstalar? [s/N]: s

───────────────────────────────────────────────────────────────

📍 Ubicación:
1. 🌍 Global (actual)
2. 📂 Local

Elige [1-2]: 1

───────────────────────────────────────────────────────────────

📥 Instalando "playwright-pom" en Global...

✓ Descargando desde skills.sh
✓ Creando directorio ~/.claude/skills/
✓ Copiando archivo
✓ Configurando paths: (automático)
  • tests/**/*.spec.ts
  • pages/**/*.ts
✓ Verificando instalación

═══════════════════════════════════════════════════════════════
✅ Skill Instalada Exitosamente
═══════════════════════════════════════════════════════════════

Skill: playwright-pom
Ubicación: ~/.claude/skills/playwright-pom.md
Paths: tests/**/*.spec.ts, pages/**/*.ts

═══════════════════════════════════════════════════════════════

¿Qué deseas hacer?
1. Instalar otra skill
2. Ver skills instaladas
3. Volver al menú

Elige [1-3]: _
```

---

**Módulo anterior**: 07-module-search.md
**Módulo siguiente**: 10-module-update.md
**Integra con**: 07-module-search.md, 09-module-list.md, 04-backend-cli.md
**Tarea**: #4 - Módulo Instalar (150 XP 💎)
