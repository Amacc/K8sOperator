. $PSScriptRoot\bootstrap.ps1
$jeeves = [Bot]@{
    Spec=[BotSpec]@{
        Name="Jeeves"
        SlackEndpoint="https://something"
    }
}
$params = @{
    Namespace = "default"
    CRD = ($jeeves)
    Handler = ([BotHandler]::new())
}
$controller = Initialize-K8sOperatorController @params
