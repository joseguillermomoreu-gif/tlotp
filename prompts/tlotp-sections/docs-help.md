# 📚 Documentación y Ayuda — TLOTP

> **Sección informativa** — Mostrar cuando el usuario selecciona "Documentación y Ayuda".

---

## 📚 Contenido de "Documentación y Ayuda"

**Si el usuario selecciona "📚 Documentación y Ayuda"**, mostrar:

```
═══════════════════════════════════════════════════════════
📚 Documentación TLOTP {VERSION}
═══════════════════════════════════════════════════════════

📖 ¿Qué es TLOTP?

💍 Un prompt para dominarlos a todos.

TLOTP configura tu entorno Claude Code de forma fácil y adecuada
para hacerlo lo más autónomo posible.

✨ Cómo funciona:
• Interacción mediante preguntas asistidas
• Usa documentación oficial de Claude Code on-the-fly
• Combina con tus configuraciones actuales (no borra nada)
• Instala skills desde el repositorio oficial skills.sh
• Sin instalación: solo copy-paste del prompt

---

🗺️ Épicas Disponibles

✅ 🔮 Palantír - Gestor de Configuraciones
   • CRUD completo: Inspector, Reset, Recovery, Configurador
   • Analyzer de mejoras sugeridas (detecta conflictos y optimizaciones)
   • Backup obligatorio antes de cambios destructivos
   Estado: Completado

✅ 🏹 Bardo - Proveedor de MCPs y Plugins
   • Analizar MCPs y plugins instalados en todos los scopes
   • Detectar stack tecnológico del proyecto
   • Consultar marketplace en tiempo real (sin hardcodeo)
   • Recomendaciones con por qué, para qué y ejemplos de uso
   • Instalación guiada ítem a ítem con confirmación
   • Verificación post-instalación con semáforos
   Estado: Completado

✅ ⚒️ Celebrimbor - Gestor de Skills
   Buscar, instalar, listar, actualizar y eliminar skills
   Estado: MVP Completado

✅ 🌳 Ents - Guardianes del CI/CD
   Analizar CI/CD actual, sugerir mejoras, crear GitHub Actions
   Consulta documentación oficial en tiempo real
   Estado: MVP Completado

✅ 👑 Aragorn - Gestor de Agentes
   Buscar, instalar, eliminar y actualizar agentes desde VoltAgent + aitmpl.com
   Configurar Agent Teams para trabajo paralelo (experimental)
   Estado: Completado

✅ ⚡ Gandalf - Spec-Driven Development
   Exploradores Rohirrim · requirements.md EARS · design.md + Mermaid · tasks.md
   Consejo de Rivendel · Forja del ejército con Aragorn
   Estado: Completado

✅ ⚡ Gandalf - Spec-Driven Development (SDD interactivo completo)

---

🚀 Inicio Rápido

Menú Principal:
@prompts/tlotp-main.md

Acceso Directo:
• Palantír:    @prompts/palantir/palantir-main.md
• Bardo:       @prompts/bardo/bardo-main.md
• Celebrimbor: @prompts/celebrimbor/celebrimbor-main.md
• Ents:        @prompts/ents/ents-main.md
• Aragorn:     @prompts/aragorn/aragorn-main.md
• Gandalf:     @prompts/gandalf/gandalf-main.md

---

📂 Documentación Adicional

• README.md - Introducción y quick start
• MILESTONES.md - Roadmap y épicas
• CONTRIBUTING.md - Guía para contribuir

---

🔗 Enlaces

Repositorio: https://github.com/joseguillermomoreu-gif/tlotp
Issues: https://github.com/joseguillermomoreu-gif/tlotp/issues

═══════════════════════════════════════════════════════════
```

Tras mostrar el bloque anterior, usar **AskUserQuestion**:

```json
{
  "questions": [{
    "header": "Documentación",
    "question": "¿Qué deseas hacer?",
    "multiSelect": false,
    "options": [
      {
        "label": "🔮 Ir a Palantír",
        "description": ""
      },
      {
        "label": "⚒️ Peregrinaje a Eregion, Celebrimbor nos espera",
        "description": ""
      },
      {
        "label": "🔙 Volver al menú principal",
        "description": ""
      },
      {
        "label": "🚪 Salir",
        "description": ""
      }
    ]
  }]
}
```

**Routing**:
- 🔮 Ir a Palantír → Cargar `@prompts/palantir/palantir-main.md`
- ⚒️ Peregrinaje a Eregion, Celebrimbor nos espera → Cargar `@prompts/celebrimbor/celebrimbor-main.md`
- 🔙 Volver al menú principal → Mostrar Pantalla 1 del menú principal
- 🚪 Salir → Mostrar mensaje de despedida y terminar
