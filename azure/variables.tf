# ----------- Azure ------------

variable "az_location" { type = string }

variable "az_resource_group" { type = string }

# ----------- Common ------------

variable "cidr_block" { type = string }

# Ref: aws_references.md – section "Loops and Dynamic Configuration"
variable "team_groups" {
  type        = list(string)
  default     = ["DevOps", "Developers", "Managers"]
  description = "List of internal IAM groups used by the organisation"
}
