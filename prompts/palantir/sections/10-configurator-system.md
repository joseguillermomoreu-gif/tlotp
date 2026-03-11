# ⚙️ Sistema de Configuración Asistida

Este módulo se ejecuta cuando el usuario selecciona "Configurar característica" en el menú principal.

---

## 📋 Información de Contexto

**IMPORTANTE**: Este módulo usa la información oficial de Claude Code Memory ya cargada en el entry point:

La información de `prompts/info_claude.md` está disponible para explicar al usuario para qué sirve cada fichero.

---

## 📍 PASO 1: Solicitar Característica

Mostrar mensaje:

```markdown
═══════════════════════════════════════════════════════════

              ⚙️ CONFIGURACIÓN ASISTIDA

═══════════════════════════════════════════════════════════

¿Qué característica o preferencia deseas añadir a tu
configuración de Claude Code?

Ejemplos:
- "Quiero que Claude use pytest para testing en Python"
- "Añadir regla: usar TypeScript strict mode"
- "Preferencia: commits en español"
- "Usar Tailwind CSS para estilos"

═══════════════════════════════════════════════════════════

Describe la característica que quieres añadir:
```

**Obtener input del usuario**: Leer la descripción de la característica

---

## 🔍 PASO 2: Fase de Investigación

### A. Consultar Documentación Oficial

**Consultar `info_claude.md`** para determinar:

1. **Tipo de configuración**:
   - ¿Es preferencia general? → User/Project Memory
   - ¿Es regla para archivos específicos? → Rules
   - ¿Es comportamiento al inicio? → Memory
   - ¿Es skill/herramienta? → Skills (mencionar, no crear)

2. **Archivo correcto**:
   - Global (todos proyectos): `~/.claude/CLAUDE.md`
   - Proyecto específico: `./CLAUDE.md`
   - Reglas con paths: `./.claude/rules/{nombre}.md`
   - Local (git-ignored): `./CLAUDE.local.md`

3. **Formato apropiado**:
   - Memory: Markdown con secciones
   - Rules: YAML frontmatter + Markdown
   - Estructura según documentación oficial

### B. Detectar si Ya Existe

**Leer archivos relevantes** para buscar características similares:

```bash
# Leer archivos según el tipo detectado
if tipo == "global":
    leer ~/.claude/CLAUDE.md
if tipo == "proyecto":
    leer ./CLAUDE.md
if tipo == "regla":
    leer ./.claude/rules/*.md
```

**Buscar características similares**:
- Palabras clave relacionadas
- Frameworks/herramientas mencionados
- Preferencias del mismo ámbito

**Si encuentra similar**:
```markdown
⚠️ Característica Similar Detectada

Se encontró configuración similar en {ARCHIVO}:

{PREVIEW_DE_LO_EXISTENTE}
```

Usar `AskUserQuestion`:
```
header: "Característica similar"
question: "¿Qué deseas hacer?"
multiSelect: false
options:
  1. label: "Actualizar la existente"
     description: "Reemplazar con la nueva versión"

  2. label: "Crear adicional"
     description: "Mantener ambas características"

  3. label: "Combinar ambas"
     description: "Merge inteligente de ambas versiones"

  4. label: "Cancelar"
     description: "No añadir nada"
```

Si elige "Cancelar" → Abortar proceso completo

### C. ⚠️ NUEVO: Detectar Conflictos o Contradicciones

**Buscar características que puedan entrar en conflicto**:

**Tipos de conflictos a detectar**:

1. **Conflicto de Framework/Herramienta**:
   ```
   Existente: "Usar PHPUnit para testing PHP"
   Nueva:     "Usar Pest para testing PHP"
   → CONFLICTO: Ambas definen framework de testing
   ```

2. **Conflicto de Configuración**:
   ```
   Existente: "TypeScript: permitir any"
   Nueva:     "TypeScript strict mode (no any)"
   → CONFLICTO: Configuraciones contradictorias
   ```

