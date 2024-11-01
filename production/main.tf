provider "azurerm" {
  features {}
}

terraform {
  #   required_version = "value"
  required_providers {}

# Backend resource to store statefile
  backend "azurerm" {
    resource_group_name  = "my-terraform-rg"
    storage_account_name = "myterraformstorageacc1"
    container_name       = "terraformstate"
    key                  = "Production.tfstate"
    }
}

# if required pass your suubscription as environment variable
# export ARM_SUBSCRIPTION_ID=""
