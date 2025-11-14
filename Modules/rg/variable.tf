variable "rgs1" {
  description = "Map of resource group"

  type = map(object({
    name = string
    location = string
    tags = optional(map(string) )
  }))
}