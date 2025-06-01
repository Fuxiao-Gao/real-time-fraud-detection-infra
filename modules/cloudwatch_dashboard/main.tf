resource "random_id" "sagemaker_suffix" {
  byte_length = 4
}

resource "aws_cloudwatch_dashboard" "this" {
  dashboard_name = "${var.dashboard_name}-${random_id.sagemaker_suffix.hex}"
  dashboard_body = var.dashboard_body
}