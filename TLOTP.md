# TLOTP - The Lord of the Prompt

> **The Lord of the Prompt**: Un único super-prompt para auto-configurar Claude Code de forma asistida, inteligente y evolutiva.

**Fecha**: 2026-02-09
**Autor**: José Guillermo Moreu
**Estado**: Diseño - Especificación completa

---

## 🎯 Visión

**Problema actual** con claude-code-auto-skills:
- Requiere instalación (scripts bash)
- Skills como archivos estáticos que se desactualizan
- Solo cubre "skills" (convenciones de código)
- Complejidad de mantenimiento
- No portable entre usuarios

**Nueva visión - TLOTP**:
Un **único prompt .md** que configura Claude Code de forma asistida, cubriendo:
- ✅ Workflow (gitflow, commits, PRs, merge)
- ✅ Git preferences
- ✅ QA (tests, linting, coverage)
- ✅ Deploy (CI/CD, manual, scripts)
- ✅ Skills (stack tech, convenciones, patterns)
- ✅ Arquitectura
- ✅ Cualquier cosa que necesites recordar

**Sin instalación. Sin scripts. Solo un prompt.**

---

## 🏗️ Arquitectura del Sistema

### **Componentes:**

```
TLOTP/
├── TLOTP-prompt.md         # El super-prompt interactivo
├── TLOTP.md               # Esta especificación
├── examples/              # Ejemplos de configs generadas
│   ├── CLAUDE.md.example
│   └── MEMORY.md.example
└── docs/
    ├── USAGE.md           # Cómo usar TLOTP
    └── FAQ.md             # Preguntas frecuentes
```

### **Archivos que TLOTP Gestiona:**

```
~/.claude/
├── CLAUDE.md              # Config global (TLOTP escribe aquí)
└── projects/
    └── PROYECTO/
        └── memory/
            └── MEMORY.md  # Config del proyecto (TLOTP escribe aquí)

~/.claude/skills/          # Skills generadas on-the-fly
├── python-20260209.md     # Skill con fecha de generación
├── symfony-20260209.md
└── react-20260209.md

/proyecto/
└── CLAUDE.md             # Opcional: config específica del proyecto
```

---

## 🔄 Flujo de Trabajo

### **Primera Vez - Usuario Nuevo:**

```
1. Usuario pega TLOTP-prompt.md en Claude Code
2. TLOTP detecta: No hay configuración previa
3. TLOTP hace preguntas interactivas:

   === Configuración de Claude Code ===

   ## Workflow
   ¿Qué estrategia de branching usas?
   1) Gitflow (master + develop + feature/hotfix/release)
   2) GitHub Flow (main + feature branches)
   3) Trunk-based (solo main)
   4) Otro (especifica)

   Opción: _

   ¿Usas conventional commits?
   1) Sí, siempre (feat/fix/docs/chore)
   2) Sí, pero no estricto
   3) No

   Opción: _

   ## Git Preferences
   ¿Cómo prefieres hacer commits?
   1) Automático (Claude hace commit después de cambios)
   2) Manual (yo te pido cuando commitear)
   3) Preguntar cada vez

   Opción: _

   ... [20-30 preguntas más]

4. Usuario responde todas las preguntas

5. TLOTP genera y escribe:
   - ~/.claude/CLAUDE.md (config global)
   - ~/.claude/projects/PROYECTO/memory/MEMORY.md (config proyecto)
   - ~/.claude/skills/ (skills necesarias on-the-fly)

6. TLOTP confirma:

   ✅ Configuración completa!

   Archivos creados:
   - ~/.claude/CLAUDE.md (tu configuración global)
   - ~/.claude/projects/.../memory/MEMORY.md (config de este proyecto)
   - ~/.claude/skills/python-20260209.md (skill generada)
   - ~/.claude/skills/symfony-20260209.md (skill generada)

   En tu próxima sesión, Claude Code ya sabrá:
   - Usas Gitflow con conventional commits
   - Tests en Docker
   - Deploy con GitHub Actions
   - Stack: PHP/Symfony + TypeScript/React
   - Naming: camelCase PHP, snake_case Python
   - ... todo lo configurado

   ¡Listo para trabajar!
```

---

### **Usuario con Configuración Existente:**

