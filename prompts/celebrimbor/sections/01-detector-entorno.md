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

**Formato de salida**:

```
🔮 Celebrimbor - Detección de Entorno ⚒️

Node.js:  v20.11.0  ✅ (>= 18 requerido)
npm:      v10.2.4   ✅
npx:      ✅ Disponible
skills:   v1.2.3    ✅ Funcional

Estado: ✅ Listo para Backend CLI
```

O si hay problemas:

```
🔮 Celebrimbor - Detección de Entorno ⚒️

Node.js:  v12.22.9  ❌ (>= 18 requerido)
npm:      v8.5.1    ✅
npx:      ✅ Disponible
skills:   ❌ Error (requiere Node.js >= 18)

⚠️ ACCIÓN REQUERIDA:
Node.js desactualizado. Actualiza a versión >= 18.

Opciones:
1. Instalar Node.js >= 18 y usar Backend CLI (Recomendado)
2. Esperar a Celebrimbor v2.0 con Backend Git (sin Node.js)

Instrucciones de actualización:
https://nodejs.org/en/download/package-manager
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
