# 📚 Información Oficial de Claude Code Memory

> Fuente: https://code.claude.com/docs/en/memory

Esta información se usa para proporcionar contexto al usuario durante operaciones de reset/recovery.

---

## 🗂️ Tipos de Memoria de Claude Code

### 1. Managed Policy (Políticas de Organización)

**Ubicación**:
- macOS: `/Library/Application Support/ClaudeCode/CLAUDE.md`
- Linux: `/etc/claude-code/CLAUDE.md`
- Windows: `C:\Program Files\ClaudeCode\CLAUDE.md`

**Propósito**: Instrucciones a nivel organizacional gestionadas por IT/DevOps

**Ejemplos de uso**:
- Estándares de código de la empresa
- Políticas de seguridad
- Requisitos de cumplimiento

**Compartido con**: Todos los usuarios de la organización

**⚠️ IMPORTANTE**: NUNCA modificar en reset (es responsabilidad de IT/DevOps)

---

### 2. User Memory (Memoria Personal Global)

**Ubicación**: `~/.claude/CLAUDE.md`

**Propósito**: Preferencias personales que aplican a TODOS tus proyectos

**Ejemplos de uso**:
- Preferencias de estilo de código
- Atajos de herramientas personales
- Convenciones de naming preferidas
- Stack tecnológico que dominas

**Compartido con**: Solo tú (todos tus proyectos)

**Reset**: Mejor **vaciar** que borrar (mantener el archivo indica que existe)

---

### 3. User Rules (Reglas Personales Modulares)

**Ubicación**: `~/.claude/rules/*.md`

**Propósito**: Reglas personales organizadas por tema

**Ejemplos de uso**:
- Guías específicas de lenguaje
- Convenciones de testing
- Estándares de API

**Compartido con**: Solo tú (todos tus proyectos)

**Reset**: **Borrar archivos .md individuales**, mantener directorio

**Características**:
- Soporta subdirectorios para organización
- Soporta symlinks a reglas compartidas
- Puede tener frontmatter YAML con `paths:` para reglas condicionales

---

### 4. Project Memory (Memoria del Proyecto Compartida)

**Ubicación**: `./CLAUDE.md` o `./.claude/CLAUDE.md`

**Propósito**: Instrucciones del proyecto compartidas con el equipo

**Ejemplos de uso**:
- Arquitectura del proyecto
- Estándares de código del equipo
- Flujos de trabajo comunes

**Compartido con**: Miembros del equipo (vía control de versiones)

**Reset**: **Vaciar o borrar** (si está en git, mejor vaciar para mantener el archivo versionado)

**Características**:
- Soporta @imports de otros archivos
- Claude Code busca CLAUDE.md recursivamente hacia arriba desde el directorio actual

---

### 5. Project Rules (Reglas del Proyecto Modulares)

**Ubicación**: `./.claude/rules/*.md`

**Propósito**: Instrucciones modulares del proyecto con paths específicos

**Ejemplos de uso**:
- Guías específicas de lenguaje
- Convenciones de testing
- Estándares de API

**Compartido con**: Miembros del equipo (vía control de versiones)

**Reset**: **Borrar archivos .md individuales**, mantener directorio `./.claude/rules/`

**Características**:
- Soporta frontmatter YAML con `paths:` para reglas condicionales
- Soporta subdirectorios
- Soporta symlinks

---

### 6. Project Local (Memoria Personal del Proyecto)

**Ubicación**: `./CLAUDE.local.md`

**Propósito**: Preferencias personales específicas del proyecto (NO en git)

**Ejemplos de uso**:
- URLs de sandbox personales
- Datos de prueba preferidos
- Configuraciones locales

**Compartido con**: Solo tú (proyecto actual)

**Reset**: **Borrar** (no está versionado, se regenera fácil)

**Características**:
- Automáticamente añadido a `.gitignore`
- Ideal para preferencias privadas que no deben estar en git

---

### 7. Auto Memory (Notas Automáticas de Claude)

**Ubicación**: `~/.claude/projects/<project>/memory/`

**Propósito**: Notas automáticas que Claude escribe para sí mismo

**Ejemplos de contenido**:
- Patrones del proyecto (comandos de build, convenciones de test)
- Insights de debugging (soluciones a problemas, causas de errores)
- Notas de arquitectura (archivos clave, relaciones entre módulos)
- Tus preferencias (estilo de comunicación, hábitos de flujo de trabajo)

**Compartido con**: Solo tú (por proyecto)

**Reset**: **Borrar MEMORY.md y topic files** (Claude los regenera)

**Estructura**:
```
~/.claude/projects/<project>/memory/
├── MEMORY.md          # Índice conciso (primeras 200 líneas se cargan)
├── debugging.md       # Notas detalladas de debugging
├── api-conventions.md # Decisiones de diseño de API
└── ...                # Otros topic files que Claude crea
```

**Características**:
- Solo las primeras 200 líneas de MEMORY.md se cargan automáticamente
- Topic files se leen bajo demanda cuando Claude los necesita
- Claude lee y escribe estos archivos durante la sesión

---

## 📊 Jerarquía de Prioridad

Instrucciones más específicas tienen precedencia sobre las más amplias:

1. **Project Local** (más específico)
2. **Project Rules**
3. **Project Memory**
4. **User Rules**
5. **User Memory**
6. **Managed Policy** (más amplio)

---

## 🔧 Sistema de @imports

CLAUDE.md puede importar archivos adicionales:

```markdown
@path/to/file.md
@~/global-preferences.md
@README.md
```

**Características**:
- Paths relativos y absolutos permitidos
- Imports recursivos (max depth: 5)
- Primera vez en un proyecto: diálogo de aprobación

---

## 💡 Mejores Prácticas

**User Memory**:
- Sé específico: "Usa 2 espacios de indentación" > "Formatea código correctamente"
- Organiza con headings markdown
- Revisa periódicamente

**Project Memory**:
- Incluye comandos frecuentes (build, test, lint)
- Documenta estilo de código y convenciones de naming
- Añade patrones arquitectónicos importantes

**Rules**:
- Mantén reglas enfocadas (un tema por archivo)
- Usa nombres descriptivos
- Usa `paths:` solo cuando las reglas aplican a archivos específicos
- Organiza con subdirectorios

---

## ⚠️ Notas Importantes

- **Managed Policy**: NUNCA modificar (responsabilidad de IT)
- **CLAUDE.local.md**: Automáticamente en `.gitignore`
- **Auto Memory**: Claude lo gestiona, pero puedes editarlo manualmente
- **Symlinks**: Soportados en rules/ para compartir reglas entre proyectos

---

*Información extraída de la documentación oficial de Claude Code*
*Última actualización: 2026-02-13*
