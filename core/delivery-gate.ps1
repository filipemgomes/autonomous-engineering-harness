[CmdletBinding()]param([Parameter(Mandatory)][string]$Repo)
$state=Join-Path (Resolve-Path $Repo) '.engineering\discovery-state.json';if(!(Test-Path $state)){throw 'DELIVERY BLOCKED: no discovery state'};$s=Get-Content -Raw $state|ConvertFrom-Json;if($s.Status -ne 'READY' -or $s.DeliveryAllowed -ne $true){throw 'DELIVERY BLOCKED: project is not READY'};'DELIVERY ALLOWED'
