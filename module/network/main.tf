#--------------------------------------------------------------------------------------------------
                        #-------------------  Network Resources Configuration-------------------#
#--------------------------------------------------------------------------------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-aca"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.vnet_address_space
  tags = {
    environment = var.env_name
    stack       = "aca"
  }
}

resource "azurerm_subnet" "subnets" {
for_each             = var.subnet
  name                 = "subnet-${each.value.name}"
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes

}

resource "azurerm_network_security_group" "nsgs" {
  for_each            = var.nsg
  name                = "nsg-${each.value.name}"
  resource_group_name = azurerm_virtual_network.vnet.resource_group_name
  location            = azurerm_virtual_network.vnet.location
  tags = {
    environment = var.env_name
    stack       = "aca"
  }

  dynamic "security_rule" {
    for_each = each.value.security_rules
    content {
      name                       = security_rule.key
      direction                  = security_rule.value.direction
      priority                   = security_rule.value.priority
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_address_prefixes    = security_rule.value.source_address_prefixes
      source_port_range          = security_rule.value.source_port_range
      destination_address_prefix = security_rule.value.destination_address_prefix
      destination_port_range     = security_rule.value.destination_port_range
    }

  }
}
resource "azurerm_subnet_network_security_group_association" "association" {
  for_each                  = var.nsg
  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.nsgs[each.key].id
}
