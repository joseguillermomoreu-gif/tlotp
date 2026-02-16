# 🎯 Selector de Backend - Celebrimbor

## Misión

Detectar entorno y seleccionar el backend apropiado (CLI o Git) de forma inteligente.

---

## 🔍 Proceso de Selección

### PASO 1: Detección de Entorno

**Ejecutar módulo**: `01-detector-entorno.md`

**Capturar**:
- Node.js versión y disponibilidad
- npm/npx disponibilidad
- Git disponibilidad

**Resultado**:
```yaml
environment:
  node:
    available: true/false
    version: "20.11.0" | "12.22.9" | null
    meets_requirements: true/false  # >=18

  git:
    available: true/false
    version: "2.34.1" | null

  backends_available:
    - "cli"      # Si Node.js >=18
    - "git"      # Si Git disponible (v2.2.0)
```

---

### PASO 2: Verificar Preferencia Guardada

**Leer configuración**:
```bash
cat ~/.celebrimbor/config.yml
```

**Estructura**:
```yaml
# ~/.celebrimbor/config.yml
version: "1.0"
backend_preference: "cli" | "git" | null
last_used: "2026-02-15T10:30:00Z"
```

**Lógica**:
- Si `backend_preference` existe y backend disponible → Usar preferencia
- Si `backend_preference` no existe → Ir a PASO 3

---

### PASO 3: Selección Automática o Manual

#### Caso A: Ambos Backends Disponibles

**v2.1.0 (MVP)**: Solo CLI disponible
```
✅ Backend CLI disponible (Node.js v20.11.0)
🚧 Backend Git disponible en v2.2.0

Usando Backend CLI automáticamente.
```

**v2.2.0 (Futuro)**: Preguntar al usuario
```
🔮 Ambos backends disponibles

¿Qué backend prefieres usar?

1. ⚡ CLI (Node.js) - Recomendado
   • Rápido y selectivo
   • Acceso a 59,000+ skills
   • Búsqueda en tiempo real

2. 📦 Git (Universal)
   • Sin Node.js requerido
   • Funciona offline (después de setup inicial)
   • Control total de archivos

Elige [1-2]: _
```

**Guardar preferencia**:
```yaml
backend_preference: "cli"  # o "git"
```

#### Caso B: Solo CLI Disponible

```
✅ Usando Backend CLI

Node.js: v20.11.0 ✅
npm:     v10.2.4  ✅
skills:  Funcional ✅

Continuando con Backend CLI...
```

#### Caso C: Solo Git Disponible

**v2.1.0**: NO soportado (Git backend no implementado)
```
⚠️ Solo Git disponible

Node.js: v12.22.9 ❌ (requiere >=18)
Git:     v2.34.1  ✅

Backend Git estará disponible en TLOTP v2.2.0

Opciones:
1. Actualizar Node.js >=18 → Usar Backend CLI ahora
2. Esperar v2.2.0 → Usar Backend Git

Ver instrucciones: docs/REQUISITOS.md
```

**v2.2.0**: Usar Git automáticamente
```
✅ Usando Backend Git

Node.js: No disponible
Git:     v2.34.1 ✅

Continuando con Backend Git...
```

#### Caso D: Ningún Backend Disponible

```
❌ No hay backends disponibles

Node.js: No instalado (requiere >=18)
Git:     No instalado

ACCIÓN REQUERIDA:

Opción 1: Instalar Node.js >=18
  → Usar Backend CLI (recomendado)
  → Instrucciones: docs/REQUISITOS.md

Opción 2: Instalar Git
  → Usar Backend Git (v2.2.0)
  → Más simple, sin Node.js

No puedes continuar sin al menos uno de ellos.
```

---

## 🎯 API del Selector

### get_backend()

**Retorna**: Objeto backend seleccionado

```python
backend = selector.get_backend()

# Retorna:
backend = {
  "type": "cli" | "git",
  "available": true,
  "version": "1.0.0",
  "operations": {
    "search": function,
    "install": function,
    "list": function,
    "update": function,
    "remove": function
  }
}
```

### set_preference(backend_type)

**Guarda** preferencia de usuario

```python
selector.set_preference("cli")

# Escribe en ~/.celebrimbor/config.yml:
backend_preference: "cli"
last_updated: "2026-02-15T10:30:00Z"
```

### reset_preference()

**Borra** preferencia guardada

```python
selector.reset_preference()

# Elimina backend_preference de config.yml
# Próxima ejecución preguntará de nuevo
```

---

## 📦 Archivo de Configuración

**Ubicación**: `~/.celebrimbor/config.yml`

**Crear si no existe**:
```bash
mkdir -p ~/.celebrimbor
touch ~/.celebrimbor/config.yml
```

**Estructura completa**:
```yaml
# Celebrimbor Configuration
version: "1.0"

# Backend Selection
backend_preference: "cli"  # null | "cli" | "git"
backend_last_used: "2026-02-15T10:30:00Z"

# Environment Detection (cache)
environment:
  node_version: "20.11.0"
  git_version: "2.34.1"
  detected_at: "2026-02-15T10:00:00Z"

# Cache Settings
cache:
  skills_index_ttl: 3600  # 1 hora
  environment_check_ttl: 86400  # 24 horas
```

---

## 🔗 Integración con Otros Módulos

### Con Detector de Entorno (01)

```python
# Selector usa detección
env_data = detector.detect()
backends = selector.get_available_backends(env_data)
```

### Con Backend CLI (04)

```python
if backend.type == "cli":
    # Cargar módulo 04-backend-cli.md
    skills = backend.search("playwright")
```

### Con Backend Git (05)

```python
if backend.type == "git":
    # Cargar módulo 05-backend-git.md
    skills = backend.search("playwright")
```

### Con Menú Principal (02)

```python
# Menú adapta opciones según backend seleccionado
backend = selector.get_backend()
menu.show_options(backend)
```

---

## 🎨 Experiencia de Usuario

### Primera Ejecución

```
🔮 Celebrimbor - Detección de Entorno ⚒️

Detectando configuración...

Node.js: v20.11.0  ✅ (>= 18 requerido)
npm:     v10.2.4   ✅
skills:  v1.2.3    ✅ Funcional

✅ Backend CLI disponible

Usando Backend CLI por defecto.
(Puedes cambiar esto en cualquier momento)

Continuando...
```

### Ejecuciones Posteriores

```
🔮 Celebrimbor ⚒️

Backend: CLI ⚡ (Node.js v20.11.0)

[Menú principal...]
```

### Cambiar Backend Manualmente

```
Opciones:

1. Buscar skills
2. Instalar skill
...
8. ⚙️ Cambiar backend
9. 🚪 Salir

Elige [1-9]: 8

Backends disponibles:
1. ⚡ CLI (actual)
2. 📦 Git (disponible en v2.2.0)

¿Cambiar a otro backend? [s/N]: _
```

---

## 🎯 Reglas de Ejecución

1. **SIEMPRE ejecutar detección** al inicio (usa cache si <24h)
2. **Respetar preferencia** guardada si backend disponible
3. **Preguntar solo una vez** (guardar respuesta)
4. **Failover automático** si backend preferido falla
5. **Transparencia total** al usuario sobre qué backend se usa

---

**Módulo anterior**: 05-backend-git.md
**Módulos utilizados**: 01-detector-entorno.md, 04-backend-cli.md, 05-backend-git.md
**Integra con**: 02-menu-principal.md
