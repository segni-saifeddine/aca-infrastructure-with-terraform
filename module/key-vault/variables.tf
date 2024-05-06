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
variable "tenant_id" {
  description = "(Required) The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
  type        = string
}

variable "sku_name" {
  description = "(Optionnal) The Name of the SKU used for this Key Vault. Possible values are standard and premium."
  type        = string
  default     = "standard"
}
variable "ip_rules" {
  description = "(Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault."
  type        = list(string)
  default     = []
}

variable "virtual_network_subnet_ids" {
  description = "(Optional) A list of resource ids for subnets."
  type        = list(string)
  default     = []
}
variable "subnet_id" {
  description = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created."
  type        = string
}



variable "virtual_network_id" {
  description = "(Required) The ID of the Virtual Network that should be linked to the DNS Zone. Changing this forces a new resource to be created."
  type        = string
}

variable "object_id" {
  type = string
  description = " ID of object id that will have access poliyc to the aks"
}