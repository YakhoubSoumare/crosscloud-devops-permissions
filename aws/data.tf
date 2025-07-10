# Retrieve AWS account ID dynamically
# Ref: aws_references.md – section "Terraform Data Sources"
data "aws_caller_identity" "current" {}