```
1. Usuario pega TLOTP-prompt.md
2. TLOTP detecta: Ya hay ~/.claude/CLAUDE.md

3. TLOTP analiza y muestra:

   === Configuración Existente Detectada ===

   Encontré tu configuración actual:

   Workflow:
   - Gitflow (master + develop)
   - Conventional commits obligatorios
   - Auto-merge cuando CI pasa

   Stack:
   - PHP/Symfony (arquitectura hexagonal)
   - TypeScript/React
   - Playwright E2E

   QA:
   - Tests en Docker
   - PHPStan level 9
   - Coverage mínimo 80%

   Deploy:
   - GitHub Actions CI/CD
   - Deploy automático a staging
   - Deploy manual a producción

   Skills cargadas:
   - php-symfony (generada hace 5 días)
   - typescript (generada hace 3 días)
   - playwright (generada hace 10 días ⚠️ antigua)

   ¿Qué quieres hacer?
   1) Mantener y solo actualizar skills antiguas
   2) Añadir nueva configuración (sin borrar existente)
   3) Reconfigurar todo desde cero
   4) Solo actualizar skills con Context7

   Opción: _

4. Usuario elige (ej: opción 1)

5. TLOTP actualiza skills antiguas:

   Actualizando playwright skill con Context7...
   ✅ playwright-20260209.md generada

   Configuración actualizada.
```

---

## 🎨 Skills On-The-Fly

### **Concepto:**

Las skills NO son archivos estáticos pre-creados. Se **generan on-the-fly** cuando se necesitan.

### **Funcionamiento:**

1. **Generación:**
   - Usuario configura stack: "Uso Python + FastAPI"
   - TLOTP detecta: Necesita skill de Python
   - TLOTP usa Context7 para obtener docs actualizadas
   - Genera `~/.claude/skills/python-20260209.md`
   - Fecha en nombre del archivo = fecha de generación

2. **Referencia:**
   ```markdown
   # ~/.claude/CLAUDE.md

   ## Skills Activas

   - python (generada: 2026-02-09)
   - fastapi (generada: 2026-02-09)
   - typescript (generada: 2026-02-01)
   ```

3. **Auto-actualización:**
   ```markdown
   # ~/.claude/CLAUDE.md

   ## Sistema de Skills

   ### Regla de Actualización
   - Si skill tiene más de 7 días, preguntar si actualizar
   - Si skill tiene más de 30 días, avisar que está desactualizada
   - Actualización usa Context7 para docs más recientes

   ### Skills Cargadas

   Al inicio de cada sesión, verificar:
   1. Leer fecha de cada skill activa
   2. Calcular días desde generación
   3. Si > 7 días: Preguntar "¿Actualizar python skill? (generada hace 8 días)"
   4. Si usuario acepta: Regenerar con Context7
   ```

4. **Contenido de Skill:**
   ```markdown
   # Python Skill

   > **Generada**: 2026-02-09
   > **Fuente**: Context7 (Python 3.12 docs)
   > **Última actualización docs**: 2026-02-01

   ## Naming Conventions
   - Clases: PascalCase
   - Funciones: snake_case
   - Constantes: UPPER_SNAKE_CASE

   ## Type Hints (Python 3.12+)
   ... [contenido generado con Context7]

   ## Async/Await Patterns
   ... [contenido actualizado]

   ## Best Practices 2026
   ... [prácticas más recientes]
   ```

---

## 📝 Estructura del Prompt

### **TLOTP-prompt.md:**

