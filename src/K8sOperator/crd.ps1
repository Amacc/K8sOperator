using namespace ContainerSolutions.OperatorSDK

# . $PSScriptRoot\setup.ps1

Function New-CRDTemplate {
    param(
        # [BaseC]$test
    )
}

Function Out-Yaml {
    param(
        [Parameter(ValueFromPipeline)]
        [BaseCrd]$crd
    )
    process {
        ($crd |
            # Select-Object apiVersion, kind, metadata, spec |
            ForEach-Object {
                [PSCustomObject]@{
                    apiVersion=$_.ApiVersion
                    kind= $_.Kind
                    metadata= $_.Metadata
                    spec= $_.Spec
                }
            } |
            convertto-json) `
                -replace '"','' `
                -replace '{','' `
                -replace '}','' `
                -replace ',',''
    }
    # $controller,
}
