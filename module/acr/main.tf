#--------------------------------------------------------------------------------------------------
                        #-------------------  Container Registry Configuration-------------------#
#-------------------------------------------------------------------------------------------------

resource "azurerm_container_registry" "acr" {
  name                = "AcaAcr"
  resource_group_name = var.rg_name
  location            = var.location
  tags = {
    environment = var.env_name
    stack       = "aca"
  }

  sku = "Premium"

  admin_enabled                 = false
  public_network_access_enabled = false
  network_rule_bypass_option    = "AzureServices"
}
#--------- Private endpoint for the acr-----------------------------
resource "azurerm_private_dns_zone" "acr" {
  name                = "privatelink.azurecr.io"
  resource_group_name = azurerm_container_registry.acr.resource_group_name
}

resource "azurerm_private_endpoint" "acr" {

  name                = "inf-ep-acr"
  location            = azurerm_container_registry.acr.location
  resource_group_name = azurerm_container_registry.acr.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "acr-privateserviceconnection"
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "privatelink.azurecr.io"
    private_dns_zone_ids = [azurerm_private_dns_zone.acr.id]
  }

}

resource "azurerm_private_dns_zone_virtual_network_link" "acr" {
  name                  = "private-dns-acr-link"
  resource_group_name   = azurerm_container_registry.acr.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.acr.name
  virtual_network_id    = var.virtual_network_id

}

resource "azurerm_role_assignment" "containerRegistryPullRoleAssignment" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = var.aca_id
}