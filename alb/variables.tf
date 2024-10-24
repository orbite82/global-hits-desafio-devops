variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs for the ALB"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "target_group_name" {
  description = "Name of the target group for ECS"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB and Target Group will be created"
  type        = string
}

variable "desired_count" {
  description = "Desired number of tasks in ECS"
  type        = number
}

variable "ecs_task_id" {
  description = "Task ID for the ECS service to register in the target group"
  type        = string
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
}

variable "health_check_path" {
  description = "Path for the health check"
  type        = string
  default     = "/"
}