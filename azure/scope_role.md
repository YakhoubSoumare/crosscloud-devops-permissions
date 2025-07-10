# Azure RBAC: scope vs assignable_scopes

## Scope: 
Where the role is defined. Required by Terraform. Must be within assignable_scopes.

## Assignable_scopes 
Where the role can be assigned. Can include multiple scopes.

- Not related to `location` or Azure region. 
- RBAC scopes refer to resource hierarchy (e.g. subscription, resource group), not geography