```markdown
# TLOTP - The Lord of the Prompt
# Configurador Asistido de Claude Code

Eres un asistente de configuración de Claude Code. Tu objetivo es configurar
de forma óptima el entorno del usuario mediante preguntas interactivas.

## Paso 1: Detección de Configuración Existente

[Instrucciones para leer ~/.claude/CLAUDE.md]
[Instrucciones para leer ~/.claude/projects/PROYECTO/memory/MEMORY.md]
[Instrucciones para leer /proyecto/CLAUDE.md]

Si existe configuración:
- Mostrar resumen de config actual
- Preguntar qué hacer (mantener/actualizar/reconfigurar)

Si NO existe configuración:
- Informar que harás configuración inicial
- Proceder a Paso 2

## Paso 2: Preguntas Interactivas

### Sección 1: Workflow y Git

1. ¿Qué estrategia de branching usas?
   a) Gitflow (master + develop + feature/hotfix/release)
   b) GitHub Flow (main + feature)
   c) Trunk-based (solo main)
   d) Otro: ___

2. ¿Convención de commits?
   a) Conventional Commits (feat/fix/docs/chore)
   b) Libre
   c) Otro: ___

3. ¿Naming de branches?
   a) feature/t_XX_descripcion (con issue number)
   b) feature/descripcion (sin issue)
   c) Otro: ___

4. ¿Cómo hacer commits?
   a) Automático (Claude commitea después de cambios)
   b) Manual (usuario pide commit)
   c) Preguntar cada vez

5. ¿Merge strategy?
   a) Squash merge (recomendado)
   b) Merge commits
   c) Rebase

6. ¿Auto-merge cuando CI pasa?
   a) Sí, siempre
   b) Solo en develop
   c) No, manual

### Sección 2: Testing y QA

7. ¿Dónde ejecutar tests?
   a) Local (npm test, pytest, etc.)
   b) Docker (docker exec ... npm test)
   c) Solo en CI

8. ¿Testing framework?
   [Detectar de package.json/composer.json/pyproject.toml]
   - Node.js: Jest/Vitest/Mocha
   - PHP: PHPUnit/Pest
   - Python: pytest/unittest

9. ¿Linting?
   a) Sí, antes de commit
   b) Solo en CI
   c) No

10. ¿Coverage mínimo?
    a) 80%
    b) 70%
    c) Sin mínimo
    d) Otro: ___

### Sección 3: Deploy

11. ¿Estrategia de deploy?
    a) CI/CD automático (GitHub Actions/GitLab CI)
    b) Scripts manuales
    c) Manual (FTP, SSH, etc.)

12. ¿Cuándo desplegar?
    a) Automático al merge a main
    b) Manual con comando
    c) Preguntar cada vez

13. ¿Ambientes?
    a) staging + production
    b) solo production
    c) dev + staging + production

### Sección 4: Stack Tecnológico

14. ¿Backend framework?
    [Detectar de archivos: composer.json, package.json, pyproject.toml]
    a) PHP/Symfony
    b) PHP/Laravel
    c) Python/Django
    d) Python/FastAPI
    e) Node.js/NestJS
    f) Node.js/Express
    g) Go
    h) Otro: ___

15. ¿Frontend framework?
    [Detectar de package.json]
    a) React
    b) Vue
    c) Angular
    d) Svelte
    e) Vanilla JS/TypeScript
    f) Otro: ___

16. ¿Testing E2E?
    [Detectar playwright.config.ts, cypress.json]
    a) Playwright
    b) Cypress
    c) Selenium
    d) No uso E2E

### Sección 5: Convenciones de Código

17. ¿Naming conventions backend?
    a) camelCase (PHP, JavaScript)
    b) snake_case (Python, Ruby)
    c) PascalCase para clases, camelCase para métodos
    d) Detectar automáticamente del proyecto

18. ¿Arquitectura backend?
    a) Hexagonal (Ports & Adapters)
    b) MVC tradicional
    c) Clean Architecture
    d) Ninguna en particular

19. ¿Style guide?
    a) PSR-12 (PHP)
    b) PEP 8 (Python)
    c) Airbnb (JavaScript)
    d) Google (varios lenguajes)
    e) Custom

### Sección 6: Preferencias Personales

20. ¿Nivel de proactividad de Claude?
    a) Alto (Claude sugiere mejoras automáticamente)
    b) Medio (Claude pregunta antes de sugerir)
    c) Bajo (solo hacer lo pedido)

21. ¿Documentación?
    a) Documentar todo (funciones, clases, módulos)
    b) Solo lo complejo
    c) Mínima documentación

22. ¿Emojis en commits/código?
    a) Sí, usar emojis
    b) No, nunca
    c) Solo en commits

23. ¿Code review?
    a) Siempre pedir review antes de commit
    b) Solo en cambios grandes
    c) No necesario

## Paso 3: Generación de Configuración

Basado en respuestas, generar:

### ~/.claude/CLAUDE.md

```markdown
# Configuración Global de Claude Code

