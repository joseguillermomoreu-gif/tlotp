# 📜 Módulo G4b — Los Pergaminos Oficiales

## Misión

Fetchear documentación oficial del stack detectado por los Rohirrim.
Los pergaminos enriquecerán la forja de requirements, design y tasks.
Un Rohirrim con mapa oficial llega más lejos que uno sin él.

---

## Banner de inicio

Mostrar antes de lanzar los fetches:

```
╔════════════════════════════════════════════════════════════╗
║  📜 Los Jinetes parten a buscar los Pergaminos Oficiales   ║
╚════════════════════════════════════════════════════════════╝

  Solo los dominios presentes en el stack explorado.
  El Mago Blanco no manda jinetes a batallas que no son suyas.
```

---

## Mapping stack → fuentes

Solo fetchear para los dominios detectados en `contexto_rohirrim` (Éowyn del Stack):

| Stack detectado | URL a fetchear |
|-----------------|----------------|
| PHP/Symfony | https://symfony.com/doc/current/index.html |
| TypeScript/React | https://react.dev/learn |
| Playwright | https://playwright.dev/docs/intro |
| Python/FastAPI | https://fastapi.tiangolo.com/ |
| Laravel | https://laravel.com/docs |
| Node.js | https://nodejs.org/en/docs |
| Go | https://go.dev/doc/ |
| PHPUnit | https://docs.phpunit.de/en/11.5/ |
| Doctrine | https://www.doctrine-project.org/projects/doctrine-orm/en/3.3/index.html |
| Vue.js | https://vuejs.org/guide/introduction |
| Next.js | https://nextjs.org/docs |
| Django | https://docs.djangoproject.com/ |

Lanzar WebFetch **en paralelo** para todos los dominios detectados.

---

## Animación de progreso (mostrar durante el fetch)

```
🏇 [tecnología-1]  → buscando en [dominio]...     [✅ pergamino obtenido / ⚠️ sin respuesta]
🏇 [tecnología-2]  → buscando en [dominio]...     [✅ pergamino obtenido / ⚠️ sin respuesta]
...

══════════════════════════════════════════════════════════════
  📚 [N]/[Total] pergaminos obtenidos. El Consejo puede proceder.
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
**Requiere**: WebFetch (paralelo), contexto_rohirrim (Éowyn del Stack)
