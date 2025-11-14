# resource "azurerm_subnet_network_security_group_association" "nsg_associatiate" {
#     for_each = var.nsgs_association
#   subnet_id                 = each.value.subnet_id
#   network_security_group_id = each.value.network_security_group_id
# }



