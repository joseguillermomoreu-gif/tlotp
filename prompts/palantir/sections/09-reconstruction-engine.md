# ⚒️ Motor de Reconstrucción Inteligente

Este módulo proporciona el sistema de reconstrucción para Reset y Recovery.

**Objetivo**: Reconstruir archivos de configuración con estructura correcta, evitando corrupción.

---

## 🎯 Filosofía de Reconstrucción

> **"Como los herreros élficos que reforjaron Andúril desde fragmentos rotos"**

No basta con editar archivos. Debemos **reconstruir** con maestría:

1. **Acumular** lo valioso (preferencias a mantener)
2. **Purificar** el metal (borrar/vaciar correctamente)
3. **Reforjar** con estructura correcta (validar y escribir)
4. **Verificar** la obra (validación final)

---

## 📦 Estructura Temporal de Reconstrucción

Durante el proceso, acumula preferencias en memoria (NO en archivos):

```javascript
// Estructura en memoria durante la sesión
const reconstructionPlan = {
  "~/.claude/CLAUDE.md": {
    fileType: "user-memory",
    preferences: [
      {
        id: 1,
        content: "## Stack Tecnológico\n- Backend: PHP/Symfony\n...",
        type: "section",
        sectionName: "Stack Tecnológico",
        lines: 25
      },
      {
        id: 2,
        content: "## Herramientas\n- MCPs: GitHub, Context7",
        type: "section",
        sectionName: "Herramientas",
        lines: 8
      }
    ]
  },
  "./CLAUDE.md": {
    fileType: "project-memory",
    preferences: [...]
  }
}
```

---

## 🔍 PASO 1: Consulta a Documentación Oficial

Antes de reconstruir, consultar `info_claude.md` para saber:

### Función: `determinarEstructuraCorrecta(filePath, content)`

```python
def determinarEstructuraCorrecta(filePath, content):
    """
    Consulta info_claude.md para determinar cómo almacenar correctamente.

    Returns:
        {
            "fileType": "user-memory|project-memory|user-rules|...",
            "shouldKeepFile": true|false,
            "emptyStrategy": "vaciar|borrar",
            "structure": {
                "requiresFrontmatter": true|false,
                "sections": ["## Sección 1", "## Sección 2"],
                "format": "markdown|yaml|json"
            },
            "validations": [
                "check_markdown_headers",
                "check_yaml_frontmatter",
                "check_no_broken_refs"
            ]
        }
    }
    """

    # Mapeo según info_claude.md
    fileTypeMap = {
        "~/.claude/CLAUDE.md": {
            "fileType": "user-memory",
            "shouldKeepFile": true,
            "emptyStrategy": "vaciar",  # Mejor vaciar que borrar
            "structure": {
                "requiresFrontmatter": false,
                "expectedSections": [
                    "Perfil de Desarrollo",
                    "Stack Tecnológico",
                    "Preferencias de Código",
                    "Skills Especializados"
                ],
                "format": "markdown"
            }
        },
        "~/.claude/rules/*.md": {
            "fileType": "user-rules",
            "shouldKeepFile": false,
            "emptyStrategy": "borrar",
            "structure": {
                "requiresFrontmatter": true,  # paths: en YAML
                "format": "markdown+yaml"
            }
        },
        "./CLAUDE.md": {
            "fileType": "project-memory",
            "shouldKeepFile": true,
            "emptyStrategy": "vaciar",  # Si está en git, mantener
            "structure": {
                "requiresFrontmatter": false,
                "expectedSections": [
                    "Comportamiento al Iniciar",
                    "Branches & Pull Requests",
                    "Testing & QA"
                ],
                "format": "markdown"
            }
        },
        "./.claude/rules/*.md": {
            "fileType": "project-rules",
            "shouldKeepFile": false,
            "emptyStrategy": "borrar",
            "structure": {
                "requiresFrontmatter": true,
                "format": "markdown+yaml"
            }
        },
        "./CLAUDE.local.md": {
            "fileType": "project-local",
            "shouldKeepFile": false,
            "emptyStrategy": "borrar",
            "structure": {
                "requiresFrontmatter": false,
                "format": "markdown"
            }
        },
        "~/.claude/projects/*/memory/MEMORY.md": {
            "fileType": "auto-memory",
            "shouldKeepFile": false,
            "emptyStrategy": "borrar",  # Claude lo regenera
            "structure": {
                "maxLines": 200,  # Límite para índice
                "format": "markdown"
            }
        }
    }

    return fileTypeMap[matchedPattern]
```

