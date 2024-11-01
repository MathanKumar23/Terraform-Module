environment         = "dev"
resource_group_name = "Module_RG"
location            = "West US2"
vnet_name           = "vent1"
vnet_address_prefix = "10.0.0.0/16"
subnets = {
  "public-subnet" = {
    name             = "public-subnet"
    address_prefixes = "10.0.10.0/24"
  }
  "private-subnet" = {
    name             = "private-subnet"
    address_prefixes = "10.0.20.0/24"
  }
}
nsg_name        = "nsg1"
public_vm_size  = "Standard_DS1_v2"
private_vm_size = "Standard_DS1_v2"
