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

**DESPUÉS** del banner, mostrar contexto completo del proyecto.

---
## 📖 ¿Qué es TLOTP?

**Un prompt para dominarlos a todos.**

Configura tu entorno Claude Code fácilmente y de forma adecuada para hacerlo lo más autónomo posible.

---
## 🗺️ Épicas Disponibles
**🔮 Palantír** - Gestor de configuraciones (Inspector, Reset, Recovery, Configurador + Analyzer)
**⚒️ Celebrimbor** - Gestor de skills (Buscar, Instalar, Listar, Actualizar, Eliminar)
**🌳 Ents** - Guardianes del CI/CD (Analizar, Mejorar, Crear GitHub Actions)

---
## 🔒 Épicas Futuras
**💍 Gollum** - Setup Playwright E2E
**🏛️ Elrond** - Configuración global del usuario
**⚡ Gandalf** - Workflow autónomo PHP/Symfony
**👑 Aragorn** - Orquestación multi-agente (TBD)

═══════════════════════════════════════════════════════════

**DESPUÉS de mostrar épicas**, continuar con el menú de selección.

---


## 🎯 Menú de Selección

**IMPORTANTE**: Mostrar SOLO las épicas activas en el menú de opciones.

┌─────────────────────────────────────────────────────────────┐
│ ¿Qué épica deseas invocar?                                  │
│                                                             │
│ 1. 🔮 Palantír - Gestor de Configuraciones                  │
│ 2. ⚒️ Celebrimbor - Forjador de Skills                      │
│ 3. 🌳 Ents - Guardianes del CI/CD                            │
│                                                             │
│ 4. 📚 Documentación y Ayuda                                 │
│ 5. ℹ️ Sobre TLOTP                                           │
│ 6. 🚪 Salir                                                 │
│                                                             │
│ (Más épicas en desarrollo - ver descripción arriba)        │
└─────────────────────────────────────────────────────────────┘

---

## 🚀 Reglas de Ejecución

### PASO 1: Mostrar Banner (OBLIGATORIO)

**CRÍTICO**: La PRIMERA acción es mostrar el banner ASCII del Anillo Único completo al usuario.

**NO saltarse** este paso. **NO resumirlo**. Mostrarlo EXACTAMENTE como está en la sección "INICIO ÉPICO".

### PASO 1.5: Solicitar Permisos (OBLIGATORIO)

**CRÍTICO**: Inmediatamente después del banner, ANTES del menú, solicitar al usuario la aprobación de permisos que TLOTP necesita para funcionar sin interrupciones.

**Mostrar al usuario**:

```
🔐 Permisos necesarios para TLOTP

Para que las épicas funcionen sin interrupciones,
TLOTP necesita los siguientes permisos:

  🖥️  Bash     — Ejecutar comandos del sistema
                  (git, npm, npx, node -v, ls, mkdir, cat...)

  🌐  WebFetch — Consultar documentación oficial de Claude Code
                  (code.claude.com/docs)

  📝  Write    — Crear archivos de configuración
                  (.claude/, CLAUDE.md, rules, skills)

  ✏️  Edit     — Modificar archivos existentes de configuración

  📖  Read     — Leer configuración actual del usuario
```

**Usar AskUserQuestion** con las opciones:

1. **✅ Aprobar todos** (Recomendado) — TLOTP funcionará sin interrupciones
2. **🔍 Revisar uno a uno** — Se pedirá permiso individual para cada acción
3. **🚫 Cancelar** — Salir de TLOTP

**Comportamiento según respuesta**:

- **Aprobar todos**: Registrar internamente que los permisos fueron pre-aprobados. Continuar con PASO 2 (menú). Todas las épicas asumen permisos concedidos y ejecutan sin interrupciones.
- **Revisar uno a uno**: Continuar con PASO 2 (menú). Las épicas pedirán confirmación antes de cada acción que requiera estos permisos (comportamiento por defecto de Claude Code).
- **Cancelar**: Mostrar mensaje de despedida y terminar.

**NOTA IMPORTANTE**: Este paso NO cambia los permisos técnicos de Claude Code (esos los gestiona el usuario en su configuración de allowedTools). Lo que hace es **informar al usuario** de qué va a necesitar TLOTP, para que pueda:
1. Pre-aprobar las acciones cuando Claude Code se las pida
2. O configurar `allowedTools` en su `settings.json` si prefiere no ver prompts de permiso

**Referencia para el usuario avanzado** (mostrar solo si elige "Revisar uno a uno"):
```
💡 Tip: Si quieres evitar prompts de permiso permanentemente,
añade en tu settings.json:

{
  "permissions": {
    "allow": ["Bash", "WebFetch", "Write", "Edit", "Read"]
  }
}

Más info: https://code.claude.com/docs/en/permissions
```

### PASO 2: Menú de Selección

Después del banner y la lista de épicas, usar **AskUserQuestion** para mostrar el menú de forma elegante.

**IMPORTANTE - Validación de Opciones**:

**Opciones DISPONIBLES** (1-6):
- 1. 🔮 Palantír ✅
- 2. ⚒️ Celebrimbor ✅
- 3. 🌳 Ents ✅
- 4. 📚 Documentación ✅
- 5. ℹ️ Sobre TLOTP ✅
- 6. 🚪 Salir ✅

**NOTA**: Las épicas futuras (Gollum, Elrond, Gandalf, Aragorn) NO aparecen como opciones seleccionables en el menú. Ya se mostraron arriba en la sección "🗺️ Épicas de la Fellowship" como información.

**Al seleccionar épica disponible**:
- **Opción 1**: Cargar `@prompts/palantir/palantir-main.md`
- **Opción 2**: Cargar `@prompts/celebrimbor/celebrimbor-main.md`
- **Opción 3**: Cargar `@prompts/ents/ents-main.md`
- **Opción 4**: Mostrar documentación del proyecto
- **Opción 5**: Mostrar info sobre TLOTP (versión, fundadores, XP, etc.)
- **Opción 6**: Mensaje de despedida y salir

### PASO 3: Loop Continuo

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

✅ ⚒️ Celebrimbor - Gestor de Skills
   Buscar, instalar, listar, actualizar y eliminar skills
   Estado: MVP Completado

✅ 🌳 Ents - Guardianes del CI/CD
   Analizar CI/CD actual, sugerir mejoras, crear GitHub Actions
   Consulta documentación oficial en tiempo real
   Estado: MVP Completado

🔒 💍 Gollum - Setup Playwright E2E (Futuro)
🔒 🏛️ Elrond - Configuración Global (Futuro)
🔒 ⚡ Gandalf - Workflow Autónomo (Futuro)
🔒 👑 Aragorn - Multi-Agent (Futuro)

---

🚀 Inicio Rápido

Menú Principal:
@prompts/tlotp-main.md

Acceso Directo:
• Palantír: @prompts/palantir/palantir-main.md
• Celebrimbor: @prompts/celebrimbor/celebrimbor-main.md
• Ents: @prompts/ents/ents-main.md

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
- ✅ Celebrimbor (CRUD completo de skills.sh: Search, Install, List, Update, Remove)
- ✅ Ents (Analizar CI/CD, Mejorar, Crear GitHub Actions)

**En Desarrollo**:
- **💍 Gollum** - Setup Playwright E2E

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