---

## 🏗️ PASO 2: Fase de Purificación

Antes de reconstruir, limpiar correctamente usando la documentación oficial.

### Por Cada Archivo a Resetear

```bash
# Determinar estrategia
strategy = determinarEstructuraCorrecta(filePath)

if strategy.emptyStrategy == "vaciar":
    # Vaciar pero mantener archivo
    echo "" > $filePath
    echo "✅ $filePath: Vaciado (archivo mantenido)"

elif strategy.emptyStrategy == "borrar":
    # Borrar archivo completamente
    rm $filePath
    echo "✅ $filePath: Borrado (Claude lo regenerará si es necesario)"
```

**Excepciones**:
- **Managed Policy**: NUNCA tocar, saltar con advertencia
- **Archivos en git**: Preferir vaciar sobre borrar

---

## ⚒️ PASO 3: Fase de Reconstrucción

Por cada preferencia acumulada en `reconstructionPlan`:

### 3.1. Analizar Contenido

```python
def analizarPreferencia(preference):
    """
    Analiza una preferencia para determinar cómo almacenarla.

    Returns:
        {
            "targetFile": "~/.claude/CLAUDE.md",
            "targetSection": "## Stack Tecnológico",
            "format": "markdown-section",
            "needsValidation": ["markdown_headers", "no_empty_bullets"]
        }
    """

    content = preference.content

    # Detectar tipo de contenido
    if content.startswith("##"):
        return {
            "type": "section",
            "sectionName": extractSectionName(content),
            "format": "markdown-section"
        }
    elif content.startswith("---\npaths:"):
        return {
            "type": "rule-with-frontmatter",
            "format": "yaml+markdown"
        }
    elif isJSON(content):
        return {
            "type": "json-config",
            "format": "json"
        }
    else:
        return {
            "type": "free-text",
            "format": "markdown"
        }
```

### 3.2. Mostrar Confirmación al Usuario

**ANTES de escribir cada preferencia**, mostrar:

```markdown
═══════════════════════════════════════════════════════════

⚒️ RECONSTRUCCIÓN #{N} de {TOTAL}

═══════════════════════════════════════════════════════════

📋 Contenido a reconstruir:

{PREVIEW_DEL_CONTENIDO}

(Si >30 líneas, mostrar primeras 20 + últimas 10)

───────────────────────────────────────────────────────────

📂 Ubicación de destino:
   Archivo: {TARGET_FILE}
   Sección: {TARGET_SECTION} (si aplica)

🔧 Formato de almacenamiento:
   {DESCRIPCION_DEL_FORMATO}

📚 Según documentación oficial:
   {EXTRACT_DE_INFO_CLAUDE_MD_SOBRE_ESTE_TIPO}

───────────────────────────────────────────────────────────

💡 Estrategia de escritura:
   - {PASO_1}
   - {PASO_2}
   - {PASO_3}

═══════════════════════════════════════════════════════════
```

Usar `AskUserQuestion`:

```
header: "Reconstrucción #{N} de {TOTAL}"
question: "¿Aplicar esta reconstrucción?"
multiSelect: false
options:
  1. label: "Sí, aplicar"
     description: "Escribir con la estructura mostrada"

  2. label: "Modificar ubicación"
     description: "Cambiar dónde se almacenará"

  3. label: "Saltar esta preferencia"
     description: "No incluir en la reconstrucción"
```

### 3.3. Ejecutar Reconstrucción

Si el usuario aprueba:

```python
def reconstruir(preference, target):
    """
    Escribe la preferencia en el archivo correcto con estructura validada.
    """

    # 1. Leer archivo actual (si existe)
    currentContent = readFile(target.file) if fileExists(target.file) else ""

    # 2. Determinar cómo insertar
    if target.format == "markdown-section":
        # Insertar como nueva sección
        newContent = insertSection(currentContent, preference.content, target.section)

    elif target.format == "yaml+markdown":
        # Asegurar frontmatter + contenido
        newContent = buildWithFrontmatter(preference.content)

    elif target.format == "json":
        # Parse y merge JSON
        newContent = mergeJSON(currentContent, preference.content)

    else:
        # Append simple
        newContent = currentContent + "\n\n" + preference.content

    # 3. Validar estructura
    if not validarEstructura(newContent, target.validations):
        return {
            "status": "error",
            "message": "Estructura inválida detectada",
            "details": "..."
        }

    # 4. Escribir usando Write tool
    writeFile(target.file, newContent)

    return {
        "status": "success",
        "message": f"✅ Reconstruido en {target.file}"
    }
```

