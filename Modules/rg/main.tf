resource "azurerm_resource_group" "merarg" {
    for_each = var.rgs1
    name = each.value.name
    location = each.value.location
    tags = each.value.tags
}

