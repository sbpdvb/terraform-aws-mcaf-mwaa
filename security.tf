resource "aws_security_group" "mwaa" {
  count       = var.create_security_group ? 1 : 0
  name        = var.name
  description = "Allow traffic to the MWAA"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    description = "Allow ingress Amazon MWAA traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  #todo: change it to 443
  ingress {
    description = "Allow traffic from ALB over HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    description = "Allow login ingress from VDI"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