3. **Conflicto de Preferencia**:
   ```
   Existente: "Commits en inglés"
   Nueva:     "Commits en español"
   → CONFLICTO: Preferencias contradictorias
   ```

4. **Conflicto de Comportamiento**:
   ```
   Existente: "Crear branches automáticamente"
   Nueva:     "Preguntar siempre antes de crear branch"
   → CONFLICTO: Comportamientos opuestos
   ```

**Lógica de detección**:
- Analizar secciones del archivo actual
- Identificar keywords de la nueva característica
- Buscar keywords similares o relacionados en existente
- Detectar negaciones o contradicciones
- Listar todos los conflictos encontrados

**Si se detectan conflictos** → Ir a PASO 3 (Resolución de Conflictos)
**Si NO hay conflictos** → Ir a PASO 4 (Preguntar Detalles)

---

## ⚔️ PASO 3: Fase de Detección y Resolución de Conflictos

**SOLO si se detectaron conflictos en el paso anterior.**

### A. Mostrar Conflictos Encontrados

```markdown
═══════════════════════════════════════════════════════════

            ⚠️ CONFLICTOS DETECTADOS

═══════════════════════════════════════════════════════════

Se encontraron {N} características que pueden entrar en
conflicto con la nueva configuración:

───────────────────────────────────────────────────────────

⚔️ CONFLICTO 1: {TIPO_CONFLICTO}

📍 Existente en {ARCHIVO}, {SECCION}:
"{CONTENIDO_EXISTENTE}"

🆕 Nueva característica:
"{NUEVA_CARACTERISTICA}"

💡 Problema:
{EXPLICACION_DEL_CONFLICTO}

───────────────────────────────────────────────────────────

[Repetir para cada conflicto detectado]

═══════════════════════════════════════════════════════════
```

### B. ⚒️ Sistema de Propuestas Iterativo

**Inicializar contador de propuestas**: `propuestaNum = 1`

**WHILE (usuario NO acepta Y NO cancela)**:

#### 1. Generar Propuesta de Combinación

**Estrategias de combinación** (rotar entre ellas):

**Propuesta #1 - Unificar con Contexto**:
```markdown
═══════════════════════════════════════════════════════════

          💡 PROPUESTA DE COMBINACIÓN #{NUM}

═══════════════════════════════════════════════════════════

📋 Estrategia: Unificar con contexto específico

Para: {NOMBRE_CONFLICTO}

Propuesta:
- Mantener nueva característica como principal
- Conservar existente como alternativa/contexto
- Nuevo formato:

{PREVIEW_DE_COMBINACION}

Ejemplo:
## Testing PHP

- **Framework preferido**: Pest (nuevo, más expresivo)
- **Fallback**: PHPUnit (proyectos legacy existentes)
- **Migración gradual**: Nuevos tests en Pest

═══════════════════════════════════════════════════════════
```

**Propuesta #2 - Priorizar Nuevo, Archivar Antiguo**:
```markdown
═══════════════════════════════════════════════════════════

          💡 PROPUESTA DE COMBINACIÓN #{NUM}

═══════════════════════════════════════════════════════════

📋 Estrategia: Priorizar nuevo, archivar antiguo

Para: {NOMBRE_CONFLICTO}

Propuesta:
- Usar nueva característica como única activa
- Comentar/archivar configuración antigua
- Añadir nota de cambio

Resultado:
{PREVIEW_DE_COMBINACION}

Ejemplo:
## Testing PHP

- **Framework**: Pest
- **Sintaxis**: Expresiva, estilo BDD

<!--
ARCHIVADO 2026-02-14:
Anteriormente se usaba PHPUnit.
Migrado a Pest para mayor expresividad.
-->

═══════════════════════════════════════════════════════════
```

