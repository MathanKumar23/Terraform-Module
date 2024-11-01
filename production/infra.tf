module "prod_vnet_1" {
  source = "../modules/network"

  environment         = var.environment
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  vnet_address_prefix = var.vnet_address_prefix
  subnets             = var.subnets
}

module "prod_nsg_1" {
  source = "../modules/nsg"

  nsg_name = var.nsg_name
  nsg_rules = [
    {
      name                       = "AllowSSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow22"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow80"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
  resource_group_name = module.prod_vnet_1.resource_group
  location            = module.prod_vnet_1.location
  subnet_id           = module.prod_vnet_1.subnet_id
}

module "prod_compute" {
  source              = "../modules/compute"
  environment         = module.prod_nsg_1.environment
  resource_group_name = module.prod_vnet_1.resource_group
  location            = module.prod_vnet_1.location
  subnet_id           = module.prod_vnet_1.subnet_id
  public_vm_size      = var.public_vm_size
  private_vm_size     = var.private_vm_size
  public_key_path     = "../modules/compute/publickey.pub" # key stored in the compute folder. Using keyvault is recommanded
  pem_file_path       = "../modules/compute/pemkey.pem"
  encoded_path        = "../modules/compute/userdata.tpl"
  script_path         = "../modules/compute/userdata.sh"
}
module "lb" {
  source              = "../modules/loadbalancer"
  environment         = module.prod_vnet_1.environment
  resource_group_name = module.prod_vnet_1.resource_group
  location            = module.prod_vnet_1.location
  nic                 = module.prod_compute.public_nic
  virtual_network_id  = module.prod_vnet_1.virtual_network_id
}
