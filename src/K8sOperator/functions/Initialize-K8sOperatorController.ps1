using namespace ContainerSolutions.OperatorSDK
# Config Logger for bot using controller
# generic method
# [Controller[Bot]]::ConfigLogger()

Function Initialize-K8sOperatorController {
    param(
        [String] $Namespace,
        [BaseCRD] $CRD,
        $Handler
    )
    $crdTypeName = $CRD.GetType().Name

    $controller = New-Object `
        -TypeName Controller[$crdTypeName] `
        -ArgumentList $crd, $handler, $Namespace

    return $controller
    # return $controller, $controller.SatrtAsync();
}

Export-ModuleMember -Function Initialize-K8sOperatorController
