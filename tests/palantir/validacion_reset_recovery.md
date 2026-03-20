# 🧪 Validación Reset y Recovery - Palantir v1.4

**Fecha inicio**: 2026-02-13
**Branch**: feature/palantir-reset-system
**Issue**: #38

---

## 📋 Funcionalidades a Validar

### Menú Principal
- [ ] Muestra las 3 opciones correctamente
- [ ] Routing funciona a cada módulo

### Reset Completo
- [ ] Backup obligatorio se crea
- [ ] Muestra documentación oficial por fichero
- [ ] Muestra resumen del contenido del backup
- [ ] Pregunta antes de borrar
- [ ] Vacía/borra según tipo de fichero
- [ ] Respeta Managed Policy

### Reset Selectivo
- [ ] Analiza fichero completo
- [ ] Identifica reglas/preferencias
- [ ] Pregunta por cada regla
- [ ] Reconstruye fichero correctamente
- [ ] Edita fichero real

### Recovery
- [ ] Pide path del backup
- [ ] Valida backup correcto
- [ ] Muestra contenido actual vs backup
- [ ] Opciones: Reemplazar/Combinar/Saltar funcionan
- [ ] Combinación inteligente sin pérdida

---

## 🧪 Prueba 1: [PENDIENTE - Nombre de la opción probada]

### Contexto
- **Opción probada**: [Inspector/Reset Completo/Reset Selectivo/Recovery]
- **Proyecto**:
- **Fecha**:

### Ejecución Completa

