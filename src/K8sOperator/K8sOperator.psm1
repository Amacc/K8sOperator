

Get-ChildItem $PSScriptRoot\functions |
    ForEach-Object {
        . $_
    }
