# Configure the backend in Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.113.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tf-migrate-bug-bash-resource-group"
    storage_account_name = "pulsepixelstorage"
    container_name       = "echomindcontainer"
    key                  = "streamflow/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Create a Resource Group
resource "azurerm_resource_group" "echomind-resource-group" {
  name     = var.resource_group_name
  location = "West US"

  tags = {
    createdFor = "tf-migrate bug bash"
    createdBy  = "terraform"
    canDelete  = "true"
    appName    = "streamflow"
    timestamp  = timestamp()
  }
}

# Create output
output "resource_group_name" {
  value = azurerm_resource_group.echomind-resource-group.name
}

