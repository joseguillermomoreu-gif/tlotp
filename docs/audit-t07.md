# T07 — Auditoría de ficheros .md > 250 líneas

**Fecha**: 2026-03-18
**Umbral**: 250 líneas
**Auditor**: ux-lore-fellowship (refactoring-specialist)

---

## Candidatos

### aragorn-main.md (322 líneas)

**Veredicto**: SÍ modularizable

**Motivo**: El archivo contiene cuatro áreas funcionales claramente delimitadas
por separadores `---` y títulos de sección independientes. Cada área puede vivir
en un fichero sin crear dependencias circulares porque el routing ya usa
`@prompts/aragorn/sections/XX-module-*.md` para los submódulos operativos.
Lo que permanece en `aragorn-main.md` (banner, permisos, menú paginado, routing)
puede reducirse sustancialmente extrayendo el bloque de lore de personajes.

**Secciones candidatas a extracción**:

1. **`sections/99-lore-characters.md`** (~90 líneas) — La sección "Lore al Instalar
   y Listar Agentes" (líneas 251-323) es un catálogo de datos puro: tabla de
   personajes, frases épicas y reglas de rotación. No contiene lógica de flujo.
   Es la candidata principal: todos los módulos la usan pero está embebida en el
   main. Extraerla y hacer `@import` desde cada módulo que la necesite elimina la
   duplicación de contexto cuando se carga un submódulo directamente.

2. **Alternativa**: Si el equipo prefiere mantener la tabla de personajes en el
   main (para que sea el punto único de verdad del lore), se podría extraer en
   cambio el bloque de permisos (~55 líneas, líneas 27-84) a
   `sections/00-module-permisos.md`, alineándolo con el patrón que usan Palantír
   y Ents (que tienen su propio `00-` de intro/permisos).

**Tamaño estimado post-extracción**: ~230 líneas (bajo umbral).

---

### gandalf-main.md (265 líneas)

**Veredicto**: SÍ modularizable — con matiz

**Motivo**: El archivo está justo 15 líneas por encima del umbral. Su estructura
es correcta: banner, permisos, menú paginado en 3 pantallas, routing y lore de
frases de cierre. No hay lógica de negocio aquí, solo orquestación. La extracción
no es urgente pero es viable.

**Secciones candidatas a extracción**:

1. **`sections/00-module-permisos.md`** (~55 líneas) — El bloque de permisos
   (líneas 43-98) sigue exactamente el mismo patrón visual que Aragorn. Extraerlo
   a un módulo dedicado lo alinea con el patrón arquitectónico del resto de épicas
   y deja `gandalf-main.md` en ~210 líneas.

2. **Sección de lore de frases** (~15 líneas, líneas 252-260) — El repertorio de
   frases rotatorias de Gandalf es un catálogo de datos puro. Podría ir a
   `sections/99-lore-frases.md` junto con el bloque de personajes si en el futuro
   se amplía. Por tamaño actual no justifica extracción por sí sola.

**Sección candidata principal**: el bloque de permisos. La Pantalla 3 del menú
(líneas 196-216) es anormalmente corta (solo opciones de "Volver") y podría
fusionarse con Pantalla 2 si se añade una opción futura, pero eso es una mejora
de UX, no de modularidad.

**Tamaño estimado post-extracción**: ~210 líneas (bajo umbral).

---

### bardo-main.md (255 líneas)

**Veredicto**: NO modularizable (límite marginal, beneficio insuficiente)

**Motivo**: El archivo está solo 5 líneas por encima del umbral. Contiene:
banner, introducción rápida, solicitud de permisos, menú paginado y flujo de
navegación. Todo el contenido está acoplado al entry point: la intro y los
permisos solo se muestran una vez y su lógica está entrelazada con el estado
del menú. Extraer el bloque de permisos (~35 líneas) generaría un módulo
demasiado pequeño para justificar el overhead de un @import adicional. El
beneficio en reducción de contexto es nulo porque `bardo-main.md` se carga
siempre completo como punto de entrada.

---

### tlotp-main.md (467 líneas)

**Veredicto**: SÍ modularizable — candidato de alta prioridad

**Motivo**: El archivo es el mayor del proyecto y contiene contenido claramente
separable en dos bloques que no necesitan cargarse juntos:

1. **Flujo principal activo** (líneas 1-244): Banner, detección de SO, reglas de
   ejecución, lore e intro, y el menú paginado de 3 pantallas con su routing.
   Este bloque es el núcleo operativo — se ejecuta siempre.

