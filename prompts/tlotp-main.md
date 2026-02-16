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
Auto-configuración asistida de Claude Code. Gestiona configuraciones, skills y workflows.

---
## 🗺️ Épicas Disponibles
**🔮 Palantír** - Gestor de configuraciones (Inspector, Reset, Recovery, Configurador)
**⚒️ Celebrimbor** - Gestor de skills (Buscar, Instalar, Listar, Actualizar, Eliminar)

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
│                                                             │
│ 3. 📚 Documentación y Ayuda                                 │
│ 4. ℹ️ Sobre TLOTP                                           │
│ 5. 🚪 Salir                                                 │
│                                                             │
│ (Más épicas en desarrollo - ver descripción arriba)        │
└─────────────────────────────────────────────────────────────┘

---

## 🚀 Reglas de Ejecución

### PASO 1: Mostrar Banner (OBLIGATORIO)

**CRÍTICO**: La PRIMERA acción es mostrar el banner ASCII del Anillo Único completo al usuario.

**NO saltarse** este paso. **NO resumirlo**. Mostrarlo EXACTAMENTE como está en la sección "INICIO ÉPICO".

### PASO 2: Menú de Selección

Después del banner y la lista de épicas, usar **AskUserQuestion** para mostrar el menú de forma elegante.

**IMPORTANTE - Validación de Opciones**:

**Opciones DISPONIBLES** (1-5):
- 1. 🔮 Palantír ✅
- 2. ⚒️ Celebrimbor ✅
- 3. 📚 Documentación ✅
- 4. ℹ️ Sobre TLOTP ✅
- 5. 🚪 Salir ✅

**NOTA**: Las épicas futuras (Gollum, Elrond, Gandalf, Aragorn) NO aparecen como opciones seleccionables en el menú. Ya se mostraron arriba en la sección "🗺️ Épicas de la Fellowship" como información.

**Al seleccionar épica disponible**:
- **Opción 1**: Cargar `@prompts/palantir/palantir-main.md`
- **Opción 2**: Cargar `@prompts/celebrimbor/celebrimbor-main.md`
- **Opción 3**: Mostrar documentación del proyecto
- **Opción 4**: Mostrar info sobre TLOTP (versión, fundadores, XP, etc.)
- **Opción 5**: Mensaje de despedida y salir

### PASO 3: Loop Continuo

**Loop continuo** hasta que el usuario elija Salir o seleccione una épica específica.

---

## 📊 Estado del Proyecto

**Completadas**:
- ✅ Palantír (CRUD completo: Inspector, Reset, Recovery, Configurador)
- ✅ Celebrimbor (CRUD completo de skills.sh: Search, Install, List, Update, Remove)

**En Desarrollo**:
- **💍 Gollum** - Setup Playwright E2E

---

## 🔗 Recursos

- **Repositorio**: https://github.com/joseguillermomoreu-gif/tlotp
- **Documentación**: `docs/`
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
