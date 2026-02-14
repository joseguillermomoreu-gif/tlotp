# 📦 Sistema de Recovery desde Backup

Este módulo se ejecuta cuando el usuario selecciona "Recovery desde backup" en el menú principal.

---

## 📋 Información de Contexto

**IMPORTANTE**: Este módulo usa la información oficial de Claude Code Memory ya cargada en el entry point:

La información de `prompts/info_claude.md` está disponible para explicar al usuario para qué sirve cada fichero.

---

## 📍 PASO 1: Solicitar Path del Backup

Mostrar mensaje:

```markdown
═══════════════════════════════════════════════════════════

                    📦 SISTEMA DE RECOVERY

═══════════════════════════════════════════════════════════

Restaurar configuraciones desde un backup anterior.

Por favor, proporciona el path del backup que deseas restaurar.

Ejemplos de ubicaciones típicas:
- ./tlotp_backup/reset_20260213_153045/
- ./tlotp_backup/backup_20260213_160112/
- /ruta/personalizada/mi_backup/

═══════════════════════════════════════════════════════════

Path del backup:
```

**Obtener input del usuario**: Leer el path proporcionado

---

## ✅ PASO 2: Validar Backup

Validar que el path proporcionado es un backup válido de TLOTP:

1. **Verificar que el directorio existe**:
   ```bash
   [ -d "$BACKUP_PATH" ] || echo "ERROR"
   ```

2. **Buscar BACKUP_INDEX.md** (indicador de backup de TLOTP):
   ```bash
   [ -f "$BACKUP_PATH/BACKUP_INDEX.md" ]
   ```

3. **Verificar estructura** (al menos uno de estos directorios debe existir):
   - `user-memory/`
   - `project-memory/`
   - `auto-memory/`
   - `other-configs/`

**Si la validación falla**:

```markdown
❌ Error: El path proporcionado no parece ser un backup válido de TLOTP.

Verifica que:
- El directorio existe
- Contiene BACKUP_INDEX.md
- Tiene estructura de backup de TLOTP

Operación cancelada.
```

**Si la validación es exitosa**:

```markdown
✅ Backup válido encontrado

📋 Leyendo BACKUP_INDEX.md...

{MOSTRAR_RESUMEN_DEL_BACKUP_INDEX}

Ejemplo:
- Fecha: 2026-02-13 15:30:45
- Total archivos: 4
- User Memory: ~/.claude/CLAUDE.md (38K)
- Auto Memory: MEMORY.md + 2 topic files
- Project Local: settings.local.json (10K)

═══════════════════════════════════════════════════════════

Iniciando proceso de recovery fichero por fichero...

═══════════════════════════════════════════════════════════
```

---

## 📂 PASO 3: Listar Ficheros del Backup

Escanear el backup y crear lista de ficheros a procesar:

```bash
# Buscar todos los archivos de configuración en el backup
find "$BACKUP_PATH" -type f ! -name "BACKUP_INDEX.md" | sort
```

**Orden de procesamiento** (por jerarquía de importancia):

