terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }
backend "azurerm" {
  resource_group_name = "shivi109"
  storage_account_name = "devshivi110"
  container_name = "tfstate"
  key = "dev2.terraform.tfstate"
  
  use_azuread_auth = true
}



}

provider "azurerm" {
  # Configuration options

  features {

  }

  subscription_id = "e5efa2cd-02a5-4c7b-be99-6e2ae6d5feac"
}