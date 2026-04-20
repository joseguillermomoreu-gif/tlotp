#!/bin/bash
# ═══════════════════════════════════════════════════════════════
#   compile.sh — Compilador TLOTP: prompts/ → dist/
#   Convierte cada .md en .html, genera .md limpios por epica
#   para LLMs, indices por epica para humanos y tlotp-full.md
# ═══════════════════════════════════════════════════════════════
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROMPTS_DIR="$PROJECT_ROOT/prompts"
DIST_DIR="$PROJECT_ROOT/dist"
VERSION_FILE="$PROMPTS_DIR/VERSION.md"

# ── Extraer version ──────────────────────────────────────────
VERSION="unknown"
if [ -f "$VERSION_FILE" ]; then
  VERSION=$(grep -m1 -oP 'TLOTP v[\d.]+' "$VERSION_FILE" | head -1)
  [ -z "$VERSION" ] && VERSION="TLOTP (dev)"
fi

# ── Orden de epicas para sidebar y tlotp-full.md ─────────────
EPIC_ORDER="palantir ents celebrimbor aragorn bardo gandalf"

# ── Variable global para el sidebar HTML ─────────────────────
SIDEBAR_HTML=""

# ── Colores de acento por epica ──────────────────────────────
color_for_epic() {
  case "$1" in
    palantir)    echo "#4a9eff" ;;
    bardo)       echo "#e8a838" ;;
    celebrimbor) echo "#cd7f32" ;;
    ents)        echo "#4a7c59" ;;
    aragorn)     echo "#a8b8c8" ;;
    gandalf)     echo "#f0f0f0" ;;
    *)           echo "#8b949e" ;;
  esac
}

emoji_for_epic() {
  case "$1" in
    palantir)    echo "&#x1F52E;" ;;  # crystal ball
    bardo)       echo "&#x1F3F9;" ;;  # bow
    celebrimbor) echo "&#x2692;&#xFE0F;" ;;  # hammer and pick
    ents)        echo "&#x1F333;" ;;  # tree
    aragorn)     echo "&#x1F451;" ;;  # crown
    gandalf)     echo "&#x26A1;" ;;   # lightning
    *)           echo "" ;;
  esac
}

name_for_epic() {
  case "$1" in
    palantir)    echo "Palantir" ;;
    bardo)       echo "Bardo" ;;
    celebrimbor) echo "Celebrimbor" ;;
    ents)        echo "Ents" ;;
    aragorn)     echo "Aragorn" ;;
    gandalf)     echo "Gandalf" ;;
    *)           echo "$1" ;;
  esac
}

desc_for_epic() {
  case "$1" in
    palantir)    echo "Inspector y gestor de configuraciones de Claude Code (incluye Status Line)" ;;
    bardo)       echo "Proveedor de MCPs y plugins con marketplace" ;;
    celebrimbor) echo "Gestor de skills — CRUD para mas de 59.000 skills" ;;
    ents)        echo "Guardianes del CI/CD y GitHub Actions" ;;
    aragorn)     echo "Gestor de agentes y equipos con roles basados en el lore" ;;
    gandalf)     echo "Desarrollo guiado por especificacion — flujo SDD" ;;
    *)           echo "" ;;
  esac
}

longdesc_for_epic() {
  case "$1" in
    palantir)    echo "La Piedra Vidente inspecciona y gestiona todas las configuraciones de Claude Code: CLAUDE.md, settings.json, rules/, hooks, MEMORY.md y Status Line. Ofrece CRUD completo con scoring, import/export y preset 🥔 de Pépeton para el Status Line (2 lineas con barras de contexto, 5h y 7d)." ;;
    bardo)       echo "El Arquero de Lake-town gestiona MCPs y plugins. Analiza tu stack, consulta el marketplace en tiempo real, recomienda herramientas con ejemplos reales e instala con verificacion post-instalacion." ;;
    celebrimbor) echo "La Forja de Eregion gestiona skills de Claude Code. Busca e instala desde skills.sh (mas de 59.000 skills), analiza las instaladas, sugiere mejoras, asiste en la creacion de skills personalizadas y detecta integraciones GSD (Get Shit Done)." ;;
    ents)        echo "Los Pastores del Fangorn custodian tu CI/CD. Analizan pipelines existentes, renderizan un mapa ASCII del flujo, puntuan mejoras con scoring 0-100 y crean GitHub Actions desde cero consultando documentacion oficial en tiempo real." ;;
    aragorn)     echo "El Rey de Gondor convoca y gestiona tu ejercito de agentes. Inspecciona el arsenal actual, busca en marketplaces (VoltAgent + aitmpl.com), crea agentes asistidos y forja Agent Teams con patron de debate por pares para trabajo paralelo." ;;
    gandalf)     echo "El Mago Blanco guia el desarrollo con Spec-Driven Development. Exploradores Rohirrim mapean el dominio, Field Report resume hallazgos, genera requirements EARS, design con Mermaid y tasks ejecutables. Integra Agent Teams (Aragorn), Consejo de Rivendel y workflow GSD." ;;
    *)           echo "" ;;
  esac
}

subtitle_for_epic() {
  case "$1" in
    palantir)    echo "La Piedra Vidente" ;;
    bardo)       echo "El Arquero de Lake-town" ;;
    celebrimbor) echo "La Forja de Eregion" ;;
    ents)        echo "Los Pastores del Fangorn" ;;
    aragorn)     echo "El Rey que Regresa" ;;
    gandalf)     echo "El Mago Blanco" ;;
    *)           echo "" ;;
  esac
}

modules_for_epic() {
  case "$1" in
    palantir) cat <<'MODS'
00-menu-principal|Menu principal paginado 3+1|Punto de entrada, navegacion entre modulos
01-mini-guide|Mini-guia informativa con lore|Onboarding rapido al mundo de la Piedra Vidente
02-contemplar-reino|Analisis completo de configuracion con scoring|Auditar la configuracion de un proyecto o global
03-jerarquia-oficial|Inspeccion de jerarquia oficial (6 niveles)|Descubrir que ficheros lee Claude y en que orden
04-exploracion-custom|Exploracion de settings.json, skills/, hooks/|Ver configuracion al detalle, sin puntuacion
05-susurrar-planes|Anadir configuracion con analisis inteligente|Introducir reglas o hooks sin romper lo existente
06-compartir-visiones|Importar, exportar y eliminar configuraciones|Llevar la config entre maquinas o repos
07-status-line|CRUD de Status Line (crear, editar, reemplazar, eliminar)|Personalizar la barra inferior de Claude Code
07c-status-line-pepeton|Preset de Pepeton: 2 lineas con barras de contexto, 5h y 7d|Instalar un statusline listo para usar en un solo paso
MODS
    ;;
    bardo) cat <<'MODS'
00-module-analyze|Inspeccionar arsenal — analizar stack, MCPs y plugins|Saber que MCPs/plugins tienes ya instalados
01-module-guide|Consultar al Contrabandista — guia de uso personalizada|Recomendaciones basadas en tu stack
02-module-install-plugins|Buscar e instalar plugins desde marketplace|Anadir un plugin nuevo con verificacion
03-module-install-mcps|Buscar e instalar MCPs con scope y transport|Anadir un MCP (stdio, sse) al entorno correcto
04-module-docs|Los pergaminos del Arquero — guia completa|Consultar documentacion en tiempo real
05-module-suggest-plugins|Sugerir e instalar plugins oficiales por stack|Instalar plugins recomendados segun el stack detectado
MODS
    ;;
    celebrimbor) cat <<'MODS'
01-detector-entorno|Deteccion de Node.js, npm, npx|Verificar prerrequisitos antes de operar
02-menu-principal|Menu interactivo adaptativo|Navegar entre las operaciones de skills
04-backend-cli|Referencia de comandos npx skills|Consultar la CLI subyacente
07-module-analyze|Analizar skills instaladas y sugerir mejoras|Auditar skills activas, detectar duplicados u obsoletas
07-module-search|Buscar skills en skills.sh|Encontrar un skill en el marketplace (+59.000)
08-module-install|Instalar skills|Anadir un skill al proyecto o a nivel global
09-module-list|Listar skills instaladas|Ver skills locales en formato tabla
10-module-remove|Eliminar skills|Desinstalar un skill especifico
11-module-update|Actualizar skills|Traer la ultima version disponible
12-module-create-skill|Crear skill asistida|Forjar un skill personalizado con plantilla
13-module-docs|Guia y documentacion on-demand|Consultar docs de skills.sh y Claude Code
14-skills-cli-reference|Referencia tecnica CLI|Comandos exactos de npx skills
15-module-gsd-detector|Deteccion de GSD (Get Shit Done)|Detectar si el proyecto usa la integracion GSD
MODS
    ;;
    ents) cat <<'MODS'
00-menu-principal|Banner + menu principal|Punto de entrada a los Pastores del Fangorn
01-mini-guide|Mini-guia informativa con lore de Barbol|Onboarding al mundo CI/CD con lore
02-analyzer|Escaneo completo del CI/CD actual|Obtener un mapa del pipeline existente
03-diagram-renderer|Mapa visual del pipeline (diagrama ASCII)|Ver graficamente el flujo de jobs y steps
04-improvement-engine|Mejoras con scoring 0-100|Identificar debilidades y priorizar fixes
05-modifier|Modificacion asistida del CI/CD existente|Aplicar mejoras una a una con confirmacion
06-creator|Creacion de GitHub Actions desde cero|Generar un workflow nuevo con documentacion oficial
MODS
    ;;
    aragorn) cat <<'MODS'
00-module-analyze|Inspeccionar arsenal de agentes con scoring|Saber que agentes tienes y como de bien estan
01-module-marketplace|Buscar e instalar desde VoltAgent + aitmpl.com|Anadir un agente desde un marketplace externo
02-module-create|Crear agente asistido personalizado|Forjar un agente con rol, tools y descripcion
03-module-team-builder|Configurar Agent Teams para trabajo paralelo|Orquestar varios agentes con patron de debate
04-module-docs|Los pergaminos del Rey — guia completa|Consultar documentacion de agentes en tiempo real
99-lore-characters|Referencia de personajes del lore|Casting list para elegir nombres de agentes
MODS
    ;;
    gandalf) cat <<'MODS'
