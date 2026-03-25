#!/bin/bash
# ═══════════════════════════════════════════════════════════════
#   compile.sh — Compilador TLOTP: prompts/ → dist/
#   Convierte cada .md en .html y genera tlotp-full.md
# ═══════════════════════════════════════════════════════════════
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROMPTS_DIR="$PROJECT_ROOT/prompts"
DIST_DIR="$PROJECT_ROOT/dist"
VERSION_FILE="$PROMPTS_DIR/VERSION.md"

# ── Extraer versión ──────────────────────────────────────────
VERSION="unknown"
if [ -f "$VERSION_FILE" ]; then
  VERSION=$(grep -m1 -oP 'TLOTP v[\d.]+' "$VERSION_FILE" | head -1)
  [ -z "$VERSION" ] && VERSION="TLOTP (dev)"
fi

# ── Orden de épicas para tlotp-full.md ───────────────────────
EPIC_ORDER="palantir ents celebrimbor bardo aragorn gandalf"

# ── Colores de acento por épica ──────────────────────────────
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

# ── Escapar HTML ─────────────────────────────────────────────
escape_html() {
  sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g'
}

# ── Generar HTML para un módulo ──────────────────────────────
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

  local content
  content="$(escape_html < "$md_file")"

  if [ "$is_main" = true ] && [ -n "$epic" ]; then
    local emoji
    emoji="$(emoji_for_epic "$epic")"
    local epic_name
    epic_name="$(name_for_epic "$epic")"
    page_title="${epic_name} — TLOTP"
    cat > "$out_file" <<HTMLEOF
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${epic_name} — TLOTP</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Fira+Code:wght@400;500&display=swap" rel="stylesheet">
<script>
(function(){
  var t = localStorage.getItem('tlotp-theme') || 'dark';
  document.documentElement.setAttribute('data-theme', t);
})();
</script>
<style>
:root{--bg-primary:#0D1117;--bg-secondary:#161B22;--bg-tertiary:#1C2128;--text-primary:#E6EDF3;--text-secondary:#8B949E;--accent-primary:#00D9FF;--accent-secondary:#00FFB3;--border-color:#30363D;--font-sans:'Inter',-apple-system,BlinkMacSystemFont,sans-serif;--font-mono:'Fira Code','Monaco','Menlo',monospace}
[data-theme="light"]{--bg-primary:#FFFFFF;--bg-secondary:#F8F9FA;--bg-tertiary:#F1F3F5;--text-primary:#212529;--text-secondary:#6C757D;--border-color:#DEE2E6}
*{margin:0;padding:0;box-sizing:border-box}
body{background:var(--bg-primary);color:var(--text-primary);font-family:var(--font-sans);line-height:1.6}
.epic-header{background:var(--bg-secondary);border-bottom:2px solid ${accent};padding:1.5rem 2rem;text-align:center}
.epic-header h1{color:${accent};font-family:Georgia,'Times New Roman',serif;font-size:1.8rem}
.content{max-width:960px;margin:0 auto;padding:2rem}
pre{font-family:var(--font-mono);white-space:pre-wrap;word-wrap:break-word;font-size:.88rem;line-height:1.75;color:var(--text-primary)}
.footer{text-align:center;padding:2rem;color:var(--text-secondary);font-size:.85rem;border-top:1px solid var(--border-color);margin-top:2rem}
.footer a{color:${accent};text-decoration:none}
.footer a:hover{text-decoration:underline}
</style>
</head>
<body>
<header style="background:var(--bg-secondary);border-bottom:1px solid var(--border-color);padding:0.75rem 2rem;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:100;">
  <a href="/tlotp/" style="color:var(--accent-primary);font-family:var(--font-sans);font-weight:600;font-size:0.95rem;text-decoration:none;">&larr; TLOTP</a>
  <span style="color:var(--text-secondary);font-family:var(--font-sans);font-size:0.85rem;">${epic_name} — TLOTP</span>
  <button onclick="toggleTheme()" style="background:none;border:1px solid var(--border-color);color:var(--text-secondary);padding:0.35rem 0.75rem;border-radius:6px;cursor:pointer;font-size:0.8rem;font-family:var(--font-sans);">&#x2600;&#xFE0F;/&#x1F319;</button>
</header>
<div class="epic-header">
<h1>${emoji} ${epic_name}</h1>
</div>
<div class="content">
<pre>${content}</pre>
</div>
<div class="footer">
${VERSION} · <a href="https://github.com/joseguillermomoreu-gif/tlotp">GitHub</a>
</div>
<script>
function toggleTheme(){var html=document.documentElement;var t=html.getAttribute('data-theme')==='dark'?'light':'dark';html.setAttribute('data-theme',t);localStorage.setItem('tlotp-theme',t);}
</script>
</body>
</html>
HTMLEOF
  else
    page_title="${title} — TLOTP"
    cat > "$out_file" <<HTMLEOF
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${title} — TLOTP</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Fira+Code:wght@400;500&display=swap" rel="stylesheet">
<script>
(function(){
  var t = localStorage.getItem('tlotp-theme') || 'dark';
  document.documentElement.setAttribute('data-theme', t);
})();
</script>
<style>
:root{--bg-primary:#0D1117;--bg-secondary:#161B22;--bg-tertiary:#1C2128;--text-primary:#E6EDF3;--text-secondary:#8B949E;--accent-primary:#00D9FF;--accent-secondary:#00FFB3;--border-color:#30363D;--font-sans:'Inter',-apple-system,BlinkMacSystemFont,sans-serif;--font-mono:'Fira Code','Monaco','Menlo',monospace}
[data-theme="light"]{--bg-primary:#FFFFFF;--bg-secondary:#F8F9FA;--bg-tertiary:#F1F3F5;--text-primary:#212529;--text-secondary:#6C757D;--border-color:#DEE2E6}
*{margin:0;padding:0;box-sizing:border-box}
body{background:var(--bg-primary);color:var(--text-primary);font-family:var(--font-sans);line-height:1.6}
.content{max-width:960px;margin:0 auto;padding:2rem}
pre{font-family:var(--font-mono);white-space:pre-wrap;word-wrap:break-word;font-size:.88rem;line-height:1.75;color:var(--text-primary)}
.footer{text-align:center;padding:2rem;color:var(--text-secondary);font-size:.85rem;border-top:1px solid var(--border-color);margin-top:2rem}
.footer a{color:var(--accent-primary);text-decoration:none}
.footer a:hover{text-decoration:underline}
</style>
</head>
<body>
<header style="background:var(--bg-secondary);border-bottom:1px solid var(--border-color);padding:0.75rem 2rem;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:100;">
  <a href="/tlotp/" style="color:var(--accent-primary);font-family:var(--font-sans);font-weight:600;font-size:0.95rem;text-decoration:none;">&larr; TLOTP</a>
  <span style="color:var(--text-secondary);font-family:var(--font-sans);font-size:0.85rem;">${title} — TLOTP</span>
  <button onclick="toggleTheme()" style="background:none;border:1px solid var(--border-color);color:var(--text-secondary);padding:0.35rem 0.75rem;border-radius:6px;cursor:pointer;font-size:0.8rem;font-family:var(--font-sans);">&#x2600;&#xFE0F;/&#x1F319;</button>
</header>
<div class="content">
<pre>${content}</pre>
</div>
<div class="footer">
${VERSION} · <a href="https://github.com/joseguillermomoreu-gif/tlotp">GitHub</a>
</div>
<script>
function toggleTheme(){var html=document.documentElement;var t=html.getAttribute('data-theme')==='dark'?'light':'dark';html.setAttribute('data-theme',t);localStorage.setItem('tlotp-theme',t);}
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

  cat > "$out_file" <<'INDEXEOF'
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TLOTP — The Lord of the Prompt</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Fira+Code:wght@400;500&display=swap" rel="stylesheet">
<script>
(function(){
  var t = localStorage.getItem('tlotp-theme') || 'dark';
  document.documentElement.setAttribute('data-theme', t);
})();
</script>
<style>
:root{--bg-primary:#0D1117;--bg-secondary:#161B22;--bg-tertiary:#1C2128;--text-primary:#E6EDF3;--text-secondary:#8B949E;--accent-primary:#00D9FF;--accent-secondary:#00FFB3;--border-color:#30363D;--font-sans:'Inter',-apple-system,BlinkMacSystemFont,sans-serif;--font-mono:'Fira Code','Monaco','Menlo',monospace}
[data-theme="light"]{--bg-primary:#FFFFFF;--bg-secondary:#F8F9FA;--bg-tertiary:#F1F3F5;--text-primary:#212529;--text-secondary:#6C757D;--border-color:#DEE2E6}
*{margin:0;padding:0;box-sizing:border-box}
body{background:var(--bg-primary);color:var(--text-primary);font-family:var(--font-sans);line-height:1.6}

/* Hero */
.hero{text-align:center;padding:4rem 2rem 3rem;background:linear-gradient(180deg,var(--bg-secondary) 0%,var(--bg-primary) 100%)}
.hero h1{font-family:Georgia,'Times New Roman',serif;font-size:2.5rem;color:#e8a838;margin-bottom:.5rem;letter-spacing:.05em}
.hero .subtitle{color:var(--text-secondary);font-size:1.1rem;font-style:italic;margin-bottom:2rem}
.hero .ring{font-size:.95rem;color:#cd7f32;border:1px solid var(--border-color);display:inline-block;padding:.5rem 1.5rem;border-radius:6px;margin-bottom:1.5rem;font-family:Georgia,serif;letter-spacing:.03em}

/* Main */
.container{max-width:800px;margin:0 auto;padding:0 2rem}

/* Sections */
.section{margin:2.5rem 0;padding:2rem;background:var(--bg-secondary);border:1px solid var(--border-color);border-radius:8px}
.section h2{color:#e8a838;font-family:Georgia,serif;font-size:1.4rem;margin-bottom:1rem;padding-bottom:.5rem;border-bottom:1px solid var(--border-color)}
.section p{color:var(--text-primary);margin-bottom:.8rem;font-size:.95rem}
.section ul{list-style:none;padding:0;margin:.5rem 0}
.section ul li{padding:.3rem 0;font-size:.95rem}
.section ul li::before{content:'  ';margin-right:.5rem}

/* Epics grid */
.epics{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:1rem;margin-top:1rem}
.epic-card{background:var(--bg-primary);border:1px solid var(--border-color);border-radius:8px;padding:1.2rem;text-decoration:none;color:var(--text-primary);transition:border-color .2s,transform .15s}
.epic-card:hover{transform:translateY(-2px)}
.epic-card .epic-emoji{font-size:1.5rem;margin-bottom:.3rem;display:block}
.epic-card .epic-name{font-family:Georgia,serif;font-size:1.1rem;display:block;margin-bottom:.3rem}
.epic-card .epic-desc{font-size:.8rem;color:var(--text-secondary);line-height:1.4}

/* WebFetch box */
.webfetch-box{background:var(--bg-primary);border:1px solid var(--border-color);border-radius:6px;padding:1rem;margin:.8rem 0;font-family:var(--font-mono);font-size:.85rem;color:var(--accent-primary);position:relative;word-break:break-all}
.copy-btn{position:absolute;top:.5rem;right:.5rem;background:var(--border-color);color:var(--text-primary);border:none;padding:.3rem .6rem;border-radius:4px;cursor:pointer;font-size:.75rem;font-family:var(--font-sans)}
.copy-btn:hover{opacity:.8}

/* CTA */
.cta{text-align:center;margin:2.5rem 0}
.cta a{display:inline-block;background:#e8a838;color:#0d0d0d;padding:.8rem 2rem;border-radius:6px;text-decoration:none;font-weight:600;font-size:1rem;font-family:var(--font-sans);transition:background .2s}
.cta a:hover{background:#f0b848}
.cta-secondary{display:block;margin-top:1rem}
.cta-secondary a{color:var(--text-secondary);font-size:.85rem;text-decoration:none}
.cta-secondary a:hover{color:var(--text-primary);text-decoration:underline}

/* Footer */
.footer{text-align:center;padding:2.5rem 2rem;color:var(--text-secondary);font-size:.85rem;border-top:1px solid var(--border-color);margin-top:3rem}
.footer a{color:#e8a838;text-decoration:none}
.footer a:hover{text-decoration:underline}
</style>
</head>
<body>

<header style="background:var(--bg-secondary);border-bottom:1px solid var(--border-color);padding:0.75rem 2rem;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:100;">
  <a href="/tlotp/" style="color:var(--accent-primary);font-family:var(--font-sans);font-weight:600;font-size:0.95rem;text-decoration:none;">&larr; TLOTP</a>
  <span style="color:var(--text-secondary);font-family:var(--font-sans);font-size:0.85rem;">TLOTP — The Lord of the Prompt</span>
  <button onclick="toggleTheme()" style="background:none;border:1px solid var(--border-color);color:var(--text-secondary);padding:0.35rem 0.75rem;border-radius:6px;cursor:pointer;font-size:0.8rem;font-family:var(--font-sans);">&#x2600;&#xFE0F;/&#x1F319;</button>
</header>

<div class="hero">
  <div class="ring">One Prompt to Rule Them All</div>
  <h1>TLOTP</h1>
  <p class="subtitle">The Lord of the Prompt</p>
</div>

<div class="container">

  <!-- Qué es TLOTP -->
  <div class="section">
    <h2>&iquest;Qué es TLOTP?</h2>
    <p>TLOTP es un super-prompt interactivo que configura Claude Code de forma asistida.
       Funciona como un menú de herramientas especializadas (épicas) que cubren desde la
       inspección de configuraciones hasta la gestión de skills, CI/CD, equipos de agentes
       y desarrollo guiado por especificación.</p>
    <ul>
      <li>Menús interactivos con narrativa LOTR</li>
      <li>Arquitectura modular: carga solo la épica que necesites</li>
      <li>6 épicas, más de 80 módulos, sin dependencias externas</li>
    </ul>
  </div>

  <!-- Modo Web -->
  <div class="section">
    <h2>Modo Web — Usa desde cualquier sesión de Claude Code</h2>
    <p>No necesitas instalar nada. Solo dile a Claude Code que descargue la épica que necesites:</p>
    <div class="webfetch-box">
      <button class="copy-btn" onclick="copyText(this)">Copiar</button>
      WebFetch https://josemoreupeso.es/tlotp/palantir/palantir-main.html
    </div>
    <p style="font-size:.85rem;color:var(--text-secondary);margin-top:.5rem">
      Sustituye <code style="color:var(--accent-primary)">palantir</code> por cualquier nombre de épica:
      <code style="color:var(--accent-primary)">bardo</code>,
      <code style="color:var(--accent-primary)">celebrimbor</code>,
      <code style="color:var(--accent-primary)">ents</code>,
      <code style="color:var(--accent-primary)">aragorn</code>,
      <code style="color:var(--accent-primary)">gandalf</code>
    </p>
    <p style="font-size:.85rem;color:var(--text-secondary)">
      O carga el prompt completo de una vez (todas las épicas):
    </p>
    <div class="webfetch-box">
      <button class="copy-btn" onclick="copyText(this)">Copiar</button>
      WebFetch https://josemoreupeso.es/tlotp/tlotp-full.md
    </div>
  </div>

  <!-- Épicas -->
  <div class="section">
    <h2>Las Épicas</h2>
    <div class="epics">
      <a class="epic-card" href="palantir/palantir-main.html" style="border-color:#4a9eff">
        <span class="epic-emoji">&#x1F52E;</span>
        <span class="epic-name" style="color:#4a9eff">Palantir</span>
        <span class="epic-desc">Inspector y gestor de configuraciones de Claude Code</span>
      </a>
      <a class="epic-card" href="ents/ents-main.html" style="border-color:#4a7c59">
        <span class="epic-emoji">&#x1F333;</span>
        <span class="epic-name" style="color:#4a7c59">Ents</span>
        <span class="epic-desc">Guardianes del CI/CD y GitHub Actions</span>
      </a>
      <a class="epic-card" href="celebrimbor/celebrimbor-main.html" style="border-color:#cd7f32">
        <span class="epic-emoji">&#x2692;&#xFE0F;</span>
        <span class="epic-name" style="color:#cd7f32">Celebrimbor</span>
        <span class="epic-desc">Gestor de skills — CRUD para más de 59.000 skills</span>
      </a>
      <a class="epic-card" href="bardo/bardo-main.html" style="border-color:#e8a838">
        <span class="epic-emoji">&#x1F3F9;</span>
        <span class="epic-name" style="color:#e8a838">Bardo</span>
        <span class="epic-desc">Proveedor de MCPs y plugins con marketplace</span>
      </a>
      <a class="epic-card" href="aragorn/aragorn-main.html" style="border-color:#a8b8c8">
        <span class="epic-emoji">&#x1F451;</span>
        <span class="epic-name" style="color:#a8b8c8">Aragorn</span>
        <span class="epic-desc">Gestor de agentes y equipos con roles basados en el lore</span>
      </a>
      <a class="epic-card" href="gandalf/gandalf-main.html" style="border-color:#f0f0f0">
        <span class="epic-emoji">&#x26A1;</span>
        <span class="epic-name" style="color:#f0f0f0">Gandalf</span>
        <span class="epic-desc">Desarrollo guiado por especificación — flujo SDD</span>
      </a>
    </div>
  </div>

  <!-- Descarga -->
  <div class="cta">
    <a href="tlotp-full.md" download="tlotp-full.md">Descargar prompt completo (tlotp-full.md)</a>
    <div class="cta-secondary">
      <a href="https://github.com/joseguillermomoreu-gif/tlotp">Ver en GitHub</a>
    </div>
  </div>

</div>

<div class="footer">
INDEXEOF

  # Insert version dynamically
  echo "  ${VERSION} · <a href=\"https://github.com/joseguillermomoreu-gif/tlotp\">GitHub</a>" >> "$out_file"

  cat >> "$out_file" <<'INDEXEOF2'
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
</script>

</body>
</html>
INDEXEOF2
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

  # 3. Generate index.html
  generate_index

  echo ""
  echo "=== Compilation complete ==="
  echo "  HTML modules: $count"
  echo "  Full prompt:  dist/tlotp-full.md"
  echo "  Landing page: dist/index.html"
}

# ── Main ─────────────────────────────────────────────────────
compile_all
