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
