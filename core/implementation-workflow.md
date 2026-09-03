# Shared implementation workflow

This is the repository-wide operating policy for coding agents. Product truth
comes from the target repository's configured `truth_sources`.

## Resolve

- `implement ticket NN` resolves exactly one configured tracker file.
- Ambiguous resolution stops and names the matching files.
- Never infer completion from chat history.

## Before editing

1. Inspect Git status and preserve unrelated changes.
2. Read configured truth sources and the complete ticket.
3. Trace the existing flow and reuse existing code.
4. Classify acceptance items as implementation, external blocker, or debt.

## Delivery

Implement the ticket, run configured checks, run the installed semantic
`code-review` integration from `HEAD`, fix only P0/P1 findings, rerun checks,
then run `completion-gate.ps1`.

P0/P1 are blocking. P2 is concrete actionable debt. P3 is discarded.

Record blockers and evidence in the ticket. Cross-cutting debt becomes a new
tracker item; ticket-only debt stays in the ticket. Do not create parallel
trackers.

## Outcomes

- `DONE`: all executable acceptance items and the gate pass.
- `closed-partial`: only externally blocked acceptance items remain, recorded
  with the required validation.
- `blocked`: a functional failure, P0/P1, decision, or mandatory work remains.

`DONE` and `closed-partial` may be committed automatically after selective
staging. `blocked` is never committed as a conclusion. Never push.
