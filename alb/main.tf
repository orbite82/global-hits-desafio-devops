resource "aws_lb" "devops" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.devops.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.devops.arn
  }
}

resource "aws_lb_target_group" "devops" {
  name     = var.target_group_name
  port     = 8080 # Porta onde a aplicação Go está escutando
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold  = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = var.target_group_name
  }
}

resource "aws_lb_target_group_attachment" "ecs" {
  count              = var.desired_count
  target_group_arn   = aws_lb_target_group.devops.arn
  target_id          = var.ecs_task_id
  port               = 8080
}