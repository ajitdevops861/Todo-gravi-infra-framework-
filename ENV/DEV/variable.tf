variable "rgs1" {
  type = map(object({
    name     = string
    location = string

    tags = optional(map(string))
  }))

}

variable "vnets" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    #dns_servers         = optional(list(string))
    subnets = optional(list(object({
      name             = string
      address_prefixes = list(string)
      #  Added field for enabling outbound internet
      default_outbound_access_enabled  = optional(bool, true)
    })), [])

  }))
}

variable "nsgs" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = optional(map(string))
    inbound_rules = optional(list(object({
      name                       = string
      priority                   = number
      access                     = string
      protocol                   = string
      source_port_range          = optional(string)
      destination_port_range     = optional(string)
      source_address_prefix      = optional(string)
      destination_address_prefix = optional(string)
    })), [])

    Outbound_rules = optional(list(object({
      name                       = string
      priority                   = number
      access                     = string
      protocol                   = string
      source_port_range          = optional(string)
      destination_port_range     = optional(string)
      source_address_prefix      = optional(string)
      destination_address_prefix = optional(string)
    })), [])

  }))
}

variable "public_ips" {
  type = map(object({

    # ---------- Required Arguments ----------
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string

    # ---------- Optional Arguments ----------
    zones                   = optional(list(string))
    ddos_protection_mode    = optional(string)
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags                 = optional(map(string))
    public_ip_prefix_id     = optional(string)
    sku                     = optional(string) # Basic or Standard
    sku_tier                = optional(string) # Regional or Global
    tags                    = optional(map(string))




  }))
}

# keyvaults 

variable "keyvaults" {
  type = map(object({

    # Required Arguments
    kv_name             = string
    location            = string
    resource_group_name = string
    sku_name            = string
    tenant_id           = optional(string)

    # optinal Arguments

    soft_delete_retention_days  = optional(number)
    purge_protection_enabled    = optional(bool)
    enabled_for_disk_encryption = optional(bool)
    tags                        = optional(map(string))
  }))
}

# key_vault_secret

variable "kv_secrets" {
  type = map(object({
    # Required
    kv_name     = string
    rg_name     = string
    secret_name = string
    # optional
    secret_value            = optional(string)
    secret_value_wo         = optional(string)
    secret_value_wo_version = optional(number)
    content_type            = optional(string)
    not_before_date         = optional(string)
    expiration_date         = optional(string)
  }))
}

# Network Interface (NIC)
variable "nics" {
  description = "Map of Network Interface configurations"
  type = map(object({
    # data block variable
    vnet_name   = string
    subnet_name = string
    pip_name    = string
    # resource block variable
    name                          = string
    resource_group_name           = string
    location                      = string
    enable_ip_forwarding          = optional(bool)
    enable_accelerated_networking = optional(bool)
    tags                          = optional(map(string))

    ip_configurations = optional(list(object({
      name = string
      # subnet_id                     = string # if we using data block for this then not required here
      private_ip_address_allocation = string
      private_ip_address_version    = optional(string)
      public_ip_address_id          = optional(string)
      primary                       = optional(bool)
    })), [])
  }))
}


# NIC ↔ NSG Association

variable "nic_nsg_association" {
  description = "Map defining NIC and NSG association"
  type = map(object({
    # data block variable
    nic_name            = string
    nsg_name            = string
    resource_group_name = string
    # resource block variable  # if we using data block for this then not required here
    # network_interface_id      = string
    # network_security_group_id = string
  }))
}



# Virtual Machine (Linux)

variable "vms" {
  type = map(object({
    kv_name                 = string # data block ke veriable
    resource_group_name     = string # data block ke veriable
    vm_username_secret_name = string # data block ke veriable
    vm_password_secret_name = string # data block ke veriable
    nic_name                = string
    # resource block variable
    name = string
    #resource_group_name = string
    size        = string
    location    = string
    script_name = optional(string)


    disable_password_authentication = optional(bool)
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string

    })
  }))

}
