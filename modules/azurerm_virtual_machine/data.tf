data "azurerm_key_vault" "kv" {
    for_each = var.vms
  name                = each.value.key_vault_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "password" {
    for_each = var.vms
  name         = "vm-password"
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
data "azurerm_subnet" "subnets" {
    for_each = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "public_ip" {
    for_each = var.vms
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}