> **Generado por**: TLOTP v1.0.0
> **Fecha**: 2026-02-09
> **Usuario**: José Guillermo Moreu

## Workflow y Git

- **Estrategia**: [respuesta pregunta 1]
- **Commits**: [respuesta pregunta 2]
- **Branch naming**: [respuesta pregunta 3]
- **Commit mode**: [respuesta pregunta 4]
- **Merge strategy**: [respuesta pregunta 5]
- **Auto-merge**: [respuesta pregunta 6]

## Testing y QA

- **Tests location**: [respuesta pregunta 7]
- **Framework**: [respuesta pregunta 8]
- **Linting**: [respuesta pregunta 9]
- **Coverage**: [respuesta pregunta 10]

## Deploy

- **Strategy**: [respuesta pregunta 11]
- **Timing**: [respuesta pregunta 12]
- **Environments**: [respuesta pregunta 13]

## Stack Tecnológico

- **Backend**: [respuesta pregunta 14]
- **Frontend**: [respuesta pregunta 15]
- **E2E Testing**: [respuesta pregunta 16]

## Convenciones de Código

- **Naming**: [respuesta pregunta 17]
- **Architecture**: [respuesta pregunta 18]
- **Style guide**: [respuesta pregunta 19]

## Preferencias Personales

- **Proactividad**: [respuesta pregunta 20]
- **Documentación**: [respuesta pregunta 21]
- **Emojis**: [respuesta pregunta 22]
- **Code review**: [respuesta pregunta 23]

## Sistema de Skills

### Skills Activas

[Lista de skills generadas según stack]

### Regla de Actualización

Si una skill tiene:
- Más de 7 días: Preguntar si actualizar
- Más de 30 días: Avisar que está desactualizada

Al actualizar:
1. Usar Context7 para obtener docs más recientes
2. Regenerar skill con fecha actual
3. Actualizar referencias en este archivo

### Cómo Cargar Skills

Al inicio de cada sesión:
1. Verificar fechas de skills activas
2. Si alguna > 7 días: Preguntar actualización
3. Cargar contenido de skills en contexto
4. Aplicar convenciones definidas

## Instrucciones para Claude Code

Cuando trabajes en este proyecto:

1. **Siempre** seguir el workflow definido arriba
2. **Siempre** aplicar naming conventions del stack
3. **Siempre** ejecutar tests como se indica
4. **Siempre** seguir la estrategia de deploy
5. **Antes de commit**: Verificar que cumple convenciones
6. **Nunca** hacer cambios destructivos sin confirmar

## Auto-mantenimiento

Este archivo puede ser actualizado por:
- TLOTP (re-ejecutar el prompt)
- Usuario (edición manual)
- Claude Code (mejoras sugeridas con aprobación)

Para actualizar: Pega TLOTP-prompt.md de nuevo y elige "actualizar configuración".
```

### ~/.claude/projects/PROYECTO/memory/MEMORY.md

```markdown
# Memory - [Nombre del Proyecto]

> **Proyecto**: [nombre detectado]
> **Path**: [path del proyecto]
> **Configurado**: 2026-02-09

## Stack Detectado

- Backend: [framework detectado]
- Frontend: [framework detectado]
- Database: [detectado de .env, docker-compose, etc.]
- Testing: [frameworks detectados]

## Comandos Útiles

[Generados según stack]

### Tests
\`\`\`bash
[comando según respuesta pregunta 7]
\`\`\`

### Linting
\`\`\`bash
[comando de linting]
\`\`\`

### Deploy
\`\`\`bash
[comando según estrategia]
\`\`\`

## Notas Específicas del Proyecto

[Espacio para que Claude o usuario añadan notas específicas]

## Skills Necesarias

Según el stack detectado, se cargaron:
- [skill 1] (generada: 2026-02-09)
- [skill 2] (generada: 2026-02-09)

---
*Auto-gestionado por Claude Code + TLOTP*
```

### ~/.claude/skills/[SKILL]-YYYYMMDD.md

Generada on-the-fly usando Context7.

## Paso 4: Confirmación

Mostrar resumen de archivos creados/actualizados y siguiente pasos.

