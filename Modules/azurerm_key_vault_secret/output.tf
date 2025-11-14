output "secret_names" {
  value = [for s in azurerm_key_vault_secret.key_vault_secret : s.name]
}

output "secret_ids" {
  value = { for k, v in azurerm_key_vault_secret.key_vault_secret : k => v.id }
}
