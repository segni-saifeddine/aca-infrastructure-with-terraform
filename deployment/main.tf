data "azurerm_client_config" "current" {}

module "rg" {
  source   = "../module/rg"
  location = var.location
  env_name = "prd"
}

module "network" {
  source             = "../module/network"
  rg_name            = module.rg.rg_name
  location           = module.rg.rg_location
  vnet_address_space = var.vnet_address_space
  env_name           = "prd"
  subnet             = var.subnet
  nsg                = var.nsg
}

module "identity" {
  source   = "../module/managed-identity"
  rg_name  = module.rg.rg_name
  location = module.rg.rg_location
}

module "akv" {
  source                     = "../module/key-vault"
  rg_name                    = module.rg.rg_name
  location                   = module.rg.rg_location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = var.vault_sku
  subnet_id                  = module.network.endpoint_subnet_id
  virtual_network_id         = module.network.vnet_id
  object_id                  = module.identity.aca_id
  ip_rules                   = var.ip_rules
  virtual_network_subnet_ids = var.virtual_network_subnet_ids
  env_name                   = "prd"
}

module "acr" {
  source             = "../module/acr"
  rg_name            = module.rg.rg_name
  location           = module.rg.rg_location
  subnet_id          = module.network.endpoint_subnet_id
  virtual_network_id = module.network.vnet_id
  env_name           = "prd"
  aca_id             = module.identity.aca_id
}

module "aca" {
  source        = "../module/aca"
  rg_name       = module.rg.rg_name
  location      = module.rg.rg_location
  env_name      = "prd"
  aca_subnet_id = module.network.aca_subnet_id
  app_name      = var.app_name
  enable_int_lb = true
  identity_ids  = [module.identity.aca_id]
}