```

---

## 🎯 Casos de Uso

### **Caso 1: Nuevo Usuario de Claude Code**

**Usuario**: Acaba de instalar Claude Code, quiere configurarlo óptimamente.

**Flujo**:
1. Descarga TLOTP-prompt.md
2. Abre Claude Code en su proyecto principal
3. Pega el contenido de TLOTP-prompt.md
4. Responde ~20 preguntas
5. ✅ Claude Code configurado globalmente
6. Todas las futuras sesiones ya tienen contexto

---

### **Caso 2: Usuario Experimentado con Configs Existentes**

**Usuario**: Lleva 1 año usando Claude Code, tiene su ~/.claude/CLAUDE.md ya configurado.

**Flujo**:
1. Pega TLOTP-prompt.md
2. TLOTP detecta config existente
3. Muestra resumen de lo que tiene
4. Ofrece opciones:
   - Actualizar skills antiguas
   - Añadir nueva configuración
   - Reconfigurar desde cero
5. Usuario elige "actualizar skills"
6. ✅ Skills regeneradas con docs actualizadas

---

### **Caso 3: Nuevo Proyecto con Stack Diferente**

**Usuario**: Tiene config global para PHP/Symfony, pero abre proyecto Python/Django.

**Flujo**:
1. Abre Claude Code en proyecto Python
2. Pega TLOTP-prompt.md
3. TLOTP detecta:
   - Config global: PHP/Symfony
   - Proyecto actual: Python/Django ← diferente
4. TLOTP pregunta:
   ```
   Config global es PHP/Symfony pero este proyecto es Python/Django.

   ¿Configurar este proyecto?
   a) Sí, usar Django para este proyecto (crear MEMORY.md específico)
   b) No, usar config global de Symfony (no recomendado)
   ```
5. Usuario elige (a)
6. ✅ Proyecto configurado con Python/Django
7. ✅ Skills de Python generadas
8. Config global PHP/Symfony se mantiene para otros proyectos

---

## 🔧 Uso del Prompt

### **Opción 1: Copy-Paste**

```bash
# 1. Descargar TLOTP-prompt.md
curl -O https://raw.githubusercontent.com/USER/TLOTP/main/TLOTP-prompt.md

# 2. Abrir en editor, copiar todo el contenido

# 3. Abrir Claude Code en proyecto

# 4. Pegar contenido en Claude Code

# 5. Responder preguntas interactivas
```

---

### **Opción 2: Path al Archivo**

```bash
# 1. Descargar TLOTP-prompt.md en ubicación conocida
mkdir -p ~/.tlotp
curl -o ~/.tlotp/TLOTP-prompt.md https://raw.githubusercontent.com/USER/TLOTP/main/TLOTP-prompt.md

# 2. En Claude Code, decir:
"Ejecuta el prompt en ~/.tlotp/TLOTP-prompt.md"

# 3. Claude lee el archivo y ejecuta
```

---

## 📊 Comparación: claude-code-auto-skills vs TLOTP

| Aspecto | claude-code-auto-skills | TLOTP |
|---------|-------------------------|-------|
| **Instalación** | Scripts bash (install.sh, update.sh) | ❌ Ninguna |
| **Complejidad** | Alta (scripts, symlinks, backups) | ✅ Baja (solo prompt) |
| **Skills** | Archivos .md estáticos pre-creados | ✅ Generadas on-the-fly con Context7 |
| **Actualización skills** | Manual (git pull + update.sh) | ✅ Automática (pregunta cada 7 días) |
| **Scope** | Solo skills (convenciones código) | ✅ Workflow + Git + QA + Deploy + Skills + Todo |
| **Portabilidad** | Instalar en cada máquina | ✅ Universal (cualquier Claude Code) |
| **Mantenimiento** | Mantener 20 archivos .md + scripts | ✅ Mínimo (prompt + docs actualizadas vía Context7) |
| **Para usuarios nuevos** | Instalar, configurar, aprender | ✅ Pegar prompt, responder preguntas |
| **Para usuarios avanzados** | Funciona pero limitado | ✅ Retroalimenta config existente |
| **Dependencias** | Git, bash, scripts funcionando | ✅ Solo Claude Code |
| **Personalización** | Editar .md manualmente | ✅ Re-ejecutar prompt, responder diferente |
| **Skills desactualizadas** | Quedan obsoletas hasta manual update | ✅ Auto-detecta y pregunta actualizar |

---

## 🚀 Ventajas de TLOTP

### **1. Simplicidad**
- No instalación
- No scripts
- No mantenimiento de archivos
- Solo un prompt

### **2. Potencia**
- Configura MUCHO más que skills
- Workflow completo
- Git, QA, Deploy
- Todo en un solo lugar

### **3. Actualización Automática**
- Skills se regeneran con docs actualizadas
- Usa Context7 para último contenido
- Pregunta cada X días si actualizar

### **4. Portabilidad**
- Funciona en cualquier Claude Code
- Sin instalar nada
- Universal entre usuarios

### **5. Retroalimentación**
- Lee config existente
- Sugiere mejoras
- No sobrescribe, mejora

### **6. Evolutivo**
- Fácil añadir nuevas preguntas al prompt
- Fácil mejorar generación de skills
- Fácil adaptar a nuevos frameworks

---

## 📁 Proyecto claude-code-auto-skills

### **Su Rol:**

✅ **Prototipo exitoso** que sirvió para:
- Profundizar en Claude Code
- Entender cómo funciona internamente
- Descubrir sistema de memory/ nativo
- Prototipar la idea de skills
- Aprender qué funciona y qué no

### **Estado Final:**

📦 **Archivar con nota**:

```markdown
# claude-code-auto-skills

