[CmdletBinding()]
param(
    $Module = "K8sOperator"
)

. $PSScriptRoot\utils.ps1

$manifest = Import-PowerShellDataFile .\src\$Module\$Module.psd1
$assets = get-content -Raw .\obj\project.assets.json | convertfrom-json

Extract-DependenciesFromManifest -Manifest $manifest -Assets $assets
