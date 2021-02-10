Describe "Convert-CRDToYaml Type" {
    BeforeAll {
        $Module = "K8sOperator"
        Import-Module "$PSScriptRoot\..\..\$Module\$Module.psd1"
    }
    AfterAll  {
        Remove-Module "$Module"
    }

    Context "With a generic CRD" {
        BeforeAll {
            $myCRD = New-GenericBaseCRD
        }

        It "Can be created with custom properties" {
            $resultUnderTest = $myCRD | Convert-CRDToYaml
        }
    }
}
