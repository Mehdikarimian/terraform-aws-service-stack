resource "aws_alb_target_group" "default" {
  name        = var.app_name
  port        = var.app_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  tags = local.tags
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = var.health_check_match
    path                = var.health_check_path
    interval            = 30
  }
}

#redirecting all incomming traffic from ALB to the target group
resource "aws_alb_listener" "default" {
  load_balancer_arn = var.alb_id
  port              = var.app_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.default.arn
  }
}
