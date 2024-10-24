resource "aws_ecs_service" "devops" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.devops.id
  task_definition = aws_ecs_task_definition.devops.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = true # Isso garante que a tarefa ECS terá um IP público
  }

  depends_on = [aws_ecs_task_definition.devops]
}

resource "aws_ecs_task_definition" "devops" {
  family                   = var.task_family
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      memory    = var.memory
      cpu       = var.cpu
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
    }
  ])

  tags = {
    Name = var.task_family
  }
}

resource "aws_ecs_service" "devops" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.devops.id
  task_definition = aws_ecs_task_definition.devops.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = true
  }

  depends_on = [aws_ecs_task_definition.devops]
}
