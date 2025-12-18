terraform {
  backend "azurerm" {
    resource_group_name = "shiviaj101"
    storage_account_name = "stgshivi101"
    container_name = "tfstate"
    key = "dev2.terraform.tfstate" # for dev 
    use_azuread_auth = false # backend
  }
}