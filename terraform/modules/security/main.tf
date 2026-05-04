resource "aws_security_group" "alb" {
  name        = "${var.project}-${var.env}-alb-sg"
  description = "ALB security group"
  vpc_id      = var.vpc.id

  tags = {
    Name = "${var.project}-${var.env}-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "alb_to_ecs" {
  security_group_id            = aws_security_group.alb.id
  referenced_security_group_id = aws_security_group.ecs.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80

  tags = {
    Name = "Allow HTTP connections to the web security group"
  }
}

resource "aws_security_group" "ecs" {
  name        = "${var.project}-${var.env}-ecs-sg"
  description = "ECS security group"
  vpc_id      = var.vpc.id

  tags = {
    Name = "${var.project}-${var.env}-ecs-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_to_ecs" {
  security_group_id            = aws_security_group.ecs.id
  referenced_security_group_id = aws_security_group.alb.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.ecs.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}