# 📖 Referencia CLI skills.sh - Celebrimbor

## 📖 Documentación Oficial (Live)

**ANTES de ejecutar comandos CLI**, obtener la referencia actualizada desde DOS fuentes:

> **WebFetch 1**: https://github.com/vercel-labs/skills
> **Extraer**:
> - Comandos disponibles: `add`, `find`, `list/ls`, `check`, `update`, `init`, `remove/rm`
> - Flags por comando (especialmente `-g`, `-a`, `-s`, `-l`, `-y`, `--copy`, `--all`)
> - Formatos de source aceptados (GitHub shorthand, URL, SSH, local)
> - Scopes de instalación (project vs global)
> - Métodos de instalación (symlink vs copy)
> - Estructura de SKILL.md (frontmatter YAML)
> - Variables de entorno

> **WebFetch 2**: https://code.claude.com/docs/en/skills
> **Extraer**:
> - Sistema de skills nativo de Claude Code
> - Ubicaciones de skills (enterprise, personal, project, plugin)
> - Frontmatter fields disponibles
> - Control de invocación (disable-model-invocation, user-invocable)
> - Patrones avanzados (context fork, supporting files)

**Usar la información obtenida como fuente de verdad** para todas las operaciones CLI.

---

## 🎯 Propósito

Referencia técnica del CLI de skills.sh para que Celebrimbor ejecute operaciones correctamente.

**Fuentes oficiales**:
- CLI: [github.com/vercel-labs/skills](https://github.com/vercel-labs/skills)
- Skills nativos: [code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills)
- Web: [skills.sh](https://skills.sh)

---

## ⚠️ Errores Comunes (Verificados)

Estos errores fueron verificados contra la documentación real y se mantienen como referencia rápida:

| Error | Causa | Solución |
|-------|-------|----------|
| `search` no reconocido | Comando incorrecto | Usar `find` en vez de `search` |
| "No skills found" | `SKILL.md` sin `name` o `description` | Verificar YAML frontmatter |
| Skill no carga | Path incorrecto o frontmatter inválido | Verificar ubicación y formato |
| Permission errors | Sin permisos de escritura | Verificar permisos del directorio destino |

> **IMPORTANTE**: El comando de búsqueda es `find`, NO `search`.

---

## 🎯 Cheatsheet Rápido (Verificado)

Estos comandos son correctos según la documentación oficial:

```bash
# Buscar
npx skills find <query>

# Instalar (Claude Code, no interactivo)
npx skills add <owner/repo> -s <skill-name> -a claude-code -y

# Instalar global
npx skills add <owner/repo> -s <skill-name> -g -a claude-code -y

# Listar
npx skills list
npx skills ls -a claude-code

# Verificar updates
npx skills check

# Actualizar todas
npx skills update

# Crear skill nueva
npx skills init <name>

# Eliminar
npx skills remove <skill-name> -a claude-code -y

# Ver disponibles sin instalar
npx skills add <owner/repo> --list
```

---

**Fuente oficial**: [github.com/vercel-labs/skills](https://github.com/vercel-labs/skills)
**Índice de fuentes**: `@prompts/docs-sources.md`
