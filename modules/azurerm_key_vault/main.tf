variable "keyvaults" {}
variable "secrets" {}
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {

  for_each = var.keyvaults

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = each.value.sku_name

  rbac_authorization_enabled = false

  soft_delete_retention_days = each.value.soft_delete_retention_days
}
resource "azurerm_key_vault_access_policy" "kv_policy" {

  for_each = azurerm_key_vault.kv

  key_vault_id = each.value.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "get",
    "list",
    "create",
    "delete",
    "encrypt",
    "decrypt",
    "wrapKey",
    "unwrapKey",
    "sign",
    "verify",
    "recover",
    "backup",
    "restore",
    "purge",
  ]

  secret_permissions = [
    "get",
    "list",
    "set",
    "delete",
    "recover",
    "backup",
    "restore",
    "purge",
  ]

  certificate_permissions = [
    "get",
    "list",
    "create",
    "delete",
    "managecontacts",
    "getissuers",
    "listissuers",
    "setissuers",
    "deleteissuers",
    "manageissuers",
    "recover",
    "backup",
    "restore",
    "purge",
  ]
}
resource "azurerm_key_vault_secret" "vm_password" {

  for_each = var.secrets

  name  = each.value.name
  value = each.value.value

  key_vault_id = azurerm_key_vault.kv["kv1"].id

  depends_on = [
    azurerm_role_assignment.kv_admin
  ]
}