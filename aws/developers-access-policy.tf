# Ref: REFERENCES.md – section "IAM and Policies"

# Define custom IAM policy for Developers group
resource "aws_iam_policy" "developers_policy" {
  name        = "DevelopersPolicy"
  path        = "/internal/"
  description = "IAM policy for Developers group to work with Lambda, IoT, Logs and Dead Letter Queues"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [

      # Allow limited Lambda access
      {
        Sid    = "LambdaBasicAccess",
        Effect = "Allow",
        Action = [
          "lambda:InvokeFunction",
          "lambda:GetFunction",
          "lambda:UpdateFunctionCode"
        ],
        Resource = "*"
      },

      # Read logs from CloudWatch
      {
        Sid    = "CloudWatchLogsRead",
        Effect = "Allow",
        Action = [
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:GetLogEvents"
        ],
        Resource = "*"
      },

      # IoT Core MQTT access (publish + subscribe)
      {
        Sid    = "IoTMQTTAccess",
        Effect = "Allow",
        Action = [
          "iot:Connect",
          "iot:Publish",
          "iot:Subscribe",
          "iot:Receive"
        ],
        Resource = "arn:aws:iot:${var.aws_region}:${data.aws_caller_identity.current.account_id}:topic/internal/developers/*"
      },

      # Optional: allow creating test devices
      {
        Sid    = "IoTThingTestAccess",
        Effect = "Allow",
        Action = [
          "iot:CreateThing"
        ],
        Resource = "*"
      },

      # Dead-letter queue access
      {
        Sid    = "SQSDeadLetterAccess",
        Effect = "Allow",
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:GetQueueAttributes",
          "sqs:DeleteMessage"
        ],
        Resource = "arn:aws:sqs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:*"
      }
    ]
  })
}

# Attach custom policy to Developers group
resource "aws_iam_group_policy_attachment" "developers_policy_attach" {
  group      = aws_iam_group.teams["Developers"].name
  policy_arn = aws_iam_policy.developers_policy.arn
}
