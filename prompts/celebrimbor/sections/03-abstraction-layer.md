# 🔮 Capa de Abstracción - Celebrimbor

## Misión

Definir la interfaz común que AMBOS backends (CLI y Git) deben implementar.

---

## 🎯 Operaciones Comunes

Toda implementación de backend debe soportar estas operaciones:

### 1. **Buscar Skills**

**Input**:
- `query` (string): Término de búsqueda (ej: "playwright", "typescript")
- `filters` (opcional): Categoría, popularidad, etc.

**Output**:
```yaml
skills:
  - name: "playwright-pom"
    description: "Page Object Model para Playwright"
    author: "vercel-labs/skills"
    installs: 1523
    url: "https://skills.sh/vercel-labs/skills/playwright-pom"
  - name: "playwright-fixtures"
    description: "Custom fixtures para Playwright"
    author: "playwright-community"
    installs: 892
    url: "https://skills.sh/playwright-community/playwright-fixtures"
```

**Métodos**:
- `backend_cli.search(query, filters)` → Lista de skills
- `backend_git.search(query, filters)` → Lista de skills

---

### 2. **Instalar Skill**

**Input**:
- `skill_name` (string): Nombre de la skill (ej: "playwright-pom")
- `location` (string): "global" o "local"
  - global: `~/.claude/skills/`
  - local: `./.claude/rules/`
- `config` (opcional): Configuración de `paths:`

**Output**:
```yaml
status: "success" | "error"
message: "Skill installed successfully"
installed_path: "~/.claude/skills/playwright-pom.md"
```

**Métodos**:
- `backend_cli.install(skill_name, location, config)` → Status
- `backend_git.install(skill_name, location, config)` → Status

---

### 3. **Listar Skills Instaladas**

**Input**:
- `location` (opcional): "global", "local", o "all"

**Output**:
```yaml
skills:
  - name: "playwright-pom"
    location: "global"
    path: "~/.claude/skills/playwright-pom.md"
    installed_at: "2026-02-15"
    source: "vercel-labs/skills"
  - name: "php-symfony"
    location: "local"
    path: "./.claude/rules/php-symfony.md"
    installed_at: "2026-02-10"
    source: "custom"
```

**Métodos**:
- `backend_cli.list(location)` → Lista de skills instaladas
- `backend_git.list(location)` → Lista de skills instaladas

---

### 4. **Actualizar Skill**

**Input**:
- `skill_name` (string): Nombre de la skill
- `location` (string): "global" o "local"

**Output**:
```yaml
status: "success" | "error" | "already_latest"
message: "Skill updated to latest version"
previous_version: "2024-01-15"
new_version: "2026-02-15"
```

**Métodos**:
- `backend_cli.update(skill_name, location)` → Status
- `backend_git.update(skill_name, location)` → Status

---

### 5. **Eliminar Skill**

**Input**:
- `skill_name` (string): Nombre de la skill
- `location` (string): "global" o "local"

**Output**:
```yaml
status: "success" | "error"
message: "Skill removed successfully"
removed_path: "~/.claude/skills/playwright-pom.md"
```

**Métodos**:
- `backend_cli.remove(skill_name, location)` → Status
- `backend_git.remove(skill_name, location)` → Status

---

## 🔧 Estructura del Backend

Cada backend debe implementar:

```python
class Backend:
    def __init__(self):
        self.name = "cli" | "git"
        self.available = True | False
        self.version = "1.0.0"

    # CRUD Operations
    def search(query, filters=None) -> List[Skill]
    def install(skill_name, location, config=None) -> Status
    def list(location="all") -> List[InstalledSkill]
    def update(skill_name, location) -> Status
    def remove(skill_name, location) -> Status

    # Utility
    def is_available() -> bool
    def get_info() -> BackendInfo
```

---

## 🎯 Selector de Backend

**Lógica de selección**:

```yaml
1. Detectar entorno (módulo 01-detector-entorno.md)
2. Verificar disponibilidad de backends:
   - CLI: Node.js >=18 → available=True
   - Git: Git instalado → available=True
3. Si ambos disponibles:
   - Preguntar al usuario (AskUserQuestion)
   - Guardar preferencia en ~/.celebrimbor/config.yml
4. Si solo uno disponible:
   - Usar el disponible automáticamente
5. Si ninguno disponible:
   - Error: Instalar Node.js >=18 o Git
```

---

## 📦 Módulo Común

**Archivo**: `common-operations.md`

Operaciones que NO dependen del backend:
- Validar nombres de skills
- Formatear output
- Manejo de errores
- Logging
- Confirmaciones de usuario

---

## 🔗 Integración con Otros Módulos

### Con Detector de Entorno (01)
- Usa detección para determinar backends disponibles

### Con Menu Principal (02)
- Muestra opciones según backends disponibles

### Con Backend CLI (04)
- Implementa la interfaz para modo Node.js

### Con Backend Git (05)
- Implementa la interfaz para modo Git (v2.2.0)

### Con Selector (06)
- Usa la abstracción para elegir backend correcto

---

## 🎨 Principios de Diseño

1. **Backend-agnostic**: Los módulos superiores NO saben qué backend se usa
2. **Sustituibilidad**: Cambiar backend es transparente
3. **Extensibilidad**: Fácil añadir nuevos backends (npm, curl, etc.)
4. **Consistencia**: Misma UX independiente del backend
5. **Failover**: Si un backend falla, intentar con otro

---

## 📝 Ejemplo de Uso

```python
# Usuario ejecuta: Buscar skills de Playwright

# 1. Selector elige backend
backend = selector.get_backend()  # → backend_cli

# 2. Operación independiente del backend
skills = backend.search("playwright")

# 3. Resultado consistente
# Da igual si vino de CLI o Git, el formato es el mismo
```

---

**Siguiente módulo**: 04-backend-cli.md (Implementación CLI)
**Módulo relacionado**: 06-backend-selector.md (Selector)
