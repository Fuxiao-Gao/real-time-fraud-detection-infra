include {
  path = find_in_parent_folders()
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  
}

dependency "ecr_ecs" {
  config_path = "../ecr_ecs"
}

dependency "ecs_cluster" {
  config_path = "../ecs_cluster"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "kinesis_untagged" {
  config_path = "../kinesis_untagged"
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-ecs.git//modules/service?ref=v5.12.1"
}

inputs = {
  name        = local.env_vars.locals.ecs_service_name
  cluster_arn = dependency.ecs_cluster.outputs.arn
  launch_type = "FARGATE"

  # network configuration
  assign_public_ip = true
  security_group_ids = [dependency.vpc.outputs.default_security_group_id]
  subnet_ids = dependency.vpc.outputs.default_subnet_ids

  # compute configuration
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  desired_count = 1
  cpu = local.env_vars.locals.fargate_cpu
  memory = local.env_vars.locals.fargate_memory

  tasks_iam_role_name = "ecs-processor-iam-role"
  tasks_iam_role_statements = [
    {
      effect = "Allow"
      actions = [
        "kinesis:PutRecord",
        "kinesis:PutRecords",
        "kinesis:GetRecords",
        "kinesis:GetShardIterator",
        "kinesis:DescribeStream",
        "kinesis:DescribeStreamSummary",
        "kinesis:ListStreams"
      ]
      resources = [
        dependency.kinesis_untagged.outputs.stream_arn
      ]
    }
  ]

  task_exec_iam_role_name = "ecs-processor-execution-role"

  container_definitions = [
    {
      name      = local.env_vars.locals.ecs_service_name
      essential = true
      image     = "${dependency.ecr_ecs.outputs.repository_url}:$(local.env_vars.locals.version)"
      
      # create cloudwatch log group
      create_cloudwatch_log_group = true
      cloudwatch_log_group_name = "${local.env_vars.locals.ecs_log_group_prefix}/ecs-processor"
      cloudwatch_log_group_retention_in_days = 1

      port_mappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "KINESIS_STREAM_NAME"
          value = dependency.kinesis_untagged.outputs.stream_name
        },
        {
          name  = "AWS_REGION"
          value = local.env_vars.locals.region
        }
      ]

      log_configuration = {
        logDriver = "awslogs"
        options = {
          "awslogs-region"        = local.env_vars.locals.region
          "awslogs-group"         = "${local.env_vars.locals.ecs_log_group_prefix}/ecs-processor"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ]
}