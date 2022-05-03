# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "default" {
  name              = "/ecs/${var.app_name}"
  retention_in_days = 30

  tags = local.tags
}

resource "aws_cloudwatch_log_stream" "default" {
  name           = "${var.app_name}_log_stream"
  log_group_name = aws_cloudwatch_log_group.default.name
}