### 3.4. Notificar Resultado

```markdown
✅ Reconstrucción #{N}: APLICADA

📁 Escrito en: {TARGET_FILE}
📊 Tamaño: {LINES} líneas

───────────────────────────────────────────────────────────
```

---

## ✅ PASO 4: Validación de Estructura

Antes de escribir, validar que el contenido resultante es correcto:

### Validaciones por Tipo

**Markdown (CLAUDE.md)**:
```python
def validarMarkdown(content):
    checks = []

    # 1. Headers válidos
    if not hasValidHeaders(content):
        checks.append("❌ Headers markdown inválidos")
    else:
        checks.append("✅ Headers válidos")

    # 2. No listas vacías
    if hasEmptyBullets(content):
        checks.append("❌ Listas con bullets vacíos")
    else:
        checks.append("✅ Listas correctas")

    # 3. No referencias rotas (si hay @imports)
    if hasBrokenRefs(content):
        checks.append("❌ Referencias rotas detectadas")
    else:
        checks.append("✅ No referencias rotas")

    return all(check.startswith("✅") for check in checks), checks
```

**YAML + Markdown (rules/*.md)**:
```python
def validarRuleFile(content):
    checks = []

    # 1. Frontmatter YAML válido
    if not hasValidYAMLFrontmatter(content):
        checks.append("❌ Frontmatter YAML inválido o faltante")
    else:
        checks.append("✅ Frontmatter YAML correcto")

    # 2. paths: definidos
    frontmatter = extractFrontmatter(content)
    if "paths" not in frontmatter:
        checks.append("❌ Falta 'paths:' en frontmatter")
    else:
        checks.append("✅ paths: definidos")

    # 3. Contenido markdown después de frontmatter
    if not hasMarkdownAfterFrontmatter(content):
        checks.append("❌ No hay contenido después del frontmatter")
    else:
        checks.append("✅ Contenido markdown presente")

    return all(check.startswith("✅") for check in checks), checks
```

**JSON (settings.json)**:
```python
def validarJSON(content):
    try:
        parsed = json.loads(content)
        return True, ["✅ JSON válido"]
    except:
        return False, ["❌ JSON inválido - syntax error"]
```

### Reporte de Validación

Si la validación falla, mostrar:

```markdown
❌ VALIDACIÓN FALLÓ

Archivo: {FILE}

Problemas detectados:
{LIST_OF_CHECKS}

⚠️ No se escribirá el archivo para evitar corrupción.

¿Deseas:
1. Ver contenido completo para revisar
2. Saltar esta reconstrucción
3. Intentar corregir automáticamente
```

---

## 🔄 PASO 5: Resumen de Reconstrucción

Al finalizar todas las reconstrucciones:

```markdown
═══════════════════════════════════════════════════════════

            ⚒️ RECONSTRUCCIÓN COMPLETADA

═══════════════════════════════════════════════════════════

📊 Resumen:

  Total preferencias procesadas: {TOTAL}
  ✅ Aplicadas exitosamente: {SUCCESS}
  ⏭️ Saltadas por decisión del usuario: {SKIPPED}
  ❌ Fallaron validación: {FAILED}

───────────────────────────────────────────────────────────

📁 Archivos reconstruidos:

  ~/.claude/CLAUDE.md
    - {N} preferencias insertadas
    - {LINES} líneas totales
    - ✅ Validación: OK

  ./CLAUDE.md
    - {N} preferencias insertadas
    - {LINES} líneas totales
    - ✅ Validación: OK

───────────────────────────────────────────────────────────

💡 Recomendaciones:

  1. Abre una nueva sesión de Claude para verificar
  2. Revisa los archivos reconstruidos manualmente
  3. El backup original está en: {BACKUP_PATH}

═══════════════════════════════════════════════════════════
```

---

## 🛡️ Reglas de Seguridad

### 1. Nunca Perder Datos

- **SIEMPRE** tener backup antes de reconstruir
- Si falla validación, NO escribir
- Si usuario cancela, mantener lo ya hecho

### 2. Managed Policy

```markdown
⚠️⚠️⚠️ MANAGED POLICY DETECTADO ⚠️⚠️⚠️

Archivo: {PATH}

Este archivo es gestionado por IT/DevOps.
NO se puede modificar mediante reconstrucción.

Saltando automáticamente...
```

### 3. Archivos en Git

Si un archivo está en git (ej: `./CLAUDE.md`):
- Preferir **vaciar** sobre **borrar**
- Mantener el archivo para preservar historial git

### 4. Auto Memory

Si se vacía `MEMORY.md`:
- Informar que Claude lo regenerará automáticamente
- No es necesario reconstruir

---

## 📋 Plantillas de Mensajes

### Confirmación de Reconstrucción

```markdown
⚒️ Reconstruyendo: {PREFERENCE_TITLE}

📄 {PREVIEW_CONTENT}

📍 Destino: {FILE} → {SECTION}

¿Aplicar?
```

### Success

```markdown
✅ {FILE}: Reconstruido correctamente
   - {N} preferencias aplicadas
   - {LINES} líneas
   - Validación: OK
```

### Warning

```markdown
⚠️ {FILE}: Validación con advertencias
   - {WARNINGS}
   - Archivo escrito pero revisa manualmente
```

### Error

```markdown
❌ {FILE}: No se pudo reconstruir
   - {ERROR_MESSAGE}
   - Saltando para evitar corrupción
```

---

## 🔧 API del Motor

Otros módulos (07-reset, 08-recovery) pueden usar:

### `acumularPreferencia(file, content, metadata)`
Añade una preferencia al plan de reconstrucción.

### `ejecutarReconstruccion(reconstructionPlan)`
Ejecuta el plan completo con confirmaciones y validaciones.

### `validarArchivo(file, content, fileType)`
Valida estructura antes de escribir.

### `purificarArchivo(file, strategy)`
Borra o vacía según documentación oficial.

---

## 🔗 Manejo Especial de Symlinks

### Problema con Symlinks

Los symlinks (como `~/.claude/skills/`) pueden causar:
- Bucles infinitos al copiar con `-r`
- Backups enormes innecesarios
- Dificultad para eliminar en reset

### Estrategia de Manejo

**En Backup**:
- NO copiar contenido del symlink
- Solo almacenar metadata en BACKUP_INDEX.md:
  ```markdown
  ### Skills (Symlink)
  - 📎 Symlink detectado
  - Target: /ruta/real/de/skills
  - Archivos: 21 archivos (.md)
  - Total líneas: 12,128
  - **Nota**: Contenido NO incluido en backup (symlink)
  ```

**En Reset/Borrado**:
- Si es symlink: Eliminar el symlink (con `rm` o `unlink`)
- NO intentar borrar el contenido del target
- Notificar:
  ```markdown
  🔗 ~/.claude/skills: Symlink eliminado
     (Target: /ruta/real - NO modificado)
  ```

**En Recovery**:
- Si backup contiene metadata de symlink: Informar al usuario
- NO restaurar (el symlink debe recrearse manualmente si es necesario)
- Advertencia:
  ```markdown
  ⚠️ Skills era un symlink en el backup
     Target original: /ruta/real

     No se puede restaurar automáticamente.
     Recrea el symlink manualmente si es necesario:
     ln -s /ruta/real ~/.claude/skills
  ```

### Detección de Symlinks

```bash
# Verificar si es symlink
if [ -L "$path" ]; then
    # Es symlink
    target=$(readlink -f "$path")
    echo "Symlink → $target"

    # NO seguir el symlink
    # Solo registrar metadata
else
    # Archivo/directorio normal
    # Procesar normalmente
fi
```

### Comandos para Eliminar Symlinks

```bash
# Eliminar symlink (NO el contenido)
rm ~/.claude/skills        # Elimina el symlink, no el target
# o
unlink ~/.claude/skills    # Más explícito
```

**IMPORTANTE**: Usar `rm` sin `-r` para eliminar solo el symlink, no el contenido.

---

*Motor de Reconstrucción Inteligente - Palantír v1.6*
*"Reforjado con maestría élfica"* ⚒️
