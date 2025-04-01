variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "rds_mysql" {
  description = "RDS MySQL configuration"
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

variable "common_tags" {
  type = map(string)
}

variable "environment" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
