resource "aws_api_gateway_vpc_link" "link" {
  count = length(var.endpoints)
  name        = "${var.project_name}-link-${var.endpoints[count.index].name}"
  description = "VPC Link to ${var.project_name} - ${var.endpoints[count.index].name}"
  target_arns = [var.endpoints[count.index].alb_arn]
}