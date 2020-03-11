# firewall vnet
resource "azurerm_virtual_network" "firewall" {
  # count = var.fw_vnet_enabled == true ? length(keys(var.fw_vnet_config.location)) : 0
  count = var.fw_vnet_enabled == true ? length(keys(var.fw_vnet_config.vnet_name)) : 0
  name  = element(values(var.fw_vnet_config.vnet_name), count.index)
  # location            = azurerm_resource_group.firewall.*.location[count.index]
  # resource_group_name = azurerm_resource_group.firewall.*.name[count.index]
  location            = element(values(var.level1_network_location), count.index)
  resource_group_name = element(values(var.level1_network_resource_group_name), count.index)
  address_space       = element(values(var.fw_vnet_config.address_space), count.index)
  dns_servers         = element(values(var.fw_vnet_config.dns_servers), count.index)
  tags                = element(values(var.fw_vnet_config.tags), count.index)
}

# Subnet
resource "azurerm_subnet" "default" {
  count = var.fw_vnet_enabled == true ? length(keys(var.fw_vnet_config.subnet_name)) : 0
  name  = element(values(var.fw_vnet_config.subnet_name), count.index)
  # resource_group_name  = azurerm_resource_group.firewall.*.name[count.index]
  virtual_network_name = azurerm_virtual_network.firewall.*.name[count.index]
  resource_group_name = element(values(var.level1_network_resource_group_name), count.index)
  # network_security_group_id = azurerm_network_security_group.default.*.id[count.index]
  # route_table_id            = azurerm_route_table.default.*.id[count.index]
  address_prefix = element(values(var.fw_vnet_config.subnet_prefix), count.index)
}
