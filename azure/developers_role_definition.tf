# Ref: azure_references.md – section "(Azure AD + RBAC) and Policies"

resource "azurerm_role_definition" "developers_custom_role" {
  name               = "DevelopersCustomRole"
  scope              = azurerm_resource_group.rg.id
  assignable_scopes  = [azurerm_resource_group.rg.id]

  description = "Custom role for Developers to work with Azure Functions, IoT, logs and queues"

  permissions {
    actions = [
      # IoT access
      "Microsoft.Devices/IotHubs/*",

      # Azure Functions access
      "Microsoft.Web/sites/*",

      # Logs
      "Microsoft.Insights/logs/*",

      # Storage Queues (DLQ)
      "Microsoft.Storage/storageAccounts/queueServices/queues/*"
    ]
    not_actions = []
  }
}

resource "azurerm_role_assignment" "developers_assignment" {
  scope                 = azurerm_resource_group.rg.id
  role_definition_id    = azurerm_role_definition.developers_custom_role.role_definition_resource_id
  principal_id          = azuread_group.teams["Developers"].object_id
}
