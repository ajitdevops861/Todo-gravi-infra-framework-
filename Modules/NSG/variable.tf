variable "nsgs" {
  description = "Map of NSGs with inbound/outbound rules"
  type = map(object({
    name = string
    location = string
    resource_group_name = string
    tags = optional(map(string))

    inbound_rules = optional(list(object({
    name = string
    priority = number
    access = string
    protocol = string
    source_port_range = optional(string)
    destination_port_range = optional(string)
    source_address_prefix = optional(string)
    destination_address_prefix = optional(string)

    })),[])
Outbound_rules = optional(list(object({
    name = string
    priority = number
    access = string
    protocol = string
    source_port_range = optional(string)
    destination_port_range = optional(string)
    source_address_prefix = optional(string)
    destination_address_prefix = optional(string)

    })),[] )


  }))
}