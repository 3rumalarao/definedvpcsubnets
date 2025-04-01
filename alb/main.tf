# Create an internal ALB for each application (using the keys of var.applications)
resource "aws_lb" "this" {
  for_each = var.applications

  name               = "${each.key}-alb"
  internal           = true
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = var.alb_security_group_ids

  tags = merge(var.common_tags, {
    Name = "${each.key}-alb"
  })
}

# Create a target group for each application
resource "aws_lb_target_group" "this" {
  for_each = var.applications

  name     = "${each.key}-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
  }

  target_type = "instance"

  tags = merge(var.common_tags, {
    Name = "${each.key}-tg"
  })
}

locals {
  # Flatten the application instances mapping into a list of attachments.
  attachment_targets = flatten([
    for app, ids in var.app_instance_ids : [
      for id in ids : {
        app_name    = app,
        instance_id = id
      }
    ]
  ])
}

# Attach each application instance to its target group.
resource "aws_lb_target_group_attachment" "this" {
  for_each = { for t in local.attachment_targets : "${t.app_name}-${t.instance_id}" => t }

  target_group_arn = aws_lb_target_group.this[each.value.app_name].arn
  target_id        = each.value.instance_id
  port             = var.app_port
}
