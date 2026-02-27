# 📋 Inspección de Jerarquía Oficial

## 📖 Documentación Oficial (Live)

**ANTES de ejecutar la inspección**, obtener la jerarquía actualizada:

> **WebFetch**: https://code.claude.com/docs/en/memory
> **Extraer**:
> - Tabla completa de tipos de memoria (ubicaciones, propósitos, scope)
> - Jerarquía de precedencia
> - Estructura de auto memory
> - Sistema de rules con paths
> - Sistema de @imports

**Usar la información obtenida como fuente de verdad** para todos los niveles de inspección.

---

## Procedimiento de Inspección

Debes inspeccionar **TODA la jerarquía oficial de memoria** de Claude Code en el orden que indique la documentación oficial.

## Para CADA ubicación de memoria:

1. **Indica el PATH completo** del archivo/directorio
2. **Muestra el CONTENIDO COMPLETO** sin modificar nada
3. **Indica STATUS**: ✅ Encontrado / ❌ No existe / ⚠️ Sin permisos
4. **NO formatees, NO resumas, NO filtres** - muestra todo tal cual
5. **Solicita** al usuario todos los permisos que necesites para acceder/leer/copiar los ficheros

---

## Niveles de Inspección

Inspeccionar cada nivel según la documentación oficial obtenida via WebFetch.
Para cada nivel, seguir estas instrucciones específicas:

### Managed Policy (Organización)

**Qué mostrar**:
- PATH completo del archivo (según OS detectado)
- STATUS (✅/❌/⚠️)
- Contenido completo si existe

---

### User Memory (Personal - Global)

**Qué mostrar**:
- PATH completo
- STATUS
- Contenido completo
- **Detectar imports**: Si el archivo contiene `@path/to/file`, listar qué archivos importa

---

### User Rules (Personal - Modular)

**Qué mostrar**:
- PATH del directorio
- Listar TODOS los archivos `.md` recursivamente (incluyendo subdirectorios)
- Para cada archivo:
  - PATH completo
  - Si tiene YAML frontmatter con `paths:`, mostrarlo
  - Contenido completo del archivo
  - Si es symlink, indicar a qué apunta

---

### Project Memory (Equipo - Compartido)

**Qué mostrar**:
- Buscar en ambas ubicaciones posibles (raíz y directorio oculto)
- Buscar recursivamente hacia ARRIBA hasta la raíz
- Para cada CLAUDE.md encontrado: PATH, STATUS, contenido
- **Detectar imports**: Si contiene `@path/to/file`, listar archivos importados

---

### Project Rules (Equipo - Modular)

**Qué mostrar**:
- PATH del directorio
- Listar TODOS los archivos `.md` recursivamente
- Estructura de subdirectorios
- Para cada archivo:
  - PATH completo
  - Si tiene YAML frontmatter con `paths:`, mostrarlo
  - Contenido completo del archivo
  - Si es symlink, indicar a qué apunta y mostrar contenido del destino

---

### Project Local (Personal - No en Git)

**Qué mostrar**:
- PATH completo
- STATUS
- Contenido completo
- **Detectar imports**: Si contiene `@path/to/file`, listar archivos importados

---

### Auto Memory (Claude Auto-Guarda)

**Qué mostrar**:
- PATH completo del directorio de auto memory
- Listar TODOS los archivos en el directorio
- Para `MEMORY.md`:
  - Mostrar **SOLO las primeras 200 líneas** (resto no se carga en Claude)
  - Indicar cuántas líneas tiene en total
- Para otros archivos (topic files):
  - Nombre y número de líneas
  - PATH completo
  - **NO mostrar contenido completo** (son topic files que Claude lee on-demand)

---

## 🔧 Manejo de Problemas de Acceso

Si encuentras problemas de permisos al leer CUALQUIER archivo:

1. **Intenta primero** con Read tool
2. **Si falla por permisos**, usa `AskUserQuestion`:
   ```
   header: "Permisos"
   question: "No puedo leer [NOMBRE_ARCHIVO] con Read. ¿Intentar con Bash?"
   options:
     1. label: "Sí, intentar con Bash"
        description: "Leer usando cat (puede requerir permisos especiales)"
     2. label: "No, continuar sin este archivo"
        description: "Omitir y continuar con la inspección"
   ```
3. **Si usuario acepta**: Usa `cat [path]` con Bash
4. **Si aún así falla o usuario rechaza**: Marca STATUS como ⚠️ Sin permisos y continúa
