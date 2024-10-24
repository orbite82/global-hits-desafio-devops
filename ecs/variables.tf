variable "cluster_name" {
  description = "Name of the ECS Cluster"
  type        = string
}

variable "task_family" {
  description = "Family of the ECS Task"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_image" {
  description = "Docker image for the container"
  type        = string
}

variable "memory" {
  description = "Memory for the container"
  type        = string
}

variable "cpu" {
  description = "CPU units for the container"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
}

variable "service_name" {
  description = "Name of the ECS Service"
  type        = string
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "List of subnet IDs for the service"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the service"
  type        = list(string)
}