2. **Contenido estático de referencia** (líneas 248-467): Las secciones
   "Documentación y Ayuda", "Sobre TLOTP" y "Estado del Proyecto". Son secciones
   de consulta on-demand que representan ~220 líneas. Solo se muestran si el
   usuario las solicita explícitamente, y actualmente una ("Sobre TLOTP") ni
   siquiera es accesible desde el menú principal.

**Sección candidata a extraer**:

- **`sections/doc-ayuda.md`** (~140 líneas, líneas 248-388) — La sección
  "Documentación y Ayuda" con su bloque de texto y su AskUserQuestion de routing.
  Se carga on-demand cuando el usuario lo solicita.

- **`sections/sobre-tlotp.md`** (~40 líneas, líneas 391-427) — La sección "Sobre
  TLOTP" ya está marcada como "no accesible desde el menú principal actual". Es
  candidata natural a módulo independiente.

- **`sections/estado-proyecto.md`** (~25 líneas, líneas 431-455) — La sección de
  estado/recursos es puramente informativa.

**Tamaño estimado post-extracción del núcleo activo**: ~248 líneas (rozando
el umbral, pero el contenido restante es el que siempre se carga). Si se extraen
las tres secciones estáticas, el main queda en ~248 líneas, justamente en el
límite. La ganancia real es en coherencia: el main contiene solo orquestación,
los módulos contienen contenido.

---

### VERSION.md (377 líneas)

**Veredicto**: NO modularizable

**Motivo**: Archivo de datos puro. Contiene el historial de versiones, changelog,
componentes, roadmap y reglas de versionado semántico. No tiene lógica de flujo
separable: es un registro plano de información cronológica. Dividirlo (por ejemplo
en `changelog.md` + `roadmap.md`) no aportaría beneficio en tiempo de carga porque
es un archivo importado completo desde `tlotp-main.md` (`@prompts/VERSION.md`).
Su crecimiento es esperado y controlado (una entrada por release). No es un smell
de diseño sino un log de proyecto en crecimiento natural.

---

### ar7-team-builder.md (394 líneas)

**Veredicto**: NO modularizable

**Motivo**: Este archivo es un módulo operativo legacy (anterior al redesign de
Aragorn v3.22.0). Su contenido ya fue migrado a
`prompts/aragorn/sections/03-module-team-builder.md`. El archivo `ar7-team-builder.md`
existe en `prompts/aragorn/` como referencia legacy pero ya no está referenciado
en el routing activo de `aragorn-main.md` (que apunta a `sections/03-module-team-builder.md`).

Dividirlo sería un antipatrón: es un módulo de implementación completo donde cada
opción (A, B, C, D, E) depende del estado acumulado del paso anterior. Extraer
las opciones en sub-módulos generaría dependencias de estado entre ficheros y
haría el flujo más complejo sin reducir el tamaño del contexto cargado (todas las
opciones deben estar disponibles cuando el módulo se activa). La acción correcta
es archivar o eliminar este legacy, no fragmentarlo.

---

## Resumen

| Archivo | Líneas | Veredicto | Prioridad | Acción recomendada |
|---------|--------|-----------|-----------|-------------------|
| tlotp-main.md | 467 | SÍ | Alta | Extraer 3 secciones estáticas a `sections/` |
| ar7-team-builder.md | 394 | NO | — | Archivo legacy; evaluar eliminación |
| VERSION.md | 377 | NO | — | Datos puros; crecimiento natural esperado |
| aragorn-main.md | 322 | SÍ | T08 | Extraer lore-characters a `sections/99-lore-characters.md` |
| gandalf-main.md | 265 | SÍ | T09 | Extraer permisos a `sections/00-module-permisos.md` |
| bardo-main.md | 255 | NO | — | Marginal (+5 líneas); sin beneficio claro |

### Observaciones transversales

- **Patrón arquitectónico confirmado**: Las épicas maduras (Palantír, Ents, Bardo)
  siguen el patrón `[epica]-main.md` + `sections/NN-module.md`. Aragorn y Gandalf
  lo adoptaron correctamente en su redesign pero sus `main.md` aún contienen
  bloques de datos (lore, permisos) que podrían separarse.

- **ar7-team-builder.md**: Requiere aclaración de estado (legacy vs. activo)
  independientemente de la modularización. Si no está en el routing activo, debería
  archivarse para no confundir auditorías futuras.

- **tlotp-main.md**: Aunque es el más largo, su extracción es la de menor riesgo
  porque las secciones candidatas (doc-ayuda, sobre-tlotp, estado-proyecto) son
  contenido puramente declarativo sin lógica de estado.
