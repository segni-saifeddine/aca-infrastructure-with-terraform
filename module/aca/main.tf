#--------------------------------------------------------------------------------------------------
                        #-------------------  Azure Container apps Configuration-------------------#
#-------------------------------------------------------------------------------------------------

resource "azurerm_user_assigned_identity" "aca" {
  resource_group_name = var.rg_name
  location            = var.location
  name                = "aca-identity"
}

resource "azurerm_log_analytics_workspace" "aca" {
  name                = "aca-log-analytics-works"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "aca" {
  name                       = "aca-environment"
  location                   = var.location
  resource_group_name        = var.rg_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.aca.id
  infrastructure_subnet_id =    var.aca_subnet_id
  internal_load_balancer_enabled = var.enable_int_lb
    tags = {
    environment = var.env_name
    stack       = "aca"
  }
}

resource "azurerm_container_app" "aca" {
  for_each = var.app_name
  name                         = each.value.name
  container_app_environment_id = azurerm_container_app_environment.aca.id
  resource_group_name          = azurerm_container_app_environment.aca.resource_group_name
  revision_mode                = each.value.revision_mode
 identity {
   type         = "UserAssigned"
   identity_ids = var.identity_ids
 }
  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 80
    transport                  = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  template {
    container {
      name   = each.value.container_name
      image  = each.value.image
      cpu    = each.value.cpu_request
      memory = each.value.memory_request
    }
     min_replicas = each.value.min_replicas
    max_replicas = each.value.max_replicas
  }
}