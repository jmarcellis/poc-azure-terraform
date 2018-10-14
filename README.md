# poc-azure-terraform

## Workstation Setup

##### install an operating system
```
# wait, how are you reading this?
```

##### install package management - chocolatey
```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

##### install source control client - git
```
choco upgrade git.install
```

##### install development environment - vscode
```
# install vscode editor
choco upgrade vscode

# install vscode powershell extension
choco upgrade vscode-powershell

# install vscode terraform extension
code --install-extension mauve.terraform
```

##### install provisioning tool - terraform
```
choco upgrade terraform
```

## Azure Setup
Create an Azure Service Principal (if you don't already have one defined in your subscription) following the steps here:

https://www.terraform.io/docs/providers/azurerm/authenticating_via_service_principal.html

Record the values that are returned for `appId` (client_id), `password` (client_secret), and `tenant` (tenant_id) for use in the examples that follow.