## Opción 6 — Instalar MCPs / plugins

### Intro de ejecución

```
🏹 Bardo prepara el desembarco en los muelles del Fuerte...
   Ítem por ítem, sin prisas. Cada barco entra al puerto con cuidado.
```

### Paso 1 — Obtener lista a instalar

Si vienes de la Opción 5 con lista pre-cargada: usa esa lista directamente.

Si el usuario llega directamente a esta opción sin lista previa, pregúntale
(AskUserQuestion) qué quiere instalar:
- Ver recomendaciones primero (ir a Opción 5)
- Escribir manualmente el nombre de MCP o plugin a instalar
- Salir

### Paso 2 — Bucle de instalación ítem por ítem

Para cada ítem de la lista, ejecuta este flujo completo antes de pasar al siguiente:

---

#### 2a — Preguntar scope (solo para MCPs)

Muestra al usuario (AskUserQuestion):

```
⚓ Instalando: [nombre] [[tipo: MCP http/stdio | Plugin]]

  ¿Dónde quieres instalarlo?
```

Opciones:
- `project` — Solo este proyecto (guarda en `.mcp.json`, compartido con el equipo)
- `user` — Todos tus proyectos (guarda en `~/.claude.json`)
- `local` — Solo esta sesión local (no se comparte ni persiste en repo)

> Para plugins no hay que preguntar scope en este paso — se gestiona en el comando de instalación.

---

#### 2b — Mostrar comando y pedir confirmación

Construye el comando según el tipo de ítem:

**MCP http/sse:**
```
claude mcp add --transport http [nombre] [url] --scope [scope]
```

**MCP stdio:**
```
claude mcp add --transport stdio [nombre] --env VAR=valor -- [comando]
```
Si hay variables de entorno requeridas (detectadas en la documentación del MCP),
pregunta al usuario cada variable antes de construir el comando:
*"El MCP [nombre] requiere la variable [VAR]. ¿Cuál es su valor?"*

**Plugin:**
```
/plugin install [nombre]@claude-plugins-official
```

Muestra al usuario el comando completo antes de ejecutar:

```
⚓ Listo para desembarcar:

  Comando: claude mcp add --transport http github https://api.githubcopilot.com/mcp/ --scope project

  ¿Confirmas?
```

Opciones (AskUserQuestion):
- ✅ Instalar → ejecutar el comando
- ⏭️ Saltar → pasar al siguiente ítem sin instalar este
- 🚫 Cancelar todo → abortar el resto de instalaciones

---

#### 2c — Ejecutar la instalación

Para **MCPs**: ejecuta el comando `claude mcp add` via Bash.

Para **scope project**: además de ejecutar el comando, actualiza `.mcp.json`:
```bash
# Si no existe .mcp.json, créalo con estructura base
# Si existe, añade la nueva entrada en mcpServers
```
Usa Read + Write/Edit para gestionar el archivo JSON correctamente.

Para **plugins**: indica al usuario que ejecute `/plugin install [nombre]@claude-plugins-official`
en su próxima sesión de Claude Code (los plugins no se pueden instalar desde dentro del prompt).

---

#### 2d — Avisos post-instalación según tipo

**MCP http/sse**: informa al usuario:
```
✅ [nombre] instalado.
   Si requiere autenticación OAuth, ejecuta /mcp en tu próxima sesión
   para completar el login en el navegador.
```

**MCP stdio**: informa al usuario:
```
✅ [nombre] instalado.
   Verifica que el comando está disponible en tu PATH.
```

**Plugin LSP**: informa al usuario:
```
✅ [nombre] instalado.
   Los plugins LSP requieren reiniciar Claude Code para activarse.
```

**Plugin de integración**: informa al usuario:
```
✅ [nombre] instalado.
   Estará disponible en tu próxima sesión de Claude Code.
```

---

### Paso 3 — Resumen final

Tras recorrer todos los ítems, muestra:

```
🏹 Desembarco completado:

  ✅ Instalados (3):
     • github       [MCP]    → scope project
     • sentry       [MCP]    → scope user
     • php-lsp      [Plugin] → pendiente activar con /plugin

  ⏭️  Saltados (1):
     • slack        [MCP]

  ❌ Fallidos (0): —

→ Usa la Opción 7 para verificar que todo funciona correctamente.
```

### Paso 4 — Volver al menú

Pregunta al usuario (AskUserQuestion):
- Verificar instalaciones ahora (ir a Opción 7)
- Volver al menú de Bardo
- Salir

---

