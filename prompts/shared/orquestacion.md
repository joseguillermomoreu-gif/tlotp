# Patrones de Orquestación

## Patrón: Debate entre pares con facilitación

### Flujo

- **Ronda 1**: Worker A y Worker B trabajan en paralelo (sin ver la propuesta del otro)
- **Ronda 2**: A lee propuesta de B y responde; B lee propuesta de A y responde
- **Ronda 3** (condicional): Scrum Master entra como **FACILITADOR** si no hay consenso
- **Final**: code-reviewer valida siempre, sin excepción

### Principios clave

- Scrum Master **NO decide** — facilita. Hace preguntas: "¿en qué discrepáis?", "¿qué necesitáis para acordar?"
- Los Workers A y B son quienes alcanzan el consenso
- code-reviewer **siempre** al final
- Paralelo primero — A y B trabajan sin verse en ronda 1

### Roles y system prompts recomendados

| Rol | Propósito | System prompt sugerido |
|-----|-----------|----------------------|
| Worker A | Propone solución desde perspectiva X | "Eres un experto en [X]. Propón tu solución sin conocer la del otro worker." |
| Worker B | Propone solución desde perspectiva Y | "Eres un experto en [Y]. Propón tu solución sin conocer la del otro worker." |
| Scrum Master | Facilita consenso si hay divergencia | "Eres un facilitador neutral. Tu objetivo es que A y B lleguen a un acuerdo, NO decidir tú." |
| Code Reviewer | Valida resultado final | "Revisa el resultado final contra el spec y las buenas prácticas." |

### Mecanismo técnico (Agent Teams)

| Ronda | Qué ocurre | Mecanismo |
|-------|-----------|-----------|
| 1 | A y B trabajan en paralelo | Spawn paralelo, task list independiente |
| 2 | A lee propuesta de B y responde | Iteración sobre task list compartida |
| 3 (cond.) | Scrum Master lanza sesión estructurada | Spawn con contexto de ambas propuestas |
| Final | code-reviewer valida resultado | Siempre |

---

## Guía de Coste de Tokens

### Tabla de impacto por configuración

| Configuración | Impacto | Motivo |
|--------------|---------|--------|
| 1 agente secuencial | base (referencia) | Sin paralelismo ni coordinación |
| N agentes → 1 receptor | +bajo | Spawn sin coordinación central |
| N agentes en paralelo | +medio | Contextos independientes simultáneos |
| N agentes + coordinación | +alto | Coordinación añade rondas de contexto |
| N agentes + debate + SM + reviewer | +muy alto | Máximo: paralelo + iteración + facilitación + review |

### Cómo usar esta guía

Tras cada decisión del usuario en el Team Builder, mostrar el indicador de impacto correspondiente:

```
💰 Impacto estimado: +[nivel]
Motivo: [descripción de la configuración elegida]
```
