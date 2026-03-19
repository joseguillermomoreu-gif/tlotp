# 📚 Documentación Oficial Claude Code — Módulo Centralizado

> **IMPORTADO POR**: 03-jerarquia-oficial.md, 05-susurrar-planes.md, 06-compartir-visiones.md
> **NO contiene lógica de negocio ni routing** — solo instrucciones de fetch.
>
> **Caching de sesión**: Si en esta sesión ya se hizo WebFetch a estas URLs,
> reutilizar ese contenido directamente sin refetchear.

---

## Documentación Oficial (Live)

Obtener documentación actualizada en este orden:

> **WebFetch 1**: https://code.claude.com/docs/en/how-claude-code-works
> **Extraer**: arquitectura general, cómo se cargan CLAUDE.md y MEMORY.md, extension points

> **WebFetch 2**: https://code.claude.com/docs/en/best-practices
> **Extraer**: criterios de buenas prácticas (límite 200 líneas CLAUDE.md, qué incluir/excluir, estructura recomendada)

> **WebFetch 3**: https://code.claude.com/docs/en/memory
> **Extraer**: tabla completa de tipos de memoria, jerarquía de precedencia, estructura de auto memory, sistema de rules con paths, sistema de @imports

> **WebFetch 4**: https://code.claude.com/docs/en/settings
> **Extraer**: jerarquía de settings (Managed > User > Project > Local), ubicaciones de ficheros, permisos disponibles

> **WebFetch 5**: https://code.claude.com/docs/en/hooks
> **Extraer**: eventos disponibles, schema de configuración, tipos de hooks, patrones de matcher

> **WebFetch 6**: https://code.claude.com/docs/en/features-overview
> **Extraer**: cuándo usar cada feature (CLAUDE.md vs skills vs hooks vs subagents), costes de contexto

**Usar la información obtenida como fuente de verdad** para todos los análisis y operaciones del módulo que importa este fichero.
