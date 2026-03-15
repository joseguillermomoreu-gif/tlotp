# 🏗️ Arquitectura de Celebrimbor

**TLOTP**: Ver VERSION.md
**Estado**: 🔄 En rediseño (v2.0)

---

## 🎯 Visión General

Celebrimbor usa una arquitectura simple de módulos independientes sobre un único backend CLI (`npx skills`):

```
┌─────────────────────────────────────────────────────────┐
│                       USUARIO                           │
└────────────────────────┬────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────┐
│           Entry Point (celebrimbor-main.md)             │
│      Permisos → Detección entorno → Menú principal      │
└──┬─────────────┬──────────────┬──────────────┬──────────┘
   │             │              │              │
   ▼             ▼              ▼              ▼
Analizar     Buscar/         Actualizar    Crear skill
skills      Instalar         (skills.sh)   (asistida)
(07,09)    (07,08,09)          (11)         (nuevo)
   │             │              │              │
   └─────────────┴──────────────┴──────────────┘
                         │
┌────────────────────────▼────────────────────────────────┐
│              Backend CLI (04-backend-cli.md)            │
│                      npx skills                         │
└─────────────────────────────────────────────────────────┘
```

---

## 📦 Módulos

| Módulo | Responsabilidad |
|--------|----------------|
| `01-detector-entorno.md` | Detectar y validar Node.js >=18, npm, npx |
| `02-menu-principal.md` | Banner, permisos, menú de 4 opciones |
| `04-backend-cli.md` | Referencia de comandos `npx skills` |
| `07-module-search.md` | Búsqueda en skills.sh |
| `08-module-install.md` | Instalación en estructura `<name>/SKILL.md` |
| `09-module-list.md` | Listar skills instaladas (rutas oficiales) |
| `10-module-remove.md` | Eliminar skills |
| `11-module-update.md` | Actualizar skills + check pre-menú |
| `14-skills-cli-reference.md` | Referencia técnica CLI (WebFetch on-demand) |

---

## 🎨 Principios de Diseño

1. **Un solo backend**: CLI (`npx skills`) — sin abstracción de dual-backend
2. **Doc oficial on-demand**: WebFetch a `code.claude.com/docs/en/skills` cuando se necesite, nunca hardcodeada
3. **Estructura oficial**: Skills en `<name>/SKILL.md`, no archivos planos
4. **Lore épico**: Mensajes de Eregion/Gwaith-i-Mírdain al completar acciones

---

**Diseñada por**: La Fellowship del Teclado 🥔🤖
**TLOTP**: Ver VERSION.md
