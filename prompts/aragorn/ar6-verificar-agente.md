# 👑 AR6 - La Revista de las Tropas: Verificar Instalación

## Intro de ejecución

```
👑 Aragorn pasa revista a las tropas recién reclutadas...
   Un guerrero que no puede ser invocado no sirve al ejército.
```

---

## Paso 1 — Identificar agente a verificar

Si vienes de AR5 con un agente recién instalado: verificar ese agente.

Si el usuario llega directo, preguntar (AskUserQuestion):
- Qué agente quiere verificar (listar los instalados desde AR1)
- Volver al menú de Aragorn

---

## Paso 2 — Comprobar existencia del fichero

```bash
ls ~/.claude/agents/[nombre].md 2>/dev/null || ls .claude/agents/[nombre].md 2>/dev/null || echo "NOT_FOUND"
```

Si no existe:
```
❌ El agente "[nombre]" no se encontró en ningún scope.
   Verifica la instalación con la Opción 3 (Instalar agente).
```

---

## Paso 3 — Leer y validar YAML frontmatter

```bash
cat ~/.claude/agents/[nombre].md 2>/dev/null
```

Validar campo a campo:

| Campo | Validación |
|-------|-----------|
| `name` | Presente y es string no vacío |
| `description` | Presente y tiene al menos 10 caracteres |
| `tools` | Si presente, cada tool es válida (Read, Write, Bash, Grep, Glob, Edit, MultiEdit, NotebookRead, NotebookEdit, WebFetch, WebSearch, TodoRead, TodoWrite) |
| `model` | Si presente, es un modelo Claude válido |
| `permissionMode` | Si presente, es `default`, `acceptEdits` o `bypassPermissions` |
| `maxTurns` | Si presente, es número entero positivo |

---

## Paso 4 — Mostrar informe de semáforos

```
✅ REVISTA DE TROPAS: symfony-expert
══════════════════════════════════════════════════════

📍 Ubicación: ~/.claude/agents/symfony-expert.md
🌍 Scope: Global

Verificación del fichero:
  ✅ Fichero existe y es legible
  ✅ YAML frontmatter válido (delimitadores --- correctos)
  ✅ name: "symfony-expert" — presente y válido
  ✅ description: presente (142 chars) — suficiente para invocación automática
  ✅ tools: [Read, Write, Bash, Grep] — todas válidas
  ✅ model: "claude-sonnet-4-6" — válido
  ⚠️  maxTurns: no definido — usará límite por defecto (sin límite)
  ℹ️  permissionMode: no definido — usará "default"

Estado: ✅ Agente listo para ser invocado
══════════════════════════════════════════════════════
```

### Semáforos

| Símbolo | Significado |
|---------|-------------|
| ✅ | Campo presente y válido |
| ⚠️ | Campo opcional no definido, se usará valor por defecto |
| ℹ️ | Información adicional |
| ❌ | Error — campo inválido o faltante obligatorio |

---

## Paso 5 — Guía de uso post-verificación

Tras los semáforos, mostrar siempre:

```
📖 CÓMO INVOCAR symfony-expert
──────────────────────────────────────────────────────

  1. AUTOMÁTICO — Claude decide cuándo usarlo
     Claude lee la description y lo invoca si la tarea encaja.
     Ejemplo: "Analiza este UserRepository" → Claude invoca symfony-expert

  2. EXPLÍCITO — Tú decides usarlo
     "@symfony-expert [tu petición]"
     Ejemplo: "@symfony-expert revisa el bundle de pagos y detecta issues"

  3. SCOPE
     Instalado en: ~/.claude/agents/ (Global)
     Disponible en: todos tus proyectos Claude Code

  💡 Consejo: Si Claude no lo invoca automáticamente cuando esperas,
     revisa que la description sea suficientemente descriptiva sobre
     cuándo debe activarse.
```

---

## Paso 6 — Errores comunes y resolución

Si hay ❌ en algún campo:

| Error | Causa probable | Resolución |
|-------|---------------|------------|
| YAML inválido | Sintaxis incorrecta en frontmatter | Mostrar línea del error; ofrecer editar |
| Tool desconocida | Nombre de tool no existe | Mostrar lista de tools válidas |
| Model inválido | Nombre de modelo incorrecto | Sugerir `claude-sonnet-4-6` o `claude-opus-4-6` |
| name vacío | Frontmatter incompleto | Usar nombre del fichero como fallback |

---

## Paso 7 — Volver al menú

**Usar AskUserQuestion**:
- Volver al menú de Aragorn
- Listar todos los agentes (ir a AR1)
- Salir
