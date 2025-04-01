# Environment and common tags
environment      = "prod"
project          = "my-project"
owner            = "team@example.com"
region           = "us-east-1"

# Existing VPC details provided by CCOE
vpc_id           = "vpc-0abcd1234efgh5678"

# Multiple Subnets as provided by CCOE
public_subnets   = [
  "subnet-0123456789abcdef0",
  "subnet-0fedcba9876543210",
  "subnet-0abcdef0123456789"
]
private_subnets  = [
  "subnet-0a1b2c3d4e5f6a7b",
  "subnet-0b7a6f5e4d3c2b1a",
  "subnet-0123abcd4567efgh"
]

# Dynamic selection for server placement
selected_private_subnet = "subnet-0a1b2c3d4e5f6a7b"
selected_public_subnet  = "subnet-0123456789abcdef0"

availability_zones = ["us-east-1a", "us-east-1b"]

# Optional IAM role for compute resources
common_iam_role  = "my-common-iam-role"

###############################
# Compute Resources
###############################

# 1. Private Servers (all in a single dynamic private subnet)
private_servers = {
  "private-app1" = {
    ami_ids         = ["ami-0a1b2c3d4e5f6g7h8"]
    instance_type   = "t3.medium"
    security_groups = ["private-sg", "additional-sg1"]
    key_name        = "mykey"
    subnet_id       = selected_private_subnet
  },
  "private-app2" = {
    ami_ids         = ["ami-1a2b3c4d5e6f7g8h9"]
    instance_type   = "t3.medium"
    security_groups = ["private-sg", "additional-sg2"]
    key_name        = "mykey"
    subnet_id       = selected_private_subnet
  }
  # Additional private server entries can be added here (up to 14-20 instances)
}

# 2. Application Servers (AZ Spread: 2 per application across 2 AZs)
applications = {
  "app1" = {
    ami_ids         = ["ami-12345678"]
    instance_type   = "m5.xlarge"
    security_groups = ["app1-sg", "custom-app1-sg"]
    domain_name     = "app1-prod.internal.example.com"
    key_name        = "mykey"
    subnet_ids      = [ private_subnets[0], private_subnets[1] ]
  },
  "app2" = {
    ami_ids         = ["ami-23456789"]
    instance_type   = "t3.large"
    security_groups = ["app2-sg", "custom-app2-sg"]
    domain_name     = "app2-prod.internal.example.com"
    key_name        = "mykey"
    subnet_ids      = [ private_subnets[0], private_subnets[1] ]
  },
  "app3" = {
    ami_ids         = ["ami-34567890"]
    instance_type   = "m5.large"
    security_groups = ["app3-sg", "custom-app3-sg"]
    domain_name     = "app3-prod.internal.example.com"
    key_name        = "mykey"
    subnet_ids      = [ private_subnets[0], private_subnets[1] ]
  }
  # Additional application entries can be added here
}

# 3. Public Instances (all in a single dynamic public subnet)
public_instances = {
  "public-app1" = {
    ami_ids         = ["ami-45678901"]
    instance_type   = "t3.medium"
    security_groups = ["public-sg", "custom-public-sg"]
    key_name        = "mypublickey"
    subnet_id       = selected_public_subnet
  },
  "public-app2" = {
    ami_ids         = ["ami-56789012"]
    instance_type   = "t3.medium"
    security_groups = ["public-sg", "custom-public-sg"]
    key_name        = "mypublickey"
    subnet_id       = selected_public_subnet
  }
  # Additional public instance entries can be added here (up to 14-20 instances)
}

###############################
# Additional Services
###############################

# EFS Configuration
efs = {
  performance_mode = "generalPurpose"
  encrypted        = true
  efs_mount_points = ["/mnt/efs1", "/mnt/efs2"]
}

# RDS MySQL (Production Only)
rds_mysql = {
  enabled               = true
  engine                = "mysql"
  instance_class        = "db.t3.medium"
  allocated_storage     = 20
  backup_retention_days = 7
  security_groups       = ["rds-sg"]
  subnet_ids            = private_subnets
}

# Backup & Observability (Production Only)
backup_and_observability = {
  enable_backup         = true
  backup_schedule       = "cron(0 12 * * ? *)"  # daily backup at 12 UTC
  backup_retention_days = 7
  enable_vpc_flow_logs  = true
}

###############################
# Common Tags
###############################
common_tags = {
  Environment = environment
  Project     = project
  Owner       = owner
}
