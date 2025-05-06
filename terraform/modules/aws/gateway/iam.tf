resource "aws_iam_role" "role_for_apigateway" {
  name               = "${var.project_name}-gateway"
  assume_role_policy = file("${path.module}/policies/apigateway_role.json")
}
# TODO: remove permissive policy after testing
resource "aws_iam_policy" "api_gateway_access" {
  name        = "${var.project_name}-gateway-access"
  description = "IAM policy for api_gateway"
  policy = templatefile("${path.module}/policies/apigateway_policy.json", {
    api_arn = aws_api_gateway_rest_api.this.arn
  })
}
resource "aws_iam_role_policy_attachment" "apigateway_access" {
  role       = aws_iam_role.role_for_apigateway.name
  policy_arn = aws_iam_policy.api_gateway_access.arn
}