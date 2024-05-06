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

variable "vnet_address_space" {
  description = "(Required) The address space that is used the virtual network. You can supply more than one address space."
  type = list
  default = []
}

variable "subnet" {
  type = map(object({
    name = string
    address_prefixes = list(string)
  }))
}

variable "nsg" {
  description = "(Required) List of nsgs"
  type = map(object({
    name = string
    security_rules = map(object({
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefixes    = list(string)
      destination_address_prefix = string
    }))
  }))

}