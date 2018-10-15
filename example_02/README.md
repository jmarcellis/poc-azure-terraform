# Example 02 - Provision VM in Shared Network

#### initialize environment
```
# initialize environment variables
Initialize-TerraformEnvironment.ps1 -Azure -TenantID '<azure_tenant_id>' -SubscriptionID '<azure_subscription_id>' -ClientID '<azure_client_id>' -ClientSecret '<azure_client_secret>'
```

#### provision network resources
```
# change into terraform directory where configuration files exist
cd .\terraform\network

# initialize terraform in current directory
terraform init

# create resources
terraform apply
```

#### provision vm and related resources
```
# change into terraform directory where configuration files exist
cd .\terraform\vm

# initialize terraform in current directory
terraform init

# create resources
terraform apply
```

#### de-provision vm and related resources
```
# change into terraform directory where configuration files exist
cd .\terraform\vm

# remove resources
terraform destroy
```

#### de-provision network resources
```
# change into terraform directory where configuration files exist
cd .\terraform\network

# remove resources
terraform destroy
```
