# 🔄 Sistema de Reset de Configuraciones

Este módulo se ejecuta cuando el usuario selecciona "Reset de configuraciones" en el menú principal.

---

## 📋 Información de Contexto

**IMPORTANTE**: Antes de iniciar, carga la información oficial de Claude Code Memory:

@prompts/info_claude.md

Esta información te permitirá explicar al usuario para qué sirve cada fichero según la documentación oficial.

---

## ⚠️ PASO 1: Backup Obligatorio

**ANTES** de cualquier reset, **SIEMPRE** hacer backup.

Mostrar mensaje:

```markdown
═══════════════════════════════════════════════════════════

                    🔄 SISTEMA DE RESET

═══════════════════════════════════════════════════════════

Antes de continuar, se creará un backup obligatorio de todas
tus configuraciones.

Creando backup...
```

Ejecutar:
1. Crear timestamp: `YYYYMMDD_HHMMSS`
2. Crear directorio: `./tlotp_backup/reset_{TIMESTAMP}/`
3. Copiar TODOS los archivos de configuración (usar lógica de 02-backup-system.md)
4. Crear BACKUP_INDEX.md con inventario completo

Mostrar resultado:

```markdown
✅ Backup creado en:
./tlotp_backup/reset_{TIMESTAMP}/

📦 Total: X archivos (~XXK)

Ver detalles en: BACKUP_INDEX.md

═══════════════════════════════════════════════════════════
```

**Si el backup falla**: NO continuar con el reset, abortar operación.

---

## 📊 PASO 2: Selección de Tipo de Reset

Usar `AskUserQuestion`:

```
header: "Tipo de reset"
question: "¿Qué tipo de reset deseas realizar?"
multiSelect: false
options:
  1. label: "Reset Completo (interactivo)"
     description: "Revisar fichero por fichero y decidir si borrarlo"

  2. label: "Reset Selectivo (granular)"
     description: "Revisar regla por regla dentro de cada fichero"
```

---

## 🔄 OPCIÓN A: Reset Completo (Interactivo)

**Flujo**: Ir fichero por fichero del backup, preguntar si borrarlo.

### Por Cada Fichero del Backup

1. **Leer el fichero del backup** para analizar su contenido

2. **Mostrar contexto completo**:

```markdown
═══════════════════════════════════════════════════════════

📄 Fichero: {PATH_DEL_FICHERO}

📚 Según documentación oficial de Claude Code:

{DESCRIPCIÓN_SEGÚN_INFO_CLAUDE.MD}

{EJEMPLOS_DE_USO_SEGÚN_INFO_CLAUDE.MD}

---

📋 Contenido actual (análisis del backup):

{RESUMEN_DEL_CONTENIDO}

Ejemplo:
- Total líneas: 620
- Secciones principales:
  • Perfil de Desarrollo (PHP/Symfony, Testing E2E)
  • Sistema de auto-carga de skills
  • Convenciones de naming (PHP, TypeScript, Python, Bash)
  • Comandos rápidos
  [... otras secciones relevantes ...]

═══════════════════════════════════════════════════════════
```

Usar `AskUserQuestion`:

```
header: "Fichero: {NOMBRE_FICHERO}"
question: "¿Deseas borrar este fichero?"
multiSelect: false
options:
  1. label: "Sí, borrar"
     description: "Vaciar o eliminar el fichero (según tipo)"

  2. label: "No, mantener"
     description: "Conservar el fichero sin cambios"
```

