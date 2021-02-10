Function Build-DependencyTree {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $AssetJson,
        $Target = "net5.0",
        $Parent = $null,

        [Alias("Name")]
        [Parameter(ValueFromPipelineByPropertyName,ValueFromPipeline,Mandatory)]
        [String]$DependencyName,

        [Alias("Version")]
        [Parameter(ValueFromPipelineByPropertyName)]
        $DependencyVersion
    )
    process {
        if($DependencyVersion){
            $depKey = "$DependencyName/$DependencyVersion"
        } else {
            $depKey = $AssetJson.targets.$Target                    |
                Get-Member -MemberType NoteProperty                 |
                Where-Object { $_.Name -Like "$DependencyName/*"}   |
                Select-Object -ExpandProperty Name
            $DependencyVersion = ($depKey -split "/")[1]
        }

        Write-Verbose "Fetching $depKey"
        $asset = $AssetJson.targets.$Target.$depKey

        # If there is no runtime this is stdlib so return
        if(-not($asset.runtime)){return}

        Write-Verbose "Fetching Dependencies for $depKey"

        $dllName = (($asset.runtime             |
            Get-Member -MemberType NoteProperty |
            Select-Object -ExpandProperty Name) -split "/")[-1]

        # If the dll is _._ also std lib so return
        if($dllName -eq "_._"){return}

        #Yield self
        $self = [PSCustomObject]@{
            Name=$DependencyName
            Version=$DependencyVersion
            DLLName=$dllName
            Parent=$Parent
        }
        $self

        # Yield SubDependencies
        $buildSubObject = {
            [PSCustomObject]@{
                Name=$_.Name
                Version=$asset.dependencies."$($_.Name)"
            }
        }

        $hasDependencies = [bool]$asset.dependencies
        if($hasDependencies){
            $asset.dependencies                         |
                Get-Member -MemberType NoteProperty     |
                Foreach-Object $buildSubObject          |
                Build-DependencyTree -AssetJson:$AssetJson -Parent $self
        }
    }
}

Function Extract-DependenciesFromManifest {
    [CmdletBinding()]
    param(
        $Manifest,
        $Assets
    )
    process {
        $ProjectName = $Assets.project.restore.projectName
        Write-Verbose "Processing $ProjectName"
        Write-Verbose "$($Manifest.RequiredAssemblies)"

        $Manifest.PrivateData.PSData.ExternalAssemblyDependencies |
            Build-DependencyTree -AssetJson $Assets
    }
}
