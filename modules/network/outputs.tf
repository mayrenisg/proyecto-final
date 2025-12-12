# modules/network/outputs.tf

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "public_subnet_id" {
  value = azurerm_subnet.public.id
}

output "public_nsg_id" {
  value = azurerm_network_security_group.public_nsg.id
}
