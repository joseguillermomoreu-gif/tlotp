# 🗣️ Susurrar Planes en la Piedra — Añadir Configuración

## PASO 1: ¿Qué deseas añadir?

Mostrar al usuario:

```
🗣️ Susurra tus planes en la Piedra...

¿Qué deseas añadir a tu configuración de Claude Code?

Puedes describir cualquier cosa:
  — una instrucción de comportamiento
  — una regla para un tipo de fichero
  — una automatización al hacer commit
  — una preferencia de modelo o idioma
  — cualquier otra configuración

Descríbelo con tus palabras:
```

Obtener input libre del usuario.

---

## PASO 2: Cargar documentación oficial

**Comprobar primero** si la documentación oficial ya está cargada en el contexto
de esta sesión (por haber ejecutado previamente "Contemplar el reino" u otro módulo
que haya hecho los WebFetch).

**Si ya está en contexto**: usar directamente esa información sin re-fetchear.

**Si no está en contexto**, obtener documentación en este orden:

> **WebFetch 1**: https://code.claude.com/docs/en/how-claude-code-works
> **Extraer**: arquitectura general, cómo se cargan los ficheros de configuración

> **WebFetch 2**: https://code.claude.com/docs/en/best-practices
> **Extraer**: criterios de buenas prácticas, qué va en cada fichero, límites

> **WebFetch 3**: https://code.claude.com/docs/en/memory
> **Extraer**: tipos de memoria, jerarquía de precedencia, rules con paths, @imports

> **WebFetch 4**: https://code.claude.com/docs/en/settings
> **Extraer**: jerarquía de settings, ubicaciones, permisos disponibles

> **WebFetch 5**: https://code.claude.com/docs/en/hooks
> **Extraer**: eventos, schema de configuración, tipos de hooks, matchers

> **WebFetch 6**: https://code.claude.com/docs/en/features-overview
> **Extraer**: cuándo usar cada feature, costes de contexto, qué va dónde

---

## PASO 3: Analizar la petición del usuario

Con la petición del usuario y la documentación oficial, razonar:

1. **¿Es correcta la petición tal como está?** — ¿Se puede aplicar directamente según las docs?
2. **¿Hay una forma más adecuada?** — ¿Debería ir en otro fichero, tener otro formato, o expresarse de otra manera?
3. **¿Qué tipo de configuración es?**:
   - Instrucción de comportamiento → `CLAUDE.md`
   - Regla modular por path → `rules/`
   - Automatización de evento → hook en `settings.json`
   - Configuración técnica (modelo, permisos) → `settings.json`
   - Memoria persistente → `MEMORY.md`

**Si la petición es correcta**: no sugerir cambios, continuar con la propuesta tal cual.

**Si se puede mejorar**: mostrar sugerencia antes de proceder:

```
💡 SUGERENCIA DE PALANTÍR
══════════════════════════════════════════════════════

Tu petición es válida, pero hay una forma más adecuada según
la documentación oficial:

  Lo que pediste:  [petición original resumida]
  Sugerencia:      [mejora propuesta]
  Motivo:          [por qué es mejor según docs]

══════════════════════════════════════════════════════
```

**AskUserQuestion**:
- ✅ Usar la sugerencia de Palantír
- 📝 Mantener mi petición original
- ✏️ Modificar (ajustar manualmente)

---

## PASO 4: Inspeccionar configuración actual (antes de aplicar)

Antes de aplicar nada, inspeccionar silenciosamente la configuración actual:

```bash
# Leer ficheros relevantes según el tipo detectado
cat ~/.claude/CLAUDE.md 2>/dev/null
cat ~/.claude/settings.json 2>/dev/null
ls ~/.claude/rules/ 2>/dev/null
cat .claude/CLAUDE.md 2>/dev/null
cat .claude/settings.json 2>/dev/null
ls .claude/rules/ 2>/dev/null
```

Analizar buscando:
- **Conflictos**: ¿Existe ya una regla que contradiga o duplique la nueva?
- **Mejor ubicación**: ¿Hay un fichero más apropiado según el contenido existente?
- **Mejor orden**: ¿Dónde encajaría mejor dentro del fichero destino?

Si la inspección provoca cambios respecto a la propuesta inicial, actualizar la propuesta.

---

## PASO 5: Mostrar propuesta final

Mostrar siempre (haya o no cambios tras la inspección):

```
📋 PROPUESTA FINAL
══════════════════════════════════════════════════════

📝 Qué se añadirá:
   [contenido exacto que se escribirá]

📍 Dónde:
   [ruta completa del fichero]

🌍 Scope: [Global (~/.claude/) / Proyecto (.claude/)]
   Recomendación: [justificación según docs oficiales]
   ¿Puedes cambiarlo? Sí — ver opciones abajo.

⚠️  Impacto detectado:
   [conflictos o solapamientos encontrados, o "Ninguno detectado"]

══════════════════════════════════════════════════════
```

**AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Aplicar",
    "question": "¿Aplicamos esta configuración?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aplicar",
        "description": "Aplicar en el scope recomendado"
      },
      {
        "label": "🔄 Cambiar scope",
        "description": "Aplicar en global en lugar de proyecto o viceversa"
      },
      {
        "label": "✏️ Modificar contenido",
        "description": "Ajustar el contenido antes de aplicar"
      },
      {
        "label": "🚫 Cancelar",
        "description": "Volver al menú principal de Palantír sin aplicar nada"
      }
    ]
  }]
}
```

---

## PASO 6: Aplicar

Aplicar el cambio en el fichero correspondiente (crear si no existe).

Confirmar con frase épica breve, por ejemplo:
- *"Los planes susurrados en la Piedra han quedado grabados para siempre."*
- *"El reino recuerda ahora tus palabras."*
- *"Palantír ha tallado tus planes en piedra."*
*(Variar según el tipo de configuración aplicada)*

Luego volver automáticamente al **menú principal de Palantír** (el que aparece tras los permisos).
