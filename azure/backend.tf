terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-azure-backend-cloud-notification-rg"
    storage_account_name = "terraformstateyakhoub"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
