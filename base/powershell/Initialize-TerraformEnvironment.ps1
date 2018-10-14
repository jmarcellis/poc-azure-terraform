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
    [string]$ClientSecret
)

begin {
  $ErrorActionPreference = "Stop"

  # set azure terraform environment variables
  if ($Azure) {
    Write-Verbose ("Setting Environment Variable `"{0}`" = `"{1}`"." -f 'TF_VAR_AzureTenantID', $TenantID)
    $env:TF_VAR_AzureTenantID = $TenantID
    Write-Verbose ("Setting Environment Variable `"{0}`" = `"{1}`"." -f 'TF_VAR_AzureSubscriptionID', $SubscriptionID)
    $env:TF_VAR_AzureSubscriptionID = $SubscriptionID
    Write-Verbose ("Setting Environment Variable `"{0}`" = `"{1}`"." -f 'TF_VAR_AzureClientID', $ClientID)
    $env:TF_VAR_AzureClientID = $ClientID
    Write-Verbose ("Setting Environment Variable `"{0}`" = `"{1}`"." -f 'TF_VAR_AzureClientSecret', $ClientSecret)
    $env:TF_VAR_AzureClientSecret = $ClientSecret  
  }
}

process {
}

end {
}