output "api_gateway_invoke_url" {
  value = "${aws_api_gateway_deployment.this.invoke_url}${aws_api_gateway_stage.this.stage_name}"
}
output "api_gateway_regional_domain_name" {
  value = aws_api_gateway_domain_name.domain_name.regional_domain_name
}