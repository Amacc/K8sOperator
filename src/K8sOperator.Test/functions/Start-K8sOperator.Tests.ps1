Describe "Start-K8sOperator Commandlet" {
    BeforeAll {
        Import-Module $PSScriptRoot\..\..\K8sOperator\K8sOperator.psd1
    }
    AfterAll  {
        Remove-Module "K8sOperator"
    }
    It "Doesnt Error" {
        $myCRD = New-GenericBaseCRD
        Start-K8sOperator -CRD $myCRD
    }
}
