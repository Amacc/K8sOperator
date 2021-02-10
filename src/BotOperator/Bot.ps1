using namespace ContainerSolutions.OperatorSDK
using namespace KubernetesClient
using namespace System.Threading.Tasks

class Bot: BaseCRD {
    Bot() : base("beta.amacc.github.com", "v1", "bots", "bot"){
        $this.Kind = "Bot"
	}

    [BotSpec]$Spec = [BotSpec]::new()
}

class BotSpec {
    [String]$Name
    [String]$SlackEndpoint
}

# class BotHandler{
class BotHandler: IOperationHandler[Bot] {
    [Task]
    OnAdded([k8s.Kubernetes]$k8s, [Bot]$Bot){
        Write-Host $Bot.Spec.Name
        return [Task]::CompletedTask
    }

    [Task]
    OnDeleted([k8s.Kubernetes]$k8s, [Bot]$Bot){
        return [Task]::CompletedTask
    }
    [Task]
    OnUpdated([k8s.Kubernetes]$k8s, [Bot]$Bot){
        return [Task]::CompletedTask
    }
    [Task]
    OnBookmarked([k8s.Kubernetes]$k8s, [Bot]$Bot){
        return [Task]::CompletedTask
    }
    [Task]
    OnError([k8s.Kubernetes]$k8s, [Bot]$Bot){
        return [Task]::CompletedTask
    }
    [Task]
    CheckCurrentState([k8s.Kubernetes]$k8s){
        return [Task]::CompletedTask
    }
}

