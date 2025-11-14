resource "azurerm_mssql_server" "mysql_server" {
  for_each = var.sql_servers
  name = each .value .name
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  version = each.value.version
  administrator_login = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password
  minimum_tls_version = each.value.minimum_tls_version
  public_network_access_enabled = each.value.public_network_access_enabled
  tags = each.value.tags

}

variable "sql_servers" {
  type = map(object({
    name = string
    resource_group_name = string
    location = string
    version = string
    public_network_access_enabled = bool
    administrator_login = optional(string)
    administrator_login_password = optional(string)
    minimum_tls_version = optional(string)
    tags = optional(map(string))
  }))
}