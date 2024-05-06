output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}
output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "endpoint_subnet_id" {
    value = azurerm_subnet.subnets["endpoint"].id
}

output "aca_subnet_id" {
    value = azurerm_subnet.subnets["aca"].id
}
output "gateway_subnet_id" {
    value = azurerm_subnet.subnets["gateway"].id
}