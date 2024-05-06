resource "azurerm_user_assigned_identity" "aca" {
  name                = "aca_identity"
  resource_group_name = var.rg_name
  location            = var.location
}
