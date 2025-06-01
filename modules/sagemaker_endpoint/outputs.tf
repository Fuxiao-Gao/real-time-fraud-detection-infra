output "model_arn" {
  description = "The ARN of the SageMaker model"
  value       = aws_sagemaker_model.this.arn
}

output "model_name" {
  description = "The name of the SageMaker model"
  value       = aws_sagemaker_model.this.name
}

output "endpoint_config_arn" {
  description = "The ARN of the SageMaker endpoint configuration"
  value       = aws_sagemaker_endpoint_configuration.this.arn
}

output "endpoint_config_name" {
  description = "The name of the SageMaker endpoint configuration"
  value       = aws_sagemaker_endpoint_configuration.this.name
}

output "endpoint_arn" {
  description = "The ARN of the SageMaker endpoint"
  value       = aws_sagemaker_endpoint.this.arn
}

output "endpoint_name" {
  description = "The name of the SageMaker endpoint"
  value       = aws_sagemaker_endpoint.this.name
}