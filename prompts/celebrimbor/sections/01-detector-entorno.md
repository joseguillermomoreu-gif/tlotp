# 🔍 Detector de Entorno - Celebrimbor

## Misión

Detectar el entorno de ejecución y validar requisitos para Celebrimbor.

---

## Detección de Node.js

**Ejecutar comandos de detección**:

```bash
# Versión de Node.js
node --version

# Versión de npm
npm --version

# Versión de npx
npx --version
```

**Parsear versiones**:
- Extraer número de versión de Node.js (ej: v20.11.0 → 20)
- Validar si Node.js >= 18

---

## Validación de skills CLI

**Probar skills CLI**:

```bash
npx skills --version
```

**Estados posibles**:
- ✅ **OK**: skills CLI funciona (Node.js >=18)
- ❌ **Error**: Node.js desactualizado (<18)
- ❌ **No disponible**: npm/npx no instalado

---

## Reporte de Estado

### Caso 1: Node.js >= 18 ✅

**NO mostrar nada** - Continuar directo al menú de operaciones.

### Caso 2: Node.js < 18 ⚠️

```
⚠️ Node.js Desactualizado

Node.js detectado: v12.22.9
Requerido: >= v18.0.0

💡 Solución Rápida: ¿Tienes nvm instalado?

Ejecuta: nvm use 20 (o nvm use 18)

Esto cargará una versión compatible de Node.js y Celebrimbor
funcionará perfectamente.

¿Quieres que intente ejecutar 'nvm use 20' ahora? [s/N]: _
```

**Si usuario acepta**: Ejecutar `nvm use 20` y reintentar detección
**Si usuario rechaza**: Mostrar opciones alternativas

### Caso 3: Node.js NO disponible ❌

```
❌ Node.js No Detectado

Celebrimbor requiere Node.js >= 18 para el backend CLI.

Opciones:
1. Instalar Node.js >= 18 → Usar Celebrimbor ahora
   https://nodejs.org/

2. Esperar backend Git → Sin Node.js requerido (WIP)

🚧 Backend Git estará disponible en versión futura

No puedes continuar sin Node.js >= 18.
```

---

## Guardar Configuración

**Después de detección exitosa, guardar en archivo de estado**:

```bash
# Crear archivo de configuración
~/.celebrimbor/config.yml
```

**Contenido**:

```yaml
# Celebrimbor Configuration
version: "1.0"
backend: "cli"  # o "git" en v2.0
node_version: "20.11.0"
detected_at: "2026-02-15T10:30:00Z"
```

---

## Reglas de Ejecución

1. **SIEMPRE ejecutar detección al inicio** de Celebrimbor
2. **Mostrar reporte claro** con iconos ✅/❌
3. **Si Node.js < 18**: Informar y dar opciones (actualizar o esperar v2.0)
4. **Si todo OK**: Continuar con menú principal
5. **Guardar estado** para no repetir detección en cada ejecución

---

**Siguiente módulo**: 02-menu-principal.md
