# 📋 Requisitos del Sistema - TLOTP

## 🔮 Palantír (Épica #1)

**Estado**: ✅ Completado (v1.7)

### Requisitos
- **Claude Code**: Cualquier versión
- **Bash**: Para operaciones de backup/recovery
- **Permisos**: Lectura/escritura en `~/.claude/` y proyecto actual

### Skills Requeridas
Ninguna - Palantír es standalone

---

## ⚒️ Celebrimbor (Épica #2)

**Estado**: 🚧 En desarrollo (v1.0 MVP)

### Requisitos v1.0 (Backend CLI)

#### Obligatorios
- **Node.js**: >= 18.0.0
- **npm**: >= 9.0.0 (incluido con Node.js)
- **npx**: Incluido con npm

#### Verificación Rápida

```bash
# Verificar versiones
node --version   # debe ser >= v18.0.0
npm --version    # debe ser >= 9.0.0
npx --version
```

#### Instalación/Actualización de Node.js

**Ubuntu/Debian**:
```bash
# Usando NodeSource
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
```

**macOS (Homebrew)**:
```bash
brew install node@20
```

**Windows (Chocolatey)**:
```bash
choco install nodejs-lts
```

**Alternativa: nvm (Node Version Manager)**:
```bash
# Instalar nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Instalar Node.js 20
nvm install 20
nvm use 20
```

### Requisitos v2.0 (Backend Git) - Futuro

#### Obligatorios
- **Git**: Cualquier versión reciente
- **Bash**: Para operaciones de clonación y copia

**Sin Node.js requerido** ✅

---

## 💍 Gollum (Épica #3)

**Estado**: ⏳ Planificado

### Requisitos Estimados
- Celebrimbor v1.0+ (completado)
- Skills de Playwright (instaladas vía Celebrimbor)
- Proyecto Playwright existente o nuevo

---

## 🏛️ Elrond (Épica #4)

**Estado**: ⏳ Planificado

### Requisitos Estimados
- Palantír v1.0+ (completado)
- Celebrimbor v1.0+ (completado)

---

## ⚡ Gandalf (Épica #5)

**Estado**: ⏳ Planificado

### Requisitos Estimados
- Todas las épicas anteriores completadas
- Proyecto PHP con Git
- GitHub CLI (`gh`) instalado

---

## 🎯 Requisitos Generales de TLOTP

### Obligatorios
- **Claude Code**: Versión con soporte de prompts .md
- **Bash**: Shell Unix/Linux (incluido en macOS)
- **Git**: Para control de versiones (recomendado)

### Recomendados
- **GitHub CLI** (`gh`): Para integración con GitHub
- **Editor de texto**: VSCode, vim, nano, etc.
- **Permisos**: Acceso de lectura/escritura en directorios de proyecto

---

## 📊 Matriz de Requisitos por Épica

| Épica | Claude Code | Bash | Git | Node.js >=18 | GitHub CLI |
|-------|-------------|------|-----|--------------|------------|
| 🔮 Palantír | ✅ | ✅ | - | - | - |
| ⚒️ Celebrimbor v1.0 | ✅ | ✅ | Rec. | ✅ | - |
| ⚒️ Celebrimbor v2.0 | ✅ | ✅ | ✅ | - | - |
| 💍 Gollum | ✅ | ✅ | Rec. | ✅* | - |
| 🏛️ Elrond | ✅ | ✅ | Rec. | ✅* | - |
| ⚡ Gandalf | ✅ | ✅ | ✅ | ✅* | ✅ |

**Leyenda**:
- ✅ = Obligatorio
- Rec. = Recomendado
- \* = Heredado de Celebrimbor
- \- = No requerido

---

*Última actualización: 2026-02-15*
*Épica actual: Celebrimbor (Tarea #1 - Setup)*
