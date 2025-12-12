terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Módulo Network
module "network" {
  source              = "./modules/network"
  vnet_name           = "xo-vnet"
  address_space       = ["10.0.0.0/16"]
  public_subnet_name  = "public-subnet"
  public_subnet_cidr  = "10.0.1.0/24"
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on = [azurerm_resource_group.main]
}

# Módulo Backend
module "backend" {
  source              = "./modules/backend"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = module.network.public_subnet_id
  admin_password      = var.admin_password
  depends_on = [azurerm_resource_group.main]
}

# Módulo Frontend
module "frontend" {
  source               = "./modules/frontend"
  storage_account_name = "xofrontendstore"
  location             = var.location
  depends_on = [azurerm_resource_group.main]
}


