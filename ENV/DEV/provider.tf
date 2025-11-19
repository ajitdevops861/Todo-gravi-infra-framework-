terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }
backend "azurerm" {
  resource_group_name = "shivi109"
  storage_account_name = "devshivi109"
  container_name = "tfstate"
  key = "dev1.terraform.tfstate"
  
  use_azuread_auth = true
}



}

provider "azurerm" {
  # Configuration options

  features {

  }

  subscription_id = "4384363b-269f-4e6b-bb52-58030d963c7f"
}