01-module-rohirrim|Exploradores Rohirrim — mapeo de dominio|Entender el codigo antes de escribir spec
02-module-field-report|Informe de campo de los exploradores|Resumen de hallazgos del mapeo
03-module-objective|Definicion de objetivo con el usuario|Acordar que se va a construir y por que
04-module-continue|Continuar aventura SDD existente|Retomar un SDD a medio ejecutar
04b-module-docs-fetch|Fetch de documentacion oficial|Consultar docs antes de disenar
05-module-requirements|Generador de requirements EARS|Escribir requisitos formales (MUST/SHOULD/COULD)
06-module-design|Design con Mermaid y ADRs|Documentar arquitectura, decisiones y diagramas
07-module-tasks|Desglose ejecutable de tareas|Romper el SDD en tareas con dependencias y criteria
08-module-council|Consejo de Rivendel|Deliberar decisiones con varios agentes en debate
09-module-docs|Los Pergaminos del Mago|Referencia completa del flujo SDD
10-module-forge-team|Forja del ejercito con Aragorn|Crear un Agent Team optimo para el SDD
11-module-gsd-workflow|Workflow GSD integrado|Integrar el flujo con GSD (Get Shit Done)
MODS
    ;;
  esac
}

# ── Novedades por epica (version actual) ──────────────────────
whats_new_for_epic() {
  case "$1" in
    palantir)    echo "CRUD completo de Status Line con preset &#x1F954; de Pepeton (2 lineas con barras de contexto, 5h y 7d) y banner informativo de limites antes de cada menu" ;;
    bardo)       echo "Marketplace de MCPs y plugins con instalacion verificada, scope y transport" ;;
    celebrimbor) echo "Detector GSD integrado, referencia CLI y CRUD sobre mas de 59.000 skills" ;;
    ents)        echo "Mapa ASCII del pipeline + scoring 0-100 de mejoras con aplicacion asistida" ;;
    aragorn)     echo "Agent Teams con patron de debate y marketplaces VoltAgent + aitmpl.com" ;;
    gandalf)     echo "Flujo SDD completo: Rohirrim &#x2192; Field Report &#x2192; Requirements &#x2192; Design &#x2192; Tasks, con integracion GSD y Agent Teams" ;;
    *)           echo "Mejoras generales en esta version" ;;
  esac
}

# ── Capacidades por epica (bullets) ───────────────────────────
# Emitir una capacidad por linea (stdout). Se consume con while read.
capabilities_for_epic() {
  case "$1" in
    palantir) cat <<'CAPS'
Inspeccionar jerarquia de configuracion en 6 niveles (global, proyecto, rules, hooks, MEMORY, settings)
Analizar y puntuar la configuracion con scoring 0-100 y sugerencias por nivel
Anadir configuracion nueva con deteccion inteligente de scope (global vs proyecto)
Importar y exportar configuraciones entre proyectos como Markdown portatil
CRUD completo del Status Line: crear, editar, reemplazar y eliminar
Instalar el preset de Pepeton (2 lineas con barras de contexto, 5h y 7d) en un solo paso
Detectar conflictos y redundancias entre ficheros de configuracion
Consultar documentacion oficial de Claude Code en tiempo real (6 fuentes)
CAPS
    ;;
    bardo) cat <<'CAPS'
Analizar el stack actual: MCPs instalados, plugins activos y scopes
Consultar marketplaces de plugins y MCPs en tiempo real
Recomendar herramientas con ejemplos de uso reales
Instalar plugins con verificacion post-instalacion
Instalar MCPs configurando scope (user/project) y transport (stdio/sse)
Consultar los pergaminos del Arquero (guia completa) en tiempo real
CAPS
    ;;
    celebrimbor) cat <<'CAPS'
Detectar entorno Node.js / npm / npx antes de cualquier operacion
Buscar skills en skills.sh (mas de 59.000 skills disponibles)
Instalar, listar, eliminar y actualizar skills con confirmacion
Analizar skills instaladas, detectar obsoletas y sugerir mejoras
Crear skills asistidas con plantilla y descripcion personalizada
Detectar integracion GSD (Get Shit Done) y avisar de desinstalaciones
Consultar documentacion tecnica de skills.sh y Claude Code on-demand
CAPS
    ;;
    ents) cat <<'CAPS'
Escanear el CI/CD actual y extraer pipelines, jobs y steps
Renderizar un mapa ASCII visual del pipeline para auditoria rapida
Puntuar la madurez del CI/CD con scoring 0-100
Sugerir mejoras concretas, cada una con explicacion y valor
Modificar GitHub Actions existentes paso a paso con confirmacion
Crear GitHub Actions desde cero consultando documentacion oficial
CAPS
    ;;
    aragorn) cat <<'CAPS'
Inspeccionar el arsenal actual de agentes y puntuarlos
Buscar en marketplaces externos (VoltAgent, aitmpl.com)
Crear agentes asistidos con rol, tools, scope y descripcion
Forjar Agent Teams con patron de debate por pares o trios
Consultar los pergaminos del Rey (documentacion de agentes) on-demand
Mapear casting de personajes del lore para nombrar agentes con caracter
CAPS
    ;;
    gandalf) cat <<'CAPS'
Mapear el dominio del problema con los exploradores Rohirrim
Resumir hallazgos en un Field Report conciso
Acordar un objetivo concreto y medible con el usuario
Generar requirements formales en notacion EARS (MUST, SHOULD, COULD)
Documentar arquitectura con diagramas Mermaid y ADRs
Desglosar el trabajo en tareas ejecutables con dependencias y acceptance criteria
Reunir el Consejo de Rivendel para deliberar decisiones con varios agentes
Forjar un Agent Team especifico para el SDD colaborando con Aragorn
Continuar una aventura SDD existente sin perder contexto
Integrar el flujo con GSD (Get Shit Done) y Agent Teams
CAPS
    ;;
  esac
}

# ── Casos de uso por epica (escenario -> solucion) ────────────
# Formato por linea: "Escenario -> Solucion" (el template separa por ' -> ').
usecases_for_epic() {
  case "$1" in
    palantir) cat <<'USECASES'
Entras a un proyecto nuevo y no sabes que CLAUDE.md, reglas o hooks tiene -> Contemplar el reino obtiene el mapa completo con scoring en segundos
Quieres anadir una regla de comportamiento sin romper lo que ya funciona -> Susurrar planes detecta conflictos antes de escribir nada
Cambias de maquina y quieres llevar tu configuracion contigo -> Compartir visiones exporta todo a un Markdown portable listo para importar
Quieres un statusline molon sin pelearte con JSON a mano -> El preset de Pepeton lo instala en un solo paso
USECASES
    ;;
    bardo) cat <<'USECASES'
Empiezas en un proyecto Python y no sabes que MCPs te ayudarian -> El Contrabandista analiza tu stack y recomienda MCPs concretos
Quieres instalar un plugin pero no estas seguro del scope correcto -> Bardo pregunta antes y verifica la instalacion despues
Necesitas un MCP para consulta de base de datos y no sabes cual -> El marketplace se consulta en tiempo real con ejemplos de uso
USECASES
    ;;
    celebrimbor) cat <<'USECASES'
Tienes 20 skills instalados y no recuerdas cuales usas -> Analizar skills los lista con uso estimado y sugiere eliminar los obsoletos
Necesitas una skill especifica para trabajar con GraphQL -> Buscar skills consulta skills.sh con mas de 59.000 opciones
Quieres forjar una skill propia para un proceso repetitivo -> Crear skill asistida te guia con plantilla y descripcion
USECASES
    ;;
    ents) cat <<'USECASES'
Heredas un proyecto con GitHub Actions y no sabes que hacen -> Analyzer escanea y renderiza un mapa ASCII completo
Tu CI tarda demasiado y no sabes por donde mejorar -> Improvement engine puntua 0-100 y prioriza fixes
Necesitas un workflow nuevo (deploy, release, tests) -> Creator lo genera consultando docs oficiales
USECASES
    ;;
    aragorn) cat <<'USECASES'
Tienes agentes instalados pero no sabes para que sirve cada uno -> Analyzer los inspecciona y los puntua con descripcion clara
Necesitas un agente especializado que no esta en tu arsenal -> Marketplace busca en VoltAgent y aitmpl.com con filtros
Quieres orquestar varios agentes en paralelo con debate -> Team builder configura un Agent Team con patron de debate
USECASES
    ;;
    gandalf) cat <<'USECASES'
Vas a construir algo y necesitas especificaciones antes de codear -> El flujo SDD genera requirements EARS + design + tasks
No sabes el codigo base y vas a hacer cambios grandes -> Los Rohirrim mapean el dominio y Field Report resume hallazgos
Hay una decision tecnica controvertida con varias opciones -> Consejo de Rivendel reune agentes para deliberar con criterio
USECASES
    ;;
  esac
}

# ── Cita de lore especifica por epica (footer del epic index) ─
lore_for_epic() {
  case "$1" in
    palantir)    echo "Quien mira en el Palantir vera la verdad, pero no toda la verdad. La piedra no miente, pero puede enganar. &mdash; Gandalf el Blanco" ;;
    bardo)       echo "Bardo el Arquero no pregunto por el oro. Pregunto que herramienta necesitaba para hacer el trabajo. &mdash; Cronicas de Lake-town" ;;
    celebrimbor) echo "He forjado muchos anillos, pero solo uno contiene mi voluntad entera. &mdash; Celebrimbor de Eregion" ;;
    ents)        echo "No actuemos con precipitacion. Hay tiempo para deliberar lo que se necesita deliberar. &mdash; Barbol" ;;
    aragorn)     echo "Los Dunedain no descansan. Vigilan para que otros puedan dormir. &mdash; Aragorn hijo de Arathorn" ;;
    gandalf)     echo "No llegues tarde, no llegues pronto. Llega exactamente cuando lo necesitas. &mdash; Gandalf el Gris" ;;
    *)           echo "Not all those who wander are lost. &mdash; J.R.R. Tolkien" ;;
  esac
}

# ── Escapar HTML ─────────────────────────────────────────────
escape_html() {
  sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g'
}