1. Managed Policy (si existe - advertir que no se debe modificar)
2. User Memory (~/.claude/CLAUDE.md)
3. User Rules (~/.claude/rules/*.md)
4. Project Memory (./CLAUDE.md)
5. Project Rules (./.claude/rules/*.md)
6. Project Local (./CLAUDE.local.md)
7. Auto Memory (MEMORY.md, topic files)
8. Otros archivos de configuración

---

## 🔄 PASO 4: Procesar Cada Fichero

### Por Cada Fichero del Backup

#### Paso A: Determinar ubicación real

Del path del backup, extraer la ubicación real del fichero:

```bash
# Ejemplo:
# Backup: ./tlotp_backup/reset_20260213/user-memory/CLAUDE.md
# Real: ~/.claude/CLAUDE.md
```

#### Paso B: Leer contenidos

1. **Leer fichero del backup**:
   ```bash
   BACKUP_CONTENT=$(cat "$BACKUP_FILE")
   ```

2. **Leer fichero actual** (si existe):
   ```bash
   if [ -f "$REAL_FILE" ]; then
     CURRENT_CONTENT=$(cat "$REAL_FILE")
   else
     CURRENT_CONTENT="(El fichero no existe actualmente en tu sistema)"
   fi
   ```

#### Paso C: Mostrar contexto completo

```markdown
═══════════════════════════════════════════════════════════

📄 Fichero: {UBICACION_REAL}

📚 Según documentación oficial de Claude Code:

{DESCRIPCION_SEGUN_INFO_CLAUDE_MD}

{EJEMPLOS_DE_USO_SEGUN_INFO_CLAUDE_MD}

═══════════════════════════════════════════════════════════

📋 CONTENIDO ACTUAL (en tu sistema):

{MOSTRAR_CONTENIDO_ACTUAL}

Estrategia de mostrar:
- Si < 100 líneas: Mostrar completo
- Si >= 100 líneas: Mostrar resumen

Ejemplo de resumen:
---
Total: 450 líneas

Primeras 20 líneas:
{primeras 20 líneas}

...

Últimas 10 líneas:
{últimas 10 líneas}

Secciones detectadas:
- ## Stack Tecnológico (líneas 10-45)
- ## Naming Conventions (líneas 50-120)
- ## Skills (líneas 125-350)
- ## Comandos rápidos (líneas 360-440)
---

───────────────────────────────────────────────────────────

💾 CONTENIDO EN BACKUP:

{MOSTRAR_CONTENIDO_BACKUP}

(Misma estrategia de resumen si es muy largo)

═══════════════════════════════════════════════════════════
```

#### Paso D: Preguntar acción

Usar `AskUserQuestion`:

```
header: "Fichero: {NOMBRE_FICHERO}"
question: "¿Qué deseas hacer con este fichero?"
multiSelect: false
options:
  1. label: "Reemplazar con backup"
     description: "Sobrescribir completamente (pierdes contenido actual)"

  2. label: "Combinar ambos"
     description: "Merge inteligente manteniendo contenido de ambos"

  3. label: "Mantener actual"
     description: "No hacer cambios, conservar el fichero actual"
```

#### Paso E: Ejecutar acción

**OPCIÓN 1: Reemplazar con backup**

**⚒️ USAR MOTOR DE RECONSTRUCCIÓN (09-reconstruction-engine.md)**

1. **Leer contenido del backup** completo

2. **Analizar y acumular**:

   a) Identificar secciones/preferencias en el backup

   b) Acumular cada una en plan de reconstrucción:
   ```python
   reconstructionPlan[filePath].preferences.append({
       "id": preferenceId,
       "content": preferenceContent,
       "type": detectType(preferenceContent),
       "metadata": {
           "origin": "backup",
           "sectionName": extractSectionName(preferenceContent)
       }
   })
   ```

3. **Ejecutar reconstrucción**:

   **Según instrucciones de `09-reconstruction-engine.md`**:

   a) **Purificación**: Vaciar/borrar fichero actual según `info_claude.md`

   b) **Reconstrucción**: Escribir contenido del backup con estructura validada

   c) **Validación**: Asegurar que el archivo resultante es correcto

4. **Notificar**:
   ```markdown
   ✅ {UBICACION_REAL}: Reemplazado con backup (reconstruido)

   El fichero ha sido reconstruido desde el backup con validación
   de estructura para asegurar que no hay corrupción.

   - Preferencias restauradas: {N}
   - Validación: ✅ Estructura correcta
   ```

---

**OPCIÓN 2: Combinar ambos**

**⚒️ USAR MOTOR DE RECONSTRUCCIÓN (09-reconstruction-engine.md)**

**Proceso de combinación inteligente con reconstrucción**:

1. **Leer ambos contenidos** completos (actual + backup)

2. **Analizar según tipo de fichero**:

   **Para CLAUDE.md (User/Project Memory)**:

   a) Identificar secciones en ambos:
   ```
   # Del actual:
   - ## Stack Tecnológico
   - ## Naming Conventions
   - ## Skills

   # Del backup:
   - ## Stack Tecnológico (diferente contenido)
   - ## Naming Conventions (igual)
   - ## Comandos rápidos (nueva)
   - ## Meta-instrucciones (nueva)
   ```

   b) Estrategia de acumulación:
   - Secciones solo en actual: Acumular para reconstrucción
   - Secciones solo en backup: Acumular para reconstrucción
   - Secciones en ambos idénticas: Acumular una vez
   - Secciones en ambos diferentes: Acumular ambas con prefijo

   c) **Acumular en plan de reconstrucción**:

   ```python
   # Por cada sección a mantener
   reconstructionPlan[filePath].preferences.append({
       "id": sectionId,
       "content": sectionContent,
       "type": "section",
       "metadata": {
           "sectionName": sectionName,
           "origin": "current|backup|conflict",
           "conflictInfo": {...}  # si aplica
       }
   })
   ```

   **Para rules/*.md (User/Project Rules)**:

   a) Si tiene frontmatter YAML:
   - Acumular paths únicos combinados
   - Acumular reglas de ambos

   b) Sin frontmatter:
   - Acumular contenidos sin duplicados
   - Marcar origen (actual/backup)

   **Para Auto Memory (MEMORY.md)**:

   a) Acumular notas únicas de ambos
   - Respetar límite 200 líneas para índice
   - Combinar referencias a topic files

   b) Topic files:
   - Acumular notas de ambos sin duplicados

   **Para otros archivos** (settings.json, etc.):
   - JSON: Acumular merge de objetos
   - Texto: Acumular contenidos con separador

3. **NO escribir aún**. Solo acumular en memoria.

   Notificar:
   ```markdown
   📦 {UBICACION_REAL}: Análisis completado

   Contenido acumulado:
   - Del actual: {X} secciones/preferencias
   - Del backup: {Y} secciones/preferencias
   - Conflictos: {Z} (se mantendrán ambas versiones)

   ⚒️ Se reconstruirá usando motor de reconstrucción...

   ───────────────────────────────────────────────────────────
   ```

4. **Ejecutar reconstrucción**:

   **Según instrucciones de `09-reconstruction-engine.md`**:

   a) **Purificación**: Vaciar fichero actual

   b) **Reconstrucción**: Por cada preferencia acumulada:
      - Mostrar confirmación (origen, contenido, ubicación)
      - Validar estructura
      - Escribir correctamente
      - Notificar resultado

   c) **Notificar resultado final**:
   ```markdown
   ✅ {UBICACION_REAL}: Combinado y reconstruido

   Reconstrucción completada:
   - Preferencias del actual: {X}
   - Preferencias del backup: {Y}
   - Conflictos resueltos: {Z} (ambas versiones incluidas)
   - Validación: ✅ Estructura correcta

   💡 Revisa el fichero reconstruido para ajustes finales.
   ```

---

**OPCIÓN 3: Saltar (mantener actual)**

Notificar:
```markdown
⏭️ {UBICACION_REAL}: Mantenido actual (sin cambios)

El fichero actual no ha sido modificado.
```

---

#### Paso F: Siguiente fichero

Proceder con el siguiente fichero del backup.

---

### Excepción: Managed Policy

Si el backup contiene Managed Policy:

```markdown
═══════════════════════════════════════════════════════════

📄 Fichero: {PATH_MANAGED_POLICY}

⚠️⚠️⚠️ MANAGED POLICY - NO SE PUEDE MODIFICAR ⚠️⚠️⚠️

Este archivo es gestionado por IT/DevOps de tu organización.
NO debe ser modificado por usuarios individuales.

El backup contiene una copia, pero NO se restaurará.

Si necesitas modificar Managed Policy, contacta con tu
departamento de IT/DevOps.

Saltando este archivo...

═══════════════════════════════════════════════════════════
```

---

## ✅ PASO 5: Resumen Final

Al terminar el recovery, mostrar:

```markdown
═══════════════════════════════════════════════════════════

                  📦 RECOVERY COMPLETADO

═══════════════════════════════════════════════════════════

📊 Resumen de operaciones:

  ✅ Ficheros procesados: X
  🔄 Reemplazados con backup: Y
  🔀 Combinados (merge): Z
  ⏭️ Mantenidos actuales: W
  ⚠️ Saltados (Managed Policy): V

---

💾 Backup utilizado:
{BACKUP_PATH}

{Si hubo combinaciones:}
💡 Ficheros combinados - Revisa los conflictos marcados

{Si hubo Managed Policy:}
⚠️ Managed Policy no fue restaurado (gestionado por IT/DevOps)

═══════════════════════════════════════════════════════════

                 ✅ Recovery Finalizado

    Palantír (TLOTP) v1.4 - "Recovery System"

═══════════════════════════════════════════════════════════
```

---

## 🚫 Cancelación

El usuario puede cancelar en cualquier momento:
- Respondiendo "cancelar" en cualquier pregunta
- Usando Ctrl+C (si está disponible)

Al cancelar, mostrar:

```markdown
❌ Recovery cancelado

Ficheros procesados hasta el momento: X
Cambios aplicados: {lista de ficheros ya modificados}

Los cambios aplicados hasta ahora se mantienen.
Puedes ejecutar Recovery nuevamente cuando quieras.
```

---

## 📝 Reglas de Implementación

1. **Validar path**: Siempre verificar que el backup es válido de TLOTP

2. **Contexto completo**: Mostrar:
   - Descripción según documentación oficial
   - Contenido actual (resumen si es muy largo)
   - Contenido del backup (resumen si es muy largo)

3. **Resúmenes inteligentes**:
   - < 100 líneas: Mostrar completo
   - >= 100 líneas: Primeras 20 + últimas 10 + resumen de secciones

4. **Combinación sin pérdida**: En modo "Combinar", NUNCA perder contenido:
   - Mantener todo del actual
   - Añadir todo del backup
   - Marcar conflictos claramente

5. **Organización según documentación**: Usar info_claude.md para:
   - Organizar secciones lógicamente
   - Seguir mejores prácticas
   - Explicar el propósito de cada fichero

6. **Respetar Managed Policy**: NUNCA modificar, solo advertir y saltar

7. **Notificaciones claras**: Informar qué se hizo con cada fichero

8. **Reversibilidad**: Sugerir hacer backup antes si el usuario quiere seguridad extra

---

## 💡 Estrategias de Combinación por Tipo

### CLAUDE.md Files

**Identificar secciones**: Por headings markdown (##, ###)

**Combinar**:
- Mantener estructura clara
- Agrupar por categorías (Stack, Naming, Skills, etc.)
- Marcar secciones del backup con comentario
- Resolver conflictos manteniendo ambas versiones etiquetadas

**Formato del resultado**:
```markdown
# {TITULO}

{CONTENIDO_ACTUAL}

---

## 📦 Recuperado del backup

{CONTENIDO_SOLO_DEL_BACKUP}

---

## ⚠️ Revisar conflictos

{SECCIONES_CONFLICTIVAS_DE_AMBOS}
```

---

### rules/*.md Files

**Si tiene frontmatter**:
```yaml
---
paths:
  - "actual/**/*.ts"
  - "backup/**/*.js"  # Del backup
---
```

**Combinar reglas**:
- Sin duplicados
- Mantener estructura coherente

---

### Auto Memory

**MEMORY.md**:
- Respetar límite 200 líneas para el índice
- Combinar referencias a topic files
- Mantener conciso

**Topic files**:
- Concatenar notas
- Marcar origen si es relevante

---

### JSON Files (settings.json, etc.)

**Merge de objetos JSON**:
```javascript
{
  ...currentJSON,
  ...backupJSON
}
```

Si hay conflictos en keys, mantener del actual y avisar.

---

*Sistema de Recovery - Palantír v1.4*
*Restauración inteligente con merge*
