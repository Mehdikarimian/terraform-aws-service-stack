# this security group for ecs - Traffic to the ECS cluster should only come from the ALB
resource "aws_security_group" "ecs_sg" {
  name        = "${var.app_name}-security-group"
  description = "allow inbound access from the ALB only"
  vpc_id      = var.vpc_id

  tags = local.tags

  ingress {
    protocol        = "tcp"
    from_port       = var.app_port
    to_port         = var.app_port
    security_groups = [var.security_group]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
