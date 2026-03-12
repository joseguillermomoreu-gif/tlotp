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

Con la petición del usuario y la documentación oficial, razonar en profundidad.

**Mostrar SIEMPRE** el análisis completo, independientemente de si hay mejora o no:

```
🔍 ANÁLISIS DE PALANTÍR
══════════════════════════════════════════════════════

📝 Tu petición:
   "[petición original con las palabras del usuario]"

🏷️  Tipo de configuración:
   [CLAUDE.md / rules/ con paths: / hook en settings.json /
    settings.json / MEMORY.md]

   Por qué este tipo:
   [razonamiento claro basado en las docs — qué hace este tipo,
    para qué sirve, y por qué encaja con lo que el usuario pidió]

   [Si hay un tipo alternativo más adecuado]:
   💡 Alternativa recomendada: [otro tipo]
      Por qué sería mejor: [justificación según docs]

══════════════════════════════════════════════════════
```

**Si la petición puede expresarse mejor** según las docs (formato, ubicación, redacción):

```
💡 SUGERENCIA DE PALANTÍR
══════════════════════════════════════════════════════

  Lo que pediste:  [petición original resumida]
  Propuesta:       [versión mejorada manteniendo la esencia]
  Motivo:          [por qué es mejor según docs, sin perder la intención original]

══════════════════════════════════════════════════════
```

**AskUserQuestion** (solo si hay sugerencia):

```json
{
  "questions": [{
    "header": "Análisis",
    "question": "¿Cómo deseas proceder?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Usar la propuesta de Palantír",
        "description": "Aplicar la versión mejorada manteniendo tu intención original"
      },
      {
        "label": "📝 Mantener mi petición original",
        "description": "Aplicar exactamente lo que describiste"
      },
      {
        "label": "✏️ Ajustar manualmente",
        "description": "Modificar la propuesta antes de continuar"
      }
    ]
  }]
}
```

**Si no hay sugerencia**: continuar directamente al PASO 4 sin interrumpir al usuario.

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

📍 Fichero:
   [ruta completa del fichero]

⚠️  Impacto detectado:
   [conflictos o solapamientos encontrados, o "Ninguno detectado"]

══════════════════════════════════════════════════════

🌍 DÓNDE APLICARLO — ANÁLISIS DE SCOPE
══════════════════════════════════════════════════════

  🏠 Local (.claude/) — solo afecta a este proyecto
     [consecuencias concretas: qué cambia, qué no, cuándo tiene sentido]
     Cuándo elegirlo: [casos de uso específicos]

  🌍 Global (~/.claude/) — afecta a todos tus proyectos
     [consecuencias concretas: qué cambia, qué no, cuándo tiene sentido]
     Cuándo elegirlo: [casos de uso específicos]

  ⭐ Recomendación: [cuál y por qué, basado en docs y en la naturaleza
     de la petición — si es una preferencia personal → global;
     si es específica del stack/proyecto → local]

══════════════════════════════════════════════════════
```

**AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Aplicar",
    "question": "¿Dónde aplicamos esta configuración?",
    "multiSelect": false,
    "options": [
      {
        "label": "⭐ Aplicar en scope recomendado",
        "description": "[local o global según recomendación — indicar cuál]"
      },
      {
        "label": "🔄 Aplicar en el scope alternativo",
        "description": "[el otro scope — indicar cuál con su consecuencia principal]"
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
