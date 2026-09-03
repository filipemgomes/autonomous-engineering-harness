# Local tracker contract

The tracker is a configured directory of Markdown issues. Each issue has a
stable numeric prefix, a status field, acceptance checkboxes, evidence,
blockers, and debt. The harness resolves a ticket only when exactly one file
matches the configured pattern.

The tracker is local by default. No remote issue lookup or invented issue data
is allowed.