**Propuesta #3 - Mantener Ambas con Contextos**:
```markdown
═══════════════════════════════════════════════════════════

          💡 PROPUESTA DE COMBINACIÓN #{NUM}

═══════════════════════════════════════════════════════════

📋 Estrategia: Mantener ambas con contextos separados

Para: {NOMBRE_CONFLICTO}

Propuesta:
- Mantener ambas características
- Separar por contexto (proyecto/tipo/caso)
- Clarificar cuándo usar cada una

Resultado:
{PREVIEW_DE_COMBINACION}

Ejemplo:
## Commits

- **Idioma por defecto**: Español
  - Proyectos personales: Español
  - Proyectos open-source: Español (README en inglés)
  - Proyectos internacionales: Inglés (consultar README)

═══════════════════════════════════════════════════════════
```

**Propuesta #4+ - Opciones Adicionales**:
- Crear estructura condicional (if/then)
- Usar variables de configuración
- Separar en archivos diferentes (.local vs compartido)
- Delegar decisión al contexto del proyecto

#### 2. Preguntar al Usuario

Usar `AskUserQuestion`:
```
header: "Propuesta #{NUM}"
question: "¿Aceptas esta propuesta para resolver los conflictos?"
multiSelect: false
options:
  1. label: "Sí, aceptar propuesta"
     description: "Aplicar la combinación propuesta"

  2. label: "No, generar otra propuesta"
     description: "Mostrar alternativa diferente"

  3. label: "Modificar manualmente"
     description: "Describirme cómo quieres combinarlo"

  4. label: "Cancelar todo el proceso"
     description: "No añadir la nueva característica"
```

#### 3. Procesar Respuesta

**Si elige "Sí, aceptar propuesta"**:
- Guardar combinación aceptada
- **SALIR del loop**
- Continuar a PASO 4

**Si elige "No, generar otra propuesta"**:
- Incrementar `propuestaNum++`
- Generar nueva propuesta con estrategia diferente
- **CONTINUAR en el loop**

**Si elige "Modificar manualmente"**:
```markdown
Describe cómo quieres combinar estas características:

(Esperando input del usuario...)
```

Leer input del usuario y generar propuesta según su descripción.

Preguntar confirmación:
```
¿Esta propuesta basada en tu descripción está correcta?
1. Sí, aceptar
2. No, ajustar
3. Cancelar
```

**Si elige "Cancelar todo el proceso"**:
```markdown
❌ Proceso de configuración cancelado

No se han realizado cambios en tus archivos de configuración.

Puedes volver a intentarlo cuando quieras resolviendo
los conflictos de otra manera.
```

**SALIR del loop y ABORTAR PROCESO COMPLETO**

---

## 📝 PASO 4: Preguntar Detalles Necesarios

**Si NO hubo conflictos O si los conflictos fueron resueltos:**

Usar `AskUserQuestion`:

```
header: "Alcance de la característica"
question: "¿A qué debe aplicar esta característica?"
multiSelect: true
options:
  1. label: "Todos los proyectos"
     description: "Guardar en User Memory (~/.claude/CLAUDE.md)"

  2. label: "Solo este proyecto"
     description: "Guardar en Project Memory (./CLAUDE.md)"

  3. label: "Ejecutar al inicio de sesión"
     description: "Añadir a comportamiento de inicio"

  4. label: "Aplicar a archivos específicos"
     description: "Crear rule con paths (si aplica)"
```

**Si elige opción 4** (archivos específicos):

```
header: "Paths específicos"
question: "¿A qué archivos debe aplicar esta regla?"
multiSelect: false
options:
  1. label: "Escribir paths manualmente"
     description: "Especificaré los paths (ej: src/**/*.ts)"

  2. label: "Detectar automáticamente"
     description: "Claude detectará los paths según el proyecto"
```

Si elige "Escribir manualmente":
```markdown
Especifica los paths (uno por línea, usa glob patterns):

Ejemplos:
- src/**/*.ts
- tests/**/*.spec.js
- **/*.py

Paths:
```

---

## 🎯 PASO 5: Fase de Análisis

### A. Determinar Ubicación Correcta

