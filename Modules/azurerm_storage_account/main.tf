

resource "azurerm_storage_account" "storage" {
    for_each = var.stgs
  name                     = each.value.storage_account_name         # STORAGE NAME
  resource_group_name      = each.value.resource_group_name          # RESOURCE_GROUP_NAME
  location                 = each.value.location                        # RG_LOCATION
  account_tier             = each.value.account_tier           # standard
  account_replication_type = each.value.account_replication_type  # LRS , GRS
  min_tls_version = each.value.min_tls_version
  public_network_access_enabled = each.value.public_network_access_enabled

  tags = each.value.tags
  }

# variable
  variable "stgs" {
    type = map(object({
      storage_account_name = string
      resource_group_name = string
      location = string
      account_tier = string
      account_replication_type = string
      min_tls_version = string
      public_network_access_enabled = bool
      tags = optional(map(string))
    }))
  }
