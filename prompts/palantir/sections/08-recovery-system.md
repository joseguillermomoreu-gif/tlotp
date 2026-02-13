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
header: "Acción para {NOMBRE_FICHERO}"
question: "¿Qué deseas hacer con este fichero?"
multiSelect: false
options:
  1. label: "Reemplazar con backup"
     description: "Sobrescribir completamente con el del backup (pierdes contenido actual)"

  2. label: "Combinar ambos"
     description: "Merge inteligente manteniendo contenido de ambos"

  3. label: "Saltar (mantener actual)"
     description: "No hacer cambios, mantener el fichero actual"
```

#### Paso E: Ejecutar acción

**OPCIÓN 1: Reemplazar con backup**

1. Copiar fichero del backup a ubicación real:
   ```bash
   cp "$BACKUP_FILE" "$REAL_FILE"
   ```

2. Notificar:
   ```markdown
   ✅ {UBICACION_REAL}: Reemplazado con backup

   El fichero actual ha sido sobrescrito con el del backup.
   ```

---

**OPCIÓN 2: Combinar ambos**

**Proceso de combinación inteligente**:

1. **Leer ambos contenidos** completos

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

   b) Estrategia de combinación:
   - Secciones solo en actual: Mantener
   - Secciones solo en backup: Añadir
   - Secciones en ambos con contenido idéntico: Mantener una vez
   - Secciones en ambos con contenido diferente: Mantener ambas con nota

   c) Construir fichero combinado:
   ```markdown
   # {TITULO_DEL_FICHERO}

   {SECCIONES_COMUNES_O_DEL_ACTUAL}

   ---

   ## 📦 Secciones recuperadas del backup

   > Las siguientes secciones estaban en el backup pero no en tu
   > versión actual. Revisa y ajusta según necesites.

   {SECCIONES_SOLO_DEL_BACKUP}

   ---

   ## ⚠️ Conflictos detectados

   > Las siguientes secciones existen en ambas versiones con
   > contenido diferente. Ambas se mantienen para que decidas.

   ### {SECCION_CONFLICTIVA} (Versión actual)
   {CONTENIDO_ACTUAL}

   ### {SECCION_CONFLICTIVA} (Versión del backup)
   {CONTENIDO_BACKUP}

   ---

   💡 Fichero combinado el {FECHA}
   ```

   **Para rules/*.md (User/Project Rules)**:

   a) Si tiene frontmatter YAML con `paths:`:
   - Combinar paths únicos
   - Mantener reglas de ambos

   b) Si no tiene frontmatter:
   - Concatenar contenidos
   - Eliminar duplicados exactos
   - Marcar secciones del backup

   **Para Auto Memory (MEMORY.md)**:

   a) Índice (primeras 200 líneas):
   - Combinar referencias a topic files
   - Mantener notas únicas de ambos
   - Respetar límite de 200 líneas

   b) Topic files:
   - Si existe en ambos: Combinar notas
   - Si solo en backup: Restaurar

   **Para otros archivos** (settings.json, etc.):
   - Si es JSON: Merge de objetos JSON
   - Si es texto: Concatenar con separador

3. **Escribir fichero combinado**:
   ```bash
   cat > "$REAL_FILE" <<EOF
   $COMBINED_CONTENT
   EOF
   ```

4. **Notificar**:
   ```markdown
   ✅ {UBICACION_REAL}: Combinado

   Se ha creado un merge inteligente de ambos contenidos:
   - Secciones del actual: {X}
   - Secciones del backup añadidas: {Y}
   - Conflictos detectados: {Z} (revisa y resuelve)

   💡 Revisa el fichero para ajustar según tus preferencias.
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
