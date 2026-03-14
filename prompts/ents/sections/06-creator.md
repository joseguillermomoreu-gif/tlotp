# 🌱 Creator - Crear CI/CD desde Cero

## Misión

Guiar al usuario paso a paso para crear un pipeline de GitHub Actions completo,
adaptado a su proyecto, siguiendo las mejores prácticas de la documentación oficial.

---

## Principio de Operación

> **Autoasistencia guiada**: Claude analiza el proyecto, propone una estructura,
> el usuario decide, Claude implementa. En cada decisión, Claude asesora
> basándose en la documentación oficial consultada en tiempo real.

---

## Flujo de Creación

### Paso 1: Detección del Tipo de Proyecto

Escanear el proyecto para determinar su naturaleza:

```
Detectar:
- package.json → Node.js (React, Vue, Angular, Next.js, Express, etc.)
- composer.json → PHP (Symfony, Laravel, WordPress, etc.)
- requirements.txt / pyproject.toml / setup.py → Python (Django, Flask, FastAPI, etc.)
- Cargo.toml → Rust
- go.mod → Go
- pom.xml / build.gradle → Java/Kotlin
- Gemfile → Ruby (Rails, etc.)
- *.sln / *.csproj → .NET
- pubspec.yaml → Dart/Flutter
```

Mostrar resultado:

```
═══════════════════════════════════════════════════════════════
🌱 Creador de CI/CD - Análisis del Proyecto
═══════════════════════════════════════════════════════════════

  📂 Proyecto detectado: [tipo]
  📦 Dependencias: [gestor]
  🧪 Testing: [framework detectado o "no detectado"]
  📏 Linting: [herramienta detectada o "no detectada"]
  🔨 Build: [sistema detectado o "no aplica"]

═══════════════════════════════════════════════════════════════
```

---

### Paso 2: Definir Alcance del Pipeline

Preguntar al usuario con **AskUserQuestion**:

```json
{
  "questions": [
    {
      "header": "Alcance CI/CD",
      "question": "¿Qué quieres incluir en tu pipeline de CI/CD?",
      "multiSelect": true,
      "options": [
        {
          "label": "Linting y formato",
          "description": "Verificar estilo de código y formato (ESLint, Prettier, PHPStan, etc.)"
        },
        {
          "label": "Tests automatizados",
          "description": "Ejecutar tests unitarios y/o de integración automáticamente"
        },
        {
          "label": "Build y verificación",
          "description": "Compilar/build del proyecto para verificar que no hay errores"
        },
        {
          "label": "Deploy automático",
          "description": "Desplegar automáticamente a un entorno (staging/producción)"
        }
      ]
    }
  ]
}
```

---

### Paso 3: Consultar Documentación Oficial

Según el tipo de proyecto y alcance elegido, consultar con **WebFetch**:

1. **Workflow syntax**: `https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions`
2. **Starter workflows de GitHub** según el lenguaje detectado
3. **Security hardening**: `https://docs.github.com/en/actions/security-for-github-actions/security-hardening-for-github-actions`
4. **Caching**: `https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/caching-dependencies-to-speed-up-workflows`

Extraer mejores prácticas actualizadas para aplicar en la generación.

---

### Paso 4: Configurar Detalles

Según las opciones elegidas, preguntar detalles adicionales:

#### Si eligió Tests:
```json
{
  "questions": [
    {
      "header": "Tests",
      "question": "¿Cómo se ejecutan los tests en tu proyecto?",
      "multiSelect": false,
      "options": [
        {
          "label": "npm test",
          "description": "Node.js: npm test o npm run test"
        },
        {
          "label": "composer test",
          "description": "PHP: composer test o vendor/bin/phpunit"
        },
        {
          "label": "pytest",
          "description": "Python: pytest"
        },
        {
          "label": "Otro comando",
          "description": "Especificar el comando de tests manualmente"
        }
      ]
    }
  ]
}
```

#### Si eligió Deploy:
Preguntar destino de deploy (Vercel, Netlify, AWS, DigitalOcean, Docker, custom, etc.)

