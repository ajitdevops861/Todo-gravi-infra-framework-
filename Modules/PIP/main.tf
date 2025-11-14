resource "azurerm_public_ip" "public_ip" {
  for_each = var.pips

  # ---------- Required Arguments ----------
  name =  each.value.name
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  allocation_method = each.value.allocation_method

# ---------- Optional Arguments ----------

  zones = each.value.zones
  ddos_protection_mode = each.value.ddos_protection_mode
  ddos_protection_plan_id = each.value.ddos_protection_plan_id
  domain_name_label =  each.value.domain_name_label
  edge_zone = each.value.edge_zone
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
  ip_tags = each.value.ip_tags
  public_ip_prefix_id = each.value.public_ip_prefix_id
  sku = each.value.sku
  sku_tier = each.value.sku_tier
  tags = each.value.tags

}
variable "pips" {
  type = map(object({
    name = string
    resource_group_name = string
    location = string
    allocation_method = string
    zones = optional(list(string))
    ddos_protection_mode = optional(string)
    ddos_protection_plan_id = optional(string)
    domain_name_label = optional(string)
    edge_zone = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags = optional(map(string))
    public_ip_prefix_id = optional(string)
    sku = optional(string)
    sku_tier = optional(string)
    tags = optional(map(string))





  }))
}