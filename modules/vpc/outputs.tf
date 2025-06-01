
output "default_vpc_id" {
  value = data.aws_vpc.default.id
}

output "default_subnet_ids" {
  value = data.aws_subnets.default.ids
}

output "default_security_group_id" {
  value = data.aws_security_group.default.id
}
