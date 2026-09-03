# Autonomous Engineering Harness

Reusable engineering workflow for Codex and Claude Code.

## Quick start

```powershell
./bootstrap/bootstrap.ps1 -TargetRepo C:/path/to/repo -DryRun
./bootstrap/bootstrap.ps1 -TargetRepo C:/path/to/repo
./doctor/doctor.ps1 -TargetRepo C:/path/to/repo
```

The harness installs only its own `.engineering` files and never overwrites
existing `AGENTS.md` or `CLAUDE.md`. It does not include product specs,
ADRs, Grill, or IDEA processing.
