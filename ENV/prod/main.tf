# # resource Group module

# module "rg" {
#   source = "../../Modules/rg"
#   rgs1 = var.rgs1
# }
# variable "rgs1" {
#   type = map(object({
#     name = string
#     location = string
#     tags = optional(map(string))
#   }))
# }
# Resource Group Module

module "rg" {
  source = "../../Modules/rg"
  rgs1   = var.rgs1
}

# call vnet module

module "vnet" {
  source = "../../Modules/vnet"
  vnets  = var.vnets

  # 👇 dependency add here
  depends_on = [module.rg]


}
#  Call NSG module
module "NSG" {
  source = "../../Modules/NSG"
  nsgs   = var.nsgs

  # Wait until RG module completes
  depends_on = [module.rg]
}

# NSG ↔ Subnet Association module

# module "NSG_ASSOC" {

#   source = "../../Modules/NSG_ASSOC"
#   nsgs_association = var.nsgs_association
#   depends_on = [ module.NSG , module.vnet , module.rg ]

# }

# variable "nsgs_association" {

#   type = map(object({
#     subnet_id =  string
#     network_security_group_id = string
#   }))

# }

module "public_ip" {
  source     = "../../Modules/PIP"
  depends_on = [module.rg]
  pips       = var.public_ips

}

# Keyvaults

module "key_vaults" {
  source     = "../../Modules/azurerm_key_vault"
  keyvaults  = var.keyvaults
  depends_on = [module.rg]
}

#keyvault secret
module "key_vault_secret" {
  source     = "../../Modules/azurerm_key_vault_secret"
  kv_secrets = var.kv_secrets
  depends_on = [module.rg, module.key_vaults]

}
# NIC
module "nic" {
  source = "../../Modules/azurerm_network_interface"

  nics       = var.nics
  depends_on = [module.public_ip, module.rg, module.vnet]
}

module "nic_nsg_association" {
  nic_nsg_association = var.nic_nsg_association
  source              = "../../Modules/nic_nsg_association"
  depends_on          = [module.nic, module.NSG]
}


module "linux_vm" {
  source     = "../../Modules/virtual_machin"
  depends_on = [module.rg, module.nic, module.key_vault_secret, module.key_vaults]
  vms        = var.vms
}

# mssql_server 
# module "mssql_server" {
#source      = "../../Modules/azurerm_mssql_server"
#sql_servers = var.sql_servers
#depends_on  = [module.rg, module.key_vaults, module.key_vault_secret]
#}

#variable "sql_servers" {
#type = map(object({
# sql_server_name     = string
#resource_group_name = string
#location            = string
#key_vault_name      = string
#sql_username        = string
#sql_password        = string
#version             = string
#key_vault_rg_name   = optional(string)
#}))
#}

module "mysql_server" {
  source      = "../../Modules/azurerm_mssql_server"
  depends_on  = [module.rg]
  sql_servers = var.servers
}

variable "servers" {
  type = map(object({
    name                          = string
    resource_group_name           = string
    location                      = string
    version                       = string
    public_network_access_enabled = bool
    administrator_login           = optional(string)
    administrator_login_password  = optional(string)
    minimum_tls_version           = optional(string)
    tags                          = optional(map(string))
  }))
}

# Database Call from child module
module "azurerm_mssql_database" {
  source     = "../../Modules/azurerm_mssql_database"
  depends_on = [module.mysql_server, module.rg]
  database   = var.database
}

variable "database" {
  type = map(object({
    server_name         = string
    resource_group_name = string
    database_name       = string
    collation           = string
    license_type        = optional(string)
    max_size_gb         = number
    sku_name            = string
    enclave_type        = optional(string)
    tags                = optional(map(string))
  }))
}

# call storage

module "storage_account_name" {
  source     = "../../Modules/azurerm_storage_account"
  depends_on = [module.rg]
  stgs       = var.stgs
}
# variable
variable "stgs" {
  type = map(object({
    storage_account_name          = string
    resource_group_name           = string
    location                      = string
    account_tier                  = string
    account_replication_type      = string
    min_tls_version               = string
    public_network_access_enabled = bool
    tags                          = optional(map(string))
  }))
}





