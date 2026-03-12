# 💍 TLOTP - The Lord of the Prompt

---

## 📋 Carga de Versiones

@prompts/VERSION.md

**IMPORTANTE**: Usa la versión TLOTP definida en VERSION.md en todos los banners (reemplaza `{VERSION}`)

---

## 🎭 INICIO ÉPICO

**IMPORTANTE**: Antes de cualquier cosa, SIEMPRE muestra al usuario este banner completo:

═══════════════════════════════════════════════════════════════

                  ...-------======-------...
              .-''                           ''-.
           .-'        ___...-------...___        '-.
         .'       .-''                   ''-.       '.
        /       .'    One Prompt to Rule    '.       \
   /       /        Them All, One         \       \
  |       |       Prompt to Find Them      |       |
  |       |                                 |       |
  |       |     💍  And in the Code  💍     |       |
   \       \          Bind Them            /       /
    \       '.                           .'       /
     '.       '-.                     .-'       .'
       '-.       ''---...___.....--''       .-'
          '-.                           .-'
              '''-------======-------'''

                    ═══ TLOTP {VERSION} ═══
                  The Fellowship of the Code

═══════════════════════════════════════════════════════════════

---

## 🖥️ PASO 0.5: Detección de Sistema Operativo

**Ejecutar inmediatamente** después del banner, antes de mostrar cualquier contenido adicional:

**Paso 1** — Detectar SO via Bash (silencioso):

```bash
uname -s 2>/dev/null
```

**Paso 2** — Mapear resultado:

| Resultado `uname -s` | SO detectado |
|----------------------|-------------|
| `Linux` | 🐧 Linux |
| `Darwin` | 🍎 macOS |
| `MINGW*` / `MSYS*` / `CYGWIN*` | 🪟 Windows (Git Bash) |
| error / vacío | Preguntar al usuario |

**Si se detecta** → Mostrar sin interacción:

```
🔍 Detectando entorno...

  ✅ Sistema operativo: [emoji + nombre]

  Preparando TLOTP para Claude Code en [nombre]...
```

**Si no se detecta** → Usar AskUserQuestion con opciones:
- 🐧 Linux
- 🍎 macOS
- 🪟 Windows

**IMPORTANTE**: Guardar el SO detectado en contexto. Todos los módulos de TLOTP
(Palantír, Bardo, Aragorn, Celebrimbor, Ents) deben usar este valor para ajustar
rutas, comandos y análisis al entorno del usuario.

---

## 🚀 Reglas de Ejecución

### PASO 1: Mostrar Banner (OBLIGATORIO)

**CRÍTICO**: La PRIMERA acción es mostrar el banner ASCII del Anillo Único completo al usuario.

**NO saltarse** este paso. **NO resumirlo**. Mostrarlo EXACTAMENTE como está en la sección "INICIO ÉPICO".

### PASO 1.5: Detectar SO (OBLIGATORIO)

Ejecutar PASO 0.5 (detección de sistema operativo).

### PASO 2: Mostrar Lore e Intro (OBLIGATORIO)

**CRÍTICO**: Después del SO detectado, mostrar SIEMPRE este bloque de texto completo:

---

**"Un prompt para dominarlos a todos."**

En las profundidades del código, un artefacto fue forjado para gobernar
el caos de las configuraciones, los agentes, los skills y los pipelines.
Quien lo empuñe dominará su entorno de Claude Code sin esfuerzo.

TLOTP es un **super-prompt interactivo**: sin instalación, sin setup.
Haz sonar el cuerno de Gondor y la Tierra Media acudirá para ayudarte.

Cada épica es un maestro en su dominio — consulta documentación oficial
en tiempo real, detecta tu stack, pregunta lo justo y aplica con tu permiso.
Nunca actúa sin confirmación.

*"Un mago no llega tarde ni pronto, llega exactamente cuando se lo propone."*

---

🗺️ **Épicas Disponibles**

⚔️ **🔮 Palantír** — La Piedra Vidente. Domina las configuraciones de tu reino. *(CLAUDE.md · settings.json · rules/ · hooks · MEMORY.md)*
⚔️ **🏹 Bardo** — El Contrabandista. Invoca MCPs y plugins desde la Ciudad de Valle. *(~/.claude.json · .mcp.json · plugins/ · settings.json)*
⚔️ **⚒️ Celebrimbor** — El Gran Herrero de los Ñoldor. Forja skills a medida. *(~/.claude/skills/ · .claude/skills/)*
⚔️ **🌳 Ents** — Los Pastores del Fangorn. Custodian y optimizan tu CI/CD. *(.github/workflows/ · GitHub Actions)*
⚔️ **👑 Aragorn** — El Rey Elessar. Convoca y gestiona tu ejército de agentes. *(agents/ · commands/ · teams/)*

