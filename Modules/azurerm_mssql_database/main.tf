
data "azurerm_mssql_server" "serverid" {
    for_each = var.database
  name                = each.value.server_name
  resource_group_name = each.value.resource_group_name
}





resource "azurerm_mssql_database" "Databases" {
 for_each = var.database
  name         = each.value.database_name
  server_id    = data.azurerm_mssql_server.serverid[each.key].id
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name
  enclave_type = each.value.enclave_type

  tags = each.value.tags


}

variable "database" {
  type = map(object({
    server_name = string
    resource_group_name = string
    database_name = string
    collation = string
    license_type = optional(string)
    max_size_gb = number
    sku_name = string
    enclave_type = optional(string)
    tags    = optional(map(string))

  }))
}