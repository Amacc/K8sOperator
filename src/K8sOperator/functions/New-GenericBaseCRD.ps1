# Import Base CRD Class
. $PSScriptRoot\..\types\BaseCrd.ps1

Function New-GenericBaseCRD {
    <#
        .Synopsis
            Creates a new Generic BaseCRD
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipelineByPropertyName)]
        [String] $Kind = "GenericBaseCRD",

        [Alias("ApiGroup")]
        [Parameter(ValueFromPipelineByPropertyName)]
        [String] $Group = "amacc.github.com",

        [Parameter(ValueFromPipelineByPropertyName)]
        [String] $Version = "v1/beta",

        [Parameter(ValueFromPipelineByPropertyName)]
        [String] $Singular = "basecrd",

        [Parameter(ValueFromPipelineByPropertyName)]
        [String] $Plural =  "basecrds",

        [Parameter(ValueFromPipelineByPropertyName)]
        [int] $ReconInterval = 5
    )
    process{
        $newParams = @{
            TypeName = "GenericBaseCRD"
            ArgumentList = $Group, $Version, $Plural, $Singular, $Kind

        }
        return New-Object @newParams
    }
}

Export-ModuleMember -Function New-GenericBaseCRD
