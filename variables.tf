variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, qa, uat, prod)"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
}

variable "vpc_id" {
  description = "Existing VPC ID provided by CCOE"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets provided by CCOE"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnets provided by CCOE"
  type        = list(string)
}

variable "selected_private_subnet" {
  description = "Dynamically selected private subnet for all private_servers"
  type        = string
}

variable "selected_public_subnet" {
  description = "Dynamically selected public subnet for all public_instances"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "common_iam_role" {
  description = "Common IAM role attached to compute resources"
  type        = string
}

variable "private_servers" {
  description = "Map of private server configurations (up to 14-20 entries)"
  type = map(object({
    ami_ids         = list(string)
    instance_type   = string
    security_groups = list(string)
    key_name        = string
    subnet_id       = string
  }))
}

variable "applications" {
  description = "Map of application configurations (each creates 2 instances across AZs)"
  type = map(object({
    ami_ids         = list(string)
    instance_type   = string
    security_groups = list(string)
    domain_name     = string
    key_name        = string
    subnet_ids      = list(string)
  }))
}

variable "public_instances" {
  description = "Map of public instance configurations (up to 14-20 entries)"
  type = map(object({
    ami_ids         = list(string)
    instance_type   = string
    security_groups = list(string)
    key_name        = string
    subnet_id       = string
  }))
}

variable "efs" {
  description = "EFS configuration"
  type = object({
    performance_mode = string
    encrypted        = bool
    efs_mount_points = list(string)
  })
}

variable "efs_security_groups" {
  description = "Security groups for EFS mount targets (if applicable)"
  type        = list(string)
  default     = []
}

variable "rds_mysql" {
  description = "RDS MySQL configuration (Production Only)"
  type = object({
    enabled               = bool
    engine                = string
    instance_class        = string
    allocated_storage     = number
    backup_retention_days = number
    security_groups       = list(string)
    subnet_ids            = list(string)
  })
}

variable "db_username" {
  description = "RDS MySQL username"
  type        = string
}

variable "db_password" {
  description = "RDS MySQL password"
  type        = string
  sensitive   = true
}

variable "backup_and_observability" {
  description = "Backup and Observability configuration (Production Only)"
  type = object({
    enable_backup         = bool
    backup_schedule       = string
    backup_retention_days = number
    enable_vpc_flow_logs  = bool
  })
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
}

variable "security_groups" {
  description = "Map of security group definitions to be created"
  type = map(object({
    name        = string
    description = string
    ingress     = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress      = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}
