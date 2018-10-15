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

# network security group
resource "azurerm_network_security_group" "base-nsg" {
  name                = "${var.azure_base_name}-nsg"
  location            = "${var.azure_location}"
  resource_group_name = "${azurerm_resource_group.base-rg.name}"

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "${var.allow_source_ip}"
    destination_address_prefix = "*"
  }

  tags {
    environment = "${var.azure_environment}"
  }
}

# virtual network
resource "azurerm_virtual_network" "base-vnet" {
  name                = "${var.azure_base_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.azure_location}"
  resource_group_name = "${azurerm_resource_group.base-rg.name}"

  tags {
    environment = "${var.azure_environment}"
  }
}

# subnet
resource "azurerm_subnet" "base-subnet" {
  name                      = "${var.azure_base_name}-subnet"
  resource_group_name       = "${azurerm_resource_group.base-rg.name}"
  virtual_network_name      = "${azurerm_virtual_network.base-vnet.name}"
  address_prefix            = "10.0.2.0/24"
  network_security_group_id = "${azurerm_network_security_group.base-nsg.id}"
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
    subnet_id                     = "${azurerm_subnet.base-subnet.id}"
    private_ip_address_allocation = "dynamic"
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
