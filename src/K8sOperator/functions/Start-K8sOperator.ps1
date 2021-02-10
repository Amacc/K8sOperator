using namespace ContainerSolutions.OperatorSDK

Function Start-K8sOperator {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact="High")]
    param(
        [Parameter(ValueFromPipeline)]
        $controller
    )

    if ($PSCmdlet.ShouldProcess(
        $controller.Kubernetes.BaseUri,
        'This will Start a listener that cannot be stopped... are you ready?'
    )) {
        $controller.SatrtAsync().GetAwaiter().GetResult()
    }
}

Export-ModuleMember -Function Start-K8sOperator