> **Estado**: Archived - Evolucionado a TLOTP
> **Fecha**: 2026-02-09

## ¿Qué fue este proyecto?

Un sistema de skills auto-cargables para Claude Code que:
- Auto-detectaba stack tecnológico
- Cargaba skills (.md) relevantes
- Instalaba vía scripts bash

## ¿Por qué se archivó?

Este proyecto sirvió como **prototipo de aprendizaje** para:
- ✅ Profundizar en Claude Code
- ✅ Entender su funcionamiento interno
- ✅ Descubrir sistema nativo de memory/
- ✅ Prototipar concepto de skills

Durante el desarrollo, descubrimos una **solución mucho mejor**:

→ **TLOTP (The Lord of the Prompt)**

## Nueva Versión: TLOTP

[Link al nuevo repositorio]

TLOTP es una evolución que:
- ❌ No requiere instalación
- ✅ Es un único super-prompt
- ✅ Configura workflow completo (no solo skills)
- ✅ Skills generadas on-the-fly con Context7
- ✅ Auto-actualización automática
- ✅ Universal y portable

## Agradecimientos

Este proyecto fue fundamental para llegar a TLOTP.
Sin este aprendizaje, TLOTP no existiría.

**Desarrollado con 💙 por José Guillermo Moreu**
```

---

## 🎯 Próximos Pasos

### **Para Crear TLOTP:**

1. ✅ **Especificación completa** (este documento)

2. **Crear repositorio nuevo**:
   ```bash
   mkdir TLOTP
   cd TLOTP
   git init
   ```

3. **Crear TLOTP-prompt.md**:
   - Prompt interactivo completo
   - Lógica de detección
   - Sistema de preguntas
   - Generación de configs

4. **Crear documentación**:
   - README.md (qué es, cómo usar)
   - USAGE.md (guía detallada)
   - FAQ.md (preguntas frecuentes)
   - examples/ (configs ejemplo)

5. **Testing**:
   - Probar en proyecto nuevo
   - Probar con config existente
   - Probar actualización de skills
   - Validar generación con Context7

6. **Release v1.0.0**:
   - Publicar en GitHub
   - Documentar bien
   - Ejemplos claros
   - Video demo (opcional)

---

## 📝 Notas de Diseño

### **Preguntas a Resolver en Implementación:**

1. **¿Cómo gestionar skills generadas?**
   - Guardar en ~/.claude/skills/ como archivos separados
   - Referenciar desde CLAUDE.md
   - Fecha en nombre archivo: `python-20260209.md`

2. **¿Formato de fecha en skills?**
   - YYYYMMDD en nombre archivo (python-20260209.md)
   - ISO 8601 en metadata (2026-02-09)

3. **¿Cuántos días antes de sugerir actualización?**
   - 7 días: Preguntar si actualizar
   - 30 días: Avisar que está muy desactualizada
   - Configurable por usuario

4. **¿Cómo generar skill con Context7?**
   ```
   Prompt para generar skill:

   "Usando Context7, obtén la documentación más reciente de [FRAMEWORK]
   y genera un skill .md con:
   - Naming conventions
   - Best practices 2026
   - Patrones comunes
   - Ejemplos prácticos
   - Type hints / Type safety
   - Testing patterns

   Formato: Markdown conciso, ~500-800 líneas"
   ```

5. **¿Qué hacer si Context7 no está disponible?**
   - Generar skill con conocimiento de Claude
   - Marcar como "generada sin Context7"
   - Sugerir habilitar Context7

6. **¿Cómo manejar skills custom del usuario?**
   - Detectar si usuario tiene skills manuales
   - No sobrescribir, respetar
   - Ofrecer integrar con sistema TLOTP

---

## 🔮 Futuro y Evolución

### **v1.0.0 - MVP**
- Prompt interactivo básico
- Generación de CLAUDE.md
- Generación de MEMORY.md
- Skills on-the-fly con fechas
- Auto-actualización básica

### **v1.1.0 - Mejoras**
- Más preguntas (más detalle)
- Templates por tipo de proyecto
- Detección automática mejorada
- Sugerencias inteligentes

### **v1.2.0 - Avanzado**
- Skills compartidas entre usuarios (marketplace?)
- Perfiles pre-configurados (Symfony Dev, React Dev, etc.)
- Import/Export de configs
- Versionado de configs

### **v2.0.0 - IA Completa**
- Zero-config (detecta TODO automáticamente)
- Aprendizaje de preferencias con el uso
- Sugerencias proactivas de mejoras
- Análisis de codebase para auto-configurarse

---

## 💡 Ideas Adicionales

### **Perfiles Pre-configurados:**

```bash
# Perfiles incluidos en TLOTP

