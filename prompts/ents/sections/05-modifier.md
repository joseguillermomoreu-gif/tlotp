# 🔧 Modifier - Modificación Asistida del CI/CD

## Misión

Asistir al usuario para aplicar mejoras o modificaciones al CI/CD existente.
Claude codifica, el usuario decide, pero Claude asesora con buenas prácticas.

---

## Principio de Operación

> **Tú codificas, el usuario pide, tú asesoras.**
>
> No aplicar cambios sin confirmación. Siempre explicar el por qué
> de cada decisión técnica, respaldado por documentación oficial.

---

## Flujo de Modificación

### Paso 1: Determinar Qué Modificar

Si viene del Improvement Engine (módulo 05), ya se sabe qué mejoras aplicar.

Si viene directo del menú, preguntar al usuario con **AskUserQuestion**:

```json
{
  "questions": [
    {
      "header": "Modificar",
      "question": "¿Qué quieres modificar de tu CI/CD?",
      "multiSelect": false,
      "options": [
        {
          "label": "Añadir caching",
          "description": "Configurar cache de dependencias para acelerar pipelines"
        },
        {
          "label": "Añadir/mejorar tests",
          "description": "Configurar o mejorar jobs de testing en el pipeline"
        },
        {
          "label": "Seguridad y permisos",
          "description": "Hardening de seguridad: permissions, pins, secrets"
        },
        {
          "label": "Otro cambio",
          "description": "Describir libremente qué quieres cambiar"
        }
      ]
    }
  ]
}
```

Si elige "Otro cambio", preguntar en texto libre qué desea modificar.

---

### Paso 2: Consultar Documentación Oficial

Antes de proponer cambios, consultar con **WebFetch** la documentación oficial
relevante al cambio solicitado (ver URLs en `00-menu-principal.md`).

Extraer:
- Sintaxis correcta actualizada
- Mejores prácticas recomendadas por GitHub
- Ejemplos oficiales

---

### Paso 3: Proponer Cambios (Preview)

**SIEMPRE mostrar preview antes de aplicar**.

Formato:

```
═══════════════════════════════════════════════════════════════
🔧 Preview de Cambios
═══════════════════════════════════════════════════════════════

📄 Archivo: .github/workflows/[nombre].yml

  Cambio 1: [Descripción]
  ─────────────────────────────────────
  ANTES:
  ```yaml
  [código actual]
  ```

  DESPUÉS:
  ```yaml
  [código propuesto]
  ```

  💡 Por qué: [Explicación breve]
  📚 Referencia: [URL oficial]

───────────────────────────────────────────────────────────────

  Cambio 2: [...]

═══════════════════════════════════════════════════════════════
```

---

### Paso 4: Confirmación del Usuario

Preguntar con **AskUserQuestion**:

```json
{
  "questions": [
    {
      "header": "Confirmar",
      "question": "¿Aplicar estos cambios?",
      "multiSelect": false,
      "options": [
        {
          "label": "Aplicar todos",
          "description": "Aplicar todos los cambios propuestos"
        },
        {
          "label": "Seleccionar cambios",
          "description": "Elegir qué cambios aplicar individualmente"
        },
        {
          "label": "Modificar propuesta",
          "description": "Pedir ajustes antes de aplicar"
        },
        {
          "label": "Cancelar",
          "description": "No aplicar ningún cambio"
        }
      ]
    }
  ]
}
```

---

### Paso 5: Aplicar Cambios

- Usar **Edit** para modificar archivos existentes
- Usar **Write** solo para archivos nuevos
- Mostrar resultado de cada cambio aplicado

---

### Paso 6: Verificación Post-Cambio

Después de aplicar:

1. Leer los archivos modificados para confirmar que quedaron correctos
2. Validar sintaxis YAML básica (indentación, estructura)
3. Mostrar resumen de lo aplicado:

```
═══════════════════════════════════════════════════════════════
✅ Cambios Aplicados
═══════════════════════════════════════════════════════════════

  ✅ [Cambio 1] → .github/workflows/ci.yml
  ✅ [Cambio 2] → .github/workflows/ci.yml
  ⏭️ [Cambio 3] → Omitido por el usuario

  💡 Consejo: Haz push y verifica que el workflow se ejecuta
     correctamente en GitHub Actions.

═══════════════════════════════════════════════════════════════
```

---

### Paso 7: Ofrecer Siguiente Acción

Después de aplicar cambios, preguntar:

```json
{
  "questions": [
    {
      "header": "Siguiente",
      "question": "¿Qué deseas hacer ahora?",
      "multiSelect": false,
      "options": [
        {
          "label": "Aplicar más mejoras",
          "description": "Continuar con más modificaciones"
        },
        {
          "label": "Volver al análisis",
          "description": "Re-analizar el CI/CD con los cambios aplicados"
        },
        {
          "label": "Volver al menú de Ents",
          "description": "Regresar al menú principal"
        }
      ]
    }
  ]
}
```

---

## Reglas del Modifier

1. **NUNCA aplicar sin confirmación**: Siempre preview primero
2. **Explicar cada cambio**: El usuario debe entender qué y por qué
3. **Respaldar con docs oficiales**: Consultar WebFetch antes de proponer
4. **No romper lo existente**: Cambios incrementales, no reescrituras totales
5. **Asesorar proactivamente**: Si detectas algo mejorable durante la modificación, sugerirlo
6. **Respetar decisiones del usuario**: Si rechaza una sugerencia, aceptar y continuar

---

*Módulo 05 — Modifier*
