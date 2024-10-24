module "vpc" {
  source                = "./vpc"
  cidr_block            = "10.0.0.0/16"
  vpc_name              = "vpc-devops"
  region                = "us-east-1" # Altere para sua região caso necessário
  public_subnet_count   = 2
  private_subnet_count  = 2
  availability_zones    = ["us-east-1a", "us-east-1b"]
}

resource "aws_security_group" "ecs_security_group" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs_security_group"
  }
}

module "ecs" {
  source                = "./ecs"
  cluster_name          = "my-ecs-cluster"
  task_family           = "my-task-family"
  container_name        = "my-container"
  container_image       = "your-dockerhub-username/go-ecs-example" # Use sua imagem
  memory                = "512" # Memória em MB
  cpu                   = "256" # CPU em unidades
  container_port        = 8080
  service_name          = "my-ecs-service"
  desired_count         = 1
  subnet_ids            = module.vpc.public_subnet_ids
  security_group_ids    = [aws_security_group.ecs_security_group.id]
}

module "alb" {
  source                = "./alb"
  alb_name              = "my-alb"
  security_group_ids    = [aws_security_group.alb_security_group.id]
  subnet_ids            = module.vpc.public_subnet_ids
  target_group_name     = "my-target-group"
  vpc_id                = module.vpc.vpc_id
  desired_count         = 1
  ecs_task_id           = module.ecs.ecs_service_id
  target_group_port     = 8080
  health_check_path     = "/"
}