```python
def determinarUbicacion(caracteristica, alcance):
    if alcance.includes("Todos los proyectos"):
        return "~/.claude/CLAUDE.md"
    elif alcance.includes("Solo este proyecto"):
        return "./CLAUDE.md"
    elif alcance.includes("Aplicar a archivos específicos"):
        return "./.claude/rules/{nombre_de_la_regla}.md"
    elif alcance.includes("Local/Git-ignored"):
        return "./CLAUDE.local.md"
```

### B. Determinar Sección Correcta

**Analizar la característica y determinar sección**:

- Framework/Librería → `## Stack Tecnológico`
- Preferencia de código → `## Preferencias de Código`
- Naming convention → `## Naming Conventions` o dentro de Preferencias
- Comportamiento → `## Comportamiento` o sección específica
- Testing → `## Testing` o dentro de Stack
- Nueva categoría → Preguntar al usuario

**Si la sección no existe en el archivo**:
```
header: "Nueva sección"
question: "La sección recomendada '{SECCION}' no existe. ¿Crearla?"
options:
  1. label: "Sí, crear sección"
     description: "Crear '{SECCION}' en el orden correcto"

  2. label: "Usar sección existente"
     description: "Elegir otra sección del archivo"

  3. label: "Cancelar"
     description: "No añadir la característica"
```

### C. Construir Contenido

**Según el tipo de archivo**:

**Para User/Project Memory (.md)**:
```markdown
## {SECCION}

- **{Título}**: {Descripción}
  - {Detalles}
  - {Ejemplos si aplica}
```

**Para Rules (.md con frontmatter)**:
```markdown
---
paths:
  - "{PATH1}"
  - "{PATH2}"
---

# {Título de la Regla}

{Descripción de la regla}

Ejemplo:
\`\`\`{lenguaje}
{Código de ejemplo}
\`\`\`
```

---

## ✅ PASO 6: Fase de Confirmación

### A. Mostrar Resumen Completo

```markdown
═══════════════════════════════════════════════════════════

              📝 RESUMEN DE CONFIGURACIÓN

═══════════════════════════════════════════════════════════

📋 Característica:
{DESCRIPCION_DE_LA_CARACTERISTICA}

📂 Se guardará en:
Archivo: {ARCHIVO}
Sección: {SECCION}
Formato: {FORMATO}

📚 Según documentación oficial:
{EXTRACT_DE_INFO_CLAUDE_MD}

{Si hubo conflictos resueltos:}
⚔️ Conflictos resueltos: {N}
💡 Estrategia aplicada: {ESTRATEGIA}

───────────────────────────────────────────────────────────

💡 Reestructuración del fichero:

Usando la documentación oficial de Claude Code, se
reestructurará el archivo para que la nueva característica
quede en el orden correcto según las mejores prácticas.

═══════════════════════════════════════════════════════════
```

### B. ⚒️ Reestructuración con Documentación Oficial

**Consultar `info_claude.md`** para determinar orden ideal de secciones:

```python
def consultarOrdenIdeal(tipoArchivo):
    """
    Según info_claude.md, el orden recomendado es:

    Para User/Project Memory:
    1. Perfil/Introducción
    2. Stack Tecnológico
    3. Preferencias de Código
    4. Naming Conventions
    5. Arquitectura
    6. Skills/Herramientas
    7. Comandos/Workflows
    8. Notas/Otros

    Para Rules:
    1. Frontmatter YAML (paths)
    2. Título principal
    3. Descripción
    4. Reglas específicas
    5. Ejemplos
    """
```

**Extraer secciones actuales del archivo**:
```bash
# Leer archivo completo
contenido = leer(archivo)

# Extraer secciones por headings (##)
secciones = extraerSecciones(contenido)
```

**Añadir nueva característica a la lista de secciones**:
```python
secciones.append({
    "nombre": seccionNombre,
    "contenido": contenidoNuevo,
    "orden": determinarOrden(seccionNombre, ordenIdeal)
})
```

**Reordenar según documentación oficial**:
```python
seccionesOrdenadas = ordenarPorDocumentacion(secciones, ordenIdeal)
```

