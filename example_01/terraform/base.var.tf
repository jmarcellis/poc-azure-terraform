variable "azure_tenant_id" {}
variable "azure_subscription_id" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "allow_source_ip" {}
variable "azure_base_name" {
  default = "smc-test"
}
variable "azure_location" {
  default = "EastUS"
}
variable "azure_environment" {
  default = "test"
}
variable "azure_vm_image_publisher_name" {
  default = "MicrosoftWindowsServer"
}
variable "azure_vm_image_offer_name" {
  default = "WindowsServer"
}
variable "azure_vm_image_sku_name" {
  default = "2016-Datacenter"
}
variable "azure_vm_image_version_name" {
  default = "latest"
}
variable "azure_vm_size" {
  default = "Standard_DS2_v2"
}
variable "azure_vm_admin_username" {
  default = "scolligan"
}
variable "azure_vm_admin_password" {
  default = "tR1ckyP@ssw0rd"
}