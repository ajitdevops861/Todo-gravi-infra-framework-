# Virtual Machine (Linux)

variable "vms" {
  type = map(object({
    kv_name = string  # data block ke veriable
    resource_group_name = string # data block ke veriable
    vm_username_secret_name = string # data block ke veriable
    vm_password_secret_name = string # data block ke veriable
    nic_name = string
# resource block variable
name = string

size = string
location = string
#custom_data = string    # custom data script  name
disable_password_authentication = optional(bool)
script_name = optional(string)
source_image_reference = object({
  publisher = string
  offer = string
  sku = string
  version = string 
})
  }))

}

