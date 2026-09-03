[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$sandbox = Join-Path ([IO.Path]::GetTempPath()) ('harness-empty-' + [guid]::NewGuid())
try {
    New-Item -ItemType Directory -Path $sandbox | Out-Null
    & (Join-Path $root 'bootstrap\bootstrap.ps1') -TargetRepo $sandbox | Out-Null

    $idea = 'quero criar um app para organizar estudos de concurso...'
    foreach ($adapter in @('AGENTS.md', 'CLAUDE.md')) {
        $text = Get-Content -Raw (Join-Path $sandbox $adapter)
        $required = @(
            'discovery-state\.json', '(?i)not exactly `READY`', '(?i)IDEA',
            '(?i)providers[\\/]grill\.ps1', '(?i)do not propose a solution',
            '(?i)required', '(?i)CONSTITUTION', '(?i)ADR', '(?i)spec',
            '(?i)plan', '(?i)ticket'
        )
        if ($required | Where-Object { $text -notmatch $_ }) {
            throw "Acceptance failed: $adapter does not enforce implicit Discovery."
        }
    }

    try { $gate = & (Join-Path $sandbox '.engineering\delivery-gate.ps1') -Repo $sandbox 2>&1 }
    catch { $gate = $_.Exception.Message }
    if ($LASTEXITCODE -eq 0 -or (($gate -join "`n") -notmatch 'BLOCKED')) {
        throw 'Acceptance failed: empty repo can pass Delivery.'
    }

    "PASS: '$idea' is an IDEA and cannot reach Delivery before READY Discovery."
}
finally {
    if (Test-Path -LiteralPath $sandbox) { Remove-Item -LiteralPath $sandbox -Recurse -Force }
}
