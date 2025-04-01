security_groups = {
  "private-sg" = {
    name        = "private-sg"
    description = "Security group for private servers"
    ingress     = [
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      },
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]
    egress      = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  "additional-sg1" = {
    name        = "additional-sg1"
    description = "Additional SG for private-app1"
    ingress     = [
      {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["10.0.1.0/24"]
      }
    ]
    egress      = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  "additional-sg2" = {
    name        = "additional-sg2"
    description = "Additional SG for private-app2"
    ingress     = [
      {
        from_port   = 9090
        to_port     = 9090
        protocol    = "tcp"
        cidr_blocks = ["10.0.2.0/24"]
      }
    ]
    egress      = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  "app1-sg" = {
    name        = "app1-sg"
    description = "Security group for application app1"
    ingress     = [
      {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["10.0.1.0/24"]
      }
    ]
    egress      = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  "custom-app1-sg" = {
    name        = "custom-app1-sg"
    description = "Custom additional SG for application app1"
    ingress     = [
      {
        from_port   = 8443
        to_port     = 8443
        protocol    = "tcp"
        cidr_blocks = ["10.0.1.0/24"]
      }
    ]
    egress      = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  "app2-sg" = {
    name        = "app2-sg"
    description = "Security group for application app2"
    ingress     = [
      {
        from_port   = 8081
        to_port     = 8081
        protocol    = "tcp"
        cidr_blocks = ["10.0.2.0/24"]
      }
    ]
    egress      = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  "custom-app2-sg" = {
    name        = "custom-app2-sg"
    description = "Custom additional SG for application app2"
    ingress     = [
      {
        from_port   = 8444
        to_port     = 8444
        protocol    = "tcp"
        cidr_blocks = ["10.0.2.0/24"]
      }
    ]
    egress      = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  "app3-sg" = {
    name        = "app3-sg"
    description = "Security group for application app3"
    ingress     = [
      {
        from_port   = 8082
        to_port     = 8082
        protocol    = "tcp"
        cidr_blocks = ["10.0.3.0/24"]
      }
    ]
    egress      = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  "custom-app3-sg" = {
    name        = "custom-app3-sg"
    description = "Custom additional SG for application app3"
    ingress     = [
      {
        from_port   = 8445
        to_port     = 8445
        protocol    = "tcp"
        cidr_blocks = ["10.0.3.0/24"]
      }
    ]
    egress      = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  "public-sg" = {
    name        = "public-sg"
    description = "Security group for public instances"
    ingress     = [
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress      = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  "custom-public-sg" = {
    name        = "custom-public-sg"
    description = "Custom additional SG for public instances"
    ingress     = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress      = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  "rds-sg" = {
    name        = "rds-sg"
    description = "Security group for RDS instance"
    ingress     = [
      {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]
    egress      = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },
  "alb-sg" = {
    name        = "alb-sg"
    description = "Security group for internal ALB"
    ingress     = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
      }
    ]
    egress      = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
}
