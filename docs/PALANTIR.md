# 🔮 Palantír v1.7 - Guía de Uso Completa

> *"La piedra que todo lo ve"*

**Palantír** es el sistema completo de gestión de configuraciones de Claude Code. Inspecciona, resetea, recupera y configura todas tus preferencias con un CRUD completo.

**Versión**: 1.7.0
**Release**: 2026-02-14
**Estado**: ✅ Producción - Completamente funcional

---

## 📖 Tabla de Contenidos

1. [¿Qué es Palantír?](#-qué-es-palantír)
2. [Requisitos Previos](#-requisitos-previos)
3. [Inicio Rápido](#-inicio-rápido)
4. [Modos de Operación](#-modos-de-operación)
   - [Inspector (READ)](#-modo-inspector-read)
   - [Reset (DELETE)](#-modo-reset-delete)
   - [Recovery (UPDATE)](#-modo-recovery-update)
   - [Configurador (CREATE)](#-modo-configurador-create)
5. [Casos de Uso](#-casos-de-uso)
6. [Troubleshooting](#-troubleshooting)
7. [FAQ](#-faq)
8. [Arquitectura](#-arquitectura)

---

## 🎯 ¿Qué es Palantír?

Palantír es una herramienta épica que te permite **gestionar todas tus configuraciones de Claude Code** siguiendo la jerarquía oficial y detectando configuraciones custom.

### **¿Qué puede hacer?**

✅ **Inspector (READ)**: Ver todas tus configuraciones en los 7 niveles de jerarquía oficial
✅ **Reset (DELETE)**: Borrar configuraciones (completo o selectivo) con backup obligatorio
✅ **Recovery (UPDATE)**: Restaurar configuraciones desde backups con merge inteligente
✅ **Configurador (CREATE)**: Añadir nuevas preferencias con detección de conflictos

### **Jerarquía Oficial Claude Code**

Palantír inspecciona estos 7 niveles (de menos a más específico):

1. **Managed Policy** - `/etc/claude-code/CLAUDE.md` (organizaciones)
2. **User Memory** - `~/.claude/CLAUDE.md` (preferencias personales globales)
3. **User Rules** - `~/.claude/rules/` (reglas modulares personales)
4. **Project Memory** - `./CLAUDE.md` (instrucciones del equipo)
5. **Project Rules** - `./.claude/rules/` (reglas modulares del proyecto)
6. **Project Local** - `./CLAUDE.local.md` (preferencias personales del proyecto, gitignored)
7. **Auto Memory** - `~/.claude/projects/<project>/memory/` (notas automáticas de Claude)

**+ Configuración adicional**: Settings, skills, symlinks, y más.

---

## 📦 Requisitos Previos

- ✅ **Claude Code** instalado y funcionando
- ✅ **Proyecto** con algunas configuraciones (o sin ellas, Palantír detecta ambos casos)
- ✅ **Acceso** a la terminal para ejecutar comandos

**Nota**: Palantír es un prompt .md, no requiere instalación.

---

## 🚀 Inicio Rápido

### **Paso 1: Obtener Palantír**

```bash
# Clonar el repositorio TLOTP
git clone https://github.com/joseguillermomoreu-gif/tlotp.git
cd tlotp
```

### **Paso 2: Cargar el Prompt**

Abre Claude Code y carga el prompt principal:

```
@prompts/palantir/palantir-main.md
```

### **Paso 3: Ejecutar**

Claude te mostrará el menú principal:

```
═══════════════════════════════════════════════════════════

                     🔮 P A L A N T Í R

             The All-Seeing Configuration Stone
                TLOTP Inspector Module v1.7

             Jerarquía Oficial Claude Code Memory

═══════════════════════════════════════════════════════════

¿Qué deseas hacer con Palantír?

1. Inspeccionar configuraciones
2. Reset de configuraciones
3. Recovery desde backup
4. Configurar característica
```

Elige una opción y sigue las instrucciones.

---

## 🎯 Modos de Operación

---

## 🔍 Modo Inspector (READ)

**¿Qué hace?**: Muestra **todas** tus configuraciones de Claude Code.

### **Cómo usarlo**

1. Carga Palantír: `@prompts/palantir/palantir-main.md`
2. Selecciona: **"Inspeccionar configuraciones"**
3. Palantír preguntará si quieres hacer backup (opcional pero recomendado)
4. Inspecciona los 7 niveles oficiales + configuración adicional
5. Al final pregunta: ¿Resumen / Conclusiones / No?

### **Ejemplo de Output - Inspección**

```markdown
═══════════════════════════════════════════════════════════

                 ✅ Backup Completado

═══════════════════════════════════════════════════════════

📦 Ubicación: /home/user/.claude/.backup-20260215-001234
📊 Total archivos: 5 (15.2K)

💡 Ver detalles completos en: BACKUP_INDEX.md

═══════════════════════════════════════════════════════════

# 📋 INSPECCIÓN DE CONFIGURACIONES

═══════════════════════════════════════════════════════════

## 🏢 1. Managed Policy (Organización)

**Descripción**: Políticas organizacionales (IT/DevOps)
**PATH**: /etc/claude-code/CLAUDE.md
**STATUS**: ❌ No existe (esperado para usuarios individuales)

---

## 👤 2. User Memory (Personal - Global)

**Descripción**: Preferencias personales para todos los proyectos
**PATH**: ~/.claude/CLAUDE.md
**STATUS**: ✅ Encontrado

# Perfil de Desarrollo - jgmoreu

## Stack Tecnológico
- Senior Backend: PHP/Symfony (8+ años)
- Testing E2E: Playwright + TypeScript
- En aprendizaje: Python para LLMs/IA

[... contenido completo ...]

---

## 📚 3. User Rules (Personal - Modular)

**Descripción**: Reglas personales por tema
**PATH directorio**: ~/.claude/rules/
**STATUS**: ❌ No existe

---

## 📁 4. Project Memory (Equipo - Compartido)

**Descripción**: Instrucciones del proyecto compartidas
**PATH**: ./CLAUDE.md
**STATUS**: ✅ Encontrado

# Proyecto TLOTP

## Comportamiento al Iniciar Sesión
- SIEMPRE leer MILESTONES.md
- Verificar tareas asignadas
[...]

---

[... más niveles ...]
```

### **Opción: Resumen**

Si eliges **"Sí, mostrar resumen"**, recibes un resumen compacto:

```markdown
═══════════════════════════════════════════════════════════

                  📊 Resumen General

═══════════════════════════════════════════════════════════

Configuración Activa de Claude Code:

Jerarquía Oficial:
  1. ❌ Managed Policy - No existe
  2. ✅ User Memory - 350 líneas
  3. ❌ User Rules - No existe
  4. ✅ Project Memory - 170 líneas
  5. ❌ Project Rules - No existe
  6. ❌ Project Local - No existe
  7. ✅ Auto Memory - MEMORY.md (200 líneas)

Configuración Adicional:
  - Skills: 21 skills (symlink a skills/)
  - Settings: settings.json local

💾 Backup completo guardado en:
/home/user/.claude/.backup-20260215-001234
```

### **Opción: Conclusiones (NUEVO en v1.7)**

Si eliges **"Sí, mostrar conclusiones y sugerencias"**, recibes análisis inteligente:

```markdown
═══════════════════════════════════════════════════════════

           🎯 Conclusiones y Sugerencias

═══════════════════════════════════════════════════════════

## 📊 Estado Actual de tu Configuración

Jerarquía Oficial Detectada:
  1. ❌ Managed Policy - No existe (esperado)
  2. ✅ User Memory - Encontrado
  3. ❌ User Rules - No existe (oportunidad de modularización)
  4. ✅ Project Memory - Encontrado
  5. ❌ Project Rules - No existe
  6. ❌ Project Local - No existe
  7. ✅ Auto Memory - Encontrado

---

## 🔍 Análisis Detallado

### 1. Estructura y Organización

**Análisis**:
- ✅ User Memory bien ubicado
- ✅ Project Memory correctamente configurado
- ⚠️ Sin modularización: No usas rules/ para organizar

**Recomendaciones**:
✅ Buenas prácticas:
  - Separación clara entre personal y proyecto

⚠️ Mejoras sugeridas:
  - Modularizar Project Memory en ./.claude/rules/
    - gitflow.md
    - testing.md
    - ci-cd.md

---

### 2. Contenido y Claridad

**Análisis**:
- ✅ User Memory conciso y bien estructurado
- ⚠️ Project Memory tiene 170 líneas en un solo archivo

**Recomendaciones**:
  - Dividir en módulos por tema
  - Usar paths: en frontmatter para reglas condicionales

---

### 3. Conflictos y Contradicciones

**Análisis**:
No se detectaron conflictos entre niveles.

✅ No hay instrucciones contradictorias

---

### 4. Optimizaciones y Eficiencia

**Recomendaciones**:
- 💡 Modularizar (Impacto: Alta mantenibilidad)
- 💡 Usar @imports para config compartida
- 💡 Considerar paths: específicos para reglas

---

## 🚀 Plan de Acción Sugerido

**Prioridad Alta** 🔴:
(ninguna - configuración sana)

**Prioridad Media** 🟡:
1. Modularizar Project Memory
2. Crear ./.claude/rules/ con módulos por tema

**Prioridad Baja** 🟢:
1. Explorar @imports para DRY
2. Añadir paths: a reglas específicas
```

---

## 🗑️ Modo Reset (DELETE)

**¿Qué hace?**: Borra configuraciones de Claude Code (con backup obligatorio).

### **Tipos de Reset**

1. **Reset Completo**: Borra todos los archivos de configuración
2. **Reset Selectivo**: Borra solo las reglas/preferencias que elijas

### **⚠️ IMPORTANTE: Backup Obligatorio**

Palantír **NO permite** hacer reset sin backup. Es una medida de seguridad crítica.

### **Cómo usarlo - Reset Completo**

1. Carga Palantír y selecciona **"Reset de configuraciones"**
2. Palantír hace backup automático (obligatorio)
3. Elige: **"Reset completo"**
4. Palantír lista TODOS los archivos que va a borrar:

```markdown
═══════════════════════════════════════════════════════════

              ⚠️ CONFIRMACIÓN DE RESET COMPLETO

═══════════════════════════════════════════════════════════

Se van a BORRAR los siguientes archivos:

Jerarquía Oficial:
  ✓ ~/.claude/CLAUDE.md (350 líneas)
  ✓ ./CLAUDE.md (170 líneas)
  ✓ ./CLAUDE.local.md (45 líneas)
  ✓ ~/.claude/projects/<project>/memory/MEMORY.md (200 líneas)

Total: 4 archivos, 765 líneas

💾 Backup guardado en:
/home/user/.claude/.backup-20260215-001234

⚠️ ESTA ACCIÓN NO SE PUEDE DESHACER
(excepto restaurando desde el backup)

¿Estás SEGURO que quieres continuar?
```

5. Confirmas: **"Sí, continuar"**
6. Palantír borra todo y muestra resultado:

```markdown
═══════════════════════════════════════════════════════════

                 ✅ Reset Completado

═══════════════════════════════════════════════════════════

Archivos eliminados: 4
Líneas borradas: 765

💾 Backup guardado en:
/home/user/.claude/.backup-20260215-001234

Para restaurar: Usa modo "Recovery desde backup"
```

### **Cómo usarlo - Reset Selectivo**

1. Elige **"Reset selectivo"**
2. Palantír extrae TODAS las reglas/preferencias de tus archivos:

```markdown
═══════════════════════════════════════════════════════════

            📋 Reglas y Preferencias Detectadas

═══════════════════════════════════════════════════════════

De ~/.claude/CLAUDE.md:
  1. Stack Tecnológico (Backend PHP/Symfony)
  2. Naming Conventions (PHP)
  3. Sistema de auto-carga de skills
  4. Principios generales (KISS, DRY)

De ./CLAUDE.md:
  5. Comportamiento al iniciar sesión
  6. Gitflow workflow
  7. Testing y QA checklist
  8. Conventional commits

Total: 8 reglas/preferencias detectadas

¿Cuáles quieres BORRAR? (números separados por coma):
```

3. Eliges las reglas a borrar: **"2,6,7"**
4. Palantír muestra preview:

```markdown
Se van a BORRAR estas reglas:

  ✓ Naming Conventions (PHP) [~/.claude/CLAUDE.md]
  ✓ Gitflow workflow [./CLAUDE.md]
  ✓ Testing y QA checklist [./CLAUDE.md]

Los archivos se reconstruirán SIN estas secciones.

¿Confirmar?
```

5. Confirmas y Palantír:
   - Extrae las secciones a borrar
   - Reconstruye archivos sin esas secciones
   - Valida estructura
   - Aplica cambios

---

## 🔄 Modo Recovery (UPDATE)

**¿Qué hace?**: Restaura configuraciones desde un backup anterior.

### **Tipos de Recovery**

1. **Reemplazar**: Sobreescribe configuración actual con el backup
2. **Combinar (Merge)**: Combina backup + configuración actual inteligentemente

### **Cómo usarlo**

1. Carga Palantír y selecciona **"Recovery desde backup"**
2. Palantír lista tus backups disponibles:

```markdown
═══════════════════════════════════════════════════════════

                 📦 Backups Disponibles

═══════════════════════════════════════════════════════════

1. backup_2026-02-15_00-12-34
   📅 2026-02-15 00:12:34
   📊 5 archivos (15.2K)
   📝 Backup realizado por: Palantír v1.7

2. backup_2026-02-14_18-30-00
   📅 2026-02-14 18:30:00
   📊 4 archivos (12.8K)
   📝 Reset completo - backup obligatorio

3. backup_2026-02-13_22-45-12
   📅 2026-02-13 22:45:12
   📊 6 archivos (18.1K)
   📝 Inspección con backup

¿Cuál quieres usar? (número o path completo):
```

3. Eliges: **"1"**
4. Palantír muestra preview del backup:

```markdown
═══════════════════════════════════════════════════════════

           📋 Contenido del Backup Seleccionado

═══════════════════════════════════════════════════════════

Archivos en este backup:

User Memory:
  └── CLAUDE.md (350 líneas)

Project Memory:
  └── CLAUDE.md (170 líneas)
  └── CLAUDE.local.md (45 líneas)

Auto Memory:
  └── MEMORY.md (200 líneas)

Otros:
  └── settings.json (50 líneas)

Total: 5 archivos, 815 líneas
```

5. Palantír pregunta qué restaurar:

```markdown
¿Qué deseas restaurar?

1. Todo (todos los archivos del backup)
2. Solo User Memory
3. Solo Project Memory
4. Solo Auto Memory
5. Archivos específicos (elegir manualmente)
```

6. Eliges: **"1 - Todo"**
7. Palantír pregunta estrategia:

```markdown
¿Cómo quieres restaurar?

1. Reemplazar
   → Borra configuración actual y pone la del backup

2. Combinar (Merge inteligente)
   → Combina backup + configuración actual
   → Detecta conflictos y propone soluciones
```

8. Si eliges **"Combinar"**, Palantír hace merge inteligente:

```markdown
═══════════════════════════════════════════════════════════

              🔀 Merge Inteligente - Análisis

═══════════════════════════════════════════════════════════

Comparando backup vs. configuración actual...

Cambios detectados:

User Memory (~/.claude/CLAUDE.md):
  ✓ Backup tiene regla "Naming PHP" que falta en actual
  ⚠️ Conflicto: "Stack Python" diferente
     - Backup: "Python 3.11 con FastAPI"
     - Actual: "Python 3.12 con Django"

Project Memory (./CLAUDE.md):
  ✓ Actual tiene "CI/CD pipeline" que falta en backup (mantener)
  ⚠️ Conflicto: "Testing QA" diferente

¿Cómo resolver los conflictos?

Para "Stack Python":
1. Usar del backup (Python 3.11 FastAPI)
2. Mantener actual (Python 3.12 Django)
3. Combinar ambos
```

9. Resuelves conflictos y Palantír aplica el merge con el Motor de Reconstrucción.

---

## ⚙️ Modo Configurador (CREATE)

**¿Qué hace?**: Añade nueva configuración con detección inteligente de conflictos.

**NUEVO en v1.7** - Sistema de configuración asistida completo.

### **Características**

✅ Detección automática de características similares
✅ Detección de conflictos y contradicciones
✅ Propuestas iterativas de combinación
✅ Reestructuración automática según info_claude.md
✅ Preview completo antes de aplicar
✅ Motor de Reconstrucción integrado

### **Cómo usarlo**

1. Carga Palantír y selecciona **"Configurar característica"**
2. Palantír pregunta qué quieres añadir:

```markdown
═══════════════════════════════════════════════════════════

              ⚙️ Sistema de Configuración Asistida

═══════════════════════════════════════════════════════════

¿Qué característica/preferencia quieres añadir?

Ejemplos:
- "Usar TypeScript strict mode"
- "Preferir React hooks sobre class components"
- "Siempre usar arquitectura hexagonal en PHP"
- "Commits en español con conventional commits"

Describe la característica:
```

3. Tú escribes: **"Usar Playwright con Page Object Model estricto"**

4. Palantír investiga:

```markdown
🔍 Investigando...

Consultando info_claude.md para determinar ubicación correcta...
✓ Tipo de regla: Testing E2E
✓ Ubicación recomendada: ./.claude/rules/testing.md
✓ Frontmatter recomendado: paths: ["tests/**/*.spec.ts"]

Buscando características similares en configuración actual...
⚠️ Encontrada característica similar:
  - Archivo: ~/.claude/CLAUDE.md
  - Sección: "Testing E2E"
  - Contenido: "Playwright + TypeScript"
```

5. Palantír detecta conflictos:

```markdown
═══════════════════════════════════════════════════════════

              🔍 Conflictos Detectados

═══════════════════════════════════════════════════════════

## Conflicto #1: Framework de Testing

**Ubicación 1**: ~/.claude/CLAUDE.md
- Testing E2E: Playwright + TypeScript

**Ubicación 2**: Nueva característica
- Usar Playwright con Page Object Model estricto

**Tipo**: Solapamiento (no contradictorio, pero relacionado)

**Impacto**: Ambos hablan de Playwright E2E

---

Total: 1 conflicto detectado
```

6. Palantír propone solución:

```markdown
═══════════════════════════════════════════════════════════

            💡 Propuesta de Combinación #1

═══════════════════════════════════════════════════════════

**Estrategia**: Unificar en una sola regla

**Ubicación**: ./.claude/rules/playwright.md (nuevo archivo)

**Contenido propuesto**:

```yaml
---
paths:
  - "tests/**/*.spec.ts"
  - "tests/**/*.ts"
---

# Playwright E2E Testing

## Stack
- Playwright + TypeScript
- Page Object Model (POM) estricto

## Reglas
- SIEMPRE usar POM pattern
- Un page object por página
- Selectores en page objects, no en tests
- Tests descriptivos en español
```

**Cambios**:
- Mover regla de Testing E2E desde ~/.claude/CLAUDE.md
- Crear ./.claude/rules/playwright.md
- Añadir especificaciones de POM

¿Aceptas esta propuesta?

1. Sí, aplicar esta propuesta
2. No, proponer otra solución
3. Modificar manualmente
4. Cancelar todo
```

7. Si eliges **"No, proponer otra"**, Palantír genera propuesta alternativa:

```markdown
═══════════════════════════════════════════════════════════

            💡 Propuesta de Combinación #2

═══════════════════════════════════════════════════════════

**Estrategia**: Mantener ambas por separado

**Configuración propuesta**:

1. ~/.claude/CLAUDE.md (global):
   - Stack general: "Playwright + TypeScript"

2. ./.claude/rules/pom-strict.md (proyecto):
   - Reglas específicas de POM

**Ventaja**: Separación global vs proyecto

¿Aceptas esta propuesta?
[... mismo menú ...]
```

8. Aceptas propuesta y Palantír muestra preview completo:

```markdown
═══════════════════════════════════════════════════════════

                  📋 Preview de Cambios

═══════════════════════════════════════════════════════════

Archivo a crear: ./.claude/rules/playwright.md

```yaml
---
name: playwright-testing
paths:
  - "tests/**/*.spec.ts"
  - "tests/**/*.ts"
---

# Playwright E2E Testing

## Stack
- Playwright + TypeScript
- Page Object Model (POM) estricto

## Reglas POM
- SIEMPRE usar POM pattern
- Un page object por página
- Selectores SOLO en page objects, NUNCA en tests
- Tests descriptivos en español

## Estructura
```
tests/
├── pages/
│   └── LoginPage.ts
└── specs/
    └── login.spec.ts
```

## Ejemplo Page Object
```typescript
export class LoginPage {
  constructor(private page: Page) {}

  // Selectores
  private usernameInput = () => this.page.locator('[data-testid="username"]');

  // Acciones
  async login(username: string, password: string) {
    await this.usernameInput().fill(username);
    // ...
  }
}
```
```

Total líneas: 45

¿Aplicar esta edición?

1. Sí, aplicar
2. No, cancelar TODO
```

9. Confirmas y Palantír:
   - Usa el Motor de Reconstrucción
   - Valida estructura
   - Crea el archivo
   - Verifica éxito

10. Palantír pregunta si quieres añadir otra característica (loop continuo).

---

## 💡 Casos de Uso

### **Caso 1: Primera vez usando Palantír**

**Situación**: Quieres ver qué configuración tienes actualmente.

**Solución**:
1. Ejecuta modo **Inspector**
2. Haz backup (recomendado)
3. Elige **"Conclusiones y sugerencias"** al final
4. Revisa el análisis y aplica mejoras sugeridas

---

### **Caso 2: Configuración corrupta o problemas**

**Situación**: Claude Code se comporta raro, sospechas config corrupta.

**Solución**:
1. Ejecuta modo **Inspector** para ver el estado
2. Si confirmas que está corrupto, usa modo **Reset**
3. Elige **Reset selectivo** para borrar solo lo problemático
4. O **Reset completo** para empezar limpio
5. Backup obligatorio te protege

---

### **Caso 3: Quieres volver a configuración anterior**

**Situación**: Hiciste cambios que no te gustan.

**Solución**:
1. Ejecuta modo **Recovery**
2. Elige el backup de cuando funcionaba bien
3. Usa **Reemplazar** para volver exactamente a ese estado
4. O **Combinar** si quieres mantener algunos cambios nuevos

---

### **Caso 4: Añadir nueva preferencia sin romper nada**

**Situación**: Quieres añadir preferencia nueva (ej: usar POM en Playwright).

**Solución**:
1. Ejecuta modo **Configurador**
2. Describe la característica
3. Palantír detecta conflictos automáticamente
4. Acepta propuesta o itera hasta que te guste
5. Preview completo antes de aplicar

---

### **Caso 5: Limpiar configuración antes de empezar proyecto nuevo**

**Situación**: Vas a empezar proyecto nuevo y quieres config limpia.

**Solución**:
1. Ejecuta modo **Inspector** para ver qué tienes
2. Usa **Reset selectivo** para borrar reglas específicas del proyecto anterior
3. Mantén tus preferencias personales globales
4. Usa **Configurador** para añadir reglas del nuevo proyecto

---

## 🔧 Troubleshooting

### **Problema: "No se encuentra archivo de configuración"**

**Causa**: No tienes configuración en ese nivel de jerarquía.

**Solución**: Es normal. Palantír muestra ❌ y continúa. No todos los niveles son obligatorios.

---

### **Problema: "Backup falló"**

**Causa**: Sin permisos de escritura en directorio de backup.

**Solución**:
```bash
# Verificar permisos
ls -la ~/.claude/

# Si no existe, crear
mkdir -p ~/.claude/.backup-$(date +%Y%m%d-%H%M%S)

# Verificar espacio en disco
df -h ~
```

---

### **Problema: "Reset no hace nada / archivo sigue ahí"**

**Causa**: El archivo puede estar en otra ubicación o ser un symlink.

**Solución**:
1. Ejecuta **Inspector** para ver ubicación exacta
2. Verifica si es symlink (Palantír lo indica)
3. Si es symlink, borra el destino manualmente si es necesario

---

### **Problema: "Recovery combina mal / conflictos extraños"**

**Causa**: Merge inteligente detectó contenido muy diferente.

**Solución**:
1. Usa **Recovery → Reemplazar** en lugar de Combinar
2. O haz recovery manual:
   ```bash
   # Copiar backup manualmente
   cp ~/.claude/.backup-*/CLAUDE.md ~/.claude/CLAUDE.md
   ```

---

### **Problema: "Configurador crea archivo corrupto"**

**Causa**: Bug en Motor de Reconstrucción (reportar si ocurre).

**Solución**:
1. NO te preocupes, Palantír hizo backup automático
2. Usa **Recovery** para restaurar desde el último backup
3. Reporta el bug con el issue en GitHub

---

### **Problema: "Palantír es muy lento"**

**Causa**: Muchos archivos en `~/.claude/` o auto memory muy grande.

**Solución**:
1. Limpia backups antiguos:
   ```bash
   # Ver backups
   ls -lh ~/.claude/.backup-*

   # Borrar antiguos (> 30 días)
   find ~/.claude/.backup-* -mtime +30 -exec rm -rf {} \;
   ```

2. Compacta auto memory si tiene >200 líneas (solo primeras 200 se cargan)

---

## ❓ FAQ

### **¿Palantír modifica mis archivos?**

**Solo en modos Reset, Recovery y Configurador**. El modo Inspector es **solo lectura**, jamás modifica nada.

---

### **¿Es seguro usar Reset?**

**Sí**, Palantír **obliga** a hacer backup antes de cualquier reset. No puedes resetear sin backup.

---

### **¿Qué pasa si cancelo en medio de una operación?**

**No pasa nada crítico**. Palantír:
- En Inspector: No ha modificado nada
- En Reset/Recovery/Configurador: Pregunta confirmación **antes** de aplicar cambios
- Si cancelas antes de confirmar, **no se aplica nada**

---

### **¿Puedo usar Palantír en múltiples proyectos?**

**Sí**, Palantír funciona en cualquier proyecto. La configuración User Memory es global, pero Project Memory es específico de cada proyecto.

---

### **¿Dónde se guardan los backups?**

**En `~/.claude/.backup-<timestamp>/`** con esta estructura:

```
~/.claude/.backup-20260215-001234/
├── BACKUP_INDEX.md          # Índice con metadata
├── user-memory/
│   └── CLAUDE.md
├── project-memory/
│   ├── CLAUDE.md
│   └── CLAUDE.local.md
├── auto-memory/
│   └── MEMORY.md
└── other-configs/
    └── settings.json
```

---

### **¿Cuánto espacio ocupan los backups?**

**Muy poco**, típicamente 10-50KB por backup. Configuraciones son texto plano.

---

### **¿Puedo restaurar backup de otro proyecto?**

**Técnicamente sí**, pero no es recomendado. Los backups son específicos del proyecto desde donde se ejecutó Palantír. Mezclar puede causar conflictos.

---

### **¿Qué hace el "Motor de Reconstrucción"?**

**Es el sistema que reconstruye archivos** después de Reset Selectivo o Configurador. Asegura que el archivo resultante:
- Tenga estructura válida (frontmatter, secciones)
- No esté corrupto
- Mantenga formato consistente

---

### **¿Palantír funciona sin internet?**

**Sí**, Palantír es completamente local. Solo lee/escribe archivos en tu máquina.

---

### **¿Cómo actualizo Palantír?**

```bash
cd tlotp
git pull origin master
```

Luego recarga el prompt en Claude Code.

---

### **¿Palantír escribe en mi MEMORY.md?**

**NO**. Palantír tiene regla crítica: **jamás contamina el auto memory del proyecto**. Solo inspecciona (lectura) pero no escribe.

---

### **¿Cuál es la diferencia entre User Memory y Project Memory?**

- **User Memory** (`~/.claude/CLAUDE.md`): Preferencias **personales globales** para todos tus proyectos
- **Project Memory** (`./CLAUDE.md`): Instrucciones **del equipo** específicas de este proyecto (versionadas en Git)

---

### **¿Qué hago si Palantír detecta muchos conflictos?**

**Es bueno**, significa que tu configuración tiene overlaps. Palantír te ayuda a resolverlos con propuestas iterativas. Acepta, rechaza o modifica hasta que quede como quieres.

---

## 🏗️ Arquitectura

### **Módulos de Palantír v1.7**

Palantír está construido con **arquitectura modular** (11 módulos):

```
prompts/palantir/
├── palantir-main.md                  # Entry point
└── sections/
    ├── 00-menu-principal.md          # Menú interactivo
    ├── 01-metadata.md                # Banner y misión
    ├── 02-backup-system.md           # Sistema de backups
    ├── 03-jerarquia-oficial.md       # Inspector de 7 niveles
    ├── 04-exploracion-custom.md      # Detección genérica
    ├── 05-formato-output.md          # Templates de output
    ├── 06-reglas-ejecucion.md        # Flujo del Inspector
    ├── 07-reset-system.md            # Sistema de Reset
    ├── 08-recovery-system.md         # Sistema de Recovery
    ├── 09-reconstruction-engine.md   # Motor de Reconstrucción
    └── 10-configurator-system.md     # Sistema Configurador
```

**Total**: ~3,830 líneas de prompts

---

### **Flujo de Ejecución**

```
Usuario carga palantir-main.md
         ↓
00-menu-principal.md muestra opciones
         ↓
    ┌────┴────┬────────┬─────────┐
    ↓         ↓        ↓         ↓
Inspector  Reset  Recovery  Configurador
    ↓         ↓        ↓         ↓
Backup    Backup   Elige    Detecta
  ↓         ↓      backup   conflictos
Inspecciona ↓        ↓         ↓
7 niveles  Confirma Merge    Propone
  ↓         ↓        ↓      soluciones
Muestra   Motor de  Motor     ↓
output   Recons.   Recons.  Motor de
  ↓         ↓        ↓      Recons.
Resumen/  Notifica Notifica Notifica
Conclus.    ✓        ✓        ✓
```

---

### **Tecnologías**

- **Lenguaje**: Markdown con instrucciones para Claude Code
- **Tools**: Read, Edit, Write, Bash, Grep, Glob, AskUserQuestion
- **Versionado**: Git (GitHub)
- **Testing**: Manual exhaustivo (validado v1.7)

---

### **Principios de Diseño**

1. **Seguridad primero**: Backup obligatorio antes de operaciones destructivas
2. **Confirmación explícita**: Nunca aplicar cambios sin confirmación del usuario
3. **Transparencia total**: Mostrar siempre qué se va a hacer antes de hacerlo
4. **Reversibilidad**: Todo cambio es reversible vía Recovery
5. **Modularidad**: Cada módulo tiene una responsabilidad única
6. **No contaminar**: Palantír no escribe en auto memory del proyecto

---

## 📚 Recursos Adicionales

- **Repositorio**: [github.com/joseguillermomoreu-gif/tlotp](https://github.com/joseguillermomoreu-gif/tlotp)
- **Issues**: [GitHub Issues](https://github.com/joseguillermomoreu-gif/tlotp/issues)
- **Milestones**: Ver [MILESTONES.md](../MILESTONES.md)
- **Contribuir**: Ver [CONTRIBUTING.md](../CONTRIBUTING.md)

---

## 🎉 ¡Listo para Usar Palantír!

Ahora que conoces todos los modos y características, estás listo para dominar tus configuraciones de Claude Code.

**Siguiente paso**: Ejecuta modo **Inspector** para ver el estado actual de tu configuración.

```
@prompts/palantir/palantir-main.md
```

---

**Palantír v1.7** - "La piedra que todo lo ve" 🔮
*One Prompt to Rule Them All* 💍

---

**Changelog**:
- **v1.7.0** (2026-02-14): Sistema de Configuración Asistida, Conclusiones inteligentes, Loop continuo
- **v1.6.0** (2026-02-13): Motor de Reconstrucción Inteligente, Prevención auto-memory
- **v1.5.0** (2026-02-13): Sistema Reset y Recovery completos
- **v1.3.0** (2026-02-13): Arquitectura modular con 6 módulos
- **v1.2.0**: Inspector completo funcional

---

*Documentación creada: 2026-02-15*
*Última actualización: 2026-02-15*
