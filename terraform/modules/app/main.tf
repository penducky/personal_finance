# APPLICATION LOAD BALANCER
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  load_balancer_type = "application"
  security_groups    = [var.sg_alb.id]
  subnets            = [for subnet in var.public_subnet : subnet.id]
}

resource "aws_lb_target_group" "test" {
  name        = "tf-example-lb-alb-tg"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc.id
}

resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}

# IAM
data "aws_iam_role" "ecs_task" {
  name = "ecsTaskExecutionRole"
}

# ECR
resource "aws_ecr_repository" "main" {
  name                 = var.ecr_repo_name
    force_delete        = true
}

# ECS CLUSTER
resource "aws_ecs_cluster" "main" {
  name = "${var.project}-${var.env}-ecs-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = data.aws_iam_role.ecs_task.arn
  task_role_arn           = data.aws_iam_role.ecs_task.arn
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024

  container_definitions    = jsonencode([
    {
      name      = "nginx"
      image     = "nginx"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = "${var.project}-${var.env}-ecs-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [for subnet in var.private_subnet : subnet.id]
    security_groups  = [var.sg_ecs.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.test.arn
    container_name   = "nginx"
    container_port   = 80
  }

  # placement_constraints {
  #   type       = "memberOf"
  #   expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  # }
}

