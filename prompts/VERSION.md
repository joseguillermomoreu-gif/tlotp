# 🏷️ TLOTP - Versiones de Prompts

> **Fuente única de verdad** para las versiones de todos los prompts de TLOTP

---

## 📊 Versiones Actuales

### Palantír
- **Versión**: 1.7.0
- **Versión corta**: v1.7
- **Fecha release**: 2026-02-14
- **Descripción**: CRUD Completo - Inspector, Reset, Recovery, Reconstrucción y Configurador

### Celebrimbor
- **Versión**: 2.1.0
- **Versión corta**: v2.1
- **Fecha release**: 2026-02-16
- **Descripción**: Skills Manager MVP - CRUD Completo con Backend CLI

### Gollum
- **Versión**: (pendiente)
- **Descripción**: Playwright E2E Testing

### Elrond
- **Versión**: (pendiente)
- **Descripción**: Global Config Management

### Gandalf
- **Versión**: (pendiente)
- **Descripción**: Autonomous PHP Development

---

## 📝 Formato de Uso

### Para Palantír

**En banners header**:
```
TLOTP Inspector Module v1.3
```

**En banners footer**:
```
Palantír (TLOTP) v1.3 - "La piedra que todo lo ve"
```

**En metadata de backups**:
```
Backup realizado por: Palantír (TLOTP) v1.3
```

**En títulos de archivos**:
```
# 🔮 Palantír v1.3 - Main Entry Point
```

---

## 🔄 Cómo Usar Este Archivo

**En prompts**: Importa este archivo al inicio de tu `*-main.md`:

```markdown
@prompts/VERSION.md
```

Luego, usa la versión correspondiente según el formato de uso arriba.

---

## 📋 Changelog

### v2.1.0 - Celebrimbor (2026-02-16)
- **Sistema de Gestión de Skills Completo** (Backend CLI MVP)
  - Detección automática de entorno (Node.js >=18, npm, Git)
  - Arquitectura modular dual-backend (CLI + Git futuro)
  - Abstraction layer para backends intercambiables
- **CRUD Completo de Skills**:
  - CREATE: Instalación global/local con npx skills add
  - READ: Búsqueda en skills.sh + listado de instaladas
  - UPDATE: Actualización automática con npx skills update
  - DELETE: Eliminación segura con confirmación
- **Features Destacados**:
  - Verificación automática de updates al inicio
  - Detección de duplicados antes de instalar
  - Banner épico con estado de sistema
  - Integración con 59,000+ skills de skills.sh
  - Manejo robusto de errores
- **Arquitectura**: 11 módulos (4,234 líneas de prompts)
- **XP Generado**: 710 XP (6 tareas completadas)
- **Pendiente v2.2.0**: Backend Git, Update selectivo, Modo Automático

### v1.7.0 - Palantír (2026-02-14)
- **Sistema de Configuración Asistida** (10-configurator-system.md)
  - Nueva opción en menú principal: "Configurar característica"
  - Solicitar qué característica añadir (con ejemplos)
  - Consultar `info_claude.md` para determinar ubicación correcta
  - Detectar si ya existe característica similar
- **Detección de Conflictos y Contradicciones**
  - Buscar características que se sobreescriban
  - Identificar preferencias contradictorias
  - Detectar inconsistencias lógicas (frameworks, configs, comportamientos)
  - Listar todos los conflictos encontrados
- **Sistema de Propuestas Iterativo**
  - Generar propuesta de combinación automática
  - Estrategias: Unificar/Priorizar nuevo/Mantener ambas
  - Si rechazo → generar propuesta alternativa
  - Permitir "Modificar manualmente" con input usuario
  - Continuar iterando mientras NO acepte Y NO cancele
  - Si cancela → abortar TODO el proceso
- **Reestructuración con Documentación Oficial**
  - Consultar `info_claude.md` para orden ideal de secciones
  - Extraer secciones actuales del archivo
  - Añadir nueva característica en orden correcto
  - Reordenar según mejores prácticas
  - Mostrar preview del archivo resultante completo (30+ líneas)
- **Confirmación Crítica Antes de Aplicar**
  - Preview completo de edición
  - AskUserQuestion: "¿Aplicar esta edición?"
  - Si rechazo → cancelar TODO (no aplicar NADA)
- **Uso del Motor de Reconstrucción**
  - Usar `09-reconstruction-engine.md` para aplicar cambios
  - Validación de estructura por tipo de archivo
  - Verificación post-aplicación
- **CRUD Completo**:
  - CREATE: Configurador (nuevo) ✅
  - READ: Inspector ✅
  - UPDATE: Recovery con merge ✅
  - DELETE: Reset ✅
- **Arquitectura**: 11 módulos (3,611 líneas de prompts)

### v1.6.0 - Palantír (2026-02-13)
- **Motor de Reconstrucción Inteligente** (09-reconstruction-engine.md)
  - Sistema de acumulación temporal en memoria
  - Validación de estructura por tipo de archivo
  - Confirmación por cada reconstrucción
  - Prevención de archivos corruptos
- **Prevención de Contaminación de Auto Memory**
  - Regla crítica para no generar MEMORY.md durante ejecución
  - Palantír no deja rastro en memoria del proyecto
- **Reset Selectivo con Reconstrucción**
  - Acumula preferencias en memoria
  - Reconstruye con estructura correcta
  - Valida antes de escribir
- **Recovery con Reconstrucción**
  - Opción "Reemplazar" con validación
  - Opción "Combinar" con merge inteligente + reconstrucción
- **Solución a archivos corruptos** reportados en issue #40

### v1.5.0 - Palantír (2026-02-13)
- Sistema de Reset completo e interactivo
- Sistema de Reset Selectivo (regla por regla)
- Sistema de Recovery desde backups
- Menú principal con 3 modos
- Documentación oficial Claude Code Memory integrada

### v1.4.0 - Palantír (2026-02-13)
- Sistema de versionado centralizado (VERSION.md)
- Versión como fuente única de verdad

### v1.3.0 - Palantír (2026-02-13)
- Arquitectura modular con @imports
- 6 módulos separados por concerns
- ARCHITECTURE.md como patrón estándar
- Sistema de backup robusto
- Inspección de 7 niveles de jerarquía Claude Code

### v1.2.0 - Palantír (anterior)
- Monolítico (884 líneas)
- Sistema de backup implementado
- Exploración completa de configuraciones

---

*Actualizar este archivo cuando se libere una nueva versión de cualquier prompt*
