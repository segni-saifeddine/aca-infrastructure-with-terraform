#--------------------------------------------------------------------------------------------------
                        #-------------------  Azure Key Vault Configuration-------------------#
#--------------------------------------------------------------------------------------------------

resource "azurerm_key_vault" "keyvault" {
  name                          = "aca-vault"
  location                      = var.location
  resource_group_name           = var.rg_name
  tenant_id                     = var.tenant_id
  soft_delete_retention_days    = 14
  sku_name                      = var.sku_name
  enable_rbac_authorization     = true
  public_network_access_enabled = true
  purge_protection_enabled      = true

    tags = {
    environment = var.env_name
    stack       = "aca"
  }

  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = (var.ip_rules == [] || var.ip_rules == null)? null : var.ip_rules
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }
}

#--------- Manage AKV access policies ----------------------------
resource "azurerm_key_vault_access_policy" "vault" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id               = var.tenant_id
  object_id               = var.object_id
  key_permissions         = ["Get", "List"]
  secret_permissions      =["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = ["Get", "List"]
}

#--------- Private endpoint for akv-----------------------------

resource "azurerm_private_endpoint" "keyvault" {
  name                = "pep-aca"
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "keyvault-privateserviceconnection"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "privatelink.vaultcore.azure.net"
    private_dns_zone_ids = [azurerm_private_dns_zone.keyvault.id]
  }
}

resource "azurerm_private_dns_zone" "keyvault" {
  name                = "privatelink.vault.core.windows.net"
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "keyvault" {
  name                  = "privatedns-keyvault-link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.keyvault.name
  virtual_network_id    = var.virtual_network_id

}
