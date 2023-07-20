


data "aws_iam_policy_document" "policy" {

  statement {
    actions = ["s3:ListAllMyBuckets"]
    effect  = "Deny"
    resources = [
      local.s3_bucket_arn,
      "${local.s3_bucket_arn}/*"
    ]
  }

  statement {
    actions = [
      "s3:GetObject*",
      "s3:GetBucket*",
      "s3:List*"
    ]
    effect = "Allow"
    resources = [
      local.s3_bucket_arn,
      "${local.s3_bucket_arn}/*"
    ]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:GetLogRecord",
      "logs:GetLogGroupFields",
      "logs:GetQueryResults"
    ]
    effect    = "Allow"
    resources = ["arn:${local.partition}:logs:${data.aws_region.current.name}:${local.account_id}:log-group:airflow-${var.name}-*"]
  }

  statement {
    actions   = ["logs:DescribeLogGroups"]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions   = ["s3:GetAccountPublicAccessBlock"]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions   = ["cloudwatch:PutMetricData"]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage",
      "sqs:SendMessage"
    ]
    effect    = "Allow"
    resources = ["arn:${local.partition}:sqs:${data.aws_region.current.name}:*:airflow-celery-*"]
  }

  statement {
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
      "kms:Encrypt"
    ]
    effect        = "Allow"
    not_resources = ["arn:${local.partition}:kms:*:${local.account_id}:key/*"]
    condition {
      test     = "StringLike"
      variable = "kms:ViaService"
      values = [
        "sqs.${data.aws_region.current.name}.amazonaws.com",
        "s3.${data.aws_region.current.name}.amazonaws.com"
      ]
    }
  }

  statement {
    actions   = ["airflow:PublishMetrics"]
    effect    = "Allow"
    resources = ["arn:${local.partition}:airflow:${data.aws_region.current.name}:${local.account_id}:environment/${var.name}"]
  }

  statement {
    count = var.trusting_accounts > 0 ? 1 : 0
    actions = ["sts:AssumeRole"]
    effect = "Allow"
    resources = [for account_id in var.trusting_accounts : "arn:aws:iam::${account_id}:role/*"]
  }
}


module "iam_role" {
  count                 = var.create_iam_role ? 1 : 0
  source                = "github.com/schubergphilis/terraform-aws-mcaf-role?ref=v0.3.2"
  name                  = "MWAA-${var.name}-role"
  create_policy         = true
  principal_identifiers = ["airflow-env.amazonaws.com", "airflow.amazonaws.com"]
  principal_type        = "Service"
  role_policy           = data.aws_iam_policy_document.policy.json
  tags                  = var.tags
  permissions_boundary  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/PermissionsBoundary"
}