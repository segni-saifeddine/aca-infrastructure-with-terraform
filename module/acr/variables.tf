variable "location" {
  default = "France Central"
  type = string
  description = "(Required) The name of the resource group in which the Container App Environment is to be created. Changing this forces a new resource to be created."
}
variable "env_name" {
  default = "dev"
  type = string
  description = "(Required) The name of the environment in which the Container App Environment is to be created. Changing this forces a new resource to be created.possible value are : dev or prd"
}
variable "rg_name" {
  description = "(Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created."
  type        = string
}
variable "subnet_id" {
  description = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created."
  type        = string
}



variable "virtual_network_id" {
  description = "(Required) The ID of the Virtual Network that should be linked to the DNS Zone. Changing this forces a new resource to be created."
  type        = string
}

variable "aca_id" {
  description = "the identity that manage the azure container app"
}
