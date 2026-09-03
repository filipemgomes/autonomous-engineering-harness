[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Ticket,
  [Parameter(Mandatory)][string]$Repo,
  [switch]$ConfirmScope,
  [switch]$ConfirmBlockersRecorded,
  [switch]$ConfirmDebtRecorded,
  [switch]$ConfirmSemanticReview
)
$ErrorActionPreference='Stop'; Set-Location $Repo
$fail=@(); $partial=@()
if(!$ConfirmScope){$fail+='Scope review was not confirmed.'}
if(!$ConfirmBlockersRecorded){$fail+='Blocker review was not confirmed.'}
if(!$ConfirmDebtRecorded){$fail+='Technical-debt review was not confirmed.'}
if(!$ConfirmSemanticReview){$fail+='Semantic code review was not confirmed.'}
$path=if(Test-Path -LiteralPath $Ticket -PathType Leaf){$Ticket}else{@(Get-ChildItem .engineering\issues -Recurse -File -Filter "$Ticket-*.md")}
if($path -is [array]){if($path.Count -ne 1){$fail+="Ticket '$Ticket' resolved to $($path.Count) files."}else{$path=$path[0].FullName}}
if(Test-Path -LiteralPath $path -PathType Leaf){$text=Get-Content -Raw -Encoding UTF8 $path;$open=@($text -split "`r?`n"|Where-Object{$_ -match '^- \[ \]'});$partialAllowed=$text -match '(?im)^\*\*Status:\*\*\s*closed-partial\s*$';if($open.Count){if($partialAllowed -and $text -match '(?is)external|environmental|non-executable'){$partial+=$open}else{$fail+="Ticket has $($open.Count) open acceptance criteria."}}}
if($fail.Count){'COMPLETION GATE: FAIL';$fail;exit 1}
if($partial.Count){'COMPLETION GATE: PARTIAL';$partial;exit 2}
'COMPLETION GATE: PASS';exit 0