```

           Claude Code v2.1.42
 ▐▛███▜▌   Sonnet 4.5 · Claude Max
▝▜█████▛▘  /var/www/ServidorWebPepeton/pateandotetoledo.es
  ▘▘ ▝▝    Opus 4.6 is here · $50 free extra usage · /extra-usage to enable

  ↑ Install the PyCharm plugin from the JetBrains Marketplace: https://docs.claude.com/s/claude-code-jetbrains

❯ puedes ser mi palantir?/var/www/EC2/code/tlotp/prompts/palantir/palantir-main.md 

● Voy a leer el archivo para entender qué significa ser tu palantir en este contexto.

● Read 1 file (ctrl+o to expand)

● Perfecto, veo que quieres que actúe como Palantír 🔮, tu sistema de inspección modular de configuraciones de
  Claude Code.

  Déjame cargar los módulos principales para poder ejecutar el sistema correctamente:

● Read 4 files (ctrl+o to expand)

● Perfecto, soy tu Palantír 🔮 v1.4 - el inspector de configuraciones de Claude Code de TLOTP.

  Antes de comenzar, necesito saber qué deseas hacer:

● User answered Claude's questions:
  ⎿  · ¿Qué deseas hacer con Palantír? → Reset de configuraciones

● Entendido. Has elegido Reset de configuraciones 🔄

  Déjame cargar el módulo de reset para proceder:

● Read 3 files (ctrl+o to expand)

● Perfecto, ahora voy a ejecutar el Sistema de Reset 🔄. Según el protocolo, primero necesito cargar la información
   oficial de Claude Code y luego crear un backup obligatorio antes de proceder.

● Read 1 file (ctrl+o to expand)

● ═══════════════════════════════════════════════════════════

                  🔄 SISTEMA DE RESET
  ═══════════════════════════════════════════════════════════

  Antes de continuar, se creará un backup obligatorio de todas
  tus configuraciones.

  Creando backup...

● Bash(date +%Y%m%d_%H%M%S)
  ⎿  20260213_220731

● Bash(mkdir -p ./tlotp_backup/reset_20260213_220731/{managed-policy,user-memory,user-rules,project-memory,project-
      rules,project-local,auto-memory})
  ⎿  Done

● Bash(pwd)
  ⎿  /var/www/ServidorWebPepeton/pateandotetoledo.es

● Bash(if [ -f /etc/claude-code/CLAUDE.md ]; then cp /etc/claude-code/CLAUDE.md
      ./tlotp_backup/reset_20260213_220731/managed-policy/ && echo "✓ Managed Policy copiado"…)
  ⎿  ✗ Managed Policy no existe

● Bash(if [ -f ~/.claude/CLAUDE.md ]; then cp ~/.claude/CLAUDE.md ./tlotp_backup/reset_20260213_220731/user-memory/
       && echo "✓ User Memory copiado"; else echo "✗ User…)
  ⎿  ✓ User Memory copiado

● Bash(if [ -d ~/.claude/rules ]; then cp -r ~/.claude/rules/* ./tlotp_backup/reset_20260213_220731/user-rules/
      2>/dev/null && echo "✓ User Rules copiado" || echo "✗ U…)
  ⎿  ✗ User Rules no existe

● Bash(if [ -f ./CLAUDE.md ]; then cp ./CLAUDE.md ./tlotp_backup/reset_20260213_220731/project-memory/CLAUDE.md &&
      echo "✓ Project Memory (./CLAUDE.md) copiado"; else…)
  ⎿  ✓ Project Memory (./CLAUDE.md) copiado

● Bash(if [ -f ./.claude/CLAUDE.md ]; then cp ./.claude/CLAUDE.md
      ./tlotp_backup/reset_20260213_220731/project-memory/CLAUDE_claude.md && echo "✓ Project Memory (./.cl…)
  ⎿  ✗ Project Memory (./.claude/CLAUDE.md) no existe

● Bash(if [ -d ./.claude/rules ]; then cp -r ./.claude/rules/* ./tlotp_backup/reset_20260213_220731/project-rules/
      2>/dev/null && echo "✓ Project Rules copiado" || ech…)
  ⎿  ✗ Project Rules no existe

● Bash(if [ -f ./CLAUDE.local.md ]; then cp ./CLAUDE.local.md ./tlotp_backup/reset_20260213_220731/project-local/
      && echo "✓ Project Local copiado"; else echo "✗ Proje…)
  ⎿  ✗ Project Local no existe

● Bash(if [ -d ~/.claude/projects/-var-www-ServidorWebPepeton-pateandotetoledo-es/memory ]; then cp -r
      ~/.claude/projects/-var-www-ServidorWebPepeton-pateandotetoledo-…)
  ⎿  ✓ Auto Memory copiado

● Read 2 files (ctrl+o to expand)

● Bash(find ./tlotp_backup/reset_20260213_220731/auto-memory -type f -name "*.md" | while read file; do
        basename_file=$(basename "$file")…)
  ⎿  ✓ Metadata añadida a Auto Memory

● Searched for 1 pattern (ctrl+o to expand)

● Bash(du -sh ./tlotp_backup/reset_20260213_220731 | awk '{print $1}')
  ⎿  64K

● Read 1 file (ctrl+o to expand)    

● ✅ Backup creado en:  ↓                             )
  ./tlotp_backup/reset_20260213_220731/
                                                                                                                   
  📦 Total: 3 archivos (~64K)
                                                                                                                   
  Ver detalles en: BACKUP_INDEX.md                                                                               

  ═══════════════════════════════════════════════════════════

  Ahora voy a preguntarte qué tipo de reset deseas realizar:                                                       
                 
● User answered Claude's questions:                   
  ⎿  · ¿Qué tipo de reset deseas realizar? → Reset Selectivo (granular)
                                                                                                                   
● Perfecto, has elegido Reset Selectivo (granular) 🎯   
                                                                                                                   
  Vamos a revisar cada fichero regla por regla. Empecemos:                                                         
                                                                                                                   
● Read 1 file (ctrl+o to expand)                                                                                   
                                                                                                                   
● ═══════════════════════════════════════════════════════════                                                      
                                                                                                                   
  📄 Fichero: ~/.claude/CLAUDE.md                                                                                  
                                                            
  📚 Según documentación oficial de Claude Code:                                                                   
                                                                                                                   
  User Memory (Memoria Personal Global)

  Propósito: Preferencias personales que aplican a TODOS tus proyectos

  Ejemplos de uso:
  - Preferencias de estilo de código
  - Atajos de herramientas personales
  - Convenciones de naming preferidas
  - Stack tecnológico que dominas

  Compartido con: Solo tú (todos tus proyectos)

  ---
  📋 Contenido actual (análisis del backup):

  - Total líneas: 620
  - Secciones principales:
  • Perfil de Desarrollo (PHP/Symfony, Testing E2E)
  • Instrucción crítica sobre auto-carga de skills
  • Stack Tecnológico (Backend, Testing E2E, En Aprendizaje, Herramientas)
  • Preferencias de Código (Principios, Naming Conventions, Arquitectura)
  • Skills Especializados (Backend, Frontend, Testing, Quality, etc.)
  • Sistema de Auto-Carga de Skills (flujo completo)
  • Meta-Instrucciones de Auto-Mantenimiento
  • Comandos Rápidos
  • Prioridad de Configuración
  • Filosofía de Trabajo

  ═══════════════════════════════════════════════════════════

  Voy a presentarte el contenido regla por regla. Para cada regla, podrás decidir si MANTENERLA o BORRARLA.

  Empecemos con la primera regla:

  ───────────────────────────────────────────────────────────

  📌 Regla/Preferencia #1 encontrada:

  ## 🚨 INSTRUCCIÓN CRÍTICA - EJECUTAR SIEMPRE EN CADA SESIÓN

  **IMPORTANTE**: Al iniciar una sesión en CUALQUIER proyecto, DEBES ejecutar esta verificación:

  ### Verificación Automática de Skills

  ```bash
  # 1. Verificar si existe MEMORY.md en el directorio actual
  if [ -f "$(pwd)/MEMORY.md" ]; then
    # ✅ MEMORY.md existe → Cargar skills automáticamente
    # Lee la sección "Skills Activos" y carga esos skills silenciosamente
    # Notifica brevemente: "📚 Skills cargados: php-symfony, typescript"
  else
    # ❌ MEMORY.md NO existe → Ejecutar auto-detección
    # DEBES hacer esto PROACTIVAMENTE (no esperar que el usuario lo pida)
  fi

  Proceso de Auto-Detección (cuando NO hay MEMORY.md)

  Paso 1: DETECTAR automáticamente el stack del proyecto:

  # Backend Frameworks
  - composer.json + symfony/ → php-symfony.md, arquitectura-hexagonal.md, twig.md
  - composer.json + laravel/ → laravel.md
  - pyproject.toml o requirements.txt → python.md

  # Frontend
  - package.json + tsconfig.json → typescript.md
  - package.json + react → react.md

  # Testing
  - playwright.config.ts → playwright.md, pom.md
  - package.json + @cucumber/cucumber → cucumber.md

  # Tools
  - *.sh en root → bash-scripts.md
  - phpstan.neon → phpstan.md

  Paso 2: PREGUNTAR al usuario qué skills cargar:

  [... resto del proceso de auto-detección...]

  ⚠️ REGLAS IMPORTANTES:

  1. SER PROACTIVO: NO esperes que el usuario te pida la detección. Si no hay MEMORY.md, hazlo automáticamente en
  tu primer mensaje.
  2. SER BREVE: Si MEMORY.md existe, solo di: "📚 Skills cargados: [lista]" y continúa.
  3. NO PREGUNTAR si ya hay MEMORY.md. Solo carga los skills listados.
  4. SIEMPRE VERIFICAR al inicio de cada sesión nueva en un proyecto.

  ───────────────────────────────────────────────────────────

  ¿Deseas MANTENER esta regla/preferencia? (s/n):

✻ Sautéed for 2m 29s                                                                                               
   
────────────────────────────────────────────────
```

### Análisis

**✅ Funcionó bien**:
-

**❌ Problemas detectados**:
-

**💡 Mejoras sugeridas**:
-

### Ajustes Realizados

1. **Ajuste**:
   - **Archivo**:
   - **Cambio**:
   - **Razón**:

---

## 🧪 Prueba 2: [Siguiente prueba]

[Misma estructura]

---

## 📊 Resumen de Validación

### Estado General
- Total pruebas:
- Exitosas:
- Con ajustes:
- Pendientes:

### Principales Mejoras Aplicadas
1.
2.
3.

### Issues Nuevos Detectados
- [ ]
- [ ]

---

*Validación en progreso - No commitear hasta completar*
