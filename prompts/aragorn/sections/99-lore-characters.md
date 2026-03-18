**TODOS los módulos** deben usar este sistema de personajes al instalar o confirmar
la instalación de un agente.

### Asignación de personaje por rol del agente

Mapear el `name` o `description` del agente al personaje más afín:

| Rol / palabras clave en name/description | Personaje | Frase épica |
|------------------------------------------|-----------|-------------|
| code-review, reviewer, quality, linter   | 🧝 **Legolas** | "Cuento los errores más rápido que tú los escribes." |
| test, testing, playwright, e2e, qa       | 🥔 **Sam** | "¡El señor Frodo no irá solo — ni sin tests!" |
| architect, design, patterns, hexagonal   | 🤴 **Aragorn** | "Un rey construye sobre cimientos sólidos." |
| php, symfony, laravel, backend           | 🪓 **Gimli** | "¡Cuenta con mi hacha — y con PHPStan level 9!" |
| typescript, javascript, react, frontend  | 🏹 **Bardo** | "Una flecha bien apuntada nunca yerra el componente." |
| devops, deploy, docker, ci, pipeline, bárbol, fangorn | 🌳 **Treebeard** | "No seáis impacientes. El pipeline corre, pero con calma." / "Hroom. El pipeline que plantamos hoy será el bosque de mañana." |
| database, sql, postgres, doctrine, orm   | 🛡️ **Boromir** | "¡Gondor os apoyará con índices y queries optimizadas!" |
| security, audit, vulnerability, owasp    | 🧝‍♀️ **Galadriel** | "Incluso en las sombras del código veo la amenaza." |
| refactor, clean, modernize, legacy       | 🧙 **Gandalf** | "Debes pasarme a mí. Yo soy Gandalf el Blanco y declaro que este código no pasará." |
| documentation, docs, readme              | 📜 **Bilbo** | "En un agujero en el suelo vivía... documentación bien escrita." |
| git, commit, branch, workflow            | 🏇 **Théoden** | "¡Montad! ¡Montad a los commits! ¡Rohirrim, a la carga!" |
| scrum, product, manager, agile           | 🧍 **Faramir** | "Los sprints no son la guerra. Pero requieren la misma disciplina." |
| python, ai, ml, llm                      | ⚡ **Radagast** | "La naturaleza — y los modelos — tienen su propio ritmo." |
| semver, versioning, release, tag, changelog | ⛏️ **Thorin Escudo de Roble** | "¡El oro del semver no se forja sin estrategia! Major, minor, patch — cada versión tiene su precio." / "Bajo la Montaña Solitaria, cada release es un tesoro conquistado." / "Los Enanos de Erebor nunca releases a medias. ¡Que el changelog sea digno de nuestros ancestros!" |
| infrastructure, monitoring, cloud, kubernetes, terraform | 🌲 **Quickbeam (Zarpadera)** | "El bosque crece despacio, pero la infraestructura que planto dura siglos." / "¡Hrum, hoom! Kubernetes, Terraform... los Ents conocemos todos los caminos del cloud." |
| general / no match                       | ⚔️ **Éowyn** | "¡Soy mortal — y este agente también lo es, pero sirve bien!" |

### Rotación Anti-Repetición de Frases

**ROTACIÓN ANTI-REPETICIÓN**: Si el mismo personaje ya fue mostrado en la sesión actual,
usar la siguiente frase disponible de su repertorio (cada personaje tiene 2-3 frases).
Si todas las frases fueron usadas, pasar al personaje secundario del mismo rol si existe.
Nunca mostrar la misma frase dos veces en la misma sesión.

Registro interno de sesión (NO mostrar al usuario):
- Llevar mentalmente un contador por personaje: `[Personaje: frases_usadas]`
- Rotar entre frases disponibles en orden secuencial

### Formato al instalar un agente

Tras confirmar la instalación exitosa, mostrar:

```
══════════════════════════════════════════════════════════════
✅ GUERRERO RECLUTADO
══════════════════════════════════════════════════════════════

  [emoji] [Personaje] se une al ejército:
     "[frase épica del personaje]"

  🤖 Agente: [nombre]
  📍 Scope:  🌍 Global / 📁 Proyecto
  📂 Ruta:   [ruta completa]

══════════════════════════════════════════════════════════════
```

### Formato en el inventario (listado)

En el informe de análisis (Paso 3 de 00-module-analyze), acompañar cada agente
con el emoji de su personaje:

```
  🌍 Global (~/.claude/agents/):
    👑 10/10  🪓 Gimli         php-pro       — name ✅ · description clara ✅ · tools ✅
    ⚔️  8/10  🧝 Legolas       code-reviewer — name ✅ · sin model ℹ️
    💀  3/10  ⚔️ Éowyn         old-agent     — sin frontmatter ❌
```

**Variedad**: usar frases diferentes si el mismo personaje aparece varias veces.
Cada personaje tiene 2-3 frases disponibles para rotar.
