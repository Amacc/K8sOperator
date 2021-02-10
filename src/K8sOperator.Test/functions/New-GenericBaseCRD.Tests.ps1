Describe "BaseCRD Type" {
    BeforeAll {
        Import-Module $PSScriptRoot\..\..\K8sOperator\K8sOperator.psd1
    }
    AfterAll  {
        Remove-Module "K8sOperator"
    }
    It "Can be called without error" {
        $myCRD = New-GenericBaseCRD
    }

    It "Can be created with custom properties" {
        $params = @{
            Kind= "MyKind"
            Group= "foo.bar.com"
            Version= "v1"
            Singular="me"
            Plural="mes"
        }
        $myCRD = New-GenericBaseCRD @params
        $params.GetEnumerator() |
            ForEach-Object {
                $myCRD."$($_.Name)" | Should -be $_.Value
            }
    }
}
