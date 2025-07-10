# Ref: azure_references.md – section "(Azure AD + RBAC) and Policies"

resource "azurerm_role_definition" "devops_custom_role" {
  name               = "DevOpsCustomRole"
  scope              = azurerm_resource_group.rg.id
  assignable_scopes  = [azurerm_resource_group.rg.id]

  description = "Custom role for DevOps team to manage core infra, IoT, logs and storage"

  permissions {
    actions = [
      # Network insight (equiv. to ec2:Describe)
      "Microsoft.Network/virtualNetworks/*",
      "Microsoft.Network/virtualNetworks/subnets/*",

      # Storage access (for state/DLQs)
      "Microsoft.Storage/storageAccounts/blobServices/containers/*",
      "Microsoft.Storage/storageAccounts/listKeys/action",
      "Microsoft.Storage/storageAccounts/read",
      "Microsoft.Storage/storageAccounts/write",
      "Microsoft.Storage/storageAccounts/delete",

      # IoT full access
      "Microsoft.Devices/*",

      # Azure Functions
      "Microsoft.Web/sites/*",

      # Logs & Monitoring
      "Microsoft.Insights/*",

      # Queues (DLQ)
      "Microsoft.Storage/storageAccounts/queueServices/queues/*"
    ]
    not_actions = []
  }
}

resource "azurerm_role_assignment" "devops_assignment" {
  scope                	= azurerm_resource_group.rg.id
  role_definition_id 	= azurerm_role_definition.devops_custom_role.role_definition_resource_id
  principal_id         	= azuread_group.teams["DevOps"].object_id
}
