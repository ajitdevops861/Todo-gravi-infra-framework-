terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.52.0"
    }
  }
}

provider "azurerm" {
  # Configuration options

  features {

  }

  subscription_id = "4384363b-269f-4e6b-bb52-58030d963c7f"
}