# 📜 Módulo G4b — Los Pergaminos del Saber SDD

## Misión

Fetchear documentación oficial sobre metodologías de Spec-Driven Development.
Los pergaminos enriquecerán la forja de requirements, design y tasks con las
mejores prácticas de especificación del mundo conocido.
Las docs de tecnología son responsabilidad de los Rohirrim (G1), no de G4b.

---

## Banner de inicio

Mostrar antes de lanzar los fetches:

```
╔════════════════════════════════════════════════════════════╗
║  📜 Los Jinetes parten a buscar los Pergaminos del Saber SDD ║
╚════════════════════════════════════════════════════════════╝

  Cinco fuentes de sabiduría. Cinco jinetes en paralelo.
  El Mago Blanco envía a sus mejores a los archivos del Saber.
```

---

## Mapping SDD methodology → fuentes

Fetchear **siempre** las mismas fuentes, independientemente del stack detectado:

| SDD Methodology | URL a fetchear |
|-----------------|----------------|
| EARS format (Easy Approach to Requirements Syntax) | https://www.iaria.org/conferences2013/filesICSEA13/ICSEA_2013_Tutorial_Mavin.pdf |
| Plan Mode (Claude Code) | https://docs.anthropic.com/en/docs/claude-code/cli-usage |
| Kiro / AWS spec-driven development | https://kiro.dev/docs/specs/ |
| ADR lite (Architecture Decision Records) | https://adr.github.io/ |
| C4 model (diagramas de arquitectura) | https://c4model.com/ |

Lanzar WebFetch **en paralelo** para las 5 fuentes.

---

## Animación de progreso (mostrar durante el fetch)

```
🏇 EARS format           → buscando en iaria.org...           [✅ pergamino obtenido / ⚠️ sin respuesta]
🏇 Plan Mode             → buscando en anthropic.com...       [✅ pergamino obtenido / ⚠️ sin respuesta]
🏇 Kiro spec-driven      → buscando en kiro.dev...            [✅ pergamino obtenido / ⚠️ sin respuesta]
🏇 ADR lite              → buscando en adr.github.io...       [✅ pergamino obtenido / ⚠️ sin respuesta]
🏇 C4 model              → buscando en c4model.com...         [✅ pergamino obtenido / ⚠️ sin respuesta]

══════════════════════════════════════════════════════════════
  📚 [N]/5 pergaminos obtenidos. El Consejo puede proceder.
══════════════════════════════════════════════════════════════
```

---

## Fallback si WebFetch falla

```
⚠️ El jinete no pudo traer el pergamino de [fuente].
   El Consejo procederá con el conocimiento disponible.
```

El flujo continúa sin bloquearse. Un fallo de WebFetch NO detiene el SDD.

---

## Guardar contexto

El contenido fetcheado (resumen de cada fuente, máx 500 palabras por fuente) se guarda como `contexto_docs` para los módulos G5, G6 y G7.

Si ningún fetch tuvo éxito: `contexto_docs = null`. Los módulos posteriores funcionan sin él.

---

## Transición

→ Cargar `@prompts/gandalf/sections/05-module-requirements.md`

---

**Módulo**: `04b-module-docs-fetch.md`
**Invocado desde**: `03-module-objective.md`
**Requiere**: WebFetch (paralelo)