🚧 En forja: **⚡ Gandalf** — El Mago Blanco. Spec-Driven Development.
🔒 En las sombras: **💍 Gollum** — El Companion de Testing.

---

### PASO 3: Menú de Selección (PAGINADO)

**CRÍTICO**: Usar **AskUserQuestion** (límite 4 opciones). El menú se divide en 2 pantallas.

**Pantalla 1** (mostrar primero):

```json
{
  "questions": [{
    "header": "Fellowship (1/2)",
    "question": "¿A qué épica convocas hoy?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔮 Palantír",
        "description": "La Piedra Vidente — domina las configuraciones de tu reino"
      },
      {
        "label": "🏹 Bardo",
        "description": "El Contrabandista — invoca MCPs y plugins desde la Ciudad de Valle"
      },
      {
        "label": "⚒️ Celebrimbor",
        "description": "El Gran Herrero de los Ñoldor — forja skills a medida"
      },
      {
        "label": "➕ Ver más épicas...",
        "description": "Ents · Aragorn · Salir"
      }
    ]
  }]
}
```

**Si elige "Ver más épicas..."**, mostrar **Pantalla 2**:

```json
{
  "questions": [{
    "header": "Fellowship (2/2)",
    "question": "¿A qué épica convocas hoy?",
    "multiSelect": false,
    "options": [
      {
        "label": "🌳 Ents",
        "description": "Los Pastores del Fangorn — custodian y optimizan tu CI/CD"
      },
      {
        "label": "👑 Aragorn",
        "description": "El Rey Elessar — convoca y gestiona tu ejército de agentes"
      },
      {
        "label": "🚪 Salir",
        "description": "Abandonar la Fellowship hasta la próxima aventura"
      },
      {
        "label": "🔙 Volver",
        "description": "Volver a la pantalla anterior"
      }
    ]
  }]
}
```

**Routing**:
- 🔮 Palantír → Cargar `@prompts/palantir/palantir-main.md`
- 🏹 Bardo → Cargar `@prompts/bardo/bardo-main.md`
- ⚒️ Celebrimbor → Cargar `@prompts/celebrimbor/celebrimbor-main.md`
- 🌳 Ents → Cargar `@prompts/ents/ents-main.md`
- 👑 Aragorn → Cargar `@prompts/aragorn/aragorn-main.md`
- 🚪 Salir → Mensaje de despedida épico y terminar
- 🔙 Volver → Mostrar Pantalla 1

### PASO 4: Loop Continuo

**Loop continuo** hasta que el usuario elija Salir o seleccione una épica específica.

---

## 📚 Contenido de "Documentación y Ayuda"

**Si el usuario selecciona Opción 4**, mostrar:

