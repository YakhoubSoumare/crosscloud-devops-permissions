# ============================================
# Role Assignments for Managers Group (Azure)
# ============================================

# Ref: azure_references.md – section "(Azure AD + RBAC) and Policies"

# ------------------------------------------------------------
# Assign built-in "Reader" role to Managers at RG scope
# ------------------------------------------------------------
# This allows Managers to view all resources within the project
# resource group, such as IoT Hub, Functions, logs, queues etc.
resource "azurerm_role_assignment" "managers_reader" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Reader"
  principal_id         = azuread_group.teams["Managers"].object_id
}

# ------------------------------------------------------------------------
# Assign built-in "Cost Management Reader" role at subscription level
# ------------------------------------------------------------------------
# This gives Managers permission to view cost and usage data for
# the entire Azure subscription, useful for financial oversight.
resource "azurerm_role_assignment" "managers_cost_reader" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Cost Management Reader"
  principal_id         = azuread_group.teams["Managers"].object_id
}
