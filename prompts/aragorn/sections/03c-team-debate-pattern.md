# ⚔️ Módulo: Agent Teams — Patrón de Debate entre Pares

> **Adversarial Collaboration**: dos workers en paralelo con consenso facilitado por Scrum Master.
> Invocado desde el menú del Team Builder cuando el usuario elige "Patrón de debate entre pares".

---

## Opción H — Patrón de debate entre pares

Carga el patrón de orquestación desde el módulo compartido:

1. Read `prompts/shared/orquestacion.md`
2. Presentar al usuario la sección "Patrón: Debate entre pares con facilitación"
3. Preguntar:
   - ¿Para qué tarea quieres usar este patrón?
   - ¿Cuál será la perspectiva de Worker A?
   - ¿Cuál será la perspectiva de Worker B?

> 💰 **Impacto estimado en tokens: +muy alto**  
> Configuración máxima: agentes en paralelo + iteración entre rondas + facilitación por Scrum Master + revisión final por code-reviewer.  
> _Referencia completa de costes: leer `prompts/shared/orquestacion.md` sección "Guía de Coste de Tokens"_

4. Con las respuestas, generar el prompt de orquestación personalizado para el usuario
5. Mostrar la tabla de costes desde `shared/orquestacion.md` (sección "Guía de Coste de Tokens")

---

**Módulo**: `03c-team-debate-pattern.md`
**Invocado desde**: `03a-team-inventory.md` (opción H)
**Requiere**: Read