**Mostrar orden propuesto**:
```markdown
Orden propuesto según documentación oficial:

1. ## Stack Tecnológico (existente)
2. ## Preferencias de Código (existente)
3. ## Testing (NUEVA - se insertará aquí) ← AQUÍ
4. ## Naming Conventions (existente)
5. ## Comandos rápidos (existente)

───────────────────────────────────────────────────────────
```

### C. Vista Previa de la Edición Completa

**Reconstruir archivo con el nuevo orden**:
```python
archivoReconstruido = reconstruirArchivo(seccionesOrdenadas)
```

**Mostrar preview** (primeras 30 líneas + resumen):

```markdown
📄 Vista previa de la EDICIÓN COMPLETA:

═══════════════════════════════════════════════════════════

{PRIMERAS_30_LINEAS_DEL_ARCHIVO_RESULTANTE}

...

{RESUMEN_DEL_RESTO}

Total: {N} líneas
Secciones: {LISTA_DE_SECCIONES}

═══════════════════════════════════════════════════════════
```

### D. ⚠️ CRÍTICO - Confirmación Final

Usar `AskUserQuestion`:
```
header: "Confirmación final"
question: "¿Aplicar esta edición al archivo?"
multiSelect: false
options:
  1. label: "Sí, aplicar"
     description: "Guardar los cambios propuestos"

  2. label: "Modificar propuesta"
     description: "Ajustar algo antes de aplicar"

  3. label: "Cancelar TODO el proceso"
     description: "No realizar ningún cambio"
```

**Si elige "Modificar propuesta"**:
```markdown
¿Qué deseas modificar?

1. Cambiar ubicación (archivo/sección)
2. Cambiar contenido de la característica
3. Cambiar orden de secciones
4. Ver preview completo del archivo
5. Cancelar modificación (volver a confirmación)
```

**Si elige "Cancelar TODO el proceso"**:
```markdown
❌ Proceso de configuración cancelado

No se han realizado cambios en tus archivos de configuración.

Todo el proceso se ha abortado:
- NO se ha escrito ningún archivo
- NO se ha modificado ninguna configuración
- El archivo permanece sin cambios
```

**ABORTAR PROCESO COMPLETO**

---

## ⚒️ PASO 7: Fase de Aplicación

**SOLO si el usuario aceptó en la confirmación final.**

### A. Usar Motor de Reconstrucción

**Según instrucciones de `09-reconstruction-engine.md`**:

1. **Leer archivo actual** completamente

2. **Preparar plan de reconstrucción**:

```python
reconstructionPlan = {
    archivoPath: {
        "fileType": tipoArchivo,
        "preferences": []
    }
}

# Por cada sección del archivo reconstruido
for seccion in seccionesOrdenadas:
    reconstructionPlan[archivoPath]["preferences"].append({
        "id": seccionId,
        "content": seccion.contenido,
        "type": "section",
        "metadata": {
            "sectionName": seccion.nombre,
            "origin": "existente" if seccion.existente else "nueva",
            "order": seccion.orden
        }
    })
```

3. **Purificación**:

```bash
# Vaciar o borrar archivo según tipo
if tipoArchivo in ["user-memory", "project-memory"]:
    echo "" > archivo  # Vaciar
else:
    rm archivo  # Borrar (si es nuevo)
```

4. **Reconstrucción**:

Por cada preferencia/sección en el plan:
- Validar estructura
- Escribir correctamente
- Notificar progreso

```markdown
⚒️ Reconstruyendo archivo...

✓ Sección 1/5: Stack Tecnológico (existente)
✓ Sección 2/5: Preferencias de Código (existente)
✓ Sección 3/5: Testing (NUEVA) ← Añadida
✓ Sección 4/5: Naming Conventions (existente)
✓ Sección 5/5: Comandos rápidos (existente)
```

5. **Validación**:

