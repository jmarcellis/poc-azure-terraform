# configure provider connection info
provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
}

# resource group
resource "azurerm_resource_group" "network-rg" {
  name     = "${var.azure_environment_prefix}-${var.azure_network_resource_group_base_name}-rg"
  location = "${var.azure_location}"

  tags {
    environment = "${var.azure_environment_prefix}"
  }
}

# network security group
resource "azurerm_network_security_group" "common-nsg" {
  name                = "${var.azure_environment_prefix}-${var.azure_network_resource_group_base_name}-nsg"
  location            = "${var.azure_location}"
  resource_group_name = "${azurerm_resource_group.network-rg.name}"

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
    environment = "${var.azure_environment_prefix}"
  }
}

# virtual network
resource "azurerm_virtual_network" "common-vnet" {
  name                = "${var.azure_environment_prefix}-${var.azure_network_resource_group_base_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.azure_location}"
  resource_group_name = "${azurerm_resource_group.network-rg.name}"

  tags {
    environment = "${var.azure_environment_prefix}"
  }
}

# subnet
resource "azurerm_subnet" "common-subnet" {
  name                      = "${var.azure_environment_prefix}-${var.azure_network_resource_group_base_name}-subnet"
  resource_group_name       = "${azurerm_resource_group.network-rg.name}"
  virtual_network_name      = "${azurerm_virtual_network.common-vnet.name}"
  address_prefix            = "10.0.2.0/24"
  network_security_group_id = "${azurerm_network_security_group.common-nsg.id}"
}
