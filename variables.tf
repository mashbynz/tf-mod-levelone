variable "level0_NSG" {}
variable "level0_subnet" {}
variable "level0_rt" {}
variable "level0_rg" {}
variable "level0_virtual_networks" {}

variable "tenant_id" {}
variable "object_id" {}

variable "tags" {
  default     = ""
  description = "(Required) tags for the deployment"
}

variable "rsv_suffix" {
  description = "(Optional) You can use a suffix to add to the list of Recovery Service Vaults you want to create"
  type        = string
}

variable "rsv_object" {
  description = "(Required) configuration object describing the Recovery Service Vault configuration"
}

variable "key_vault_suffix" {
  description = "(Optional) You can use a suffix to add to the list of Key Vaults you want to create"
  type        = string
}

variable "key_vault_object" {
  description = "(Required) configuration object describing the Key Vault configuration"
}

variable "networking_object" {
  description = "(Required) configuration object describing the networking configuration, as described in README"
}
