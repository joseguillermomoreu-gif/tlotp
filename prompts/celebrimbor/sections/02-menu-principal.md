# 🎯 Menú Principal - Celebrimbor

## Misión

Mostrar menú interactivo con opciones disponibles según el entorno detectado.

**NOTA**: En todos los banners, reemplaza `{VERSION}` con la versión TLOTP cargada desde `@prompts/VERSION.md`.

---

## Banner de Bienvenida (MOSTRAR SOLO UNA VEZ)

```
═══════════════════════════════════════════════════════════════
    🔮 Celebrimbor - El Forjador de Skills ⚒️
═══════════════════════════════════════════════════════════════

    "Tres Anillos para los Reyes Elfos bajo el cielo..."

    TLOTP {VERSION} | Backend CLI ⚡

═══════════════════════════════════════════════════════════════
```

**Después del banner**: Detector de entorno (módulo 01). Si todo OK, continuar al menú.

---

## Opciones del Menú

**IMPORTANTE**: NO repetir banner. Ir directo a opciones.

Operaciones:

1. 🔍 Buscar Skills
2. 📥 Instalar Skill
3. 📋 Listar Skills Instaladas
4. 🔄 Actualizar Skills
5. 🗑️ Eliminar Skill
6. 🤖 Modo Automático [🚧 WIP]
7. ⚙️ Cambiar Backend [🚧 WIP]
8. ℹ️ Ayuda
9. 🚪 Salir

Elige una opción [1-9]:
```

### Menú Limitado (Node.js < 18)

```
⚠️ ADVERTENCIA: Node.js desactualizado detectado

Tu Node.js:  v12.22.9  ❌
Requerido:   v18.0.0+  ✅

┌─────────────────────────────────────────────────────────────┐
│ 1. ⚡ Backend CLI (Node.js)                                 │
│    • ❌ NO DISPONIBLE - Actualiza Node.js primero           │
│    • Ver instrucciones de actualización                     │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ 2. 📦 Backend Git (Universal)                               │
│    • 🚧 WIP - Disponible en TLOTP v2.2.0                    │
│    • Esta opción funcionará sin Node.js                     │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ 3. 📖 Instrucciones de actualización de Node.js             │
│ 4. ℹ️  Ayuda y Documentación                                │
│ 5. 🚪 Salir                                                  │
└─────────────────────────────────────────────────────────────┘

Elige una opción [2-5]:
```

---

## Flujo de Navegación

**Al seleccionar opción**:

### Opción 1: Buscar Skills ✅
- **Cargar módulo**: `sections/07-module-search.md`
- Solicitar query de búsqueda
- Ejecutar búsqueda con backend
- Mostrar resultados
- Permitir acciones posteriores

### Opción 2: Instalar Skill ✅
- **Cargar módulo**: `sections/08-module-install.md`
- Solicitar nombre de skill (o venir desde búsqueda)
- Verificar si ya existe (duplicados)
- Elegir ubicación (global/local)
- Ejecutar instalación con backend
- Configurar paths: si necesario
- Verificar y confirmar instalación

### Opción 3: Listar Skills ✅
- **Cargar módulo**: `sections/09-module-list.md`
- Analizar jerarquía oficial (4 ubicaciones)
- Mostrar skills instaladas (global y local)
- Ofrecer ver detalles completos
- Permitir acciones (buscar, instalar, volver)

### Opción 4: Actualizar Skills ✅
- **Cargar módulo**: `sections/11-module-update.md`
- Verificar updates disponibles con `npx skills check`
- Mostrar lista de skills con updates
- Advertir que se actualizan TODAS (backend CLI)
- Confirmación del usuario
- Ejecutar `npx skills update`
- Verificar resultado
- Confirmar y mostrar qué se actualizó

### Opción 5: Eliminar Skill ✅
- **Cargar módulo**: `sections/10-module-remove.md`
- Listar skills instaladas
- Seleccionar skill a eliminar
- Confirmación crítica (NO se puede deshacer)
- Ejecutar con npx skills remove (o rm manual)
- Verificar eliminación
- Confirmar resultado

### Opción 6: Modo Automático 🚧
- **Estado**: WIP - Tarea #7
- **Si el usuario la selecciona**, mostrar:

```
🚧 Modo Automático - En Desarrollo

¿Qué hará esta funcionalidad?
Detectará automáticamente el tipo de proyecto (React, Symfony,
Playwright, Python, etc.) y te sugerirá/instalará las skills más
relevantes sin tener que buscarlas manualmente una por una.

Por ejemplo:
- Proyecto Playwright → Instala skills: playwright, pom, typescript
- Proyecto Symfony → Instala skills: php, symfony, doctrine, phpunit
- Proyecto React → Instala skills: react, typescript, vite, testing-library

Estado: 🚧 En desarrollo
Disponible en: TLOTP v2.2.0

Beneficio: Ahorra tiempo al configurar nuevos proyectos. Especialmente
útil para stacks comunes donde ya sabemos qué skills necesitas.

Presiona Enter para volver al menú...
```

- Volver al menú

### Opción 7: Cambiar Backend 🚧
- **Estado**: WIP - v2.2.0 (Backend Git)
- **Si el usuario la selecciona**, mostrar:

```
🚧 Cambiar Backend - En Desarrollo

¿Qué hará esta funcionalidad?
Te permitirá cambiar entre dos backends para gestionar skills:

⚡ Backend CLI (Actual)
   • Requiere: Node.js >= 18
   • Ventaja: Rápido, selectivo, actualiza skills individuales
   • Comando: npx skills [comando]

📦 Backend Git (Futuro)
   • Requiere: Solo git (universal)
   • Ventaja: No depende de Node.js, funciona en cualquier entorno
   • Método: Clona repos directamente desde GitHub

Estado: 🚧 En desarrollo
Disponible en: TLOTP v2.2.0

Beneficio: Si no tienes Node.js o prefieres no instalarlo,
podrás usar el backend Git y seguir gestionando skills.

Presiona Enter para volver al menú...
```

- Volver al menú

### Opción 8: Ayuda
- Mostrar documentación de Celebrimbor
- Links a ARCHITECTURE.md, README.md, docs/REQUISITOS.md

### Opción 9: Salir
- Mensaje de despedida épico
- Finalizar

---

## Reglas de Ejecución

1. **SIEMPRE mostrar banner de bienvenida**
2. **Adaptar menú** según detección de entorno
3. **Deshabilitar opciones** no disponibles (mostrar ❌)
4. **Usar AskUserQuestion** para navegación elegante
5. **Loop continuo** hasta que el usuario elija Salir

---

**Módulo anterior**: 01-detector-entorno.md
**Módulo siguiente**: 03-backend-cli.md
