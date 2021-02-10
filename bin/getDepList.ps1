param(
    $Module
)

$deps = & $PSScriptRoot\getDependencies.ps1

$deps |
    select -ExpandProperty DLLName -unique |
    Sort-Object
