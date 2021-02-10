Describe "Bot Operator -> K8s Operator" {
    It "Creates a controller of your crd" {
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
        $controller = Start-K8sOperator @params
    }
}
