variable "vpc_id" {
  description = "VPC id to attach the security groups"
  type        = string
}

variable "security_groups" {
  description = "Map of security group definitions"
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

variable "common_tags" {
  description = "Common tags for the security groups"
  type        = map(string)
}
