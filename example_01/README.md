# Example 01 - Provision VM

#### initialize environment
```
# initialize environment variables
Initialize-TerraformEnvironment.ps1 -Azure -TenantID '<azure_tenant_id>' -SubscriptionID '<azure_subscription_id>' -ClientID '<azure_client_id>' -ClientSecret '<azure_client_secret>'
```

#### provision vm and related resources
```
# change into terraform directory where configuration files exist
cd .\terraform

# initialize terraform in current directory
terraform init

# create resources
terraform apply
```

#### de-provision vm and related resources
```
# remove resources
terraform destroy
```
