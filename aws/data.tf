# Retrieve AWS account ID dynamically
# Ref: REFERENCES.md – section "Terraform Data Sources"
data "aws_caller_identity" "current" {}
