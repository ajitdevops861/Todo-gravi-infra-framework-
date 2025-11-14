resource "azurerm_network_security_group" "mynsg" {
  for_each = var.nsgs
  name = each.value.name
  location = each.value.location
  resource_group_name = each.value.resource_group_name
  tags = each.value.tags

  #  Inbound rules with dynamic block

  dynamic "security_rule" {
    for_each = each.value.inbound_rules
    content {
      name = security_rule.value.name
      priority = security_rule.value.priority
      access = security_rule.value.access
      protocol = security_rule.value.protocol
      source_port_range = security_rule.value.source_port_range
      destination_port_range =security_rule.value.destination_port_range
      source_address_prefix = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
      direction = "Inbound"

    }
  }

  # Outbound rules with dynamic block

  dynamic "security_rule" {
    for_each = each.value.Outbound_rules
    content {
      name = security_rule.value.name
      priority = security_rule.value.priority
      direction = "Outbound"
      access = security_rule.value.access
      protocol = security_rule.value.protocol
      source_port_range = security_rule.value.source_port_range
      destination_port_range = security_rule.value.destination_port_range
      source_address_prefix = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}