```python
# Validar estructura según tipo de archivo
if tipoArchivo == "memory":
    validarMarkdown(archivoResultante)
elif tipoArchivo == "rule":
    validarYAMLFrontmatter(archivoResultante)
    validarMarkdown(archivoResultante)
```

6. **Escribir archivo**:

```bash
# Usar Write tool para escribir el archivo reconstruido
Write(archivoPath, contenidoReconstruido)
```

7. **Verificar resultado**:

```bash
# Leer archivo resultante para validar
contenidoFinal = Read(archivoPath)

# Validar que se escribió correctamente
if validarContenido(contenidoFinal):
    ✅ Validación exitosa
else:
    ⚠️ Advertir al usuario
```

---

## ✅ PASO 8: Notificación Final

```markdown
═══════════════════════════════════════════════════════════

          ✅ CONFIGURACIÓN APLICADA EXITOSAMENTE

═══════════════════════════════════════════════════════════

📁 Archivo actualizado: {ARCHIVO}
📑 Sección: {SECCION}
📊 Contenido añadido: {LINES} líneas
⚒️ Archivo reestructurado según documentación oficial

{Si hubo conflictos:}
⚔️ Conflictos resueltos: {N}
💡 Estrategia: {ESTRATEGIA}

{Si hubo reestructuración:}
📐 Secciones reordenadas: {N}
💡 Orden aplicado según info_claude.md

───────────────────────────────────────────────────────────

💡 La configuración ya está activa.
   Se aplicará en la próxima sesión de Claude Code.

{Si es User Memory:}
⚙️ Aplica a TODOS los proyectos

{Si es Project Memory:}
📂 Aplica solo a este proyecto

{Si es Rule:}
📝 Aplica a archivos: {PATHS}

═══════════════════════════════════════════════════════════

             ✅ Configuración Completada

    Palantír (TLOTP) v1.7 - "Configuration Assistant"

═══════════════════════════════════════════════════════════
```

### Preguntar si Añadir Otra Configuración

Después de mostrar la notificación de éxito, preguntar al usuario:

Usar `AskUserQuestion`:
```
header: "Continuar configurando"
question: "¿Qué deseas hacer ahora?"
multiSelect: false
options:
  1. label: "➕ Añadir otra característica"
     description: "Configurar una característica adicional"

  2. label: "🔙 Volver al menú de Palantír"
     description: "Volver al menú principal para cambiar de modo"

  3. label: "🚪 Finalizar"
     description: "Terminar y salir del Configurador"
```

**Si elige "➕ Añadir otra característica"**:
- **Volver al PASO 1** (Solicitar Característica)
- Reiniciar el flujo completo del configurador
- Mantener contexto de lo ya configurado

**Si elige "🔙 Volver al menú de Palantír"**:
- Ejecutar el flujo de `00-menu-principal.md` desde el PASO 2 (menú)
- Saltar el PASO 1.5 de permisos (ya pre-aprobados en esta sesión)

**Si elige "🚪 Finalizar"**:
- Mostrar mensaje final y terminar:

```markdown
═══════════════════════════════════════════════════════════

              👋 Configurador Finalizado

Se configuraron correctamente las características solicitadas.

Todas las configuraciones están activas y se aplicarán
en la próxima sesión de Claude Code.

Puedes ejecutar Palantír nuevamente cuando necesites:
- Inspeccionar configuraciones
- Resetear configuraciones
- Recuperar desde backup
- Añadir nuevas características

═══════════════════════════════════════════════════════════
```

---

## 🚫 Cancelación en Cualquier Momento

El usuario puede cancelar en cualquier momento:
- Respondiendo "cancelar" en cualquier pregunta
- Eligiendo "Cancelar" en AskUserQuestion
- Eligiendo "Cancelar TODO el proceso" en confirmación final

**Al cancelar, mostrar**:

```markdown
❌ Configuración cancelada

Fase cancelada: {FASE_ACTUAL}

No se han realizado cambios en tus archivos de configuración.

Puedes ejecutar el Configurador nuevamente cuando quieras.
```

