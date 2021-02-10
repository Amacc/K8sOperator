using namespace YamlDotNet.Serialization;
using namespace YamlDotNet.Serialization.NamingConventions;

Function Convert-CRDToYaml {
    <#
        .Synopsis
            Limited yaml serializer
    #>
    param(
        [Parameter(ValueFromPipeline, Mandatory)]
        [BaseCRD] $InputObject,

        [INamingConvention]
        $NamingConvention = [CamelCaseNamingConvention]::Instance
    )
    process{
        Write-Verbose "Using $Namingconvention"

        # For some reason this requires conversion to a hashtable ??
        $props = @{}
        $exportedProperties = @(
            "apiVersion",
            "kind",
            "metadata",
            "spec"
        )
        $InputObject                                    |
            Select-Object $exportedProperties           |
            ForEach-Object { $_.psobject.properties }   |
            ForEach-Object { $props[$_.Name] = $_.Value }

        $serializer = [SerializerBuilder]::new(
            ).WithNamingConvention($NamingConvention).Build()
        return $serializer.Serialize($props);
    }
}

Export-ModuleMember -Function Convert-CRDToYaml
