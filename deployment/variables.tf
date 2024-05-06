variable "location" {
  default = "francecentral"
}
#-----------------------Netwaok Variables-------------------------------
variable "vnet_address_space" {
  default = ["10.1.0.0/22"]
}

variable "subnet" {
  default = {
    endpoint = {
      name             = "endpoint"
      address_prefixes = ["10.1.2.0/27"]
    }
    aca = {
      name             = "aca"
      address_prefixes = ["10.1.0.0/23"]
    }
    gateway = {
      name             = "gateway"
      address_prefixes = ["10.1.3.0/24"]
    }
  }
}
variable "nsg" {
  default = {}
}

#-----------------------akv  Variables-------------------------------
variable "vault_sku" {
  default = "standard"
}

variable "ip_rules" {
default = []
}

variable "virtual_network_subnet_ids" {
default = []
}
variable "object" {
  default = {
    aca_identity = {
      object_id              = ""
      key_permission         = []
      secret_permission      = []
      certificate_permission = []
      storage_permission     = []
    }
  }
}
#-----------------------aca  Variables-------------------------------
variable "app_name" {
  default = {

    hello_world = {
      name           = "helloapp"
      revision_mode  = "Single"
      container_name = "simple-hello"
      image          = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu_request    = "0.25"
      memory_request = "0.5Gi"
      min_replicas   = 1
      max_replicas   = 10
    }
  }
}