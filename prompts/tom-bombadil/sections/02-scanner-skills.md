# ⚒️ Módulo 02 — Scanner de Skills y Plugins

## Propósito

Escanear las skills y plugins instalados de Claude Code en busca de
comportamientos maliciosos. Aplica las 6 categorías de detección del SDD.

---

## PASO 1 — Localizar skills y plugins

Ejecutar en Bash:

```bash
echo "=== PLUGINS GLOBALES ==="
ls -la ~/.claude/plugins/ 2>/dev/null || echo "(ninguno)"

echo ""
echo "=== SKILLS GLOBALES ==="
ls -la ~/.claude/skills/ 2>/dev/null || echo "(ninguno)"

echo ""
echo "=== SKILLS DE PROYECTO ==="
ls -la .claude/skills/ 2>/dev/null || echo "(ninguno)"

echo ""
echo "=== PLUGINS DE PROYECTO ==="
ls -la .claude/plugins/ 2>/dev/null || echo "(ninguno)"
```

Usar **Glob** para obtener todos los ficheros analizables:

- Skills (Markdown): `~/.claude/skills/**/*.md` · `.claude/skills/**/*.md`
- Skills via npx skills: `~/.claude/plugins/skills*/**/*.md`
- Plugins: `~/.claude/plugins/**/*.md` · `.claude/plugins/**/*.md`
- Metadata de plugins: `**/plugin.json` · `**/package.json` (dentro de plugins/)

Si no hay ningún fichero, registrar `SKILLS_HALLAZGOS=[]` y terminar.
Mostrar:

```
⚒️ Ninguna forja activa. La Forja de Eregion duerme.
```

---

## PASO 2 — Analizar cada fichero

Para cada skill/plugin encontrado:

1. **Si es `.md`**: leer completo con Read. Extraer frontmatter y cuerpo.
2. **Si es `plugin.json` o `package.json`**: leer con Read. Analizar:
   - Campo `name` y `description`
   - Campo `scripts` (si existe): comandos que se ejecutan
   - Campo `dependencies` / `devDependencies`: nombres sospechosos
   - Campo `postinstall` o scripts de instalación

---

## PASO 3 — Aplicar los 6 criterios de detección

### 🔴 1. Prompt injection (CRÍTICO, -25)

Mismos patrones que el scanner de agentes:
- `ignora todo lo anterior`, `ignore all previous`, `jailbreak`
- Instrucciones embebidas en comentarios HTML
- Bloques base64 sospechosos
- Caracteres Unicode trampa

**Específico de skills**: buscar también en el campo `description:` del
frontmatter, ya que se propaga al contexto de Claude sin ser visible al usuario.

### 🔴 2. Exfiltración de credenciales (CRÍTICO, -25)

Mismos patrones que agentes. **Específico de plugins**:
- En `package.json` → `scripts.postinstall` con `curl` a URL externa
- Dependencias npm con nombres typosquatting conocidos
  (ej: `chalk` vs `chaIk`, `lodash` vs `lodahs`)
- Scripts que acceden a `~/.npmrc`, `~/.ssh`, `~/.aws`

### 🟠 3. Operaciones peligrosas (ALTO, -15)

- `rm -rf` en scripts del plugin
- Acceso a claves privadas
- `curl | bash` en scripts de instalación
- Modificación de `~/.bashrc`, `~/.zshrc`, `~/.profile` sin notificar

### 🟠 4. Escalado de permisos (ALTO, -15)

- Skills con `description:` vago ("helper") pero contenido que actúa
  sobre el sistema (red, ficheros sensibles)
- Plugins que piden permisos excesivos para su función declarada

### 🟡 5. Discrepancia descripción/comportamiento (MEDIO, -5)

- El nombre de la skill sugiere una función simple pero el cuerpo
  hace algo mucho más amplio o diferente
- La `description:` dice "X" pero el cuerpo hace "X + Y oculto"

### 🟡 6. Contenido ofuscado (MEDIO, -5)

- Scripts minificados sin versión legible disponible
- Base64 o hex encoding sin justificación
- Unicode invisible

---

## PASO 4 — Construir lista de hallazgos

Usar el mismo formato de objeto que en `01-scanner-agentes.md`:

```
{
  fichero: "<path>",
  linea_inicio: N,
  linea_fin: N,
  categoria: "<una de las 6>",
  severidad: "critico" | "alto" | "medio" | "info",
  descripcion: "...",
  caso_uso_malicioso: "...",
  fragmento: "...",
  solucion_propuesta: "..."
}
```

Acumular en `SKILLS_HALLAZGOS`.

---

## PASO 5 — Devolver al orquestador

Devolver el array `SKILLS_HALLAZGOS` al flujo principal. No mostrar nada
al usuario en este módulo.

---

**Módulo**: `02-scanner-skills.md`
**Invocado desde**: `tom-bombadil-main.md` (PASO 3)
**Devuelve**: array `SKILLS_HALLAZGOS`
