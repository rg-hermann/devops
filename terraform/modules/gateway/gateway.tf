resource "aws_api_gateway_rest_api" "this" {
  name = "${var.project_name}-api"
  binary_media_types = [
    "*/*"
  ]
  tags = merge({ Name = "${var.project_name}-api" },
    var.tags
  )
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = local.stage_name

  tags = var.tags
  lifecycle {
    ignore_changes = [deployment_id]
  }
}