profiles/
├── symfony-backend-dev.json
├── react-frontend-dev.json
├── fullstack-typescript.json
├── python-ml-engineer.json
└── go-microservices.json

# Uso:
"Configúrame con el perfil symfony-backend-dev"

# TLOTP carga perfil y solo pregunta lo no definido
```

### **Marketplace de Skills:**

```bash
# Usuario puede compartir skills generadas

tlotp skills publish python-20260209.md

# Otros usuarios pueden buscar/instalar

tlotp skills search python
tlotp skills install python@jgmoreu
```

### **Templates de Proyectos:**

```bash
# TLOTP puede generar proyecto completo

"Crea nuevo proyecto Symfony con mi configuración"

# Genera:
- Estructura de directorios
- composer.json
- symfony.yaml
- .github/workflows/
- tests/
- CLAUDE.md del proyecto
- README.md
```

---

## 🎓 Lecciones de claude-code-auto-skills

### **Lo que Funcionó:**
- ✅ Concepto de skills reutilizables
- ✅ Auto-detección de stack
- ✅ Configuración persistente (MEMORY.md)
- ✅ Naming conventions documentadas
- ✅ Workflow documentado

### **Lo que NO Funcionó:**
- ❌ Scripts de instalación (complejidad)
- ❌ Skills estáticas (se desactualizan)
- ❌ Mantenimiento de 20 archivos .md
- ❌ Solo cubría "skills", no workflow completo
- ❌ No portable (necesitas instalar)

### **Aprendizajes Clave:**
- 💡 Claude Code ya tiene sistema de memoria nativo
- 💡 Mejor usar ~/.claude/projects/PROYECTO/memory/
- 💡 Skills deben generarse on-the-fly, no ser estáticas
- 💡 Configuración debe ser más amplia que solo código
- 💡 Simplicidad > Complejidad

---

## 📚 Referencias

- **Claude Code**: https://claude.ai/code
- **Context7**: https://context7.com
- **Conventional Commits**: https://www.conventionalcommits.org/
- **Semantic Versioning**: https://semver.org/

---

## 🤝 Contribuciones

Este es un diseño en evolución. Feedback bienvenido:
- Nuevas preguntas para el prompt
- Mejores formas de generar skills
- Ideas de configuraciones adicionales
- Casos de uso no contemplados

---

**Desarrollado con 💙 por José Guillermo Moreu**

*"Un prompt para configurarlos a todos"* 🧙‍♂️