#### Triggers:
```json
{
  "questions": [
    {
      "header": "Triggers",
      "question": "¿Cuándo debe ejecutarse el pipeline?",
      "multiSelect": true,
      "options": [
        {
          "label": "Push a main/master",
          "description": "Ejecutar en cada push a la rama principal"
        },
        {
          "label": "Pull Requests",
          "description": "Ejecutar en cada PR (validar antes de merge)"
        },
        {
          "label": "Manual (dispatch)",
          "description": "Poder ejecutar manualmente desde GitHub"
        },
        {
          "label": "Schedule (cron)",
          "description": "Ejecutar periódicamente (ej: nightly builds)"
        }
      ]
    }
  ]
}
```

---

### Paso 5: Generar Workflow

Con toda la información recopilada, generar el/los archivo(s) de workflow.

**Buenas prácticas a aplicar SIEMPRE** (basadas en docs oficiales):

1. **Permissions mínimos**: `permissions: { contents: read }` (o lo mínimo necesario)
2. **Concurrency group**: Cancelar runs duplicados en la misma PR
3. **Cache de dependencias**: Según el gestor de paquetes
4. **Timeout**: Configurar `timeout-minutes` en cada job
5. **Nombres descriptivos**: En jobs y steps
6. **Pin de acciones por versión**: `actions/checkout@v4` (mínimo tag, ideal SHA)
7. **Filtros de paths**: Si aplica, no ejecutar en cambios de docs/README

---

### Paso 6: Preview Completo

Mostrar el workflow generado COMPLETO al usuario antes de escribirlo:

```
═══════════════════════════════════════════════════════════════
🌱 Preview del Workflow Generado
═══════════════════════════════════════════════════════════════

📄 Archivo: .github/workflows/ci.yml

```yaml
[contenido completo del workflow]
```

───────────────────────────────────────────────────────────────
💡 Decisiones Técnicas
───────────────────────────────────────────────────────────────

  1. [Decisión]: [Explicación y referencia oficial]
  2. [Decisión]: [Explicación y referencia oficial]
  ...

═══════════════════════════════════════════════════════════════
```

---

### Paso 7: Confirmación y Escritura

Preguntar con **AskUserQuestion**:

```json
{
  "questions": [
    {
      "header": "Confirmar",
      "question": "¿Crear este workflow?",
      "multiSelect": false,
      "options": [
        {
          "label": "Crear workflow",
          "description": "Escribir el archivo en .github/workflows/"
        },
        {
          "label": "Modificar antes de crear",
          "description": "Pedir ajustes al workflow antes de escribirlo"
        },
        {
          "label": "Cancelar",
          "description": "No crear el workflow"
        }
      ]
    }
  ]
}
```

Si confirma:
1. Crear directorio `.github/workflows/` si no existe
2. Escribir el archivo con **Write**
3. Verificar que se creó correctamente con **Read**

---

### Paso 8: Post-Creación

Después de crear el workflow:

```
═══════════════════════════════════════════════════════════════
✅ Workflow Creado Exitosamente
═══════════════════════════════════════════════════════════════

  📄 .github/workflows/ci.yml ✅

  📋 Próximos pasos:
  1. Revisa el workflow generado
  2. Haz commit y push al repositorio
  3. Verifica en GitHub → Actions que se ejecuta correctamente
  4. Configura branch protection rules si lo necesitas

  💡 ¿Quieres que configure branch protection? (Opción del menú Ents)

═══════════════════════════════════════════════════════════════
```

Preguntar si quiere:
- Crear otro workflow (ej: deploy separado)
- Configurar complementos (Dependabot, PR template, etc.)
- Volver al menú de Ents

---

## Reglas del Creator

1. **Siempre detectar el proyecto primero**: No asumir tecnología
2. **Consultar docs oficiales**: Cada decisión técnica respaldada por WebFetch
3. **Preview obligatorio**: NUNCA escribir sin confirmación del usuario
4. **Buenas prácticas por defecto**: Pero explicar cada una
5. **No sobre-ingeniería**: Empezar simple, ofrecer complejidad si el usuario la pide
6. **Respetar lo existente**: Si ya hay archivos `.github/`, no pisarlos sin preguntar
7. **Asesorar proactivamente**: Si detectas algo que el usuario debería saber, decirlo

---

*Módulo 06 — Creator*
