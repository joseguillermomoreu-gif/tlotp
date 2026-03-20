# 🧪 Test - Detector de Entorno Celebrimbor

## Objetivo

Probar el módulo de detección de entorno (Tarea #1).

---

## Test Suite

### Test 1: Detección de Node.js

**Ejecutar**:
```bash
node --version
npm --version
npx --version
```

**Validar**:
- Captura correcta de versiones
- Parseo de número mayor (ej: v20.11.0 → 20)
- Comparación con requisito (>=18)

---

### Test 2: Validación de skills CLI

**Ejecutar**:
```bash
npx skills --version
```

**Casos**:
1. ✅ **OK**: Skills funciona (Node >=18)
2. ❌ **Error**: SyntaxError (Node <18)
3. ❌ **No disponible**: Command not found

---

### Test 3: Reporte de Estado

**Generar reporte** con formato esperado:

```
🔮 Celebrimbor - Detección de Entorno ⚒️

Node.js:  vX.X.X   [✅/❌] (>= 18 requerido)
npm:      vX.X.X   ✅
npx:      [✅/❌]  Disponible
skills:   [✅/❌]  [Funcional/Error/No disponible]

Estado: [✅ Listo para Backend CLI / ❌ Acción requerida]
```

---

## Casos de Prueba

### Caso A: Entorno Ideal
- Node.js v20.11.0 ✅
- npm v10.2.4 ✅
- npx ✅
- skills v1.2.3 ✅
- **Resultado**: ✅ Listo para Backend CLI

### Caso B: Node.js Desactualizado (Actual)
- Node.js v12.22.9 ❌
- npm v8.5.1 ✅
- npx ✅
- skills ERROR ❌
- **Resultado**: ❌ Actualizar Node.js requerido

### Caso C: Node.js No Instalado
- Node.js NO DISPONIBLE ❌
- **Resultado**: ❌ Instalar Node.js >=18

---

## Ejecución del Test

**Cargar módulo de detección**:
```
@prompts/celebrimbor/sections/01-detector-entorno.md
```

**Ejecutar comandos de detección**

**Validar**:
1. Todas las versiones detectadas correctamente
2. Comparación con requisitos precisa
3. Reporte formateado correctamente
4. Indicadores ✅/❌ apropiados
5. Mensajes de acción claros

---

## Criterios de Éxito

- [ ] Detección de Node.js funciona en todos los casos
- [ ] Parseo de versiones correcto
- [ ] Validación de requisitos precisa
- [ ] Reporte visual claro y útil
- [ ] Mensajes de error/acción informativos
- [ ] No crash en ningún caso de borde

---

**Tarea**: #1 - Setup de Entorno y Node.js
**XP**: 80 XP (40 XP cada fundador)
**Estado**: 🧪 Testing
