terraform {
  required_version = ">=1.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.59.0"
    }
  }
  #backend "azurerm" {}
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}