**IMPORTANTE**: Si se cancela en cualquier punto:
- NO escribir NINGÚN archivo
- NO modificar NINGUNA configuración
- Abortar completamente el proceso

---

## 📝 Reglas de Implementación

1. **Validar en cada paso**: Siempre verificar datos antes de continuar

2. **Contexto completo**: Mostrar información de documentación oficial

3. **Detección de conflictos exhaustiva**: No asumir, buscar todos los posibles conflictos

4. **Propuestas iterativas**: Continuar generando alternativas hasta que usuario acepte o cancele

5. **Reestructuración obligatoria**: SIEMPRE consultar `info_claude.md` para orden correcto

6. **Preview antes de aplicar**: SIEMPRE mostrar vista previa del resultado final

7. **Confirmación crítica**: Si usuario rechaza confirmación final, NO aplicar NADA

8. **Uso del Motor de Reconstrucción**: SIEMPRE usar `09-reconstruction-engine.md`

9. **Validación post-aplicación**: Verificar que el archivo se escribió correctamente

10. **Notificaciones claras**: Informar en cada paso qué se está haciendo

---

## 💡 Estrategias por Tipo de Archivo

### User/Project Memory (CLAUDE.md)

**Identificar secciones**: Por headings markdown (##, ###)

**Orden recomendado**:
1. Perfil/Introducción
2. Stack Tecnológico
3. Preferencias de Código
4. Naming Conventions
5. Arquitectura
6. Skills Especializados
7. Comandos rápidos
8. Meta-instrucciones

**Inserción**: En la sección correspondiente, en orden lógico/alfabético

### Rules (rules/*.md)

**Estructura**:
```yaml
---
paths:
  - "src/**/*.ts"
  - "tests/**/*.spec.ts"
---

# Título de la Regla

Descripción

Ejemplos
```

**Validación**:
- Frontmatter YAML válido
- Paths correctos (glob patterns)
- Markdown bien formateado

### Project Local (CLAUDE.local.md)

**Características**:
- NO commitear a git (git-ignored)
- Preferencias locales/personales
- Sobrescribe configuraciones globales

**Uso**: Para experimentos, configuraciones temporales

---

## 🔍 Ejemplos de Detección de Conflictos

### Ejemplo 1: Framework de Testing

```
Existente (línea 45):
"## Testing PHP
- Framework: PHPUnit
- Coverage mínima: 80%"

Nueva característica:
"Usar Pest para testing PHP"

Análisis:
- Keywords: "testing", "PHP", "framework"
- Conflicto: Ambas definen framework de testing PHP
- Tipo: Conflicto de herramienta

Propuesta #1:
"## Testing PHP
- Framework preferido: Pest (nuevo)
- Fallback: PHPUnit (legacy)
- Migración gradual"
```

### Ejemplo 2: Idioma de Commits

```
Existente (línea 120):
"## Convenciones Git
- Commits en inglés
- Formato: type(scope): message"

Nueva característica:
"Commits en español"

Análisis:
- Keywords: "commits", "idioma"
- Conflicto: Idioma contradictorio
- Tipo: Conflicto de preferencia

Propuesta #1:
"## Convenciones Git
- Idioma: Español
  - Proyectos personales: Español
  - Proyectos open-source: Inglés
- Formato: type(scope): message"
```

### Ejemplo 3: TypeScript Strict Mode

```
Existente (línea 78):
"## TypeScript
- Permitir 'any' en casos necesarios
- Flexible para prototipado rápido"

Nueva característica:
"TypeScript strict mode (no any)"

Análisis:
- Keywords: "TypeScript", "any", "strict"
- Conflicto: Configuración contradictoria
- Tipo: Conflicto de configuración

Propuesta #1:
"## TypeScript
- Modo: Strict (preferido)
  - Producción: strict mode siempre
  - Prototipado: permitir any temporalmente
  - Refactorizar antes de production"
```

---

*Sistema de Configuración Asistida - Palantír v1.7*
*Crear y añadir características con detección de conflictos*
