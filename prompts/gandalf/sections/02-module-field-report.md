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

## Paso de Consenso del Consejo (condicional)

**Solo si `GANDALF_CONSENSORS` tiene agentes definidos:**

Mostrar banner:

```
╔════════════════════════════════════════════════════════════╗
║  ⚡ EL CONSEJO REVISA EL INFORME DE CAMPO                  ║
╚════════════════════════════════════════════════════════════╝

  Los agentes consensuadores leen el mapa de los Rohirrim.
  Su sabiduría enriquecerá la expedición antes de continuar.

  🗡️ [nombre-agente-consensuador-1] — revisando...
  🗡️ [nombre-agente-consensuador-2] — revisando...
```

Lanzar en paralelo un Agent por cada consensuador con este prompt:

```
Eres [nombre del agente, tipo: tipo] y formas parte del Consejo de Rivendel.
Has recibido el siguiente informe de exploración del proyecto:

[contenido del informe G2]

Revisa el informe desde tu perspectiva como [tipo de agente].
¿Hay algo que los Rohirrim hayan podido pasar por alto, subestimar o que merezca mayor atención desde tu especialidad?
Devuelve un JSON:
{
  "agente": "[nombre]",
  "observaciones": ["obs1", "obs2"],  // máx 3, concretas
  "alerta": "[si hay algo crítico que el equipo debería saber, o null]"
}
```

Tras recoger las respuestas, mostrar:

```
╔════════════════════════════════════════════════════════════╗
║  ⚡ VOCES DEL CONSEJO                                      ║
╚════════════════════════════════════════════════════════════╝

  🗡️ [agente-1]: [observaciones]
  🗡️ [agente-2]: [observaciones]
  [si hay alertas]: ⚠️ ALERTA: [texto]
```

Luego continuar con el AskUserQuestion existente del informe.

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
