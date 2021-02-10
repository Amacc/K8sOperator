
Describe "Operator" {
    BeforeAll {
        Import-Module $PSScriptRoot\..\K8sOperator\K8sOperator.psd1
        Import-Module $PSScriptRoot\..\BotOperator\BotOperator.psd1
    }
    AfterAll  {
        Remove-Module "BotOperator"
        Remove-Module "K8sOperator"
    }
    Context "Bot Handler" {
        It "Can be created" {
            [Bot]@{
                Spec=[BotSpec]@{
                    Name="Jeeves"
                    SlackEndpoint="https://something"
                }
            }
        }
    }

    Context "Bot Handler" {
        BeforeAll {
            Mock Write-Host {}
        }
        It "Can be created" {
            [BotHandler]::new()
        }

        It "Can handle On Added events" {
            $jeeves = [Bot]@{
                Spec=[BotSpec]@{
                    Name="Jeeves"
                    SlackEndpoint="https://something"
                }
            }
            $onAdded = [BotHandler]::new().OnAdded($null,$jeeves).GetAwaiter().GetResult()
            # Assert-MockCalled Write-Host -ParameterFilter { $_ -eq "Jeeves" }
        }

        # It "Can handle On Added events" {
        #     $jeeves = [Bot]@{
        #         Spec=[BotSpec]@{
        #             Name="Jeeves"
        #             SlackEndpoint="https://something"
        #         }
        #     }
        #     $onAdded = [BotHandler]::new().OnAdded($null,$jeeves).GetAwaiter().GetResult()
        #     # Assert-MockCalled Write-Host -ParameterFilter { $_ -eq "Jeeves" }
        # }
    }
}
# $t, $ttask = Start-K8sOperator -Namespace "default" -CRD ($jeeves) -Handler ([BotHandler]::new())
