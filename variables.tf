variable "aws_region" {
}

variable "access_key" {
}

variable "enviroment" {
}

variable "secret_key" {
}

variable "app_name" {
}

variable "app_image" {
}

variable "app_port" {
}

variable "app_count" {
}

variable "health_check_path" {
}

variable "health_check_match" {
}

variable "fargate_cpu" {
}

variable "fargate_memory" {
}

variable "ecs_task_execution_role" {
}

variable "acm" {
}

variable "domain" {
}

variable "zone_id" {
}

variable "vpc_id" {
}

variable "subnet_ids" { 
}
variable "tags" { 
}

variable "redis_host" {
  default = ""
}

variable "alb_id" {
}

variable "alb_security_group" {
}

variable "alb_listener" {
}

variable "alb_endpoint" {
}