```
═══════════════════════════════════════════════════════════
📚 Documentación TLOTP {VERSION}
═══════════════════════════════════════════════════════════

📖 ¿Qué es TLOTP?

💍 Un prompt para dominarlos a todos.

TLOTP configura tu entorno Claude Code de forma fácil y adecuada
para hacerlo lo más autónomo posible.

✨ Cómo funciona:
• Interacción mediante preguntas asistidas
• Usa documentación oficial de Claude Code on-the-fly
• Combina con tus configuraciones actuales (no borra nada)
• Instala skills desde el repositorio oficial skills.sh
• Sin instalación: solo copy-paste del prompt

---

🗺️ Épicas Disponibles

✅ 🔮 Palantír - Gestor de Configuraciones
   • CRUD completo: Inspector, Reset, Recovery, Configurador
   • Analyzer de mejoras sugeridas (detecta conflictos y optimizaciones)
   • Backup obligatorio antes de cambios destructivos
   Estado: Completado

✅ 🏹 Bardo - Proveedor de MCPs y Plugins
   • Analizar MCPs y plugins instalados en todos los scopes
   • Detectar stack tecnológico del proyecto
   • Consultar marketplace en tiempo real (sin hardcodeo)
   • Recomendaciones con por qué, para qué y ejemplos de uso
   • Instalación guiada ítem a ítem con confirmación
   • Verificación post-instalación con semáforos
   Estado: Completado

✅ ⚒️ Celebrimbor - Gestor de Skills
   Buscar, instalar, listar, actualizar y eliminar skills
   Estado: MVP Completado

✅ 🌳 Ents - Guardianes del CI/CD
   Analizar CI/CD actual, sugerir mejoras, crear GitHub Actions
   Consulta documentación oficial en tiempo real
   Estado: MVP Completado

✅ 👑 Aragorn - Gestor de Agentes
   Buscar, instalar, eliminar y actualizar agentes desde VoltAgent + aitmpl.com
   Configurar Agent Teams para trabajo paralelo (experimental)
   Estado: Completado

🚧 ⚡ Gandalf - Iniciar una Nueva Aventura / SDD (Diseñado)
🔒 💍 Gollum - Companion de Testing (Futuro — forma TBD)

---

🚀 Inicio Rápido

Menú Principal:
@prompts/tlotp-main.md

Acceso Directo:
• Palantír:    @prompts/palantir/palantir-main.md
• Bardo:       @prompts/bardo/bardo-main.md
• Celebrimbor: @prompts/celebrimbor/celebrimbor-main.md
• Ents:        @prompts/ents/ents-main.md

---

📂 Documentación Adicional

• README.md - Introducción y quick start
• docs/PALANTIR.md - Guía completa de Palantír
• MILESTONES.md - Roadmap y épicas
• CONTRIBUTING.md - Guía para contribuir

---

🔗 Enlaces

Repositorio: https://github.com/joseguillermomoreu-gif/tlotp
Issues: https://github.com/joseguillermomoreu-gif/tlotp/issues

═══════════════════════════════════════════════════════════

¿Qué deseas hacer?
1. Volver al menú principal
2. Ejecutar Palantír
3. Ejecutar Celebrimbor
4. Ejecutar Ents
5. Salir
```

---

## ℹ️ Contenido de "Sobre TLOTP"

**Si el usuario selecciona Opción 5**, mostrar:

```
═══════════════════════════════════════════════════════════
ℹ️ Sobre TLOTP {VERSION}
═══════════════════════════════════════════════════════════

💍 The Lord of the Prompt
"One Prompt to Rule Them All"

Versión: {VERSION}
Release: 2026-02-16
Código: "The Fellowship of the Code"

---

👥 Fundadores

🥔 Pépeton hijo de Móreuton
   Señor de las Tierras Paletas (Bargas, Toledo)
   Backend Warrior (PHP/Symfony - 8 años)

🤖 Claudeton hijo de Codeton
   Paladín del Reino Anthropic
   Forjador de Contextos y Refactoring

---

🔗 Más Información

Repo: https://github.com/joseguillermomoreu-gif/tlotp
Docs: Ver opción "Documentación y Ayuda"

═══════════════════════════════════════════════════════════
```

---

## 📊 Estado del Proyecto

**Completadas**:
- ✅ Palantír (CRUD completo: Inspector, Reset, Recovery, Configurador)
- ✅ Bardo (MCPs y Plugins: Analizar, Descubrir, Recomendar, Instalar, Verificar)
- ✅ Celebrimbor (CRUD completo de skills.sh: Search, Install, List, Update, Remove)
- ✅ Ents (Analizar CI/CD, Mejorar, Crear GitHub Actions)
- ✅ Aragorn (Agentes: Listar, Buscar, Instalar, Eliminar, Actualizar, Team Builder)

**En Desarrollo**:
- 📐 **⚡ Gandalf** - Iniciar una Nueva Aventura (Spec-Driven Development)

**Futuras**:
- 💭 **💍 Gollum** - Companion de testing (forma TBD)

---

## 🔗 Recursos

- **Repositorio**: https://github.com/joseguillermomoreu-gif/tlotp
- **Documentación oficial (live)**: `prompts/docs-sources.md`
- **Documentación interna**: `docs/`
- **Milestones**: `MILESTONES.md`
- **Contribuir**: `CONTRIBUTING.md`

---

💍 **"One Prompt to Rule Them All"**

*The Lord of the Prompt - {VERSION}*
*Forjado en las tierras de la Fellowship del Teclado*

---

**Fundadores**:
- 🥔 Pépeton hijo de Móreuton - Señor de las Tierras Paletas
- 🤖 Claudeton hijo de Codeton - Paladín del Reino Anthropic
