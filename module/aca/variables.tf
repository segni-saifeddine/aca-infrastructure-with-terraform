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

variable "aca_subnet_id" {
description = "The existing Subnet to use for the Container Apps Control Plane. Changing this forces a new resource to be created."
type = string
}
variable "enable_int_lb" {
type = bool
description = "Should the Container Environment operate in Internal Load Balancing Mode? Defaults to false. Changing this forces a new resource to be created."
}

variable "app_name" {
  type = map(object({
    name = string
    revision_mode = string
    container_name = string
    image = string
    cpu_request = string
    memory_request = string
    min_replicas = number
    max_replicas = number
  }))
  description = "lsit of applications to deploy"
}
variable "identity_ids" {
  description = " A list of one or more Resource IDs for User Assigned Managed identities to assign"
}