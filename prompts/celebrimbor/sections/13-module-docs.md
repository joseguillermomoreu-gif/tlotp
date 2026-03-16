# 📜 Módulo Documentación — Celebrimbor

## Misión

Proporcionar documentación oficial on-demand sobre el sistema de skills de Claude Code
y la CLI skills.sh, en el nivel de detalle que el viajero necesite.

---

## 🎯 Paso 1: Elegir Nivel de Detalle

Mostrar con `AskUserQuestion`:

```json
{
  "questions": [{
    "header": "Los pergaminos de Eregion",
    "question": "¿Cuánto tiempo tienes para estudiar los secretos de la Forja, viajero?",
    "multiSelect": false,
    "options": [
      {
        "label": "📖 El grimorio completo — Documentación íntegra",
        "description": ""
      },
      {
        "label": "⚡ El resumen del Ranger — 5 minutos",
        "description": ""
      },
      {
        "label": "🕐 La nota del Hobbit — 2 minutos",
        "description": ""
      },
      {
        "label": "🔙 Volver a la Forja",
        "description": ""
      }
    ]
  }]
}
```

---

## 📖 Paso 2: Obtener Documentación (on-the-fly)

**IMPORTANTE**: Comprobar primero si la documentación ya está cargada en el
contexto de esta sesión (por haber ejecutado previamente otro módulo que haya hecho WebFetch).

**Si ya está en contexto**: usar directamente esa información sin re-fetchear.

**Si no está en contexto**, hacer WebFetch en este orden:

> **WebFetch 1**: `https://code.claude.com/docs/en/skills`
> **Extraer**: Sistema de skills nativo de Claude Code: estructura de SKILL.md, campos de
> frontmatter, ubicaciones (enterprise/personal/project/plugin), control de invocación,
> context fork, supporting files, slash commands.

> **WebFetch 2**: `https://github.com/vercel-labs/skills`
> **Extraer**: CLI `npx skills`: lista de comandos (add, find, list, check, update, init, remove),
> flags por comando, scopes de instalación (global/local), métodos (symlink vs copy),
> estructura de SKILL.md desde la perspectiva del CLI, variables de entorno.

**Fallback si WebFetch falla**:
```
⚠️ No se pudo cargar la documentación oficial en este momento.

Puedes consultarla directamente:
  📄 Skills nativas:  https://code.claude.com/docs/en/skills
  📦 CLI skills.sh:   https://github.com/vercel-labs/skills
```

---

## 🗡️ Paso 3: Generar Resumen Según Nivel

### 📖 El grimorio completo

Presentar el contenido completo extraído, organizado en secciones con lore épico de separación:

```
⚒️ CAPÍTULO I — El Sistema Nativo de Skills
   [contenido de skills nativas]

⚒️ CAPÍTULO II — La CLI de Ost-in-Edhil (skills.sh)
   [contenido de npx skills]

⚒️ CAPÍTULO III — Estructura de SKILL.md
   [frontmatter, campos, ejemplos]

⚒️ CAPÍTULO IV — Patrones Avanzados
   [context fork, invocation control, supporting files]
```

### ⚡ El resumen del Ranger (5 minutos)

Incluir únicamente:
- Qué es una skill y para qué sirve (2-3 líneas)
- Dónde se instalan (rutas globales y locales)
- Cómo instalar desde skills.sh: `npx skills add <nombre>`
- Estructura mínima de SKILL.md (frontmatter básico + cuerpo)
- Los 5 comandos más usados de `npx skills` con descripción breve
- Diferencia entre skill nativa y skill del CLI

### 🕐 La nota del Hobbit (2 minutos)

Solo lo imprescindible:
- Una frase: qué es una skill
- El comando para instalar: `npx skills add <nombre>`
- Las rutas donde se instalan: `~/.claude/skills/` (global) y `.claude/skills/` (local)
- El comando para listar las instaladas: `npx skills list`

---

## 🏁 Paso 4: Presentar con Lore

**Introducción** (mostrar antes del contenido):
```
📜 Los pergaminos de Eregion están listos, viajero.
   Celebrimbor comparte el conocimiento de los Gwaith-i-Mírdain.

══════════════════════════════════════════════════════════════
```

**Cierre** (mostrar al finalizar):
```
══════════════════════════════════════════════════════════════

⚒️  El conocimiento ha sido forjado. Úsalo bien en la Tierra Media.
```

Al finalizar, volver al menú principal de Celebrimbor (sin repetir banner ni permisos).

---

## 🔗 Fuentes

Ver índice completo en `@prompts/docs-sources.md`:
- Skills nativas: `https://code.claude.com/docs/en/skills`
- CLI skills.sh: `https://github.com/vercel-labs/skills`

---

**Módulo anterior**: `02-menu-principal.md`
**Módulos relacionados**: `07-module-analyze.md`, `08-module-install.md`, `12-module-create-skill.md`
