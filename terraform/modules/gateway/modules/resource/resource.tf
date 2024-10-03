resource "aws_api_gateway_resource" "root" {
  parent_id   = var.root_resource_id
  path_part   = var.endpoint
  rest_api_id = var.rest_api_id
}
resource "aws_api_gateway_resource" "proxy" {
  parent_id   = aws_api_gateway_resource.root.id
  path_part   = "{proxy+}"
  rest_api_id = var.rest_api_id
}

resource "aws_api_gateway_method" "any" {
  authorization = "NONE"
  http_method   = "ANY"
  resource_id   = aws_api_gateway_resource.proxy.id
  rest_api_id   = var.rest_api_id
  request_parameters   = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "nlb_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = aws_api_gateway_method.any.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  connection_type         = "VPC_LINK"
  connection_id           = var.vpc_link_id
  uri                     = "${var.proxy_url}/{proxy}"
  cache_namespace         = "proxy"
  request_parameters      = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

resource "aws_api_gateway_method_response" "success200" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.any.http_method
  status_code = "200"

  response_models     = {
    "application/json" = "Empty"
  }
}