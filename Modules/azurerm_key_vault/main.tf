
data "azurerm_client_config" "current" {}

# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "West Europe"
# }

resource "azurerm_key_vault" "kv" {

    for_each = var.keyvaults  # variable use kiya  (Keyvaults)

     # ---------- Required Arguments ----------

  name                        = each.value.kv_name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  sku_name                    = each.value.sku_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id

    # ---------- Optional  Arguments ----------
  soft_delete_retention_days  = each.value.soft_delete_retention_days # 7
  purge_protection_enabled    = each.value.purge_protection_enabled #true or False
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption  #true or False
  tags                        = each.value.tags
  //enable_rbac_authorization = true   # important

  

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get","List" , "Create" , "Delete"

    ]

    secret_permissions = [
    "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set"
    ]

    storage_permissions = [
      "Get", 
    ]
  }
}