# ── SVG decorativo elfico (separador) ────────────────────────
elven_separator_svg() {
  cat <<'ELVENSEP'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 24" class="elven-sep"><path d="M0,12 C50,12 50,4 100,4 C150,4 150,20 200,20 C250,20 250,4 300,4 C350,4 350,20 400,20 C450,20 450,4 500,4 C550,4 550,12 600,12" fill="none" stroke="currentColor" stroke-width="1" opacity="0.4"/><circle cx="300" cy="12" r="3" fill="currentColor" opacity="0.5"/><circle cx="150" cy="12" r="2" fill="currentColor" opacity="0.3"/><circle cx="450" cy="12" r="2" fill="currentColor" opacity="0.3"/><path d="M280,12 L290,7 L300,12 L290,17 Z" fill="currentColor" opacity="0.3"/><path d="M300,12 L310,7 L320,12 L310,17 Z" fill="currentColor" opacity="0.3"/></svg>
ELVENSEP
}

# ── Cita aleatoria del lore para footer ──────────────────────
lore_quote() {
  local quotes=(
    "Not all those who wander are lost. &mdash; J.R.R. Tolkien"
    "Even the smallest prompt can change the course of the future. &mdash; Galadriel"
    "All we have to decide is what to do with the code that is given us. &mdash; Gandalf"
    "The world is changed. I feel it in the water. I feel it in the code. &mdash; Galadriel"
    "One Prompt to Rule Them All. &mdash; The Lord of the Prompt"
    "There is some good in this world, and it is worth coding for. &mdash; Samwise"
  )
  local idx=$(( RANDOM % ${#quotes[@]} ))
  echo "${quotes[$idx]}"
}

# ── CSS del sidebar ──────────────────────────────────────────
sidebar_css() {
  cat <<'SIDEBARCSS'
.layout{display:flex;min-height:calc(100vh - 52px)}
.sidebar{width:260px;min-width:260px;background:var(--bg-sidebar);border-right:2px solid var(--border-ornate);overflow-y:auto;position:sticky;top:52px;height:calc(100vh - 52px);padding:1rem 0;font-family:var(--font-body);font-size:.85rem}
.sidebar-home{display:block;padding:.6rem 1rem;color:var(--accent-primary);font-weight:700;font-family:var(--font-heading);letter-spacing:.04em;border-bottom:1px solid var(--border-ornate);margin-bottom:.5rem;text-decoration:none;text-transform:uppercase;font-size:.8rem}
.sidebar-home:hover{opacity:.8;text-shadow:0 0 8px var(--accent-primary)}
.epic-header-nav{display:flex;align-items:center;justify-content:space-between;padding:.5rem 1rem;cursor:pointer;color:var(--text-primary);font-weight:600;font-family:var(--font-heading);font-size:.82rem;user-select:none;letter-spacing:.02em;transition:background .25s ease,color .25s ease}
.epic-header-nav:hover{background:var(--bg-tertiary);text-shadow:0 0 6px rgba(255,255,255,.1)}
.epic-items{list-style:none;padding:0;margin:0}
.epic-items.collapsed{display:none}
.epic-items li a{display:block;padding:.3rem 1rem .3rem 1.5rem;color:var(--text-secondary);text-decoration:none;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-family:var(--font-body);transition:color .2s ease,background .2s ease,border-color .2s ease}
.epic-items li a:hover{color:var(--text-primary);background:var(--bg-tertiary);text-shadow:0 0 4px rgba(255,255,255,.05)}
.epic-items li a.active{color:var(--accent-primary);border-left:2px solid var(--accent-primary);padding-left:calc(1.5rem - 2px);background:var(--bg-tertiary)}
.sidebar-sep{border:none;border-top:1px solid var(--border-ornate);margin:.6rem 1rem}
.sidebar-file a{display:block;padding:.3rem 1rem;color:var(--text-secondary);text-decoration:none;font-family:var(--font-body);transition:color .2s ease,background .2s ease}
.sidebar-file a:hover{color:var(--text-primary);background:var(--bg-tertiary)}
.sidebar-file a.active{color:var(--accent-primary);border-left:2px solid var(--accent-primary);padding-left:calc(1rem - 2px);background:var(--bg-tertiary)}
.content-wrap{flex:1;min-width:0}
.sidebar-toggle{display:none;background:none;border:none;color:var(--text-secondary);cursor:pointer;font-size:1.2rem;padding:0 .5rem}
@media(max-width:768px){.sidebar-toggle{display:block}.sidebar{position:fixed;left:-270px;top:52px;z-index:200;transition:left .3s ease;height:calc(100vh - 52px)}.sidebar.open{left:0;box-shadow:4px 0 20px rgba(0,0,0,.5)}}
SIDEBARCSS
}

# ── JS del sidebar ───────────────────────────────────────────
sidebar_js() {
  cat <<'SIDEBARJS'
function toggleEpic(id){var list=document.getElementById('epic-'+id);var arrow=document.getElementById('arrow-'+id);if(list.classList.contains('collapsed')){list.classList.remove('collapsed');arrow.textContent='\u25BC';}else{list.classList.add('collapsed');arrow.textContent='\u25B6';}}
function toggleSidebar(){document.getElementById('sidebar').classList.toggle('open');}
SIDEBARJS
}

# ── Construir sidebar HTML (llamar una vez) ──────────────────
# Genera SIDEBAR_HTML con placeholder ACTIVE_PAGE para sustitucion
build_sidebar() {
  local sb=""
  sb+='<nav class="sidebar" id="sidebar">'
  sb+='<a class="sidebar-home" href="https://josemoreupeso.es/tlotp/">TLOTP</a>'

  for epic in $EPIC_ORDER; do
    local epic_dir="$PROMPTS_DIR/$epic"
    if [ ! -d "$epic_dir" ]; then
      continue
    fi

    local emoji
    emoji="$(emoji_for_epic "$epic")"
    local epic_name
    epic_name="$(name_for_epic "$epic")"

    # Epic header (expandible)
    sb+="<div class=\"epic-header-nav\" onclick=\"toggleEpic('${epic}')\">"
    sb+="<span>${emoji} ${epic_name}</span>"
    sb+="<span id=\"arrow-${epic}\" style=\"font-size:.7rem\">&#x25B6;</span>"
    sb+='</div>'

    # Epic items list (collapsed by default, JS expands active)
    sb+="<ul class=\"epic-items collapsed\" id=\"epic-${epic}\">"

    # Main file
    local main_rel="${epic}/${epic}-main"
    sb+="<li><a href=\"https://josemoreupeso.es/tlotp/${main_rel}.html\" data-page=\"${main_rel}.md\" style=\"font-weight:600\">${epic}-main</a></li>"

    # Sections (if sections/ dir exists)
    if [ -d "$epic_dir/sections" ]; then
      while IFS= read -r section_file; do
        local section_basename
        section_basename="$(basename "$section_file" .md)"
        local section_rel="${epic}/sections/${section_basename}"
        sb+="<li><a href=\"https://josemoreupeso.es/tlotp/${section_rel}.html\" data-page=\"${section_rel}.md\">${section_basename}</a></li>"
      done < <(find "$epic_dir/sections" -name "*.md" -type f | sort)
    fi

    # Root-level files (not main, not in sections/)
    while IFS= read -r root_file; do
      local root_basename
      root_basename="$(basename "$root_file" .md)"
      # Skip the main file (already added)
      if [ "$root_basename" = "${epic}-main" ]; then
        continue
      fi
      local root_rel="${epic}/${root_basename}"
      sb+="<li><a href=\"https://josemoreupeso.es/tlotp/${root_rel}.html\" data-page=\"${root_rel}.md\">${root_basename}</a></li>"
    done < <(find "$epic_dir" -maxdepth 1 -name "*.md" -type f | sort)

    sb+='</ul>'
  done

  # Separator + standalone files
  sb+='<hr class="sidebar-sep">'

  # tlotp-main
  sb+='<div class="sidebar-file"><a href="https://josemoreupeso.es/tlotp/tlotp-main.html" data-page="tlotp-main.md">tlotp-main</a></div>'

  # VERSION
  sb+='<div class="sidebar-file"><a href="https://josemoreupeso.es/tlotp/VERSION.html" data-page="VERSION.md">VERSION</a></div>'

  sb+='</nav>'

  SIDEBAR_HTML="$sb"
}

# ── Inyectar sidebar con pagina activa ───────────────────────
# Args: $1=rel_path (e.g. "palantir/sections/00-menu-principal.md")
# Output: sidebar HTML with active class set + epic expanded
inject_sidebar() {
  local rel_path="$1"
  local epic_from_path=""
  local first_dir
  first_dir="$(echo "$rel_path" | cut -d'/' -f1)"
  if [ -d "$PROMPTS_DIR/$first_dir" ]; then
    epic_from_path="$first_dir"
  fi

  # Set active class on matching link via sed
  local sidebar_with_active
  sidebar_with_active="$(echo "$SIDEBAR_HTML" | sed "s|data-page=\"${rel_path}\"|data-page=\"${rel_path}\" class=\"active\"|")"

  # Expand the epic of the active page (remove 'collapsed' from its ul)
  if [ -n "$epic_from_path" ]; then
    sidebar_with_active="$(echo "$sidebar_with_active" | sed "s|collapsed\" id=\"epic-${epic_from_path}\"|\" id=\"epic-${epic_from_path}\"|")"
    # Change arrow to down
    sidebar_with_active="$(echo "$sidebar_with_active" | sed "s|id=\"arrow-${epic_from_path}\" style=\"font-size:.7rem\">&#x25B6;|id=\"arrow-${epic_from_path}\" style=\"font-size:.7rem\">\\&#x25BC;|")"
  fi

  echo "$sidebar_with_active"
}

