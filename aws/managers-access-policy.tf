# Ref: REFERENCES.md – section "IAM and Policies"

# IAM policy for Managers group (read-only MQTT access)
resource "aws_iam_policy" "managers_policy" {
  name        = "ManagersPolicy"
  path        = "/internal/"
  description = "IAM policy for Managers group to receive MQTT notifications"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "IoTMQTTSubscribeOnly",
        Effect = "Allow",
        Action = [
          "iot:Connect",
          "iot:Subscribe",
          "iot:Receive"
        ],
        Resource = "arn:aws:iot:${var.aws_region}:${data.aws_caller_identity.current.account_id}:topic/internal/managers/notify"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "managers_policy_attach" {
  group      = aws_iam_group.teams["Managers"].name
  policy_arn = aws_iam_policy.managers_policy.arn
}
