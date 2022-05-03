module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "simple-vpc"
  cidr = "10.2.0.0/16"

  azs             = ["ca-central-1a", "ca-central-1b"]
  private_subnets = ["10.2.1.0/24", "10.2.2.0/24"]
  public_subnets  = ["10.2.101.0/24", "10.2.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false

  tags = {
    Name       = "simple-vpc"
    Enviroment = "Production"
  }

}


resource "aws_alb" "alb" {
  name            = "production-load-balancer"
  subnets         =  data.tfe_outputs.network.values.public_subnets
  security_groups = [aws_security_group.alb-sg.id]

  tags = local.tags
}

resource "aws_security_group" "alb-sg" {
  name        = "production-load-balancer-security-group"
  description = "controls access to the ALB"
  vpc_id      = data.tfe_outputs.network.values.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = "80"
    to_port     = "80"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = "81"
    to_port     = "81"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = "82"
    to_port     = "82"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = "83"
    to_port     = "83"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = "84"
    to_port     = "84"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = "85"
    to_port     = "85"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = "86"
    to_port     = "86"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


module "service" {
  source = "../"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
  redis_host              = ""

  acm                     = "arn:aws:acm:us-east-1:398010631141:certificate/cff2586e-5786-498e-af36-65d341c8c5f2"
  zone_id                 = "Z00787111IN1MHIN1J7WT"
  app_name                = "service-stack-example"
  app_image               = "398010631141.dkr.ecr.ca-central-1.amazonaws.com/backend:latest"
  app_port                = 80
  app_count               = 1
  domain                  = "api3.stagetry.io"
  health_check_path       = "/"
  fargate_cpu             = 256
  fargate_memory          = 512
  health_check_match      = 200
  ecs_task_execution_role = "myECcsTaskExecutionRole"

  tags = var.tags
}
