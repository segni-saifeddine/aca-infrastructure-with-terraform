#--------------------------------------------------------------------------------------------------
                        #-------------------  Resource Group Configuration -------------------#
#--------------------------------------------------------------------------------------------------

resource "azurerm_resource_group" "aca" {
  name     = "rg-aca"
  location = var.location
  tags = {
    environment = var.env_name
    stack       = "aca"
  }
}