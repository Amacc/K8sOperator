remove-module k8soperator -ea SilentlyContinue
Import-Module .\src\K8sOperator\K8sOperator.psd1

Remove-Module BotOperator -ea SilentlyContinue
Import-Module .\src\BotOperator\BotOperator.psd1
