# Retrieves the current Azure subscription ID.
# Required to assign roles at the subscription scope.
data "azurerm_subscription" "primary" {}
