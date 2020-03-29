# NSG association
resource "azurerm_subnet_network_security_group_association" "nsg_subnet_association" {
  for_each = var.level0_subnet

  subnet_id                 = var.level0_subnet[each.key].id
  network_security_group_id = var.level0_NSG[each.key].id
}

# Route Table association
resource "azurerm_subnet_route_table_association" "rt_subnet_association" {
  for_each = var.level0_subnet

  subnet_id      = var.level0_subnet[each.key].id
  route_table_id = var.level0_rt[each.key].id
}

# RSV
resource "azurerm_recovery_services_vault" "vault" {
  for_each = var.rsv_object

  name                = "${each.value.name}${var.rsv_suffix}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku

  tags = lookup(each.value, "tags", null) == null ? local.tags : merge(local.tags, each.value.tags)

  depends_on = [
    var.level0_rg
  ]
}

# VNet Peering
resource "azurerm_virtual_network_peering" "peering" {
  for_each = var.networking_object.peerings

  name                      = each.value.name
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = each.value.virtual_network_name
  remote_virtual_network_id = var.level0_virtual_networks[each.value.remote_virtual_network_id].id
  allow_forwarded_traffic   = each.value.allow_forwarded_traffic
}

# Key Vault
# resource "azurerm_key_vault" "example" {
#   for_each = var.key_vault_object

#   name                            = "${each.value.name}${var.key_vault_suffix}"
#   location                        = each.value.location
#   resource_group_name             = each.value.resource_group_name
#   enabled_for_deployment          = each.value.enabled_for_deployment
#   enabled_for_disk_encryption     = each.value.enabled_for_disk_encryption
#   enabled_for_template_deployment = each.value.enabled_for_template_deployment
#   tenant_id                       = var.tenant_id

#   sku_name = each.value.sku

#   access_policy {
#     tenant_id = var.tenant_id
#     object_id = var.object_id

#     key_permissions = [
#       "get",
#     ]

#     secret_permissions = [
#       "get",
#     ]

#     storage_permissions = [
#       "get",
#     ]
#   }

#   network_acls {
#     default_action = "Deny"
#     bypass         = "AzureServices"
#   }

#   tags = lookup(each.value, "tags", null) == null ? local.tags : merge(local.tags, each.value.tags)

#   depends_on = [
#     var.level0_rg
#   ]
# }
