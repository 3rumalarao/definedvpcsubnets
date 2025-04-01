variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets" {
  description = "Subnets for the ALB (should be private subnets for internal ALB)"
  type        = list(string)
}

variable "applications" {
  description = "Map of application configurations (for naming purposes)"
  type = map(object({
    domain_name = string
  }))
}

variable "app_instance_ids" {
  description = "Mapping of application name to list of instance IDs from compute module"
  type        = map(list(string))
}

variable "alb_security_group_ids" {
  description = "List of security group IDs for the ALB"
  type        = list(string)
}

variable "app_port" {
  description = "Port on which the application is running (and ALB listens on)"
  type        = number
  default     = 80
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}
