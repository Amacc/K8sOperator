# K8s Powershell operator

This is mostly a proof of concept more or less to prove I can more than anything.

So what I want to acheive is some sort of suite of factory methods that lets an
administrator write some powershell code and then mount that into a container
with this module and can be deployed into a kubernetes cluster as a controller.

First build a CRD or inherit from BaseCRD as shown in the bot example
then build a controller, you can do this from scratch but a helper has been
created and can be used to help with this. There is a [script](bin/buildController.ps1)
in bin that can be sourced that will load up a controller.

```powershell
. .\bin\buildController.ps1
```

This controller
can then be piped into Start-K8sController.

```powershell
$controller | Start-K8sOperator
```

---
> **Note** that this **WILL** start a task and remove the ability to cancel out
>   with control c, and i am still looking for a better implementation on it
>   so be prepared to kill the terminal/container/vscode.
>   VS Code hangs when I kill the tab. idk whats up youve been warned.
---

# Notes

Nuget packages are defined in the operator.fsproj.

Why an fsproj file vs csproj etc.? cause i can 🤷

