# 🎯 Menú Principal de Palantír

**Al inicio de la ejecución**, sigue estos pasos en orden:

---

## 📋 PASO 1: Mostrar Banner de Bienvenida

**PRIMERO**: Mostrar el banner elegante de Palantír (desde 05-formato-output.md):

```markdown
═══════════════════════════════════════════════════════════

                     🔮 P A L A N T Í R

             The All-Seeing Configuration Stone
                  TLOTP {VERSION}

             Jerarquía Oficial Claude Code Memory

═══════════════════════════════════════════════════════════
```

**IMPORTANTE**: Reemplaza `{VERSION}` con la versión actual de TLOTP cargada desde `@prompts/VERSION.md` (actualmente v2.1.0)

---

## 📋 PASO 2: Pregunta Inicial

**IMPORTANTE**: **DEBES usar la herramienta `AskUserQuestion`** (NO texto plano).

Ejecuta **AskUserQuestion** con esta configuración EXACTA:

```json
{
  "questions": [
    {
      "header": "Modo de ejecución",
      "question": "¿Qué deseas hacer con Palantír?",
      "multiSelect": false,
      "options": [
        {
          "label": "Inspeccionar configuraciones",
          "description": "Ver todas las configuraciones de Claude Code (modo inspector)"
        },
        {
          "label": "Reset de configuraciones",
          "description": "Borrar configuraciones (con backup obligatorio)"
        },
        {
          "label": "Recovery desde backup",
          "description": "Restaurar configuraciones desde un backup anterior"
        },
        {
          "label": "Configurar característica",
          "description": "Añadir nueva configuración con asistente inteligente"
        },
        {
          "label": "Gestionar Hooks",
          "description": "Inspeccionar, crear o analizar hooks de automatización"
        }
      ]
    }
  ]
}
```

**NO mostrar menú de texto plano**. Usa la herramienta AskUserQuestion del CLI de Claude.

---

## 🔀 Routing según Elección

### Opción 1: Inspeccionar configuraciones

**Acción**: Ejecutar el flujo normal de Palantír (modo inspector)

Procede a ejecutar:
1. Mostrar cabecera elegante (desde 05-formato-output.md)
2. Preguntar por backup (desde 02-backup-system.md)
3. Inspeccionar jerarquía oficial (desde 03-jerarquia-oficial.md)
4. Explorar otros archivos (desde 04-exploracion-custom.md)
5. Preguntar por resumen (desde 05-formato-output.md)
6. Mostrar banner footer (desde 05-formato-output.md)

---

### Opción 2: Reset de configuraciones

**Acción**: Ejecutar sistema de reset (módulo 07-reset-system.md)

**IMPORTANTE**:
- Antes de cualquier reset, SIEMPRE hacer backup (obligatorio)
- No continuar sin backup

Procede a ejecutar:
1. Ejecutar el flujo de reset (desde 07-reset-system.md)
2. El módulo de reset se encargará de:
   - Hacer backup obligatorio
   - Preguntar nivel de reset
   - Confirmaciones según nivel
   - Ejecutar reset
   - Mostrar resultado

---

### Opción 3: Recovery desde backup

**Acción**: Ejecutar sistema de recovery (módulo 08-recovery-system.md)

Procede a ejecutar:
1. Ejecutar el flujo de recovery (desde 08-recovery-system.md)
2. El módulo de recovery se encargará de:
   - Preguntar path del backup
   - Mostrar preview del backup
   - Preguntar qué restaurar
   - Ejecutar recovery
   - Mostrar resultado

---

### Opción 4: Configurar característica

**Acción**: Ejecutar sistema de configuración asistida (módulo 10-configurator-system.md)

Procede a ejecutar:
1. Ejecutar el flujo del configurador (desde 10-configurator-system.md)
2. El módulo de configuración se encargará de:
   - Solicitar qué característica añadir
   - Consultar documentación oficial (info_claude.md)
   - Detectar si ya existe o hay conflictos
   - Resolver conflictos con propuestas iterativas
   - Determinar ubicación y formato correcto
   - Reestructurar archivo según mejores prácticas
   - Mostrar preview completo antes de aplicar
   - Usar motor de reconstrucción para aplicar cambios
   - Validar y notificar resultado

---

### Opción 5: Gestionar Hooks

**Acción**: Ejecutar sistema de hooks (módulo 11-hooks-system.md)

Procede a ejecutar:
1. Ejecutar el flujo de hooks (desde 11-hooks-system.md)
2. El módulo de hooks se encargará de:
   - Mostrar submenu (inspeccionar, crear, decidir hook vs alternativa)
   - Inspeccionar hooks en 3 niveles de settings.json
   - Analizar configuración y sugerir mejoras
   - Asistir en creación guiada de hooks
   - Ayudar a decidir si un hook es la mejor opción

---

## ⚠️ Reglas Importantes

1. **NO ejecutar múltiples modos**: Solo uno a la vez
2. **NO saltarse el menú**: Siempre preguntar primero
3. **NO asumir el modo**: Dejar que el usuario elija
4. **Backup obligatorio**: Solo en modo Reset (no en Inspector, Recovery ni Configurador)

---

*Menú principal - Punto de entrada de Palantír v1.7*
