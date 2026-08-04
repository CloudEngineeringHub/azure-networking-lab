rgs = {
  rg1 = {
    name     = "rg-devops-prod"
    location = "west us"
  }
}

vnets = {
  vnet1 = {
    name                = "vnet-devops-prod"
    location            = "west us"
    resource_group_name = "rg-devops-prod"
    address_space       = ["10.0.0.0/16"]

  }
}


subnets = {
  subnet1 = {
    name                 = "frontend-devops-prod"
    resource_group_name  = "rg-devops-prod"
    virtual_network_name = "vnet-devops-prod"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "backend-devops-prod"
    resource_group_name  = "rg-devops-prod"
    virtual_network_name = "vnet-devops-prod"
    address_prefixes     = ["10.0.2.0/24"]
  }
  subnet3 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rg-devops-prod"
    virtual_network_name = "vnet-devops-prod"
    address_prefixes     = ["10.0.3.0/24"]
  }
}
public_ips = {
  public_ip1 = {

    name                = "bastion-ip"
    resource_group_name = "rg-devops-prod"
    location            = "west us"
    allocation_method   = "Static"
  }
  public_ip2 = {
    name                = "frontend-ip"
    resource_group_name = "rg-devops-prod"
    location            = "west us"
    allocation_method   = "Static"
  }

}

bastion = {
  bastion1 = {
    name                 = "bastion-host"
    location             = "west us"
    resource_group_name  = "rg-devops-prod"
    subnet_name          = "AzureBastionSubnet"
    virtual_network_name = "vnet-devops-prod"
    public_ip_name       = "bastion-ip"
  }
}
nsg = {
  nsg1 = {
    name                = "linux-nsg"
    resource_group_name = "rg-devops-prod"
    nic_name            = "frontend-nic"
    location            = "west us"
  }
}

keyvaults = {
  kv1 = {
    name                       = "neetu-keyvault12345"
    location                   = "west us"
    resource_group_name        = "rg-devops-prod"
    sku_name                   = "standard"
    soft_delete_retention_days = 7
  }
}

secrets = {
  vm1 = {
    name  = "vmpassword"
    value = "Password@1234"
  }
}

vms = {
  vm1 = {
    name                         = "frontend-vm"
    location                     = "west us"
    resource_group_name          = "rg-devops-prod"
    subnet_name                  = "frontend-devops-prod"
    virtual_network_name         = "vnet-devops-prod"
    public_ip_name               = "frontend-ip"
    size                         = "Standard_D2s_v3"
    admin_username               = "neetubanti"
    os_disk_caching              = "ReadWrite"
    os_disk_storage_account_type = "Standard_LRS"
    image_reference_publisher    = "Canonical"
    key_vault_name               = "neetu-keyvault12345"
    image_reference_offer        = "0001-com-ubuntu-server-jammy"
    image_reference_sku          = "22_04-lts"
    image_reference_version      = "latest"
    public_ip_name               = "frontend-ip"
    vm_username = "azureuser"
vm_password = "Admin@123"

aws_access_key_id     = "AKIAIOSFODNN7EXAMPLE"
aws_secret_access_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
db_password = "SuperSecretPassword@123"
github_token = "ghp_abcdEFGHijklMNOPqrstUVWXyz1234567890"
aws_access_key_id     = "AKIA1234567890ABCDEF"
aws_secret_access_key = "abcdefghijklmnopqrstuvwxyz1234567890ABCD"
db_password           = "DemoPassword@123"
github_token          = "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
azure_client_secret   = "demo-client-secret-123456789"
  }
}