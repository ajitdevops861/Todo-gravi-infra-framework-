resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.vms

      # ---------- Required Arguments ----------

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each . value. size
  admin_username      = data.azurerm_key_vault_secret.vm_username[each.key].value
  admin_password      =   data.azurerm_key_vault_secret.vm_password[each.key].value
  disable_password_authentication =  each.value.disable_password_authentication
  network_interface_ids = [data.azurerm_network_interface.nic_ids[each.key].id]

 # ---------- Optional Arguments ----------

# custom_data                = base64encode(file(each.value.script_name))   # custom_data usage


  # admin_ssh_key {
  #   username   = "adminuser"
  #   public_key = file("~/.ssh/id_rsa.pub")
  # }

    # ---------- Optional Nested Block ----------
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
     disk_size_gb         = 30
  }
# Required
  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
}