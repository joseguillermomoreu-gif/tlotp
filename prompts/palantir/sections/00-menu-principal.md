# 🎯 Menú Principal de Palantír

**Al inicio de la ejecución**, antes de hacer cualquier otra cosa, debes preguntar al usuario qué quiere hacer.

---

## 📋 Pregunta Inicial

Usa `AskUserQuestion` con esta configuración:

```
header: "Modo de ejecución"
question: "¿Qué deseas hacer con Palantír?"
multiSelect: false
options:
  1. label: "Inspeccionar configuraciones"
     description: "Ver todas las configuraciones de Claude Code (modo inspector)"

  2. label: "Reset de configuraciones"
     description: "Borrar configuraciones (con backup obligatorio)"

  3. label: "Recovery desde backup"
     description: "Restaurar configuraciones desde un backup anterior"
```

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

## ⚠️ Reglas Importantes

1. **NO ejecutar múltiples modos**: Solo uno a la vez
2. **NO saltarse el menú**: Siempre preguntar primero
3. **NO asumir el modo**: Dejar que el usuario elija
4. **Backup obligatorio**: Solo en modo Reset (no en Inspector ni Recovery)

---

*Menú principal - Punto de entrada de Palantír v1.4*
