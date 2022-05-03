resource "aws_lb_listener_rule" "default" {
  listener_arn = var.alb_listener

  action {
    type = "forward"
    target_group_arn = aws_alb_target_group.default.arn
  }

  condition {
    http_header {
      http_header_name = "X-Forwarded-For"
      values           = [var.app_name]
    }
  }
}