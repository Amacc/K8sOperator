param(
    $BuildDirectory = ".\bin\Debug\net5.0\publish",
    $Module = "K8sOperator"
)

New-Item -ItemType Directory $BuildDirectory -Force | Out-Null

# dotnet publish --output $BuildDirectory
dotnet publish
    # -p:PublishSingleFile=true

# copy the DLL's into the module assembly directory
$moduleAssemblyDirectory = ".\src\$Module\assemblies"
New-Item -ItemType Directory $moduleAssemblyDirectory -Force | Out-Null
& $PSScriptRoot\getDepList.ps1              |
    Where-Object {$_ -notlike "System.*"}   | # Filter out system dlls
    ForEach-Object {".\$BuildDirectory\$_"} |
    Get-Item                                |
    ForEach-Object {
        Copy-Item -Path $_ -Destination $moduleAssemblyDirectory
    }


# Cleanup Build Generated Files
Remove-Item ./bin/Debug -Force -Recurse
