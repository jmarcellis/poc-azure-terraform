<#
  .SYNOPSIS
  Initializes an environment to allow terraform to authenticate to a cloud environment  

  .EXAMPLE
  Initialize-TerraformEnvironment -Azure -TenantID '<azure_tenant_id>' -SubscriptionID '<azure_subscription_id>' -ClientID '<azure_client_id>' -ClientSecret '<azure_client_secret>'
  # initialize environment for terraform to work with an azure subscription
#>
[CmdletBinding(SupportsShouldProcess = $true)]

param (
  [Parameter(ParameterSetName='aws', Mandatory=$false, ValueFromPipeline=$false, ValueFromPipelineByPropertyName=$false)]
    [switch]$AWS,
  [Parameter(ParameterSetName='azure', Mandatory=$false, ValueFromPipeline=$false, ValueFromPipelineByPropertyName=$false)]
    [switch]$Azure,
  [Parameter(ParameterSetName='azure',Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [string]$TenantID,
  [Parameter(ParameterSetName='azure',Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [string]$SubscriptionID,
  [Parameter(ParameterSetName='azure',Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [string]$ClientID,
  [Parameter(ParameterSetName='azure',Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [string]$ClientSecret,
  [Parameter(Mandatory=$false, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [string]$AllowSourceIP
)

begin {
  $ErrorActionPreference = "Stop"

  # set the value of allow source ip - prefer passed in value
  if ($PSBoundParameters.ContainsKey('AllowSourceIP')) {
    $localAllowSourceIP = $AllowSourceIP
  }
  else {
    $localAllowSourceIP = (Invoke-RestMethod -Uri 'http://ipinfo.io/json' -Verbose:$false | Select-Object -ExpandProperty 'ip')
  }

  # set general terraform environment variables
  Write-Verbose ("Setting Environment Variable `"{0}`" = `"{1}`"." -f 'TF_VAR_azure_tenant_id', $localAllowSourceIP)
  $env:TF_VAR_allow_source_ip = $localAllowSourceIP

  # set azure terraform environment variables
  if ($Azure) {
    Write-Verbose ("Setting Environment Variable `"{0}`" = `"{1}`"." -f 'TF_VAR_azure_tenant_id', $TenantID)
    $env:TF_VAR_azure_tenant_id = $TenantID
    Write-Verbose ("Setting Environment Variable `"{0}`" = `"{1}`"." -f 'TF_VAR_azure_subscription_id', $SubscriptionID)
    $env:TF_VAR_azure_subscription_id = $SubscriptionID
    Write-Verbose ("Setting Environment Variable `"{0}`" = `"{1}`"." -f 'TF_VAR_azure_client_id', $ClientID)
    $env:TF_VAR_azure_client_id = $ClientID
    Write-Verbose ("Setting Environment Variable `"{0}`" = `"{1}`"." -f 'TF_VAR_azure_client_secret', $ClientSecret)
    $env:TF_VAR_azure_client_secret = $ClientSecret  
  }
}

process {
}

end {
}