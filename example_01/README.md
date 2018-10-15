# Example 01 - Provision a VM on Azure

#### initialize environment
```
# initialize environment variables
Initialize-TerraformEnvironment.ps1 -Azure -TenantID '<azure_tenant_id>' -SubscriptionID '<azure_subscription_id>' -ClientID '<azure_client_id>' -ClientSecret '<azure_client_secret>'

# change into terraform directory where configuration files exist
cd .\terraform

# initialize terraform in current directory
terraform init
```

#### provision vm and related resources
```
terraform apply
```

#### de-provision vm and related resources
```
terraform destroy
```
