# 📚 Documentación Oficial Claude Code — Módulo Centralizado

> **IMPORTADO POR**: 03-jerarquia-oficial.md, 05-susurrar-planes.md, 06-compartir-visiones.md
> **NO contiene lógica de negocio ni routing** — solo instrucciones de fetch.
>
> **Caching de sesión**: Si en esta sesión ya se hizo WebFetch a estas URLs,
> reutilizar ese contenido directamente sin refetchear.

---

## Plantilla de Visualización (referencia interna — T03)

Cada WebFetch sigue esta estructura de display. **Nunca ejecutar un WebFetch en silencio.**

**PRE** — Mostrar ANTES de ejecutar el WebFetch:
```
🔮 Palantír consulta los Pergaminos Antiguos...
   📜 Fuente: [URL]
   🧠 Buscando: [descripción de lo que se extrae]
```

**CACHÉ** — Si el WebFetch ya fue ejecutado en esta sesión, mostrar en su lugar:
```
🔮 Pergamino [N]/6 ya conocido — reutilizando visión previa.
```

**POST** — Mostrar TRAS completar el WebFetch:
```
✅ [Título temático] — grabado en la Piedra.
```

══════════════════════════════════════════════════════

---

## Documentación Oficial (Live)

Obtener documentación actualizada en este orden:

---

**Antes de ejecutar el WebFetch 1, mostrar:**
```
🔮 *"¿Cuánto sabes sobre la naturaleza del Palantír? Solo lo que ves. Y lo que ves es apenas la superficie."* — Gandalf
   📜 Consultando los Pergaminos Antiguos (1/6)...
   🌐 Fuente: https://code.claude.com/docs/en/how-claude-code-works
   🧠 Buscando: arquitectura interna, carga de CLAUDE.md y MEMORY.md, extension points
```
*Si este WebFetch ya fue ejecutado en esta sesión:*
`🔮 Pergamino 1/6 ya conocido — reutilizando visión previa.`

> **WebFetch 1**: https://code.claude.com/docs/en/how-claude-code-works
> **Extraer**: arquitectura general, cómo se cargan CLAUDE.md y MEMORY.md, extension points

**Tras completar el WebFetch 1, mostrar:**
`✅ Arquitectura de la Piedra — grabada en la Piedra.`

---

**Antes de ejecutar el WebFetch 2, mostrar:**
```
🔮 *"Un maestro no improvisa. Conoce las reglas para saber cuándo trascenderlas."* — Elrond
   📜 Consultando los Pergaminos Antiguos (2/6)...
   🌐 Fuente: https://code.claude.com/docs/en/best-practices
   🧠 Buscando: buenas prácticas, límites de CLAUDE.md, qué incluir/excluir, estructura recomendada
```
*Si este WebFetch ya fue ejecutado en esta sesión:*
`🔮 Pergamino 2/6 ya conocido — reutilizando visión previa.`

> **WebFetch 2**: https://code.claude.com/docs/en/best-practices
> **Extraer**: criterios de buenas prácticas (límite 200 líneas CLAUDE.md, qué incluir/excluir, estructura recomendada)

**Tras completar el WebFetch 2, mostrar:**
`✅ Códice de Buenas Prácticas — grabado en la Piedra.`

---

**Antes de ejecutar el WebFetch 3, mostrar:**
```
🔮 *"Lo que la mente de un Elfo ha visto no perece con los años. Toda memoria tiene su lugar."* — Galadriel
   📜 Consultando los Pergaminos Antiguos (3/6)...
   🌐 Fuente: https://code.claude.com/docs/en/memory
   🧠 Buscando: tipos de memoria, jerarquía de precedencia, auto memory, rules con paths, sistema de @imports
```
*Si este WebFetch ya fue ejecutado en esta sesión:*
`🔮 Pergamino 3/6 ya conocido — reutilizando visión previa.`

> **WebFetch 3**: https://code.claude.com/docs/en/memory
> **Extraer**: tabla completa de tipos de memoria, jerarquía de precedencia, estructura de auto memory, sistema de rules con paths, sistema de @imports

**Tras completar el WebFetch 3, mostrar:**
`✅ Crónicas de la Memoria — grabadas en la Piedra.`

---

**Antes de ejecutar el WebFetch 4, mostrar:**
```
🔮 *"Quien domina los mecanismos internos, domina el comportamiento de la Piedra."* — Saruman
   📜 Consultando los Pergaminos Antiguos (4/6)...
   🌐 Fuente: https://code.claude.com/docs/en/settings
   🧠 Buscando: jerarquía de settings, ubicaciones de ficheros, permisos disponibles
```
*Si este WebFetch ya fue ejecutado en esta sesión:*
`🔮 Pergamino 4/6 ya conocido — reutilizando visión previa.`

> **WebFetch 4**: https://code.claude.com/docs/en/settings
> **Extraer**: jerarquía de settings (Managed > User > Project > Local), ubicaciones de ficheros, permisos disponibles

**Tras completar el WebFetch 4, mostrar:**
`✅ Tabla de Configuraciones — grabada en la Piedra.`

---

**Antes de ejecutar el WebFetch 5, mostrar:**
```
🔮 *"Los centinelas de Gondor no duermen. Vigilan en las sombras antes y después de cada acción."* — Boromir
   📜 Consultando los Pergaminos Antiguos (5/6)...
   🌐 Fuente: https://code.claude.com/docs/en/hooks
   🧠 Buscando: eventos disponibles, schema de configuración, tipos de hooks, patrones de matcher
```
*Si este WebFetch ya fue ejecutado en esta sesión:*
`🔮 Pergamino 5/6 ya conocido — reutilizando visión previa.`

> **WebFetch 5**: https://code.claude.com/docs/en/hooks
> **Extraer**: eventos disponibles, schema de configuración, tipos de hooks, patrones de matcher

**Tras completar el WebFetch 5, mostrar:**
`✅ Tratado de los Centinelas — grabado en la Piedra.`

---

**Antes de ejecutar el WebFetch 6, mostrar:**
```
🔮 *"No toda llave abre la misma puerta. Conoce el instrumento adecuado para cada misión."* — Aragorn
   📜 Consultando los Pergaminos Antiguos (6/6)...
   🌐 Fuente: https://code.claude.com/docs/en/features-overview
   🧠 Buscando: cuándo usar cada feature, CLAUDE.md vs skills vs hooks vs subagents, costes de contexto
```
*Si este WebFetch ya fue ejecutado en esta sesión:*
`🔮 Pergamino 6/6 ya conocido — reutilizando visión previa.`

> **WebFetch 6**: https://code.claude.com/docs/en/features-overview
> **Extraer**: cuándo usar cada feature (CLAUDE.md vs skills vs hooks vs subagents), costes de contexto

**Tras completar el WebFetch 6, mostrar:**
`✅ Mapa de las Features — grabado en la Piedra.`

---

**Usar la información obtenida como fuente de verdad** para todos los análisis y operaciones del módulo que importa este fichero.
