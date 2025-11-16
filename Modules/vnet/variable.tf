
variable "vnets" {
  type = map(object({
    name = string
    location = string
    resource_group_name = string
    address_space = list(string)
    # dns_servers  = optional(list(string))

    subnets = optional(list(object({
      name = string
      address_prefixes = list(string)
      #  Added field for enabling outbound internet
      default_outbound_access_enabled  = optional(bool, true)
    })) , [])
  }))
}