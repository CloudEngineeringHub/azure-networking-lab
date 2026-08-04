variable "vms" {}


resource "azurerm_network_interface" "nics" {
    for_each = var.vms

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name


  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnets[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id  = data.azurerm_public_ip.public_ip[each.key].id
  }

  
}

resource "azurerm_linux_virtual_machine" "linux-vms" {
    for_each = var.vms
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password      = data.azurerm_key_vault_secret.password[each.key].value
  network_interface_ids = [
    azurerm_network_interface.nics[each.key].id,
  ]


  os_disk {

    caching              = each.value.os_disk_caching
    storage_account_type = each.value.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = each.value.image_reference_publisher
    offer     = each.value.image_reference_offer
    sku       = each.value.image_reference_sku
    version   = each.value.image_reference_version
  }
}