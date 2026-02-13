# 🔮 Palantír - Version Control

**Current Version**: v1.3.0
**Release Date**: 2026-02-13

---

## 📋 Changelog

### v1.3.0 (2026-02-13) - Arquitectura Modular
**Sprint P1 - Modularización**

✨ **Nuevas características**:
- Arquitectura modular con `@imports` (6 módulos + main)
- Sistema de versionado implementado (VERSION.md)
- Separación de concerns clara y mantenible

🏗️ **Estructura**:
- `palantir-main.md` - Entry point (orquestador)
- `sections/01-metadata.md` - Banner, versión, misión
- `sections/02-backup-system.md` - Sistema de backup (4 opciones)
- `sections/03-jerarquia-oficial.md` - 7 niveles Claude Code
- `sections/04-exploracion-custom.md` - Detección genérica (Sección 8)
- `sections/05-formato-output.md` - Templates de output
- `sections/06-reglas-ejecucion.md` - Flujo y reglas de ejecución

✅ **Garantía**:
- Misma funcionalidad que v1.2 (no breaking changes)
- Más fácil de mantener y extender
- Base sólida para futuras features

---

### v1.2.0 (2026-02-13) - Mejoras UX
**Sprint P2 - Sistema Inspector**

✨ **Nuevas características**:
- Resumen opcional con `AskUserQuestion`
- Filtrado inteligente (.credentials.json, docs proyecto)
- Banner footer al final (después del resumen)
- Symlinks formato mejorado (conciso y claro)
- Skills sin contaminar contexto (solo metadata)

🐛 **Fixes**:
- Excluida documentación de proyecto del backup
- .credentials.json completamente omitido (no read, no backup)

📊 **Testing**:
- ✅ Probado exitosamente 2026-02-13 14:42
- 30 archivos respaldados (~350K)
- Todos los flujos validados

---

### v1.1.0 (2026-02-12) - Sistema de Backup
**Sprint P2 - Backup System**

✨ **Nuevas características**:
- Sistema de backup con 4 opciones de path:
  1. Directorio interno Claude (~/.claude/backup/)
  2. Proyecto actual (./tlotp_backup/)
  3. Proyecto TLOTP
  4. Path personalizado
- BACKUP_INDEX.md con inventario completo
- Metadata en cada archivo respaldado
- Estructura organizada por jerarquía

🔧 **Mejoras**:
- Detección de imports (@path/to/file)
- Detección de symlinks con formato claro
- YAML frontmatter en rules

---

### v1.0.0 (2026-02-11) - Inspector Básico
**Sprint P2 - MVP**

✨ **Funcionalidad inicial**:
- Inspección de jerarquía oficial Claude Code (7 niveles):
  1. Managed Policy
  2. User Memory
  3. User Rules
  4. Project Memory
  5. Project Rules
  6. Project Local
  7. Auto Memory
- Banner header y footer elegantes
- Mostrar contenido completo de archivos
- STATUS de cada ubicación (✅/❌/⚠️)

---

## 🎯 Roadmap

### v1.4.0 (Próximo - Sprint P3)
- Mejoras condicionales (imports/topic files) (#31)
- Validación opción "Sí, mostrar resumen" (#32)
- Mensaje CLAUDE.md jerarquía superior (#33)
- Sistema de reset total (#13)

### v1.5.0 (Sprint P3)
- Reset selectivo (global, proyecto, skills) (#14-#16)
- Reset interactivo (#17)

### v2.0.0 (Futuro)
- Parser conversacional (#21)
- Comandos en lenguaje natural
- Integración con prompt dedicado (#22)

---

## 📏 Política de Versionado

Seguimos **Semantic Versioning** (semver):
- **MAJOR** (X.0.0): Breaking changes (incompatibilidad con versión anterior)
- **MINOR** (1.X.0): Nuevas features (compatible con versión anterior)
- **PATCH** (1.0.X): Bug fixes y mejoras menores

---

## 🏷️ Tags de Git

Cada versión se tagea en git:
```bash
git tag -a v1.3.0 -m "Arquitectura modular con @imports"
git push origin v1.3.0
```

---

*Mantenido por la Fellowship del Teclado* 🥔🤖
