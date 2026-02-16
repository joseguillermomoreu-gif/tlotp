# 📦 Backend Git - Celebrimbor

## Estado

🚧 **WIP - Disponible en TLOTP v2.2.0**

Este módulo define la arquitectura del Backend Git pero **NO se implementa** en v2.1.0 (MVP).

---

## Misión

Implementar backend que clona repositorio de skills y gestiona skills manualmente (sin Node.js).

---

## 🎯 Ventajas sobre Backend CLI

✅ **Sin dependencias de Node.js** - Solo requiere Git
✅ **Funciona offline** - Después del clone inicial
✅ **Control total** - Acceso directo a archivos .md
✅ **Más rápido** - No ejecuta npx en cada operación

---

## 🔧 Arquitectura (v2.2.0)

### Setup Inicial

**Primera ejecución**:
```bash
# Clonar repositorio de skills
git clone https://github.com/vercel-labs/skills.git ~/.celebrimbor/skills-repo

# Tamaño aproximado: 50MB
# Contiene todas las skills disponibles
```

**Estructura resultante**:
```
~/.celebrimbor/
├── config.yml              # Configuración de Celebrimbor
├── cache/                  # Cache de búsquedas
└── skills-repo/            # Repositorio clonado
    └── skills/
        ├── playwright-pom/
        │   └── SKILL.md
        ├── typescript-utils/
        │   └── SKILL.md
        └── ...
```

---

## 🔧 Implementación de Operaciones (Futuro)

### 1. **Buscar Skills**

**Comando**:
```bash
# Buscar en archivos locales
grep -r "playwright" ~/.celebrimbor/skills-repo/skills/*/SKILL.md
```

**Proceso**:
1. Leer índice local de skills
2. Filtrar por query
3. Parsear frontmatter YAML de cada SKILL.md
4. Retornar lista formateada

### 2. **Instalar Skill**

**Comando**:
```bash
# Copiar skill al destino
cp ~/.celebrimbor/skills-repo/skills/playwright-pom/SKILL.md \
   ~/.claude/skills/playwright-pom.md
```

**Proceso**:
1. Verificar que skill existe en repo local
2. Copiar SKILL.md al destino (global o local)
3. Configurar paths: si es necesario
4. Verificar instalación

### 3. **Listar Skills Instaladas**

**Comando**:
```bash
# Global
ls -1 ~/.claude/skills/*.md

# Local
ls -1 ./.claude/rules/*.md
```

**Proceso**: Igual que Backend CLI (lectura de directorios)

### 4. **Actualizar Skill**

**Comando**:
```bash
# Actualizar repositorio
cd ~/.celebrimbor/skills-repo
git pull origin main

# Re-copiar skill
cp skills/playwright-pom/SKILL.md ~/.claude/skills/playwright-pom.md
```

**Proceso**:
1. Git pull del repositorio
2. Re-copiar skill actualizada
3. Comparar versiones (fecha de modificación)

### 5. **Eliminar Skill**

**Comando**: Igual que Backend CLI
```bash
rm ~/.claude/skills/playwright-pom.md
```

---

## 🎨 Manejo de Errores (Futuro)

### Error: Git no instalado

**Acción**:
```
❌ Git no está disponible

Backend Git requiere Git instalado.

Instalar Git:
  Ubuntu: sudo apt install git
  macOS:  brew install git
  Windows: choco install git

Alternativa: Usa Backend CLI (requiere Node.js >=18)
```

### Error: Repositorio no clonado

**Acción**:
```
❌ Repositorio de skills no encontrado

Primera vez usando Backend Git:

Ejecutando: git clone https://github.com/vercel-labs/skills.git
Destino: ~/.celebrimbor/skills-repo
Tamaño: ~50MB
Tiempo estimado: 30 segundos

[Progreso del clone...]
```

### Error: Skill no existe

**Acción**: Similar a Backend CLI

---

## 🔗 Integración con Abstracción (Futuro)

**Implementa** la interfaz definida en `03-abstraction-layer.md`:

```yaml
backend_git:
  name: "git"
  available: true (si Git instalado)
  version: "1.0.0"

  operations:
    search:   grep + parseo local
    install:  cp de repo local
    list:     ls de directorios
    update:   git pull + re-copy
    remove:   rm manual
```

---

## 📦 Optimizaciones Futuras

### Índice Local Pre-generado

Para búsquedas más rápidas:

```yaml
# ~/.celebrimbor/skills-repo/index.yml
skills:
  - name: "playwright-pom"
    path: "skills/playwright-pom/SKILL.md"
    description: "Page Object Model for Playwright"
    author: "vercel-labs"
    updated_at: "2026-02-10"
```

### Actualización Incremental

```bash
# Solo actualizar si hay cambios
cd ~/.celebrimbor/skills-repo
git fetch origin
if [ $(git rev-parse HEAD) != $(git rev-parse origin/main) ]; then
  git pull
  echo "✅ Skills actualizadas"
else
  echo "✅ Ya tienes la última versión"
fi
```

---

## 🎯 Hooks Preparados (v2.1.0)

En la versión MVP (v2.1.0), este módulo existe pero **NO se implementa**.

**Mostrar al usuario**:
```
┌─────────────────────────────────────────────────────────────┐
│ 2. 📦 Backend Git (Sin Node.js)                             │
│    • 🚧 WIP - Disponible en TLOTP v2.2.0                    │
│    • Clona repositorio completo de skills                   │
│    • Funciona 100% offline después del setup                │
│    • Sin dependencias de Node.js                            │
└─────────────────────────────────────────────────────────────┘

⏳ Esta opción estará disponible pronto
```

---

## 📝 Tareas Pendientes para v2.2.0

- [ ] Implementar clone del repositorio
- [ ] Sistema de búsqueda local (grep + parseo)
- [ ] Instalación por copia de archivos
- [ ] Actualización con git pull
- [ ] Generación de índice local
- [ ] Tests exhaustivos
- [ ] Documentación completa

---

**Módulo anterior**: 04-backend-cli.md
**Módulo siguiente**: 06-backend-selector.md
**Versión**: Hooks preparados (implementación en v2.2.0)
