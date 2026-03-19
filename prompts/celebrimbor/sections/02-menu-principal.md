# ⚒️ Menú Principal — Celebrimbor

## Misión

Gestionar el entry point de Celebrimbor: pedir permisos, mostrar el menú y enrutar al módulo correspondiente.

**NOTA**: En todos los banners, reemplaza `{VERSION}` con la versión TLOTP cargada desde `@prompts/VERSION.md`.

---

## Banner de Bienvenida (MOSTRAR SOLO UNA VEZ)

```
══════════════════════════════════════════════════════════════
    ⚒️  CELEBRIMBOR — La Forja de Eregion
══════════════════════════════════════════════════════════════

    "Los Gwaith-i-Mírdain no forjan por encargo.
     Forjan por trato. ¿Qué ofreces a cambio, viajero?"

    Has llegado a Ost-in-Edhil. Celebrimbor te escucha.

    TLOTP {VERSION} | Backend: npx skills ⚡

══════════════════════════════════════════════════════════════
```

**Después del banner**: Ejecutar detector de entorno (módulo `01-detector-entorno.md`).
- ✅ Node.js >=18 detectado → continuar a permisos
- ❌ Node.js no disponible o versión inferior → mostrar error y opciones de instalación

---

## 📋 Solicitud de Permisos

**CRÍTICO**: Antes del menú, solicitar aprobación con `AskUserQuestion`:

```json
{
  "questions": [{
    "header": "Celebrimbor · Permisos",
    "question": "⚒️ Celebrimbor necesita los siguientes permisos:\n\n  🖥️ Bash — npx skills (check/find/add/update/remove/list)\n  📖 Read — ~/.claude/skills/ · .claude/skills/ · CLAUDE.md · rules/\n  🔍 Glob — Buscar archivos SKILL.md en rutas globales y locales\n  📝 Write — Instalar y crear skills\n  ✏️ Edit — Mejorar y actualizar skills existentes\n  🌐 WebFetch — Documentación oficial on-demand\n\n¿Apruebas los permisos de la Forja?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Aprobar todos",
        "description": "Celebrimbor trabajará sin interrupciones durante toda la sesión"
      },
      {
        "label": "🚫 Cancelar",
        "description": "Salir de Eregion"
      }
    ]
  }]
}
```

- **Aprobar todos**: Registrar permisos. Continuar al menú.
- **Cancelar**: Mostrar despedida épica y terminar.

> 💡 **Nota**: Claude Code puede mostrar confirmaciones de herramientas propias (Bash, Read, Write...)
> durante la sesión. Son del sistema — responde **Sí** a todas para que Celebrimbor funcione sin interrupciones.

---

## Verificación de Updates (ANTES DEL MENÚ)

Ejecutar silenciosamente:
```bash
npx skills check
```

Guardar resultado. Si hay updates disponibles, mostrarlo en el menú como aviso:
```
⚠️  Hay skills con actualizaciones disponibles → Opción 3
```

---

## 🗡️ Menú Principal (PAGINADO)

**CRÍTICO**: Usar **AskUserQuestion** (límite 4 opciones). El menú se divide en 2 pantallas.
Patrón: 3 opciones de contenido + "➕ Ver más..." (pantalla intermedia) · última pantalla: 3 opciones de contenido + "🔙 Volver a página 1".

Mostrar aviso de updates si procede:
```
⚠️  Hay skills con actualizaciones disponibles → Opción de actualizar
```

**Pantalla 1** (mostrar primero):

```json
{
  "questions": [{
    "header": "La Forja de Eregion (1/2)",
    "question": "¿Cuál es tu trato, viajero?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔍 Examinar las forjas de Eregion — Analizar y mejorar",
        "description": ""
      },
      {
        "label": "📦 Explorar el mercado de Ost-in-Edhil — Buscar e instalar",
        "description": ""
      },
      {
        "label": "🔄 Reafilar las hojas en la fragua — Actualizar skills",
        "description": ""
      },
      {
        "label": "➕ Ver más...",
        "description": ""
      }
    ]
  }]
}
```

**Si elige "➕ Ver más..."**, mostrar **Pantalla 2**:

```json
{
  "questions": [{
    "header": "La Forja de Eregion (2/2)",
    "question": "¿Cuál es tu trato, viajero?",
    "multiSelect": false,
    "options": [
      {
        "label": "✨ Forjar desde cero — Crear nueva skill asistida",
        "description": ""
      },
      {
        "label": "⚔️ Revisar el inventario de la Forja — Listar y eliminar",
        "description": ""
      },
      {
        "label": "📜 Consultar los pergaminos de Eregion — Guía y documentación",
        "description": ""
      },
      {
        "label": "🔙 Volver a página 1",
        "description": ""
      }
    ]
  }]
}
```

**Loop continuo**: al terminar cada módulo, volver a este menú (sin repetir banner ni permisos).

---

## Flujo de Navegación

### "🔍 Examinar las forjas de Eregion — Analizar y mejorar"
- Cargar módulo: `sections/07-module-analyze.md`
- Inspeccionar skills instaladas en rutas oficiales
- Comparar con doc oficial (WebFetch on-demand si no está en contexto)
- Mostrar resumen con sugerencias

### "📦 Explorar el mercado de Ost-in-Edhil — Buscar e instalar"
- Cargar módulo: `sections/07-module-search.md` → continúa en `sections/08-module-install.md`
- Buscar en skills.sh con `npx skills find <query>`
- Instalar en estructura `<name>/SKILL.md`
- Mostrar mensaje de lore épico al finalizar

### "🔄 Reafilar las hojas en la fragua — Actualizar skills"
- Cargar módulo: `sections/11-module-update.md`
- Mostrar skills con updates disponibles
- Confirmar y ejecutar `npx skills update`

### "✨ Forjar desde cero — Crear nueva skill asistida"
- Cargar módulo: `sections/12-module-create-skill.md`
- WebFetch on-demand a la documentación oficial de skills
- Guiar al usuario paso a paso (nombre, tipo, description, invocación, contenido)
- Mostrar lore épico al finalizar

### "📜 Consultar los pergaminos de Eregion — Guía y documentación"
- Cargar módulo: `sections/13-module-docs.md`
- Preguntar nivel de detalle (completo / 5 min / 2 min)
- WebFetch on-the-fly si las docs no están en contexto: `skills` + `vercel-labs/skills`
- Generar resumen con intro y cierre épico

### "⚔️ Revisar el inventario de la Forja — Listar y eliminar"
- Mostrar sub-menú (AskUserQuestion):
  - `📋 Ver el inventario completo — Listar skills instaladas` → `sections/09-module-list.md`
  - `🗑️ Retirar una pieza de la Forja — Eliminar skill` → `sections/10-module-remove.md`
  - `🔙 Volver al menú principal`

### "🔙 Volver a página 1"
- Mostrar de nuevo la Pantalla 1 del menú principal

---

## Reglas de Ejecución

1. **Banner y permisos**: solo al entrar, nunca en el loop del menú
2. **AskUserQuestion**: para navegación elegante en todo momento
3. **Loop continuo**: hasta que el usuario elija Salir
4. **WebFetch on-demand**: nunca precargar docs oficiales

---

**Módulo anterior**: `01-detector-entorno.md`
**Módulos destino**: `07`, `08`, `11`, `14` (y nuevo módulo #214)
