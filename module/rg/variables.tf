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