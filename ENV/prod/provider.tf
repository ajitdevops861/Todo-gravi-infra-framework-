terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "shivi109"
  #   storage_account_name = "devshivi119"
  #   container_name       = "tfstate"
  #   key                  = "dev2.terraform.tfstate"

  #   use_azuread_auth = true
  # }



}

provider "azurerm" {
  # Configuration options

  features {

  }

  subscription_id = "3d1ce785-6c4d-4565-bb5e-3b46939260a6"
}