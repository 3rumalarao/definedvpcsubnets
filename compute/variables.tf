variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "selected_private_subnet" {
  description = "Selected private subnet"
  type        = string
}

variable "selected_public_subnet" {
  description = "Selected public subnet"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "private_servers" {
  description = "Map of private server configurations"
  type = map(object({
    ami_ids         = list(string)
    instance_type   = string
    security_groups = list(string)
    key_name        = string
    subnet_id       = string
  }))
}

variable "applications" {
  description = "Map of application configurations"
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
  description = "Map of public instance configurations"
  type = map(object({
    ami_ids         = list(string)
    instance_type   = string
    security_groups = list(string)
    key_name        = string
    subnet_id       = string
  }))
}

variable "common_iam_role" {
  description = "IAM role to attach to instances"
  type        = string
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}

variable "vpc_security_group_ids" {
  description = "Mapping of security group names to their IDs"
  type        = map(string)
}
