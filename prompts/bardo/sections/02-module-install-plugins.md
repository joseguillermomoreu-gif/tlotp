# 🔌 Módulo: Conseguir un Plugin en el Mercado

## Misión

Guiar al usuario para buscar e instalar plugins desde el marketplace oficial de Claude Code,
con verificación post-instalación.

---

## Paso 0 — Documentación oficial (on-the-fly)

**IMPORTANTE**: Comprobar primero si la documentación ya está en el contexto de esta sesión.

**Si ya está en contexto**: usar directamente sin re-fetchear.

**Si no está en contexto**, hacer WebFetch:

> **WebFetch 1**: `https://code.claude.com/docs/en/plugins`
> **Extraer**: estructura de plugins, cómo instalarlos, campos de configuración, tipos.

> **WebFetch 2**: `https://code.claude.com/docs/en/discover-plugins`
> **Extraer**: catálogo de plugins disponibles, nombres, descripciones, compatibilidad.

> **WebFetch 3**: `https://code.claude.com/docs/en/plugin-marketplaces`
> **Extraer**: marketplaces oficiales, URLs de instalación, comandos de instalación.

**Fallback si WebFetch falla**: Continuar con conocimiento interno marcando con ⚠️.

---

## Paso 1 — Mostrar plugins ya instalados

```bash
{
  cat .claude/settings.json 2>/dev/null || echo "{}"
  cat ~/.claude/settings.json 2>/dev/null || echo "{}"
} 2>/dev/null
```

Mostrar resumen compacto:
```
🔌 Plugins ya instalados:
  • git-lens
  • [otros si los hay]

Esta será la referencia para detectar duplicados.
```

Si no hay ninguno: `"Tu carcaj de plugins está vacío 🏹 — esta será tu primera flecha."`

---

## Paso 2 — Obtener plugin a instalar

Dos vías de llegada:

### Desde recomendaciones del análisis (00-module-analyze.md)
Usar la lista pre-cargada directamente. Mostrar:
```
🏹 Bardo tiene una flecha preparada para ti:
   Plugin recomendado: [nombre] — [descripción]
```

### Llegada directa (sin lista previa)
Preguntar con AskUserQuestion:

```json
{
  "questions": [{
    "header": "Buscar plugin",
    "question": "🔌 ¿Qué tipo de plugin buscas?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔍 Ver el catálogo completo de plugins",
        "description": "Bardo consultará el marketplace oficial"
      },
      {
        "label": "✍️ Escribir el nombre del plugin que quiero",
        "description": ""
      },
      {
        "label": "💡 Ver recomendados para mi stack",
        "description": "Bardo analiza tu proyecto y sugiere"
      },
      {
        "label": "🔙 Volver al menú principal",
        "description": ""
      }
    ]
  }]
}
```

---

## Paso 3 — Mostrar catálogo / resultados

Usando la información obtenida via WebFetch del marketplace oficial, mostrar plugins
disponibles. Marcar con ✅ los ya instalados:

```
══════════════════════════════════════════════════════════════
🔌 Plugins disponibles
══════════════════════════════════════════════════════════════

  1. [nombre-plugin]
     📝 [descripción oficial]
     🏷️  [categoría]
     ✅ YA INSTALADO (si aplica)

  2. [nombre-plugin]
     📝 [descripción oficial]
     🏷️  [categoría]

  ...

══════════════════════════════════════════════════════════════
```

---

## Paso 4 — Seleccionar plugin e instalar

**Si el plugin ya está instalado**: avisar y preguntar si reinstalar o elegir otro.

**Si no está instalado**: confirmar con AskUserQuestion antes de instalar:

```json
{
  "questions": [{
    "header": "Instalar plugin",
    "question": "¿Confirmas la instalación de \"[nombre]\"?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Sí, instalar",
        "description": "[descripción del plugin]"
      },
      {
        "label": "🔍 Elegir otro",
        "description": "Volver al catálogo"
      },
      {
        "label": "🚫 Cancelar",
        "description": ""
      }
    ]
  }]
}
```

**Ejecutar instalación** según el método indicado en las docs oficiales (obtenido via WebFetch).
Mostrar progreso:
```
🔌 Instalando "[nombre]"...
   ✓ Descargando desde el marketplace oficial
   ✓ Configurando plugin
```

---

## Paso 5 — Verificación post-instalación

Comprobar que el plugin quedó correctamente registrado:

```bash
{
  cat .claude/settings.json 2>/dev/null || echo "{}"
  cat ~/.claude/settings.json 2>/dev/null || echo "{}"
} 2>/dev/null
```

```
══════════════════════════════════════════════════════════════
✅ Plugin instalado correctamente
══════════════════════════════════════════════════════════════

  Nombre:      [nombre]
  Descripción: [descripción]
  Estado:      ✅ Activo

══════════════════════════════════════════════════════════════
```

---

## Paso 6 — Lore épico al finalizar

```
🏹 "Una flecha más en el carcaj de Lake-town.

    [nombre] ha sido añadido a tu arsenal.
    Smaug no lo verá venir, viajero."
```

---

## Paso 7 — Acciones posteriores

```json
{
  "questions": [{
    "header": "Plugin instalado",
    "question": "🏹 ¿Qué deseas hacer ahora?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔌 Instalar otro plugin",
        "description": ""
      },
      {
        "label": "🔗 Buscar un MCP",
        "description": ""
      },
      {
        "label": "🔙 Volver al menú principal",
        "description": ""
      }
    ]
  }]
}
```

---

## Manejo de errores

### Plugin no encontrado
```
❌ No se encontró "[nombre]" en el marketplace oficial.

   Sugerencias:
   • Verifica el nombre exacto
   • Consulta el catálogo completo: docs/en/discover-plugins
```

### Error de instalación
```
⚠️ No se pudo instalar el plugin.
   Verifica los permisos y tu conexión a internet.
```

---

## 🔗 Fuentes

Ver índice completo en `@prompts/docs-sources.md`:
- Plugins: `https://code.claude.com/docs/en/plugins`
- Discover plugins: `https://code.claude.com/docs/en/discover-plugins`
- Plugin marketplaces: `https://code.claude.com/docs/en/plugin-marketplaces`

---

**Módulo**: `02-module-install-plugins.md`
**Invocado desde**: `bardo-main.md` (opción "Conseguir un plugin en el mercado")
**Requiere**: WebFetch on-demand, Read, Bash, Write/Edit
