rgs1 = {
  rg1 = {
    name     = "dev-812-test"
    location = "australiaeast"

    tags = {
      environment = "dev"
      owner       = "aj"
    }
  }

  rg2 = {
    name     = "graviinfra101"
    location = "eastus"
  }
}

vnets = {
  "vnet1" = {
    name                = "vnet-east"
    location            = "australiaeast"
    resource_group_name = "dev-812-test"

    address_space = ["10.2.0.0/16"]
    #dns_servers   = ["10.2.0.4", "10.2.0.5"]

    subnets = [
      {
        address_prefixes                = ["10.2.1.0/24"]
        name                            = "frontend_subnet"
        default_outbound_access_enabled = true
      },

      {
        name                            = "Backend_subnet"
        address_prefixes                = ["10.2.2.0/24"]
        default_outbound_access_enabled = true
      }
    ]


  }
}

nsgs = {
  dev-nsg1 = {
    name                = "dev-nsg"
    location            = "australiaeast"
    resource_group_name = "dev-812-test"
    tags = {
      environment = "dev"
    }

    inbound_rules = [
      {
        access                     = "Allow"
        destination_address_prefix = "*"
        destination_port_range     = "22"
        name                       = "Allow-SSH"
        priority                   = 100
        protocol                   = "Tcp"
        source_address_prefix      = "*"
        source_port_range          = "*"
      },
      {
        name                       = "Allow-HTTP"
        priority                   = 200
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"

      }
    ]
    Outbound_rules = [
      {
        name     = "Allow-All-Outbound"
        priority = 100
        # direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]

  }
}

public_ips = {
  "pip1" = {
    name                = "frontend_pip"
    resource_group_name = "dev-812-test"
    location            = "australiaeast"
    allocation_method   = "Static"


  }

  pip2 = {
    name                = "Backend_pip"
    resource_group_name = "dev-812-test"
    location            = "australiaeast"
    allocation_method   = "Static" # Dynamic Quota full
    sku                 = "Standard"
    # Basic karne per error aa raha
  }
}

# Keyvault

keyvaults = {
  "kv-Dev" = {
    kv_name             = "keyvault-todo-new"
    location            = "australiaeast"
    resource_group_name = "dev-812-test"
    sku_name            = "standard"

    # optional values (can skip if not needed)
    soft_delete_retention_days = 7

    purge_protection_enabled = false
    tags = {
      environment = "dev"

    }

  }
}

# Keyvault_secret

kv_secrets = {
  "kv_secret1" = {
    kv_name = "keyvault-todo-new"
    rg_name = "dev-812-test"

    secret_name  = "frontend-vm1-adminusername-"
    secret_value = "adminuseraj"
    tags         = { environment = "dev" }
  },
  kv_secret2 = {
    kv_name      = "keyvault-todo-new"
    rg_name      = "dev-812-test"
    secret_name  = "frontend-vm1-adminpassword-"
    secret_value = "ajitraghav@0000"
    tags         = { environment = "dev" }
  },
  "kv_secret3" = {
    kv_name = "keyvault-todo-new"
    rg_name = "dev-812-test"

    secret_name  = "Backend-vm2-adminusername-"
    secret_value = "adminuseraj"
    tags         = { environment = "dev" }
  },
  kv_secret4 = {
    kv_name      = "keyvault-todo-new"
    rg_name      = "dev-812-test"
    secret_name  = "Backend-vm2-adminpassword-"
    secret_value = "ajitraghav@0000"
    tags         = { environment = "dev" }
  },

  kv_secret5 = {
    kv_name      = "keyvault-todo-new"
    rg_name      = "dev-812-test"
    secret_name  = "sql-usernamee1"
    secret_value = "devopsadmin"
  },
  kv_secret6 = {
    kv_name      = "keyvault-todo-new"
    rg_name      = "dev-812-test"
    secret_name  = "sql-passwordd1"
    secret_value = "P@ssw01rd@123"
  }
}

nics = {
  nic1 = {
    vnet_name                     = "vnet-east"
    subnet_name                   = "frontend_subnet"
    pip_name                      = "frontend_pip"
    name                          = "nic-frontend"
    location                      = "australiaeast"
    resource_group_name           = "dev-812-test"
    enable_ip_forwarding          = false
    enable_accelerated_networking = false
    tags                          = { environment = "dev" }

    ip_configurations = [
      {
        name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        primary                       = true
      }
    ]
  }
  nic2 = {
    vnet_name                     = "vnet-east"
    subnet_name                   = "Backend_subnet"
    pip_name                      = "Backend_pip"
    name                          = "nic-backend"
    location                      = "australiaeast"
    resource_group_name           = "dev-812-test"
    enable_ip_forwarding          = false
    enable_accelerated_networking = false
    tags                          = { environment = "dev" }

    ip_configurations = [
      {
        name                          = "ipconfig2"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        primary                       = true
      }
    ]
  }
}

nic_nsg_association = {
  assoc1 = {
    nic_name            = "nic-frontend"
    nsg_name            = "dev-nsg"
    resource_group_name = "dev-812-test"
  }

  assoc2 = {
    nic_name            = "nic-backend"
    nsg_name            = "dev-nsg"
    resource_group_name = "dev-812-test"
  }


}
# Virtual Machine (Linux)

vms = {
  "vm1" = {

    name                = "vm-todo-frontend"
    resource_group_name = "dev-812-test"
    location            = "australiaeast"
    size                = "Standard_D2s_v3"


    disable_password_authentication = false
    script_name                     = "middleware.nginx.sh"
    nic_name                        = "nic-frontend"
    kv_name                         = "keyvault-todo-new"
    vm_username_secret_name         = "frontend-vm1-adminusername-"
    vm_password_secret_name         = "frontend-vm1-adminpassword-"
    source_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
  }
  "vm2" = {

    name                = "vm-todo-Backend"
    resource_group_name = "dev-812-test"
    location            = "australiaeast"
    size                = "Standard_D2s_v3"

    disable_password_authentication = false
    nic_name                        = "nic-backend"
    kv_name                         = "keyvault-todo-new"
    vm_username_secret_name         = "Backend-vm2-adminusername-"
    vm_password_secret_name         = "Backend-vm2-adminpassword-"
    source_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
  }
}

# sql_server

#sql_servers = {
# "sql1" = {
#  sql_server_name     = "sqlserver-dev"
#  resource_group_name = "kerg001"
#  location            = "westus"
# key_vault_name      = "keyvault-todo-new"
#  sql_username        = "sql-usernamee"
#  sql_password        = "sql-passwordd"
#  version             = "12.0"
#  key_vault_rg_name   = "kerg001"

#}
#}
servers = {
  server1 = {
    name                          = "devserver0002os"
    location                      = "australiaeast"
    resource_group_name           = "dev-812-test"
    public_network_access_enabled = true
    administrator_login           = "server12"
    administrator_login_password  = "Ajit@12345"
    version                       = "12.0"
  }
  server2 = {
    name                          = "devserver00042os"
    location                      = "australiaeast"
    resource_group_name           = "dev-812-test"
    public_network_access_enabled = true
    administrator_login           = "server13"
    administrator_login_password  = "Ajit@12345"
    version                       = "12.0"
  }
}

# Database input
database = {
  "db1" = {
    server_name         = "devserver0002os"
    resource_group_name = "dev-812-test"
    database_name       = "devdatabase001"
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    license_type        = "LicenseIncluded"
    max_size_gb         = 10
    sku_name            = "S0"
    #enclave_type = # optional
    tags = {
      environment = "dev"
      project     = "Todo-app"
    }
  }
}

# Storage_account_input
stgs = {
  "stg1" = {
    storage_account_name          = "devajrg1507"
    resource_group_name           = "dev-812-test"
    location                      = "australiaeast"
    account_tier                  = "Standard"
    account_replication_type      = "LRS"
    min_tls_version               = "TLS1_2"
    public_network_access_enabled = true
    tags = {
      environment = "dev"
      project     = "Todo-app"
    }
  }
}

