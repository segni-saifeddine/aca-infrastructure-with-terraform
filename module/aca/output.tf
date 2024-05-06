output "identity_id" {
  value = azurerm_user_assigned_identity.aca.id
}

output "containerAppsEnvironmentName" {
  value = azurerm_container_app_environment.aca.name
}

output "containerAppsEnvironmentId" {
  value = azurerm_container_app_environment.aca.id
}

output "containerAppsEnvironmentDefaultDomain" {
  value = azurerm_container_app_environment.aca.default_domain
}

output "containerAppsEnvironmentLoadBalancerIP" {
  value = azurerm_container_app_environment.aca.static_ip_address
}