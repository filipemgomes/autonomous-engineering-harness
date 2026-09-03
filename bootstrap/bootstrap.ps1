[CmdletBinding()]param([Parameter(Mandatory)][string]$TargetRepo,[switch]$DryRun)
$ErrorActionPreference='Stop';$root=Split-Path $PSScriptRoot -Parent;$target=(Resolve-Path $TargetRepo).Path
$map=@{
  'manifest.yaml'='.engineering\manifest.yaml'; 'core\implementation-workflow.md'='.engineering\implementation-workflow.md';
  'core\tracker-contract.md'='.engineering\tracker-contract.md'; 'core\completion-gate.ps1'='.engineering\completion-gate.ps1';
  'adapters\codex\AGENTS.md'='AGENTS.md'; 'adapters\claude-code\CLAUDE.md'='CLAUDE.md';
  'templates\issue.md'='.engineering\templates\issue.md'; 'templates\CONTEXT.md'='.engineering\templates\CONTEXT.md';
  'templates\spec.md'='.engineering\templates\spec.md'; 'templates\plan.md'='.engineering\templates\plan.md';
  'doctor\doctor.ps1'='.engineering\doctor.ps1'
  'core\discovery-contract.md'='.engineering\discovery-contract.md'; 'core\discovery.ps1'='.engineering\discovery.ps1'; 'core\delivery-gate.ps1'='.engineering\delivery-gate.ps1'; 'providers\grill.ps1'='.engineering\providers\grill.ps1'
}
foreach($f in $map.Keys){$dest=Join-Path $target $map[$f];if(Test-Path $dest){Write-Output "KEEP $dest"}else{Write-Output "CREATE $dest";if(!$DryRun){New-Item -ItemType Directory -Force (Split-Path $dest)|Out-Null;Copy-Item (Join-Path $root $f) $dest}}}
if($DryRun){Write-Output 'DRY-RUN: no files changed'}else{Write-Output 'BOOTSTRAP: complete'}
