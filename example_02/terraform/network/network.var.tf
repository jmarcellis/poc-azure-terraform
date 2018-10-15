variable "azure_tenant_id" {}
variable "azure_subscription_id" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "allow_source_ip" {}
variable "azure_location" {
  default = "EastUS"
}
variable "azure_environment_prefix" {
  default = "tst"
}
variable "azure_network_resource_group_base_name" {
  default = "common-network"
}
