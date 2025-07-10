# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  # resource_provider_registrations = "none" # ( OBS! inconsistency in the official documentation) This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.az_resource_group
  location = var.az_location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "cloud_notification_vnet" {
  name                = "cloud_notification_vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.cidr_block]
}

# ------------------- Internal IAM -----------------
# Create internal groups
# Ref: aws_references.md – section "Loops and Dynamic Configuration"
resource "azuread_group" "teams" {
        for_each         = toset(var.team_groups)
        display_name     = "internal-${each.key}"					# Eg. internal-DevOps
        description      = "Internal access group for ${each.key}"
        security_enabled = true										# Needed for RBAC
}