3. **Si el usuario elige "Sí, borrar"**:

   a) Determinar la acción según `info_claude.md`:

   - **User Memory** (~/.claude/CLAUDE.md): **Vaciar** (mejor que borrar)
   - **User Rules** (~/.claude/rules/*.md): **Borrar archivo**
   - **Project Memory** (./CLAUDE.md): **Vaciar** (si está en git) o **Borrar**
   - **Project Rules** (./.claude/rules/*.md): **Borrar archivo**
   - **Project Local** (./CLAUDE.local.md): **Borrar**
   - **Auto Memory** (MEMORY.md, topic files): **Borrar**
   - **Managed Policy**: **NUNCA TOCAR** (mostrar advertencia y saltar)

   b) Ejecutar la acción en el fichero real:

   ```bash
   # Si es vaciar:
   echo "" > /path/to/file

   # Si es borrar:
   rm /path/to/file
   ```

   c) Notificar resultado:

   ```markdown
   ✅ {PATH_DEL_FICHERO}: {VACIADO/BORRADO}
   ```

4. **Si el usuario elige "No, mantener"**:

   ```markdown
   ⏭️  {PATH_DEL_FICHERO}: Mantenido (sin cambios)
   ```

5. **Siguiente fichero del backup**

### Excepción: Managed Policy

Si encuentras un fichero de Managed Policy:

```markdown
═══════════════════════════════════════════════════════════

📄 Fichero: {PATH_MANAGED_POLICY}

⚠️⚠️⚠️ MANAGED POLICY - NO SE PUEDE MODIFICAR ⚠️⚠️⚠️

Este archivo es gestionado por IT/DevOps de tu organización.
NO debe ser modificado por usuarios individuales.

Saltando este archivo...

═══════════════════════════════════════════════════════════
```

---

### Manejo Especial: Symlinks

Si encuentras un **symlink** (como `~/.claude/skills/`):

**Detectar symlink**:
```bash
if [ -L "$path" ]; then
    # Es symlink
    target=$(readlink -f "$path")
fi
```

**Mostrar contexto**:
```markdown
═══════════════════════════════════════════════════════════

📄 Fichero: {PATH}

🔗 SYMLINK DETECTADO

Target: {TARGET_PATH}

Este es un enlace simbólico a otro directorio/archivo.

Al borrar, se eliminará SOLO el symlink, NO el contenido
del target.

═══════════════════════════════════════════════════════════
```

**Si usuario elige borrar**:
```bash
# Eliminar SOLO el symlink (no el target)
rm "$path"  # SIN -r, solo el symlink

# o más explícito:
unlink "$path"
```

**Notificar**:
```markdown
✅ {PATH}: Symlink eliminado
   🔗 Target: {TARGET_PATH} (NO modificado)
```

**Importante**:
- NO usar `rm -r` que borraría el contenido del target
- Usar `rm` simple o `unlink` para eliminar solo el symlink

---

## 🎯 OPCIÓN B: Reset Selectivo (Granular)

**Flujo**: Ir fichero por fichero, dentro de cada fichero ir regla/preferencia por regla/preferencia.

### Por Cada Fichero del Backup

1. **Leer el fichero del backup** completamente

2. **Mostrar contexto del fichero**:

```markdown
═══════════════════════════════════════════════════════════

📄 Fichero: {PATH_DEL_FICHERO}

📚 Según documentación oficial de Claude Code:

{DESCRIPCIÓN_SEGÚN_INFO_CLAUDE.MD}

---

Vamos a revisar el contenido regla por regla...

═══════════════════════════════════════════════════════════
```

3. **Analizar el contenido** del fichero del backup:

   - Identificar secciones (headings markdown: #, ##, ###)
   - Identificar bloques de configuración
   - Identificar listas de preferencias
   - Identificar reglas individuales

4. **Por cada regla/preferencia/sección encontrada**:

   **Importante**: Llevar contador del total de reglas: `REGLA_ACTUAL` de `TOTAL_REGLAS`

   **Paso A: Analizar tamaño de la regla**

   Contar líneas de la regla:
   - Si **< 30 líneas**: Mostrar completa directamente (ir a Paso C)
   - Si **>= 30 líneas**: Preguntar cómo revisarla (ir a Paso B)

   **Paso B: Regla larga - Preguntar cómo revisar** (solo si >= 30 líneas)

   Mostrar resumen:

   ```markdown
   ───────────────────────────────────────────────────────────

   📌 Regla #{NUMERO} de {TOTAL}

   {TITULO_O_PRIMERA_LINEA_DE_LA_REGLA}

   📊 Tamaño: {N} líneas
   📑 Subsecciones detectadas: {N} (si tiene ###)

   Primeras 10 líneas:
   {PRIMERAS_10_LINEAS}

   ...

   Últimas 5 líneas:
   {ULTIMAS_5_LINEAS}

   ───────────────────────────────────────────────────────────
   ```

   Usar `AskUserQuestion`:

   ```
   header: "Regla #{NUMERO} de {TOTAL}"
   question: "Esta regla es larga ({N} líneas). ¿Cómo deseas revisarla?"
   multiSelect: false
   options:
     1. label: "Ver completa y decidir"
        description: "Mostrar todo el contenido y decidir mantener/borrar"

     2. label: "Dividir en subsecciones"
        description: "Revisar parte por parte (si tiene subsecciones)"

     3. label: "Mantener completa"
        description: "Conservar toda la regla sin revisar"

     4. label: "Borrar completa"
        description: "Eliminar toda la regla sin revisar"
   ```

   Según respuesta:
   - **Opción 1**: Mostrar completa (ir a Paso C)
   - **Opción 2**: Dividir y revisar cada subsección (recursivo)
   - **Opción 3**: Añadir a "contenido a mantener" y siguiente regla
   - **Opción 4**: NO añadir a la lista y siguiente regla

   **Paso C: Mostrar regla y preguntar** (reglas cortas o si eligió "Ver completa")

   ```markdown
   ───────────────────────────────────────────────────────────

   📌 Regla #{NUMERO} de {TOTAL}

   {MOSTRAR_CONTENIDO_COMPLETO_DE_LA_REGLA}

   ───────────────────────────────────────────────────────────
   ```

   Usar `AskUserQuestion`:

   ```
   header: "Regla #{NUMERO} de {TOTAL}"
   question: "¿Qué deseas hacer con esta regla?"
   multiSelect: false
   options:
     1. label: "Mantener"
        description: "Conservar esta regla en el fichero"

     2. label: "Borrar"
        description: "Eliminar esta regla del fichero"
   ```

   Según respuesta:
   - **Mantener**: Añadir a lista de "contenido a mantener"
   - **Borrar**: NO añadir a la lista

   **Paso D: Siguiente regla/preferencia**

5. **Cuando termine de revisar TODO el fichero**:

   **⚒️ USAR MOTOR DE RECONSTRUCCIÓN (09-reconstruction-engine.md)**

   a) **Acumular en plan de reconstrucción**:

   Por cada regla marcada como "Mantener":
   ```python
   reconstructionPlan[filePath].preferences.append({
       "id": preferenceId,
       "content": preferenceContent,
       "type": detectType(preferenceContent),  # "section", "rule", etc.
       "metadata": {
           "sectionName": extractSectionName(preferenceContent),
           "lines": countLines(preferenceContent)
       }
   })
   ```

   b) **NO editar archivo aún**. Solo acumular en memoria.

   Notificar:
   ```markdown
   📦 Fichero {PATH}: Revisión completada

   Preferencias a mantener: X de Y (acumuladas)

   ---
   ```

6. **Siguiente fichero del backup** (seguir acumulando)

---

### IMPORTANTE: Al Finalizar TODOS los Ficheros

**Una vez revisados TODOS los ficheros del backup:**

1. **Mostrar resumen de lo acumulado**:

```markdown
═══════════════════════════════════════════════════════════

            📦 RESUMEN DE PREFERENCIAS A MANTENER

═══════════════════════════════════════════════════════════

Total ficheros con preferencias: {N}

~/.claude/CLAUDE.md
  - {X} preferencias (stack, herramientas, etc.)

./CLAUDE.md
  - {Y} preferencias (comportamiento, branches, testing)

MEMORY.md
  - {Z} preferencias (notas del proyecto)

───────────────────────────────────────────────────────────

💡 Siguiente paso: Reconstrucción inteligente

Se borrarán/vaciarán los archivos y se reconstruirán
correctamente usando la documentación oficial de Claude Code.

Cada reconstrucción será validada y confirmada antes de
aplicarse.

═══════════════════════════════════════════════════════════
```

2. **Ejecutar Motor de Reconstrucción**:

   **Según instrucciones de `09-reconstruction-engine.md`**:

   a) **Fase de Purificación**: Borrar/vaciar archivos según `info_claude.md`

   b) **Fase de Reconstrucción**: Por cada preferencia acumulada:
      - Mostrar confirmación (QUÉ, DÓNDE, CÓMO)
      - Validar estructura
      - Escribir con formato correcto
      - Notificar resultado

   c) **Resumen Final**: Estadísticas de reconstrucción

### Identificación de Reglas/Preferencias

**Criterios para identificar "una regla/preferencia"**:

1. **Secciones markdown** (## Título, ### Subtítulo):
   - Cada sección con su contenido es una "regla"
   - Preguntar por toda la sección completa

2. **Bloques separados** (separados por líneas en blanco o ---):
   - Cada bloque coherente es una "regla"

3. **Listas con contenido** (bullets, numbered):
   - Grupos de bullets relacionados son una "regla"

4. **Código/ejemplos**:
   - Bloques de código junto con su contexto

**Estrategia de análisis**:
- Leer el fichero completo del backup
- Dividir en secciones lógicas (usando headings como delimitadores)
- Dentro de cada sección, identificar sub-bloques coherentes
- Presentar cada bloque coherente como una "regla/preferencia"

---

## ✅ PASO 3: Resumen Final

Al terminar el reset (completo o selectivo), mostrar:

```markdown
═══════════════════════════════════════════════════════════

                  🔄 RESET COMPLETADO

═══════════════════════════════════════════════════════════

📊 Resumen de operaciones:

{Si fue Reset Completo:}
  ✅ Ficheros procesados: X
  🗑️  Ficheros borrados/vaciados: Y
  ⏭️  Ficheros mantenidos: Z

{Si fue Reset Selectivo:}
  ✅ Ficheros procesados: X
  📝 Total reglas revisadas: Y
  🗑️  Reglas borradas: Z
  ⏭️  Reglas mantenidas: W

---

💾 Backup disponible en:
./tlotp_backup/reset_{TIMESTAMP}/

{Si hubo Managed Policy:}
⚠️ Managed Policy no fue modificado (gestionado por IT/DevOps)

═══════════════════════════════════════════════════════════

                 ✅ Reset Finalizado

    Palantír (TLOTP) v1.4 - "Reset System"

═══════════════════════════════════════════════════════════
```

---

## 🚫 Cancelación

El usuario puede cancelar en cualquier momento:
- Respondiendo "cancelar" en cualquier pregunta
- Usando Ctrl+C (si está disponible)

Al cancelar, mostrar:

```markdown
❌ Reset cancelado

Ficheros procesados hasta el momento: X
Cambios aplicados: {lista de ficheros ya modificados}

El backup creado se mantiene en:
./tlotp_backup/reset_{TIMESTAMP}/

Puedes usar Recovery para restaurar desde este backup.
```

---

## 📝 Reglas de Implementación

1. **SIEMPRE leer del backup**: Nunca analizar los ficheros reales, usar el backup recién creado

2. **Contexto en cada decisión**: Siempre mostrar:
   - Descripción según documentación oficial
   - Resumen del contenido
   - Opción clara de mantener/borrar

3. **No asumir**: Preguntar siempre antes de borrar/editar

4. **Logging claro**: Notificar cada acción realizada

5. **Respetar Managed Policy**: NUNCA tocar, solo advertir y saltar

6. **Vaciar vs Borrar**: Seguir las reglas de `info_claude.md` según tipo de fichero

7. **Granularidad en Selectivo**: Ser lo más granular posible, presentar bloques coherentes pequeños

---

*Sistema de Reset - Palantír v1.4*
*Modo Interactivo con Contexto Completo*
