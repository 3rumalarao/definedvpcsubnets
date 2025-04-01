# Create an internal ALB for each application
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

# Create a listener for each ALB
resource "aws_lb_listener" "this" {
  for_each = aws_lb.this

  load_balancer_arn = each.value.arn
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.key].arn
  }
}

# Attach each application instance as a target in the corresponding target group
resource "aws_lb_target_group_attachment" "this" {
  for_each = var.applications

  count = length(var.app_instance_ids[each.key])

  target_group_arn = aws_lb_target_group.this[each.key].arn
  target_id        = var.app_instance_ids[each.key][count.index]
  port             = var.app_port
}
