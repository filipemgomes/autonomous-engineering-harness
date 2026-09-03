@.engineering/implementation-workflow.md

## Mandatory product entrypoint

Before answering any request to create, build, develop, or change a product,
check `.engineering/discovery-state.json`. If it is missing or its `Status` is
not exactly `READY` with `DeliveryAllowed: true`, treat the request as an
IDEA, even when the user asks for an app, MVP, architecture, stack, or code.

In that state do not propose a solution, MVP, stack, plan, or implementation.
Invoke `.engineering/discovery.ps1` using the configured
`.engineering/providers/grill.ps1` provider, with the user's natural-language
request as the IDEA, then validate that it produced the required
CONSTITUTION, ADR, spec, plan, and ticket artifacts and persisted a READY
discovery state. Do not ask the user to name Grill or run a script. Delivery
and implementation are allowed only after the state is READY.

Use the configured automatic semantic review and completion gate.
