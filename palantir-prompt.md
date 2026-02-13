# 🔮 Palantír - Inspector de Configuraciones TLOTP

> **Nota**: Este archivo es ahora un alias/redirect al nuevo sistema modular v1.3
>
> **Arquitectura modular**: `prompts/palantir/palantir-main.md`

---

## ✨ v1.3.0 - Arquitectura Modular

Este prompt ha sido modularizado para facilitar el mantenimiento y escalabilidad.

**Ver**: `prompts/palantir/MIGRATION.md` para detalles de la migración.

---

## 📚 Carga del Sistema Modular

@prompts/palantir/palantir-main.md

---

## 🎯 Funcionalidad

**Palantír v1.3** mantiene **100% de compatibilidad** con v1.2:
- ✅ Sistema de backup (4 opciones de path)
- ✅ Inspección jerarquía oficial (7 niveles Claude Code)
- ✅ Exploración de otros archivos y configuraciones
- ✅ Resumen opcional con AskUserQuestion
- ✅ Filtrado inteligente (.credentials.json, docs proyecto)
- ✅ Banner footer al final

**Sin breaking changes** - Funciona exactamente igual que antes.

---

## 📂 Nueva Estructura

```
prompts/palantir/
├── palantir-main.md           ← Entry point principal
├── VERSION.md                  ← Control de versiones
├── MIGRATION.md                ← Guía de migración
│
└── sections/                   ← Módulos separados por concerns
    ├── 01-metadata.md         ← Banner, misión, jerarquía
    ├── 02-backup-system.md    ← Sistema de backup
    ├── 03-jerarquia-oficial.md← 7 niveles Claude Code
    ├── 04-exploracion-custom.md← Detección genérica
    ├── 05-formato-output.md   ← Templates de output
    └── 06-reglas-ejecucion.md ← Flujo y reglas
```

---

*Palantír v1.3 - "La piedra que todo lo ve"* 👁️
*Arquitectura modular con @imports* 🏗️
