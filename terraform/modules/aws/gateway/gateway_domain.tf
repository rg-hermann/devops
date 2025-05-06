resource "aws_api_gateway_domain_name" "domain_name" {
  regional_certificate_arn = var.certificate_arn
  domain_name     = var.gateway_url

  endpoint_configuration {
    types = ["REGIONAL"]
  }
  tags = var.tags
}
resource "aws_api_gateway_base_path_mapping" "path_mapping" {
  api_id      = aws_api_gateway_rest_api.this.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  domain_name = aws_api_gateway_domain_name.domain_name.domain_name
}

resource "aws_api_gateway_method_settings" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    logging_level = "INFO"
    data_trace_enabled = true
    metrics_enabled = true
  }
}