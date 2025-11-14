
variable "keyvaults" {
  type = map(object({
    kv_name =  string
    location = string
    resource_group_name = string
    sku_name = string
    tenant_id = optional(string)

     # ---------- Optional / configurable arguments ----------
    
    soft_delete_retention_days = optional(number)
    purge_protection_enabled = optional(bool)
    enabled_for_disk_encryption = optional(bool)
    tags                         = optional(map(string))

  }))
}