<#
    .Synopsis
        Generic Base CRD used for testing
#>
using namespace ContainerSolutions.OperatorSDK

class GenericBaseCRD: BaseCRD {
    GenericBaseCRD(
        [String] $ApiGroup,
        [String] $Version,
        [String] $Plural,
        [String] $Singular,
        [String] $Kind = "GenericBaseCRD"
    ) : base(
        [String] $ApiGroup,
        [String] $Version,
        [String] $Plural,
        [String] $Singular
    ){
        $this.Kind = $Kind
	}
}
