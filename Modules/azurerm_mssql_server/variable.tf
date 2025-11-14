
# # Get Resource Group info (for SQL Server)

# data "azurerm_resource_group" "rg" {
#     for_each = var.sql_servers
#   name = each.value.resource_group_name
# }



# data "azurerm_key_vault" "kv" {
#     for_each = var.sql_servers
#   name                = each.value.key_vault_name
#   resource_group_name = each.value.key_vault_rg_name
# }
  
#   data "azurerm_key_vault_secret" "sql_username" {
#     for_each = var.sql_servers
#   name         = each.value.sql_username
#   key_vault_id = data.azurerm_key_vault.kv[each.key].id
# }
# # Get Admin username Secret



# # Get Admin Password Secret

# data "azurerm_key_vault_secret" "sql_password" {
#     for_each = var.sql_servers
#   name = each.value.sql_password
#   key_vault_id = data.azurerm_key_vault.kv[each.key].id
# }

# resource "azurerm_mssql_server" "sql_servers" {
#     for_each = var.sql_servers
#   name                         = each.value.sql_server_name
#   resource_group_name          = data.azurerm_resource_group.rg[each.key].name
#   location                     = each.value . location
#   version                      = each.value.version
#   administrator_login          = data.azurerm_key_vault_secret.sql_username[each.key].id
#   administrator_login_password = data.azurerm_key_vault_secret.sql_password[each.key].id
# }

# variable "sql_servers" {
#   type = map(object({
#     sql_server_name = string
#      resource_group_name = string
#      location = string
#      key_vault_name = string
#      sql_username = string
#      sql_password = string
#      version = string
#      key_vault_rg_name = optional(string)
#   }))
# }

