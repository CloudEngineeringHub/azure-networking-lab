module "resoure_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs

}

module "virtual_network" {
  source     = "../../modules/azurerm_virtual_network"
  depends_on = [module.resoure_group]
  vnets      = var.vnets
}

module "subnet" {
  source     = "../../modules/azurerm_subnet"
  depends_on = [module.resoure_group, module.virtual_network]
  subnets    = var.subnets
}

module "public_ip" {
  source     = "../../modules/azurerm_public_ip"
  depends_on = [module.resoure_group]
  public_ips = var.public_ips
}


module "bastion" {
  source     = "../../modules/azurerm_bastion"
  depends_on = [module.resoure_group, module.virtual_network, module.subnet]
  bastion    = var.bastion
}
module "nsg" {
  source     = "../../modules/azurerm_nsg"
  depends_on = [module.resoure_group, module.virtual_machine]
  nsg        = var.nsg
}
module "keyvault" {
  source = "../../modules/azurerm_key_vault"

  keyvaults = var.keyvaults
  secrets   = var.secrets

  depends_on = [
    module.resoure_group
  ]
}

module "virtual_machine" {
  source = "../../modules/azurerm_virtual_machine"

  depends_on = [
    module.resoure_group,
    module.virtual_network,
    module.subnet,
    module.public_ip,
      module.keyvault
  ]

 vms = var.vms
}