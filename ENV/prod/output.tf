output "public_ip_ids" {
  value = module.public_ip.public_ip_ids
}

output "public_ip_names" {
  value = module.public_ip.public_ip_names
}

output "public_ip_addresses" {
  value = module.public_ip.public_ip_addresses
}
output "secret_names" {
  description = "Names of Key Vault secrets created by module"
  value       = module.key_vault_secret.secret_names
}

output "secret_ids" {
  description = "IDs of Key Vault secrets created by module"
  value       = module.key_vault_secret.secret_ids
}



