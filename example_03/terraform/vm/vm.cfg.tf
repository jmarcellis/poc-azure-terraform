# configure provider connection info
provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

# resource group
resource "azurerm_resource_group" "base-rg" {
  name     = "${var.azure_base_name}-rg"
  location = "${var.azure_location}"

  tags {
    environment = "${var.azure_environment}"
  }
}

# public ip address
resource "azurerm_public_ip" "base-pubip" {
  name                         = "${var.azure_base_name}-pubip"
  location                     = "${var.azure_location}"
  resource_group_name          = "${azurerm_resource_group.base-rg.name}"
  public_ip_address_allocation = "dynamic"

  tags {
    environment = "${var.azure_environment}"
  }
}

# nic
resource "azurerm_network_interface" "base-nic" {
  name                = "${var.azure_base_name}-nic"
  location            = "${var.azure_location}"
  resource_group_name = "${azurerm_resource_group.base-rg.name}"

  ip_configuration {
    name                          = "${var.azure_base_name}-ipconfig"
    subnet_id                     = "/subscriptions/${var.common_network_subscription_id}/resourceGroups/${var.common_network_resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.common_network_vnet_name}/subnets/${var.common_network_subnet_name}"
    private_ip_address_allocation = "static"
    private_ip_address            = "10.0.2.55"
    public_ip_address_id          = "${azurerm_public_ip.base-pubip.id}"
  }

  tags {
    environment = "${var.azure_environment}"
  }
}

# vm
resource "azurerm_virtual_machine" "base-vm" {
  name                             = "vmtest"
  location                         = "${var.azure_location}"
  resource_group_name              = "${azurerm_resource_group.base-rg.name}"
  network_interface_ids            = ["${azurerm_network_interface.base-nic.id}"]
  vm_size                          = "${var.azure_vm_size}"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "${var.azure_vm_image_publisher_name}"
    offer     = "${var.azure_vm_image_offer_name}"
    sku       = "${var.azure_vm_image_sku_name}"
    version   = "${var.azure_vm_image_version_name}"
  }

  storage_os_disk {
    name              = "${var.azure_base_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "vmtest"
    admin_username = "${var.azure_vm_admin_username}"
    admin_password = "${var.azure_vm_admin_password}"
  }

  os_profile_windows_config {
    provision_vm_agent = true
    timezone           = "Central Standard Time"
  }

  tags {
    environment = "${var.azure_environment}"
  }
}
