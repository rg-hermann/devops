module "proxy_resources" {
  count = length(var.endpoints)
  source = "./modules/resource"
  vpc_link_id = aws_api_gateway_vpc_link.link[count.index].id
  root_resource_id = aws_api_gateway_rest_api.this.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.this.id
  endpoint = var.endpoints[count.index].name
  proxy_url = var.endpoints[count.index].proxy_url
}