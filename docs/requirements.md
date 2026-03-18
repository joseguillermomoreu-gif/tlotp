# Requirements — TLOTP UX & Lore Improvements

**Proyecto**: The Lord of the Prompt (TLOTP)
**Aventura**: Mejoras de UX, paginación, modularización y lore
**Tipo**: Nueva feature en proyecto existente
**Fecha**: 2026-03-18

---

## Requisitos Funcionales

### RF-01 — Pre-carga de módulos [MUST]

**Tipo**: UBIQUITOUS

THE SYSTEM SHALL pre-cargar todos los módulos y páginas de menú referenciados con @imports antes de mostrar cualquier contenido al usuario, de modo que los menús y banners se rendericen completos en un único bloque de salida.

---

### RF-02 — Paginación con 3 opciones de contenido [MUST]

**Tipo**: EVENT-DRIVEN

WHEN un menú paginado tenga más de 2 opciones de contenido, THE SYSTEM SHALL mostrar 3 opciones de contenido por página (en lugar de las actuales 2), más "➕ Ver más..." como opción fija de navegación.

---

### RF-03 — Última página con navegación completa [MUST]

**Tipo**: EVENT-DRIVEN

WHEN el usuario llega a la última página de un menú paginado, THE SYSTEM SHALL ofrecer exactamente estas opciones de salida: 🔙 Volver a página 1 · 🔙 Volver al menú anterior · 🏠 Volver al menú principal de TLOTP · 🚪 Salir.

---

### RF-04 — Detección y modularización de .md extensos [SHOULD]

**Tipo**: UBIQUITOUS

THE SYSTEM SHALL detectar ficheros .md con más de 250 líneas y proponer su modularización por áreas funcionales usando @imports, siguiendo el patrón definido en ARCHITECTURE.md.

---

### RF-05 — Sistema de personajes extensible en Aragorn [SHOULD]

**Tipo**: EVENT-DRIVEN

WHEN Aragorn lista o instala agentes, THE SYSTEM SHALL ampliar el sistema de personajes con nuevas asignaciones, usando los ejemplos del lore como referencia (no como lista cerrada): ⛏️ Thorin Escudo de Roble para CI/CD · pipelines, nombres de Ents (🌳 Bárbol, 🌲 Quickbeam...) para infraestructura · deployment. El sistema debe ser extensible y nunca repetir el mismo personaje en una misma sesión — iterar entre las opciones disponibles por rol.

---

### RF-06 — Team completo con multi-agent-coordinator como lead [SHOULD]

**Tipo**: UBIQUITOUS

WHEN Gandalf proponga un Agent Team al finalizar un SDD (módulo G10), THE SYSTEM SHALL incluir todos los agentes necesarios sin minimizar artificialmente el número de miembros, y THE SYSTEM SHALL designar siempre a multi-agent-coordinator como agente principal del team. La composición se basa en la complejidad del SDD, no en reducir el tamaño del equipo.

---

## Requisitos No Funcionales

### RNF-01 — Mantenibilidad [MUST]

THE SYSTEM SHALL aplicar todas las mejoras siguiendo el patrón de modularización existente (@imports, sections/) definido en ARCHITECTURE.md. Ningún cambio debe romper la estructura modular.

### RNF-02 — Consistencia de lore [SHOULD]

THE SYSTEM SHALL mantener coherencia narrativa LOTR en todos los banners, mensajes y asignaciones de personajes. Los nuevos personajes (Thorin, Ents) deben integrarse al sistema sin contradecir el lore existente.

### RNF-03 — Performance de carga [SHOULD]

THE SYSTEM SHALL completar la pre-carga de todos los módulos antes de la primera interacción con el usuario. No debe haber carga lazy o incremental visible durante la sesión activa.
