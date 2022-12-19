data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

locals {

  account_id             = data.aws_caller_identity.current.account_id
  partition              = data.aws_partition.current.partition
  security_group_ids     = var.create_security_group ? concat(var.associated_security_group_ids, aws_security_group.mwaa[*].id) : var.associated_security_group_ids
  s3_bucket_arn          = var.create_s3_bucket ? module.s3_bucket[0].arn : var.source_bucket_arn
  execution_role_arn     = var.create_iam_role ? module.iam_role[0].arn : var.execution_role_arn
}


module "s3_bucket" {
  count = var.create_s3_bucket ? 1 : 0
  source     = "github.com/sbpdvb/terraform-aws-mcaf-s3?ref=v0.6.1"
  name       = "${var.name}-mwaa"
  versioning = true
  tags       = var.tags
  #policy     = data.aws_iam_policy_document.processed_bucket_policy.json
  logging = {
    target_bucket = var.log_bucket
    target_prefix = "${var.name}-mwaa"
  }
}

resource "aws_mwaa_environment" "default" {
  name                            = var.name
  airflow_configuration_options   = var.airflow_configuration_options
  airflow_version                 = var.airflow_version
  dag_s3_path                     = var.dag_s3_path
  environment_class               = var.environment_class
  kms_key                         = var.kms_key
  max_workers                     = var.max_workers
  min_workers                     = var.min_workers
  plugins_s3_object_version       = var.plugins_s3_object_version
  plugins_s3_path                 = var.plugins_s3_path
  requirements_s3_object_version  = var.requirements_s3_object_version
  requirements_s3_path            = var.requirements_s3_path
  webserver_access_mode           = var.webserver_access_mode
  weekly_maintenance_window_start = var.weekly_maintenance_window_start
  source_bucket_arn               = local.s3_bucket_arn
  execution_role_arn              = local.execution_role_arn

  logging_configuration {
    dag_processing_logs {
      enabled   = var.dag_processing_logs_enabled
      log_level = var.dag_processing_logs_level
    }

    scheduler_logs {
      enabled   = var.scheduler_logs_enabled
      log_level = var.scheduler_logs_level
    }

    task_logs {
      enabled   = var.task_logs_enabled
      log_level = var.task_logs_level
    }

    webserver_logs {
      enabled   = var.webserver_logs_enabled
      log_level = var.webserver_logs_level
    }

    worker_logs {
      enabled   = var.worker_logs_enabled
      log_level = var.worker_logs_level
    }
  }

  network_configuration {
    security_group_ids = local.security_group_ids
    subnet_ids         = slice(var.subnet_ids,0,2)
  }

  tags = var.tags
}