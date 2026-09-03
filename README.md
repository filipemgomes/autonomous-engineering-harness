# Autonomous Engineering Harness

Reusable engineering workflow for Codex and Claude Code.

## Quick start

```powershell
./bootstrap/bootstrap.ps1 -TargetRepo C:/path/to/repo -DryRun
./bootstrap/bootstrap.ps1 -TargetRepo C:/path/to/repo
./doctor/doctor.ps1 -TargetRepo C:/path/to/repo
```

The harness installs only its own `.engineering` files and never overwrites
existing `AGENTS.md` or `CLAUDE.md`. Discovery is core-agnostic: the bundled
Grill provider reads an IDEA `Status` and the core permits Delivery only for
exactly `READY`.
