output "vpc_id" {
  description = "The ID of the AWS VPC"
  value       = aws_vpc.cloud_notification_platform_network.id
}

output "vpc_arn" {
  description = "The ARN of the AWS VPC"
  value       = aws_vpc.cloud_notification_platform_network.arn
}
