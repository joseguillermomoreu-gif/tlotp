# 📋 Módulo G2 — Informe de Campo

## Misión

Consolidar los 5 informes Rohirrim en un único informe estructurado.
Mostrarlo al usuario para validar antes de continuar al Consejo.
El mapa del terreno, firmado por los cinco jinetes.

---

## Formato del Informe

```
╔══════════════════════════════════════════════════════════════╗
║   ⚡ INFORME DE CAMPO — Los Rohirrim han regresado           ║
╚══════════════════════════════════════════════════════════════╝

🏇 ÉOWYN DEL STACK
   Lenguajes:   [lista detectada]
   Frameworks:  [lista detectada]
   Bases de datos: [lista detectada]
   Testing:     [lista detectada]

🏇 THÉODEN DEL DOMINIO
   App:         [tipo de aplicación]
   Arquitectura: [patrón detectado]
   Módulos:     [lista de módulos/bounded contexts]

🏇 MERRY DE LA FORJA
   Frameworks test: [lista]
   Tipos de tests:  [unit/integration/e2e]
   Cobertura:   [configurada / no configurada]
   Calidad:     [linters, phpstan, etc.]

🏇 PIPPIN DE LOS ENTS
   CI/CD:       [herramienta]
   Pipelines:   [lista de workflows]
   Docker:      [sí/no]
   Cloud:       [proveedor si se detecta]

🏇 GAMLING DE LOS NEXOS
   MCPs:        [lista instalados]
   Agentes CC:  [lista instalados]
   APIs externas: [lista referenciadas]
   Auth:        [sistema detectado]

══════════════════════════════════════════════════════════════
[✅ 5/5 Rohirrim regresaron con datos]
[o ⚠️ 4/5 — Gamling no pudo mapear los nexos (sin acceso a .claude.json)]
══════════════════════════════════════════════════════════════
```

**IMPORTANTE**: El informe usa los datos reales devueltos por los agentes.
No inventar ni rellenar con ejemplos si el agente devolvió "sin datos".

---

## AskUserQuestion tras el informe

```json
{
  "questions": [{
    "header": "Informe de Campo",
    "question": "⚡ ¿El mapa del terreno está correcto, viajero?",
    "multiSelect": false,
    "options": [
      {
        "label": "✅ Sí, el terreno está bien mapeado",
        "description": "Continuar a definir el objetivo de la aventura"
      },
      {
        "label": "✏️ Hay imprecisiones — las corrijo",
        "description": "Editar secciones del informe manualmente"
      },
      {
        "label": "🔙 Volver al menú de Gandalf",
        "description": ""
      }
    ]
  }]
}
```

---

## Flujo de corrección

Si el usuario elige corregir, preguntar qué sección:

```json
{
  "questions": [{
    "header": "Corrección del mapa",
    "question": "⚡ ¿Qué sección del mapa corregimos?",
    "multiSelect": false,
    "options": [
      {
        "label": "🏇 Éowyn del Stack — lenguajes y frameworks",
        "description": ""
      },
      {
        "label": "🏇 Théoden del Dominio — arquitectura y módulos",
        "description": ""
      },
      {
        "label": "🏇 Merry de la Forja — testing y calidad",
        "description": ""
      },
      {
        "label": "🏇 Pippin de los Ents — CI/CD e infraestructura",
        "description": ""
      }
    ]
  }]
}
```

Si hay más secciones: paginar con la misma opción 4 → segunda pantalla con Gamling y Confirmar.

Tras la corrección, pedir confirmación y mostrar el informe actualizado.

---

## Guardar informe en contexto

El informe consolidado (incluyendo correcciones) se guarda como contexto interno
para los módulos G3, G5, G6, G7 y G8. Es la base de toda la especificación.

Denominar internamente como `contexto_rohirrim`.

---

## Transición

Si el usuario confirma el informe:
→ Cargar `@prompts/gandalf/sections/03-module-objective.md`

Si viene de "Solo exploración Rohirrim":
→ No continuar a G3. Volver al menú de Gandalf con AskUserQuestion.

---

**Módulo**: `02-module-field-report.md`
**Invocado desde**: `01-module-rohirrim.md`
**Requiere**: contexto de los 5 Rohirrim
