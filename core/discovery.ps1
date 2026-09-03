[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Idea,
  [Parameter(Mandatory)][string]$Provider,[string]$OutputRoot
)
$ErrorActionPreference = 'Stop'
$ideaPath=(Resolve-Path $Idea).Path;$root=if($OutputRoot){$OutputRoot}else{Join-Path (Split-Path $ideaPath -Parent) '.engineering'}
if (!(Test-Path -LiteralPath $Provider -PathType Leaf)) { throw "Discovery provider not found: $Provider" }; . (Resolve-Path $Provider).Path
$result=Invoke-Discovery -Idea $ideaPath -OutputRoot $root;New-Item -ItemType Directory -Force $root|Out-Null
$state=[pscustomobject]@{Idea=$ideaPath;Project=$result.Project;Status=$result.Status;DeliveryAllowed=[bool]$result.DeliveryAllowed;Artifacts=$result.Artifacts;ValidatedAt=(Get-Date).ToUniversalTime().ToString('o')}
$state|ConvertTo-Json -Depth 8|Set-Content -Encoding UTF8 (Join-Path $root 'discovery-state.json');$state|ConvertTo-Json -Compress;if(!$state.DeliveryAllowed){exit 2}
