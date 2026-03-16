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

```
⚒️ Celebrimbor necesita los siguientes permisos

  🖥️  Bash     — Ejecutar npx skills, node, ls, mkdir, rm...

  📖  Read     — Leer skills instaladas
                  (~/.claude/skills/, .claude/skills/)

  📝  Write    — Instalar y crear skills
                  (~/.claude/skills/, .claude/skills/)

  ✏️  Edit     — Actualizar skills existentes

  🌐  WebFetch — Consultar skills.sh y documentación oficial
                  on-demand (nunca precargada)

¿Apruebas los permisos de la Forja?
```

**Opciones** (AskUserQuestion):
1. **✅ Aprobar todos** — Celebrimbor funcionará sin interrupciones
2. **🚫 Cancelar** — Salir de Eregion

- **Aprobar todos**: Registrar permisos. Continuar al menú.
- **Cancelar**: Mostrar despedida épica y terminar.

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

**CRÍTICO**: Usar **AskUserQuestion** (límite 4 opciones). El menú se divide en 4 pantallas.
Patrón fijo: 2 opciones de contenido + "➕ Ver más..." + "🚪 Salir de Eregion" (última página: "🔙 Volver al inicio" en lugar de "➕ Ver más...").

Mostrar aviso de updates si procede:
```
⚠️  Hay skills con actualizaciones disponibles → Opción de actualizar
```

**Pantalla 1** (mostrar primero):

```json
{
  "questions": [{
    "header": "La Forja de Eregion (1/4)",
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
        "label": "➕ Ver más...",
        "description": ""
      },
      {
        "label": "🚪 Salir de Eregion",
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
    "header": "La Forja de Eregion (2/4)",
    "question": "¿Cuál es tu trato, viajero?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔄 Reafilar las hojas en la fragua — Actualizar skills",
        "description": ""
      },
      {
        "label": "✨ Forjar desde cero — Crear nueva skill asistida",
        "description": ""
      },
      {
        "label": "➕ Ver más...",
        "description": ""
      },
      {
        "label": "🚪 Salir de Eregion",
        "description": ""
      }
    ]
  }]
}
```

**Si elige "➕ Ver más..."**, mostrar **Pantalla 3**:

```json
{
  "questions": [{
    "header": "La Forja de Eregion (3/4)",
    "question": "¿Cuál es tu trato, viajero?",
    "multiSelect": false,
    "options": [
      {
        "label": "⚔️ Revisar el inventario de la Forja — Listar y eliminar",
        "description": ""
      },
      {
        "label": "📜 Consultar los pergaminos de Eregion — Guía y documentación",
        "description": ""
      },
      {
        "label": "➕ Ver más...",
        "description": ""
      },
      {
        "label": "🚪 Salir de Eregion",
        "description": ""
      }
    ]
  }]
}
```

**Si elige "➕ Ver más..."**, mostrar **Pantalla 4**:

```json
{
  "questions": [{
    "header": "La Forja de Eregion (4/4)",
    "question": "¿Cuál es tu trato, viajero?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔙 Abandonar Eregion — Volver a La Comunidad del Código",
        "description": ""
      },
      {
        "label": "🔙 Volver al inicio",
        "description": ""
      },
      {
        "label": "🚪 Salir de Eregion",
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

### "🔙 Abandonar Eregion — Volver a La Comunidad del Código"
- Finalizar el loop de Celebrimbor
- Mostrar despedida breve:
```
Los Gwaith-i-Mírdain guardan el fuego hasta tu regreso, viajero.
```
- Cargar `@prompts/tlotp-main.md` para retomar el menú principal de TLOTP

### "🚪 Salir de Eregion"
```
Los Gwaith-i-Mírdain guardan el fuego hasta tu regreso.
Que tus skills sirvan bien en la Tierra Media, viajero.

⚒️  Eregion cierra sus puertas. Por ahora.
```

---

## Reglas de Ejecución

1. **Banner y permisos**: solo al entrar, nunca en el loop del menú
2. **AskUserQuestion**: para navegación elegante en todo momento
3. **Loop continuo**: hasta que el usuario elija Salir
4. **WebFetch on-demand**: nunca precargar docs oficiales

---

**Módulo anterior**: `01-detector-entorno.md`
**Módulos destino**: `07`, `08`, `11`, `14` (y nuevo módulo #214)