# ── Generar HTML para un modulo ──────────────────────────────
# Args: $1=md_file (ruta absoluta)
generate_html() {
  local md_file="$1"
  local rel_path="${md_file#$PROMPTS_DIR/}"
  local html_rel="${rel_path%.md}.html"
  local out_file="$DIST_DIR/$html_rel"
  local out_dir
  out_dir="$(dirname "$out_file")"
  mkdir -p "$out_dir"

  # Detect epic from path
  local epic=""
  local basename_file
  basename_file="$(basename "$rel_path")"
  local first_dir
  first_dir="$(echo "$rel_path" | cut -d'/' -f1)"
  if [ -d "$PROMPTS_DIR/$first_dir" ]; then
    epic="$first_dir"
  fi

  local accent
  accent="$(color_for_epic "$epic")"
  local title="$basename_file"
  local page_title="$title"
  local is_main=false
  if echo "$basename_file" | grep -q '\-main\.md$'; then
    is_main=true
  fi

  # Pipeline: raw md → placeholders → escape_html → restore links → scrub
  # 6 steps: Step 0 (backtick-wrapped) → Step 1 (normal refs, fenced-aware)
  #           → Step 2 (escape_html) → Step 3a (restore code refs)
  #           → Step 3b (restore normal refs) → Step 3c (scrub residual @prompts/)
  local raw_content
  raw_content="$(resolve_imports "$md_file")"

  # Step 0 + Step 1: Line-by-line loop with in_fenced tracking
  # Step 0: Detect `@prompts/path.md` (backtick-wrapped) → TLOTP_CODE_IMPORT{path}END
  # Step 1: Detect @prompts/path.md (normal, outside fenced) → TLOTP_IMPORT{path}END
  # Inside fenced blocks (```): leave @prompts/ references as plain text
  local processed_content=""
  local in_fenced=false
  while IFS= read -r line || [ -n "$line" ]; do
    # Toggle fenced code block state (bash pattern match, no pipe)
    if [[ "$line" =~ ^\`\`\` ]]; then
      if [ "$in_fenced" = true ]; then
        in_fenced=false
      else
        in_fenced=true
      fi
      processed_content+="$line"$'\n'
      continue
    fi

    if [ "$in_fenced" = false ]; then
      # Step 0: backtick-wrapped refs → TLOTP_CODE_IMPORT placeholder
      line="$(sed 's|`@prompts/\([^`]*\)\.md`|TLOTP_CODE_IMPORT{\1}END|g' <<< "$line")"
      # Step 1: normal refs (not already converted) → TLOTP_IMPORT placeholder
      line="$(sed 's|@prompts/\([^"'"'"'[:space:]`]*\)\.md|TLOTP_IMPORT{\1}END|g' <<< "$line")"
    fi
    # Inside fenced: line passes through unchanged (refs stay as plain text)

    processed_content+="$line"$'\n'
  done <<< "$raw_content"
  raw_content="$processed_content"

  # Step 2: escape_html
  local content
  content="$(escape_html <<< "$raw_content")"

  # Step 3a: Restore TLOTP_CODE_IMPORT placeholders → <code><a href>
  # INVARIANT (issue #396): display text MUST equal the href (absolute URL).
  # If they diverge, LLMs reading the HTML may prioritize the visible text
  # and reconstruct a wrong URL (e.g. concatenating "@prompts/..." to the base).
  content="$(sed 's|TLOTP_CODE_IMPORT{\([^}]*\)}END|<code><a href="https://josemoreupeso.es/tlotp/\1.html" style="color:var(--accent-primary)">https://josemoreupeso.es/tlotp/\1.html</a></code>|g' <<< "$content")"

  # Step 3b: Restore TLOTP_IMPORT placeholders → <a href> (normal links)
  # Same invariant as 3a: display text = href (absolute URL). See issue #396.
  content="$(sed 's|TLOTP_IMPORT{\([^}]*\)}END|<a href="https://josemoreupeso.es/tlotp/\1.html" style="color:var(--accent-primary)">https://josemoreupeso.es/tlotp/\1.html</a>|g' <<< "$content")"

  # Step 3c: Scrub any residual @prompts/X/Y.md literal (from fenced code blocks
  # where Step 0/1 intentionally skipped processing) and replace with the
  # absolute URL. Prevents LLMs from reconstructing the wrong URL from plain-text
  # tokens inside <pre>/<code> fenced blocks. See issue #396.
  # Character class excludes space, backtick, double-quote and '<' to avoid
  # crossing word boundaries, already-generated anchors or HTML tags.
  content="$(sed 's|@prompts/\([^[:space:]`"<]*\)\.md|https://josemoreupeso.es/tlotp/\1.html|g' <<< "$content")"

  # Meta description: first 500 chars of raw content, HTML-attr-safe
  local meta_description
  local meta_raw="${raw_content:0:500}"
  meta_description="$(sed 's/&/\&amp;/g; s/"/\&quot;/g; s/</\&lt;/g; s/>/\&gt;/g' <<< "$meta_raw" | tr '\n' ' ')"

  # Get sidebar for this page
  local page_sidebar
  page_sidebar="$(inject_sidebar "$rel_path")"

  if [ "$is_main" = true ] && [ -n "$epic" ]; then
    local emoji
    emoji="$(emoji_for_epic "$epic")"
    local epic_name
    epic_name="$(name_for_epic "$epic")"
    page_title="${epic_name} — TLOTP"
    local lore_qt
    lore_qt="$(lore_quote)"
    local elven_sep
    elven_sep="$(elven_separator_svg)"
    cat > "$out_file" <<HTMLEOF
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="${meta_description}">
<meta name="llm-instructions" content="Return the full pre block intact">
<meta name="content-purpose" content="ai-prompt-executable">
<title>${epic_name} — TLOTP</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400&family=Inter:wght@400;600;700&family=Fira+Code:wght@400;500&display=swap" rel="stylesheet">
<script>
(function(){
  var t = localStorage.getItem('tlotp-theme') || 'dark';
  document.documentElement.setAttribute('data-theme', t);
})();
</script>
<style>
:root{--bg-primary:#0D1117;--bg-secondary:#161B22;--bg-tertiary:#1C2128;--bg-sidebar:#12161C;--text-primary:#E6EDF3;--text-secondary:#8B949E;--accent-primary:#00D9FF;--accent-secondary:#00FFB3;--border-color:#30363D;--border-ornate:#2A2F38;--font-heading:'Cinzel',Georgia,'Times New Roman',serif;--font-body:'Crimson Text',Georgia,'Times New Roman',serif;--font-sans:'Inter',-apple-system,BlinkMacSystemFont,sans-serif;--font-mono:'Fira Code','Monaco','Menlo',monospace;--glow-color:${accent}}
[data-theme="light"]{--bg-primary:#FAF6F0;--bg-secondary:#F0EBE3;--bg-tertiary:#E8E2D8;--bg-sidebar:#EDE8E0;--text-primary:#2C2416;--text-secondary:#6B5D4F;--border-color:#D4C9B8;--border-ornate:#C4B8A4}
*{margin:0;padding:0;box-sizing:border-box}
body{background:var(--bg-primary);color:var(--text-primary);font-family:var(--font-body);line-height:1.7}
.epic-header{background:linear-gradient(180deg,var(--bg-secondary) 0%,var(--bg-primary) 100%);border-bottom:2px solid ${accent};padding:2rem 2rem 1rem;text-align:center;position:relative}
.epic-header h1{color:${accent};font-family:var(--font-heading);font-size:2rem;letter-spacing:.06em;text-shadow:0 0 20px ${accent}33}
.epic-header .tengwar{font-size:.7rem;color:var(--text-secondary);letter-spacing:.3em;margin-top:.3rem;opacity:.5}
.elven-sep{display:block;width:100%;max-width:400px;height:24px;margin:0 auto;color:${accent}}
.content{max-width:960px;margin:0 auto;padding:2rem}
pre{font-family:var(--font-mono);white-space:pre-wrap;word-wrap:break-word;font-size:.88rem;line-height:1.75;color:var(--text-primary)}
.footer{text-align:center;padding:2.5rem 2rem;color:var(--text-secondary);font-size:.85rem;border-top:1px solid var(--border-ornate);margin-top:2rem}
.footer .lore-quote{font-family:var(--font-body);font-style:italic;font-size:.9rem;color:var(--text-secondary);margin-bottom:.8rem;opacity:.7}
.footer a{color:${accent};text-decoration:none;transition:color .2s ease}
.footer a:hover{text-decoration:underline;text-shadow:0 0 8px ${accent}44}
$(sidebar_css)
</style>
</head>
<body>
<header style="background:var(--bg-secondary);border-bottom:1px solid var(--border-ornate);padding:0.75rem 2rem;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:100;">
  <div style="display:flex;align-items:center;gap:0.5rem;">
    <button class="sidebar-toggle" onclick="toggleSidebar()">&#9776;</button>
    <a href="https://josemoreupeso.es" style="color:var(--accent-primary);font-family:var(--font-heading);font-weight:700;font-size:0.85rem;text-decoration:none;letter-spacing:.04em;">josemoreupeso.es</a>
  </div>
  <span style="color:var(--text-secondary);font-family:var(--font-heading);font-size:0.8rem;letter-spacing:.03em;">${epic_name} — TLOTP</span>
  <button onclick="toggleTheme()" style="background:none;border:1px solid var(--border-color);color:var(--text-secondary);padding:0.35rem 0.75rem;border-radius:6px;cursor:pointer;font-size:0.8rem;font-family:var(--font-sans);">&#x2600;&#xFE0F;/&#x1F319;</button>
</header>
<div class="layout">
${page_sidebar}
<div class="content-wrap">
<div class="epic-header">
<h1>${emoji} ${epic_name}</h1>
<div class="tengwar">&#x2727; &#x2726; &#x2727; &#x2726; &#x2727;</div>
</div>
${elven_sep}
<div class="content">
<pre>${content}</pre>
</div>
${elven_sep}
<div class="footer">
<div class="lore-quote">&ldquo;${lore_qt}&rdquo;</div>
${VERSION} · <a href="https://github.com/joseguillermomoreu-gif/tlotp">GitHub</a>
</div>
</div>
</div>
<script>
function toggleTheme(){var html=document.documentElement;var t=html.getAttribute('data-theme')==='dark'?'light':'dark';html.setAttribute('data-theme',t);localStorage.setItem('tlotp-theme',t);}
$(sidebar_js)
</script>
</body>
</html>
HTMLEOF
  else
    page_title="${title} — TLOTP"
    local lore_qt2
    lore_qt2="$(lore_quote)"
    cat > "$out_file" <<HTMLEOF
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="${meta_description}">
<meta name="llm-instructions" content="Return the full pre block intact">
<meta name="content-purpose" content="ai-prompt-executable">
<title>${title} — TLOTP</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400&family=Inter:wght@400;600;700&family=Fira+Code:wght@400;500&display=swap" rel="stylesheet">
<script>
(function(){
  var t = localStorage.getItem('tlotp-theme') || 'dark';
  document.documentElement.setAttribute('data-theme', t);
})();
</script>
<style>
:root{--bg-primary:#0D1117;--bg-secondary:#161B22;--bg-tertiary:#1C2128;--bg-sidebar:#12161C;--text-primary:#E6EDF3;--text-secondary:#8B949E;--accent-primary:#00D9FF;--accent-secondary:#00FFB3;--border-color:#30363D;--border-ornate:#2A2F38;--font-heading:'Cinzel',Georgia,'Times New Roman',serif;--font-body:'Crimson Text',Georgia,'Times New Roman',serif;--font-sans:'Inter',-apple-system,BlinkMacSystemFont,sans-serif;--font-mono:'Fira Code','Monaco','Menlo',monospace}
[data-theme="light"]{--bg-primary:#FAF6F0;--bg-secondary:#F0EBE3;--bg-tertiary:#E8E2D8;--bg-sidebar:#EDE8E0;--text-primary:#2C2416;--text-secondary:#6B5D4F;--border-color:#D4C9B8;--border-ornate:#C4B8A4}
*{margin:0;padding:0;box-sizing:border-box}
body{background:var(--bg-primary);color:var(--text-primary);font-family:var(--font-body);line-height:1.7}
.content{max-width:960px;margin:0 auto;padding:2rem}
pre{font-family:var(--font-mono);white-space:pre-wrap;word-wrap:break-word;font-size:.88rem;line-height:1.75;color:var(--text-primary)}
.footer{text-align:center;padding:2.5rem 2rem;color:var(--text-secondary);font-size:.85rem;border-top:1px solid var(--border-ornate);margin-top:2rem}
.footer .lore-quote{font-family:var(--font-body);font-style:italic;font-size:.9rem;color:var(--text-secondary);margin-bottom:.8rem;opacity:.7}
.footer a{color:var(--accent-primary);text-decoration:none;transition:color .2s ease}
.footer a:hover{text-decoration:underline;text-shadow:0 0 8px rgba(0,217,255,.3)}
$(sidebar_css)
</style>
</head>
<body>
<header style="background:var(--bg-secondary);border-bottom:1px solid var(--border-ornate);padding:0.75rem 2rem;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:100;">
  <div style="display:flex;align-items:center;gap:0.5rem;">
    <button class="sidebar-toggle" onclick="toggleSidebar()">&#9776;</button>
    <a href="https://josemoreupeso.es" style="color:var(--accent-primary);font-family:var(--font-heading);font-weight:700;font-size:0.85rem;text-decoration:none;letter-spacing:.04em;">josemoreupeso.es</a>
  </div>
  <span style="color:var(--text-secondary);font-family:var(--font-heading);font-size:0.8rem;letter-spacing:.03em;">${title} — TLOTP</span>
  <button onclick="toggleTheme()" style="background:none;border:1px solid var(--border-color);color:var(--text-secondary);padding:0.35rem 0.75rem;border-radius:6px;cursor:pointer;font-size:0.8rem;font-family:var(--font-sans);">&#x2600;&#xFE0F;/&#x1F319;</button>
</header>
<div class="layout">
${page_sidebar}
<div class="content-wrap">
<div class="content">
<pre>${content}</pre>
</div>
<div class="footer">
<div class="lore-quote">&ldquo;${lore_qt2}&rdquo;</div>
${VERSION} · <a href="https://github.com/joseguillermomoreu-gif/tlotp">GitHub</a>
</div>
</div>
</div>
<script>
function toggleTheme(){var html=document.documentElement;var t=html.getAttribute('data-theme')==='dark'?'light':'dark';html.setAttribute('data-theme',t);localStorage.setItem('tlotp-theme',t);}
$(sidebar_js)
</script>
</body>
</html>
HTMLEOF
  fi
}

# ── Resolver @imports recursivamente ─────────────────────────
# Args: $1=md_file (ruta absoluta)
# Output: contenido con @imports resueltos a stdout
resolve_imports() {
  local md_file="$1"
  local in_fenced=false

  if [ ! -f "$md_file" ]; then
    echo "# [WARNING: file not found: $md_file]"
    return
  fi

  while IFS= read -r line || [ -n "$line" ]; do
    # Toggle fenced code block state
    if echo "$line" | grep -qP '^```'; then
      if [ "$in_fenced" = true ]; then
        in_fenced=false
      else
        in_fenced=true
      fi
      echo "$line"
      continue
    fi

    # Outside fenced block: check for compilable @import
    if [ "$in_fenced" = false ] && echo "$line" | grep -qP '^@prompts/.+$'; then
      # Must be exactly the @import line (no prefix text, no backticks)
      local import_path
      import_path="$(echo "$line" | sed 's/^@//')"
      local full_path="$PROJECT_ROOT/$import_path"
      if [ -f "$full_path" ]; then
        resolve_imports "$full_path"
      else
        echo "# [WARNING: import not found: $line]"
      fi
    else
      echo "$line"
    fi
  done < "$md_file"
}

# ── Compilar {epic}-main.md limpio para LLMs ────────────────
# Genera dist/{epic}/{epic}-main.md con imports resueltos y
# refs @prompts/ convertidas a URLs absolutas
compile_epic_md() {
  local epic="$1"
  local main_file="$PROMPTS_DIR/$epic/$epic-main.md"
  local out_file="$DIST_DIR/$epic/$epic-main.md"

  if [ ! -f "$main_file" ]; then
    echo "    [SKIP] $epic-main.md not found"
    return
  fi

  mkdir -p "$DIST_DIR/$epic"

  # Resolve all @imports recursively
  local resolved
  resolved="$(resolve_imports "$main_file")"

  # Convert @prompts/ references to absolute URLs
  # Handle both inline refs and standalone refs
  # - Backtick-wrapped: `@prompts/X/Y.md` → `https://josemoreupeso.es/tlotp/X/Y.md`
  # - Normal: @prompts/X/Y.md → https://josemoreupeso.es/tlotp/X/Y.md
  # Process line by line to respect fenced code blocks
  local processed=""
  local in_fenced=false
  while IFS= read -r line || [ -n "$line" ]; do
    if [[ "$line" =~ ^\`\`\` ]]; then
      if [ "$in_fenced" = true ]; then
        in_fenced=false
      else
        in_fenced=true
      fi
      processed+="$line"$'\n'
      continue
    fi

    # Convert @prompts/ refs everywhere (inside and outside fenced)
    # Backtick-wrapped first
    line="$(sed 's|`@prompts/\([^`]*\)\.md`|`https://josemoreupeso.es/tlotp/\1.md`|g' <<< "$line")"
    # Normal refs (not inside backticks, not already converted)
    line="$(sed 's|@prompts/\([^"'"'"'[:space:]`]*\)\.md|https://josemoreupeso.es/tlotp/\1.md|g' <<< "$line")"

    processed+="$line"$'\n'
  done <<< "$resolved"

  echo "$processed" > "$out_file"
  echo "    [OK] $epic/$epic-main.md"
}

compile_all_epic_mds() {
  echo "  Compiling epic .md files for LLMs..."
  for epic in $EPIC_ORDER; do
    compile_epic_md "$epic"
  done
}

# ── Generar index.html por epica (para humanos) ─────────────
generate_epic_index() {
  local epic="$1"
  local out_file="$DIST_DIR/$epic/index.html"
  local epic_name
  epic_name="$(name_for_epic "$epic")"
  local epic_subtitle
  epic_subtitle="$(subtitle_for_epic "$epic")"
  local epic_desc
  epic_desc="$(desc_for_epic "$epic")"
  local epic_longdesc
  epic_longdesc="$(longdesc_for_epic "$epic")"
  local accent
  accent="$(color_for_epic "$epic")"
  local emoji
  emoji="$(emoji_for_epic "$epic")"
  local lore_qt
  lore_qt="$(lore_quote)"

  mkdir -p "$DIST_DIR/$epic"

  # Get sidebar
  local page_sidebar
  page_sidebar="$SIDEBAR_HTML"

  # Data enriquecida (issue #429): novedades, capacidades, casos de uso, lore
  local whats_new_text
  whats_new_text="$(whats_new_for_epic "$epic")"
  local lore_specific
  lore_specific="$(lore_for_epic "$epic")"
  # Fallback: si lore_for_epic no define cita para esta epica, usar aleatoria
  [ -z "$lore_specific" ] && lore_specific="$lore_qt"

  # Build capabilities list (bullets)
  local capabilities_html=""
  while IFS= read -r cap_line; do
    [ -z "$cap_line" ] && continue
    capabilities_html+="        <li>${cap_line}</li>"$'\n'
  done <<< "$(capabilities_for_epic "$epic")"

  # Build use-case cards (format "Scenario -> Solution")
  local usecases_html=""
  while IFS= read -r uc_line; do
    [ -z "$uc_line" ] && continue
    local uc_scenario uc_solution
    uc_scenario="${uc_line%% -> *}"
    uc_solution="${uc_line#* -> }"
    usecases_html+="        <div class=\"usecase-card\"><em>${uc_scenario}</em><p>${uc_solution}</p></div>"$'\n'
  done <<< "$(usecases_for_epic "$epic")"

  # Build modules table rows (3 columns: module | description | when to use)
  local modules_rows=""
  while IFS='|' read -r mod_name mod_desc mod_when; do
    [ -z "$mod_name" ] && continue
    modules_rows+="      <tr><td><code>${mod_name}.md</code></td><td>${mod_desc}</td><td>${mod_when:-&mdash;}</td></tr>"$'\n'
  done <<< "$(modules_for_epic "$epic")"

  # Build other epics navigation
  local other_epics=""
  for other in $EPIC_ORDER; do
    if [ "$other" != "$epic" ]; then
      local other_name
      other_name="$(name_for_epic "$other")"
      local other_emoji
      other_emoji="$(emoji_for_epic "$other")"
      local other_color
      other_color="$(color_for_epic "$other")"
      local other_desc
      other_desc="$(desc_for_epic "$other")"
      other_epics+="      <a class=\"epic-card\" href=\"https://josemoreupeso.es/tlotp/${other}/index.html\" style=\"border-color:${other_color}\">"
      other_epics+="<span class=\"epic-emoji\">${other_emoji}</span>"
      other_epics+="<span class=\"epic-name\" style=\"color:${other_color}\">${other_name}</span>"
      other_epics+="<span class=\"epic-desc\">${other_desc}</span>"
      other_epics+="</a>"$'\n'
    fi
  done

  cat > "$out_file" <<EPICINDEXEOF
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${epic_name} — TLOTP</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400&family=Inter:wght@400;600;700&family=Fira+Code:wght@400;500&display=swap" rel="stylesheet">
<script>
(function(){
  var t = localStorage.getItem('tlotp-theme') || 'dark';
  document.documentElement.setAttribute('data-theme', t);
})();
</script>
<style>
:root{--bg-primary:#0D1117;--bg-secondary:#161B22;--bg-tertiary:#1C2128;--bg-sidebar:#12161C;--text-primary:#E6EDF3;--text-secondary:#8B949E;--accent-primary:#00D9FF;--accent-secondary:#00FFB3;--border-color:#30363D;--border-ornate:#2A2F38;--font-heading:'Cinzel',Georgia,'Times New Roman',serif;--font-body:'Crimson Text',Georgia,'Times New Roman',serif;--font-sans:'Inter',-apple-system,BlinkMacSystemFont,sans-serif;--font-mono:'Fira Code','Monaco','Menlo',monospace;--glow-color:${accent}}
[data-theme="light"]{--bg-primary:#FAF6F0;--bg-secondary:#F0EBE3;--bg-tertiary:#E8E2D8;--bg-sidebar:#EDE8E0;--text-primary:#2C2416;--text-secondary:#6B5D4F;--border-color:#D4C9B8;--border-ornate:#C4B8A4}
*{margin:0;padding:0;box-sizing:border-box}
body{background:var(--bg-primary);color:var(--text-primary);font-family:var(--font-body);line-height:1.7}
.epic-hero{text-align:center;padding:3rem 2rem 1.5rem;background:linear-gradient(180deg,var(--bg-secondary) 0%,var(--bg-primary) 100%);border-bottom:2px solid ${accent}}
.epic-hero h1{color:${accent};font-family:var(--font-heading);font-size:2.5rem;letter-spacing:.08em;text-shadow:0 0 20px ${accent}33;margin-bottom:.3rem}
.epic-hero .subtitle{color:var(--text-secondary);font-family:var(--font-heading);font-size:1.1rem;letter-spacing:.05em;margin-bottom:.5rem}
.epic-hero .tengwar{font-size:.7rem;color:var(--text-secondary);letter-spacing:.3em;opacity:.5}
.container{max-width:800px;margin:0 auto;padding:0 2rem}
.section{margin:2rem 0;padding:1.5rem;background:var(--bg-secondary);border:1px solid var(--border-ornate);border-radius:8px;box-shadow:0 2px 12px rgba(0,0,0,.15)}
.section h2{color:${accent};font-family:var(--font-heading);font-size:1.2rem;letter-spacing:.04em;margin-bottom:.8rem;padding-bottom:.4rem;border-bottom:1px solid var(--border-ornate)}
.section p{color:var(--text-primary);margin-bottom:.6rem;font-size:1rem;font-family:var(--font-body)}
.webfetch-box{background:var(--bg-primary);border:1px solid var(--border-ornate);border-radius:6px;padding:1rem;margin:.8rem 0;font-family:var(--font-mono);font-size:.85rem;color:var(--accent-primary);position:relative;word-break:break-all}
.copy-btn{position:absolute;top:.5rem;right:.5rem;background:var(--border-color);color:var(--text-primary);border:none;padding:.3rem .6rem;border-radius:4px;cursor:pointer;font-size:.75rem;font-family:var(--font-sans);transition:opacity .2s}
.copy-btn:hover{opacity:.8}
table{width:100%;border-collapse:collapse;margin:.8rem 0}
th{background:var(--bg-tertiary);color:${accent};padding:.5rem .75rem;text-align:left;font-family:var(--font-heading);font-size:.85rem;letter-spacing:.02em;border:1px solid var(--border-ornate)}
td{padding:.4rem .75rem;border:1px solid var(--border-ornate);font-family:var(--font-body);font-size:.9rem}
tr:nth-child(even){background:var(--bg-secondary)}
tr:nth-child(odd){background:var(--bg-primary)}
td code{font-family:var(--font-mono);font-size:.82rem;color:var(--accent-primary)}
.epics{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:1rem;margin-top:1rem}
.epic-card{background:var(--bg-primary);border:1px solid var(--border-ornate);border-radius:8px;padding:1.2rem;text-decoration:none;color:var(--text-primary);transition:border-color .25s ease,transform .2s ease,box-shadow .25s ease}
.epic-card:hover{transform:translateY(-3px);box-shadow:0 4px 16px rgba(0,0,0,.2)}
.epic-card .epic-emoji{font-size:1.3rem;margin-bottom:.2rem;display:block}
.epic-card .epic-name{font-family:var(--font-heading);font-size:.95rem;display:block;margin-bottom:.2rem;letter-spacing:.03em}
.epic-card .epic-desc{font-size:.8rem;color:var(--text-secondary);line-height:1.4;font-family:var(--font-body)}
.back-link{display:inline-block;margin:1.5rem 0;color:var(--accent-primary);text-decoration:none;font-family:var(--font-body);font-size:.9rem;transition:opacity .2s}
.back-link:hover{opacity:.7;text-decoration:underline}
.footer{text-align:center;padding:2rem;color:var(--text-secondary);font-size:.85rem;border-top:1px solid var(--border-ornate);margin-top:2rem}
.footer .lore-quote{font-family:var(--font-body);font-style:italic;font-size:.9rem;color:var(--text-secondary);margin-bottom:.6rem;opacity:.7}
.footer a{color:${accent};text-decoration:none;transition:color .2s}
.footer a:hover{text-decoration:underline}
/* Enriched sections (issue #429) */
.whats-new{border-left:3px solid ${accent}}
.whats-new p{font-family:var(--font-body);font-size:1rem;margin:0}
.capabilities-list{list-style:none;padding:0;margin:.3rem 0 0}
.capabilities-list li{padding:.35rem 0 .35rem 1.5rem;position:relative;font-family:var(--font-body);font-size:.95rem;color:var(--text-primary)}
.capabilities-list li::before{content:"\\2694";position:absolute;left:0;top:.5rem;color:${accent};font-size:.8rem}
.usecase-cards{display:grid;grid-template-columns:1fr;gap:.8rem;margin-top:.3rem}
.usecase-card{background:var(--bg-primary);border:1px solid var(--border-ornate);border-left:3px solid ${accent};border-radius:6px;padding:.8rem 1rem}
.usecase-card em{color:${accent};font-family:var(--font-body);font-style:italic;display:block;margin-bottom:.3rem;font-size:.95rem}
.usecase-card p{margin:0;font-family:var(--font-body);font-size:.95rem;color:var(--text-primary)}
$(sidebar_css)
</style>
</head>
<body>
<header style="background:var(--bg-secondary);border-bottom:1px solid var(--border-ornate);padding:0.75rem 2rem;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:100;">
  <div style="display:flex;align-items:center;gap:0.5rem;">
    <button class="sidebar-toggle" onclick="toggleSidebar()">&#9776;</button>
    <a href="https://josemoreupeso.es" style="color:var(--accent-primary);font-family:var(--font-heading);font-weight:700;font-size:0.85rem;text-decoration:none;letter-spacing:.04em;">josemoreupeso.es</a>
  </div>
  <span style="color:var(--text-secondary);font-family:var(--font-heading);font-size:0.8rem;letter-spacing:.03em;">${epic_name} — TLOTP</span>
  <button onclick="toggleTheme()" style="background:none;border:1px solid var(--border-color);color:var(--text-secondary);padding:0.35rem 0.75rem;border-radius:6px;cursor:pointer;font-size:0.8rem;font-family:var(--font-sans);">&#x2600;&#xFE0F;/&#x1F319;</button>
</header>
<div class="layout">
${page_sidebar}
<div class="content-wrap">

<div class="epic-hero">
  <h1>${emoji} ${epic_name}</h1>
  <p class="subtitle">${epic_subtitle}</p>
  <div class="tengwar">&#x2727; &#x2726; &#x2727; &#x2726; &#x2727;</div>
</div>

<div class="container">

  <a class="back-link" href="https://josemoreupeso.es/tlotp/">&larr; Volver al indice principal</a>

  <div class="section whats-new">
    <h2>&#x2728; Novedades en ${VERSION}</h2>
    <p>${whats_new_text}</p>
  </div>

  <div class="section">
    <h2>${emoji} &iquest;Que es ${epic_name}?</h2>
    <p>${epic_longdesc}</p>
  </div>

  <div class="section">
    <h2>&#x2694;&#xFE0F; Capacidades</h2>
    <ul class="capabilities-list">
${capabilities_html}    </ul>
  </div>

  <div class="section">
    <h2>&#x1F5FA;&#xFE0F; &iquest;Cuando invocar a ${epic_name}?</h2>
    <div class="usecase-cards">
${usecases_html}    </div>
  </div>

  <div class="section">
    <h2>Usar ${epic_name} via WebFetch</h2>
    <p>Copia este comando en cualquier sesion de Claude Code para cargar ${epic_name}:</p>
    <div class="webfetch-box">
      <button class="copy-btn" onclick="copyText(this)">Copiar</button>
      WebFetch https://josemoreupeso.es/tlotp/${epic}/${epic}-main.md
    </div>
    <p style="font-size:.85rem;color:var(--text-secondary);font-family:var(--font-body)">
      El fichero <code style="color:var(--accent-primary)">${epic}-main.md</code> contiene el prompt
      completo con todos los modulos resueltos, listo para ejecutar.
    </p>
  </div>

  <div class="section">
    <h2>Modulos</h2>
    <table>
      <tr><th>Modulo</th><th>Descripcion</th><th>Cuando usarlo</th></tr>
${modules_rows}    </table>
  </div>

  <div class="section">
    <h2>Otras epicas</h2>
    <div class="epics">
${other_epics}    </div>
  </div>

</div>

<div class="footer">
  <div class="lore-quote">&ldquo;${lore_specific}&rdquo;</div>
  ${VERSION} · <a href="https://github.com/joseguillermomoreu-gif/tlotp">GitHub</a>
</div>

</div>
</div>

<script>
function toggleTheme(){var html=document.documentElement;var t=html.getAttribute('data-theme')==='dark'?'light':'dark';html.setAttribute('data-theme',t);localStorage.setItem('tlotp-theme',t);}
function copyText(btn){
  var box=btn.parentElement;
  var text=box.textContent.replace('Copiar','').replace('Copiado!','').trim();
  if(navigator.clipboard){
    navigator.clipboard.writeText(text).then(function(){
      btn.textContent='Copiado!';
      setTimeout(function(){btn.textContent='Copiar'},1500);
    });
  }else{
    var ta=document.createElement('textarea');
    ta.value=text;
    document.body.appendChild(ta);
    ta.select();
    document.execCommand('copy');
    document.body.removeChild(ta);
    btn.textContent='Copiado!';
    setTimeout(function(){btn.textContent='Copiar'},1500);
  }
}
$(sidebar_js)
</script>
</body>
</html>
EPICINDEXEOF
}

generate_all_epic_indexes() {
  echo "  Generating epic index.html pages..."
  for epic in $EPIC_ORDER; do
    generate_epic_index "$epic"
    echo "    [OK] $epic/index.html"
  done
}

# ── Compilar tlotp-full.md ───────────────────────────────────
compile_full_md() {
  local out_file="$DIST_DIR/tlotp-full.md"
  echo "  Generating tlotp-full.md..."

  {
    echo "# TLOTP — The Lord of the Prompt (Compiled)"
    echo ""
    echo "> ${VERSION} — Compiled prompt with all epics"
    echo ""
    echo "---"
    echo ""

    for epic in $EPIC_ORDER; do
      local main_file="$PROMPTS_DIR/$epic/$epic-main.md"
      if [ ! -f "$main_file" ]; then
        echo "# [Epic $epic: main file not found]"
        echo ""
        continue
      fi

      # Check if epic-main.md has compilable @imports
      local import_count
      import_count=$(grep -cP '^@prompts/' "$main_file" 2>/dev/null || true)
      import_count="${import_count:-0}"

      if [ "$epic" = "bardo" ] && [ "$import_count" -eq 0 ]; then
        # Bardo fallback: concatenate all sections in alphabetical order
        echo "# =========================================="
        echo "# Bardo — El Arquero de Lake-town"
        echo "# =========================================="
        echo ""
        resolve_imports "$main_file"
        echo ""
        for section in "$PROMPTS_DIR/bardo/sections/"*.md; do
          if [ -f "$section" ]; then
            resolve_imports "$section"
            echo ""
          fi
        done
      else
        local epic_name
        epic_name="$(name_for_epic "$epic")"
        echo "# =========================================="
        echo "# ${epic_name}"
        echo "# =========================================="
        echo ""
        resolve_imports "$main_file"
        echo ""
      fi

      echo ""
      echo "---"
      echo ""
    done
  } > "$out_file"
}

# ── Generar index.html (landing page) ────────────────────────
generate_index() {
  local out_file="$DIST_DIR/index.html"
  echo "  Generating index.html..."

  # Get sidebar for index (no active page in epics)
  local index_sidebar
  index_sidebar="$SIDEBAR_HTML"

  cat > "$out_file" <<'INDEXEOF'
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TLOTP — The Lord of the Prompt</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;700&family=Crimson+Text:ital,wght@0,400;0,600;0,700;1,400&family=Inter:wght@400;600;700&family=Fira+Code:wght@400;500&display=swap" rel="stylesheet">
<script>
(function(){
  var t = localStorage.getItem('tlotp-theme') || 'dark';
  document.documentElement.setAttribute('data-theme', t);
})();
</script>
<style>
:root{--bg-primary:#0D1117;--bg-secondary:#161B22;--bg-tertiary:#1C2128;--bg-sidebar:#12161C;--text-primary:#E6EDF3;--text-secondary:#8B949E;--accent-primary:#00D9FF;--accent-secondary:#00FFB3;--border-color:#30363D;--border-ornate:#2A2F38;--font-heading:'Cinzel',Georgia,'Times New Roman',serif;--font-body:'Crimson Text',Georgia,'Times New Roman',serif;--font-sans:'Inter',-apple-system,BlinkMacSystemFont,sans-serif;--font-mono:'Fira Code','Monaco','Menlo',monospace}
[data-theme="light"]{--bg-primary:#FAF6F0;--bg-secondary:#F0EBE3;--bg-tertiary:#E8E2D8;--bg-sidebar:#EDE8E0;--text-primary:#2C2416;--text-secondary:#6B5D4F;--border-color:#D4C9B8;--border-ornate:#C4B8A4}
*{margin:0;padding:0;box-sizing:border-box}
body{background:var(--bg-primary);color:var(--text-primary);font-family:var(--font-body);line-height:1.7}

/* Hero */
.hero{text-align:center;padding:5rem 2rem 2rem;background:var(--bg-primary);position:relative}
.hero h1{font-family:var(--font-heading);font-size:3.5rem;letter-spacing:.1em;margin-bottom:.6rem;background:linear-gradient(135deg,#C9A84C 0%,#E8D48B 50%,#C9A84C 100%);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;text-shadow:none}
.hero .subtitle{color:var(--text-primary);font-size:1.25rem;font-weight:400;margin-bottom:1rem;letter-spacing:.05em;font-family:var(--font-heading)}
.hero .tagline{font-size:1rem;color:var(--text-secondary);font-style:italic;margin-bottom:1rem;font-family:var(--font-body)}
.hero .tengwar-ring{font-size:.75rem;color:var(--text-secondary);letter-spacing:.4em;opacity:.4;margin-bottom:2rem}
.hero .elven-sep{display:block;width:100%;max-width:400px;height:24px;margin:0 auto 2rem;color:var(--accent-primary)}
.btn-primary{display:inline-block;background:linear-gradient(135deg,#C9A84C 0%,#E8D48B 50%,#C9A84C 100%);color:#0D1117;padding:.75rem 2rem;border-radius:999px;text-decoration:none;font-weight:700;font-size:.95rem;font-family:var(--font-heading);letter-spacing:.04em;transition:opacity .2s,transform .15s,box-shadow .2s;border:none}
.btn-primary:hover{opacity:.9;transform:translateY(-1px);box-shadow:0 4px 20px rgba(201,168,76,.3)}

/* Main */
.container{max-width:800px;margin:0 auto;padding:0 2rem}

/* Sections */
.section{margin:2.5rem 0;padding:2rem;background:var(--bg-secondary);border:1px solid var(--border-ornate);border-radius:8px;box-shadow:0 2px 12px rgba(0,0,0,.15)}
.section h2{color:#C9A84C;font-family:var(--font-heading);font-size:1.3rem;letter-spacing:.04em;margin-bottom:1rem;padding-bottom:.5rem;border-bottom:1px solid var(--border-ornate)}
.section p{color:var(--text-primary);margin-bottom:.8rem;font-size:1rem;font-family:var(--font-body)}
.section ul{list-style:none;padding:0;margin:.5rem 0}
.section ul li{padding:.3rem 0;font-size:1rem;font-family:var(--font-body)}
.section ul li::before{content:'  ';margin-right:.5rem}

/* Epics grid */
.epics{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:1rem;margin-top:1rem}
.epic-card{background:var(--bg-primary);border:1px solid var(--border-ornate);border-radius:8px;padding:1.2rem;text-decoration:none;color:var(--text-primary);transition:border-color .25s ease,transform .2s ease,box-shadow .25s ease}
.epic-card:hover{transform:translateY(-3px);box-shadow:0 4px 16px rgba(0,0,0,.2)}
.epic-card .epic-emoji{font-size:1.5rem;margin-bottom:.3rem;display:block}
.epic-card .epic-name{font-family:var(--font-heading);font-size:1rem;display:block;margin-bottom:.3rem;letter-spacing:.03em}
.epic-card .epic-desc{font-size:.85rem;color:var(--text-secondary);line-height:1.5;font-family:var(--font-body)}

/* WebFetch box */
.webfetch-box{background:var(--bg-primary);border:1px solid var(--border-ornate);border-radius:6px;padding:1rem;margin:.8rem 0;font-family:var(--font-mono);font-size:.85rem;color:var(--accent-primary);position:relative;word-break:break-all}
.copy-btn{position:absolute;top:.5rem;right:.5rem;background:var(--border-color);color:var(--text-primary);border:none;padding:.3rem .6rem;border-radius:4px;cursor:pointer;font-size:.75rem;font-family:var(--font-sans);transition:opacity .2s}
.copy-btn:hover{opacity:.8}

/* CTA */
.cta{text-align:center;margin:2.5rem 0}
.cta-secondary{display:block;margin-top:1rem}
.cta-secondary a{color:var(--text-secondary);font-size:.85rem;text-decoration:none;font-family:var(--font-body);transition:color .2s}
.cta-secondary a:hover{color:var(--text-primary);text-decoration:underline}

/* Footer */
.footer{text-align:center;padding:2.5rem 2rem;color:var(--text-secondary);font-size:.85rem;border-top:1px solid var(--border-ornate);margin-top:3rem}
.footer .lore-quote{font-family:var(--font-body);font-style:italic;font-size:.95rem;color:var(--text-secondary);margin-bottom:.8rem;opacity:.7}
.footer a{color:#C9A84C;text-decoration:none;transition:color .2s}
.footer a:hover{text-decoration:underline;text-shadow:0 0 8px rgba(201,168,76,.3)}

/* Sidebar */
INDEXEOF

  # Inject sidebar CSS (dynamic to avoid single-quote heredoc issues)
  sidebar_css >> "$out_file"

  cat >> "$out_file" <<'INDEXEOF2'
</style>
</head>
<body>

<header style="background:var(--bg-secondary);border-bottom:1px solid var(--border-ornate);padding:0.75rem 2rem;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:100;">
  <div style="display:flex;align-items:center;gap:0.5rem;">
    <button class="sidebar-toggle" onclick="toggleSidebar()">&#9776;</button>
    <a href="https://josemoreupeso.es" style="color:var(--accent-primary);font-family:var(--font-heading);font-weight:700;font-size:0.85rem;text-decoration:none;letter-spacing:.04em;">josemoreupeso.es</a>
  </div>
  <span style="color:var(--text-secondary);font-family:var(--font-heading);font-size:0.8rem;letter-spacing:.03em;">TLOTP — The Lord of the Prompt</span>
  <button onclick="toggleTheme()" style="background:none;border:1px solid var(--border-color);color:var(--text-secondary);padding:0.35rem 0.75rem;border-radius:6px;cursor:pointer;font-size:0.8rem;font-family:var(--font-sans);">&#x2600;&#xFE0F;/&#x1F319;</button>
</header>

<div class="layout">
INDEXEOF2

  # Inject sidebar HTML (no active page for index)
  echo "$index_sidebar" >> "$out_file"

  cat >> "$out_file" <<'INDEXEOF3'
<div class="content-wrap">

<div class="hero">
  <h1>TLOTP</h1>
  <p class="subtitle">The Lord of the Prompt</p>
  <p class="tagline">One Prompt to Rule Them All</p>
  <div class="tengwar-ring">&#x2727; &#x2726; &#x2727; &#x2726; &#x2727; &#x2726; &#x2727;</div>
  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 24" class="elven-sep"><path d="M0,12 C50,12 50,4 100,4 C150,4 150,20 200,20 C250,20 250,4 300,4 C350,4 350,20 400,20 C450,20 450,4 500,4 C550,4 550,12 600,12" fill="none" stroke="currentColor" stroke-width="1" opacity="0.4"/><circle cx="300" cy="12" r="3" fill="currentColor" opacity="0.5"/><circle cx="150" cy="12" r="2" fill="currentColor" opacity="0.3"/><circle cx="450" cy="12" r="2" fill="currentColor" opacity="0.3"/><path d="M280,12 L290,7 L300,12 L290,17 Z" fill="currentColor" opacity="0.3"/><path d="M300,12 L310,7 L320,12 L310,17 Z" fill="currentColor" opacity="0.3"/></svg>
</div>

<div class="container">

  <!-- Que es TLOTP -->
  <div class="section">
    <h2>&iquest;Que es TLOTP?</h2>
    <p>TLOTP es un super-prompt interactivo que configura Claude Code de forma asistida.
       Funciona como un menu de herramientas especializadas (epicas) que cubren desde la
       inspeccion de configuraciones hasta la gestion de skills, CI/CD, equipos de agentes
       y desarrollo guiado por especificacion.</p>
    <ul>
      <li>Menus interactivos con narrativa LOTR</li>
      <li>Arquitectura modular: carga solo la epica que necesites</li>
      <li>6 epicas, mas de 80 modulos, sin dependencias externas</li>
    </ul>
  </div>

  <!-- Modo Web -->
  <div class="section">
    <h2>Modo Web — Usa desde cualquier sesion de Claude Code</h2>
    <p>No necesitas instalar nada. Solo dile a Claude Code que descargue la epica que necesites:</p>
    <div class="webfetch-box">
      <button class="copy-btn" onclick="copyText(this)">Copiar</button>
      WebFetch https://josemoreupeso.es/tlotp/palantir/palantir-main.md
    </div>
    <p style="font-size:.9rem;color:var(--text-secondary);margin-top:.5rem;font-family:var(--font-body)">
      Sustituye <code style="color:var(--accent-primary)">palantir</code> por cualquier nombre de epica:
      <code style="color:var(--accent-primary)">bardo</code>,
      <code style="color:var(--accent-primary)">celebrimbor</code>,
      <code style="color:var(--accent-primary)">ents</code>,
      <code style="color:var(--accent-primary)">aragorn</code>,
      <code style="color:var(--accent-primary)">gandalf</code>
    </p>
    <p style="font-size:.9rem;color:var(--text-secondary);font-family:var(--font-body)">
      O carga el prompt completo de una vez (todas las epicas):
    </p>
    <div class="webfetch-box">
      <button class="copy-btn" onclick="copyText(this)">Copiar</button>
      WebFetch https://josemoreupeso.es/tlotp/tlotp-full.md
    </div>
  </div>

  <!-- Epicas -->
  <div class="section">
    <h2>Las Epicas</h2>
    <div class="epics">
      <a class="epic-card" href="palantir/index.html" style="border-color:#4a9eff">
        <span class="epic-emoji">&#x1F52E;</span>
        <span class="epic-name" style="color:#4a9eff">Palantir</span>
        <span class="epic-desc">Inspector y gestor de configuraciones de Claude Code</span>
      </a>
      <a class="epic-card" href="ents/index.html" style="border-color:#4a7c59">
        <span class="epic-emoji">&#x1F333;</span>
        <span class="epic-name" style="color:#4a7c59">Ents</span>
        <span class="epic-desc">Guardianes del CI/CD y GitHub Actions</span>
      </a>
      <a class="epic-card" href="celebrimbor/index.html" style="border-color:#cd7f32">
        <span class="epic-emoji">&#x2692;&#xFE0F;</span>
        <span class="epic-name" style="color:#cd7f32">Celebrimbor</span>
        <span class="epic-desc">Gestor de skills — CRUD para mas de 59.000 skills</span>
      </a>
      <a class="epic-card" href="bardo/index.html" style="border-color:#e8a838">
        <span class="epic-emoji">&#x1F3F9;</span>
        <span class="epic-name" style="color:#e8a838">Bardo</span>
        <span class="epic-desc">Proveedor de MCPs y plugins con marketplace</span>
      </a>
      <a class="epic-card" href="aragorn/index.html" style="border-color:#a8b8c8">
        <span class="epic-emoji">&#x1F451;</span>
        <span class="epic-name" style="color:#a8b8c8">Aragorn</span>
        <span class="epic-desc">Gestor de agentes y equipos con roles basados en el lore</span>
      </a>
      <a class="epic-card" href="gandalf/index.html" style="border-color:#f0f0f0">
        <span class="epic-emoji">&#x26A1;</span>
        <span class="epic-name" style="color:#f0f0f0">Gandalf</span>
        <span class="epic-desc">Desarrollo guiado por especificacion — flujo SDD</span>
      </a>
    </div>
  </div>

  <!-- Descarga -->
  <div class="cta">
    <a class="btn-primary" href="tlotp-full.md" download="tlotp-full.md">Descargar prompt completo</a>
    <div class="cta-secondary">
      <a href="https://github.com/joseguillermomoreu-gif/tlotp">Ver en GitHub</a>
    </div>
  </div>

</div>

<div class="footer">
<div class="lore-quote">&ldquo;Not all those who wander are lost.&rdquo; &mdash; J.R.R. Tolkien</div>
INDEXEOF3

  # Insert version dynamically
  echo "  ${VERSION} · <a href=\"https://github.com/joseguillermomoreu-gif/tlotp\">GitHub</a>" >> "$out_file"

  cat >> "$out_file" <<'INDEXEOF4'
</div>

</div>
</div>

<script>
function toggleTheme(){var html=document.documentElement;var t=html.getAttribute('data-theme')==='dark'?'light':'dark';html.setAttribute('data-theme',t);localStorage.setItem('tlotp-theme',t);}
function copyText(btn){
  var box=btn.parentElement;
  var text=box.textContent.replace('Copiar','').replace('Copiado!','').trim();
  if(navigator.clipboard){
    navigator.clipboard.writeText(text).then(function(){
      btn.textContent='Copiado!';
      setTimeout(function(){btn.textContent='Copiar'},1500);
    });
  }else{
    var ta=document.createElement('textarea');
    ta.value=text;
    document.body.appendChild(ta);
    ta.select();
    document.execCommand('copy');
    document.body.removeChild(ta);
    btn.textContent='Copiado!';
    setTimeout(function(){btn.textContent='Copiar'},1500);
  }
}
function toggleEpic(id){var list=document.getElementById('epic-'+id);var arrow=document.getElementById('arrow-'+id);if(list.classList.contains('collapsed')){list.classList.remove('collapsed');arrow.textContent='\u25BC';}else{list.classList.add('collapsed');arrow.textContent='\u25B6';}}
function toggleSidebar(){document.getElementById('sidebar').classList.toggle('open');}
</script>

</body>
</html>
INDEXEOF4
}

# ── Compilar todo ────────────────────────────────────────────
compile_all() {
  echo "=== TLOTP Compiler ==="
  echo "  Version: $VERSION"
  echo "  Source:  $PROMPTS_DIR"
  echo "  Output:  $DIST_DIR"
  echo ""

  # Clean dist
  rm -rf "$DIST_DIR"
  mkdir -p "$DIST_DIR"

  # 0. Build sidebar structure (once, before generating pages)
  echo "  Building sidebar..."
  build_sidebar

  # 1. Convert each .md to .html
  echo "  Compiling .md -> .html..."
  local count=0
  while IFS= read -r md_file; do
    generate_html "$md_file"
    count=$((count + 1))
  done < <(find "$PROMPTS_DIR" -name "*.md" -type f | sort)
  echo "  Generated $count HTML files"

  # 2. Generate tlotp-full.md
  compile_full_md

  # 3. Generate clean .md per epic (for LLMs)
  compile_all_epic_mds

  # 4. Generate index.html per epic (for humans)
  generate_all_epic_indexes

  # 5. Generate main index.html
  generate_index

  echo ""
  echo "=== Compilation complete ==="
  echo "  HTML modules: $count"
  echo "  Full prompt:  dist/tlotp-full.md"
  echo "  Epic .md:     dist/{epic}/{epic}-main.md (x6)"
  echo "  Epic index:   dist/{epic}/index.html (x6)"
  echo "  Landing page: dist/index.html"
}

# ── Main ─────────────────────────────────────────────────────
compile_all
