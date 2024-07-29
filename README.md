## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
|  [aws](#provider\_aws) | 4.59.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
|  [iam\_role](#module\_iam\_role) | github.com/schubergphilis/terraform-aws-mcaf-role | v0.3.2 |
|  [s3\_bucket](#module\_s3\_bucket) | github.com/sbpdvb/terraform-aws-mcaf-s3 | v0.6.1 |

## Resources

| Name | Type |
|------|------|
| [aws_mwaa_environment.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mwaa_environment) | resource |
| [aws_security_group.mwaa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|  [airflow\_configuration\_options](#input\_airflow\_configuration\_options) | The Airflow override options | `any` | `null` | no |
|  [airflow\_version](#input\_airflow\_version) | Airflow version of the MWAA environment. | `string` | n/a | yes |
|  [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | A list of IPv4 CIDRs to allow access to the security group created by this module.The length of this list must be known at "plan" time. | `list(string)` | `[]` | no |
|  [associated\_security\_group\_ids](#input\_associated\_security\_group\_ids) | A list of IDs of Security Groups to associate the created resource with, in addition to the created security group.These security groups will not be modified and, if `create_security_group` is `false`, must have rules providing the desired access. | `list(string)` | `[]` | no |
|  [create\_iam\_role](#input\_create\_iam\_role) | Enabling or disabling the creatation of a default IAM Role for AWS MWAA | `bool` | `true` | no |
|  [create\_s3\_bucket](#input\_create\_s3\_bucket) | Enabling or disabling the creatation of an S3 bucket for AWS MWAA | `bool` | `true` | no |
|  [create\_security\_group](#input\_create\_security\_group) | Enabling or disabling the creatation of a default SecurityGroup for AWS MWAA | `bool` | `true` | no |
|  [dag\_processing\_logs\_enabled](#input\_dag\_processing\_logs\_enabled) | Enabling or disabling the collection of logs for processing DAGs | `bool` | `false` | no |
|  [dag\_processing\_logs\_level](#input\_dag\_processing\_logs\_level) | DAG processing logging level. Valid values: CRITICAL, ERROR, WARNING, INFO, DEBUG | `string` | `"INFO"` | no |
|  [dag\_s3\_path](#input\_dag\_s3\_path) | The relative path to the DAG folder on your Amazon S3 storage bucket. | `string` | `"dags"` | no |
|  [environment\_class](#input\_environment\_class) | Environment class for the cluster. Possible options are mw1.small, mw1.medium, mw1.large. | `string` | `"mw1.small"` | no |
|  [execution\_role\_arn](#input\_execution\_role\_arn) | If `create_iam_role` is `false` then set this to the target MWAA execution role | `string` | `""` | no |
|  [endpoint_management](#input\_endpoint_management) | Specifies whether the environment should be managed by MWAA. Possible options: SERVICE (default) or CUSTOMER. | `string` | `"SERVICE"` | no |
|  [kms\_key](#input\_kms\_key) | The Amazon Resource Name (ARN) of your KMS key that you want to use for encryption. Will be set to the ARN of the managed KMS key aws/airflow by default. | `string` | `null` | no |
|  [kms_key_arn](#input\_kms_key_arn) | The Amazon Resource Name (ARN) of your KMS key that you want to use for encryption. | `string` | `null` | no |
|  [log\_bucket](#input\_log\_bucket) | n/a | `string` | `null` | no |
|  [max\_workers](#input\_max\_workers) | The maximum number of workers that can be automatically scaled up. Value need to be between 1 and 25. | `number` | `10` | no |
|  [min\_workers](#input\_min\_workers) | The minimum number of workers that you want to run in your environment. | `number` | `1` | no |
|  [name](#input\_name) | n/a | `string` | n/a | yes |
|  [plugins\_s3\_object\_version](#input\_plugins\_s3\_object\_version) | The plugins.zip file version you want to use. | `string` | `null` | no |
|  [plugins\_s3\_path](#input\_plugins\_s3\_path) | The relative path to the plugins.zip file on your Amazon S3 storage bucket. For example, plugins.zip. If a relative path is provided in the request, then plugins\_s3\_object\_version is required | `string` | `null` | no |
|  [policy](#policy) |  A valid bucket policy JSON document. | `string` | `null` | no |
|  [requirements\_s3\_object\_version](#input\_requirements\_s3\_object\_version) | The requirements.txt file version you want to use. | `string` | `null` | no |
|  [requirements\_s3\_path](#input\_requirements\_s3\_path) | The relative path to the requirements.txt file on your Amazon S3 storage bucket. For example, requirements.txt. If a relative path is provided in the request, then requirements\_s3\_object\_version is required | `string` | `null` | no |
|  [scheduler\_logs\_enabled](#input\_scheduler\_logs\_enabled) | Enabling or disabling the collection of logs for the schedulers | `bool` | `false` | no |
|  [scheduler\_logs\_level](#input\_scheduler\_logs\_level) | Schedulers logging level. Valid values: CRITICAL, ERROR, WARNING, INFO, DEBUG | `string` | `"INFO"` | no |
|  [source\_bucket\_arn](#input\_source\_bucket\_arn) | If `create_s3_bucket` is `false` then set this to the Amazon Resource Name (ARN) of your Amazon S3 storage bucket. | `string` | `null` | no |
|  [startup\_script\_s3\_path](#input\_startup\_script\_s3\_path) | The relative path to the startup script on your Amazon S3 storage bucket. For example, startup.sh. | `string` | `null` | no |
|  [subnet\_ids](#input\_subnet\_ids) | The private subnet IDs in which the environment should be created. MWAA requires two subnets | `list(string)` | n/a | yes |
|  [tags](#input\_tags) | n/a | `map` | `{}` | no |
|  [task\_logs\_enabled](#input\_task\_logs\_enabled) | Enabling or disabling the collection of logs for DAG tasks | `bool` | `false` | no |
|  [task\_logs\_level](#input\_task\_logs\_level) | DAG tasks logging level. Valid values: CRITICAL, ERROR, WARNING, INFO, DEBUG | `string` | `"INFO"` | no |
|  [trusting\_accounts](#input\_trusting\_accounts) | Account IDs that will trust this MWAA cluster to assume roles. | `list(string)` | `[]` | no |
|  [vpc\_id](#input\_vpc\_id) | VPC id | `string` | n/a | yes |
|  [webserver\_access\_mode](#input\_webserver\_access\_mode) | Specifies whether the webserver should be accessible over the internet or via your specified VPC. Possible options: PRIVATE\_ONLY (default) and PUBLIC\_ONLY. | `string` | `"PRIVATE_ONLY"` | no |
|  [webserver\_logs\_enabled](#input\_webserver\_logs\_enabled) | Enabling or disabling the collection of logs for the webservers | `bool` | `false` | no |
|  [webserver\_logs\_level](#input\_webserver\_logs\_level) | Webserver logging level. Valid values: CRITICAL, ERROR, WARNING, INFO, DEBUG | `string` | `"INFO"` | no |
|  [weekly\_maintenance\_window\_start](#input\_weekly\_maintenance\_window\_start) | Specifies the start date for the weekly maintenance window. | `string` | `null` | no |
|  [worker\_logs\_enabled](#input\_worker\_logs\_enabled) | Enabling or disabling the collection of logs for the workers | `bool` | `false` | no |
|  [worker\_logs\_level](#input\_worker\_logs\_level) | Workers logging level. Valid values: CRITICAL, ERROR, WARNING, INFO, DEBUG | `string` | `"INFO"` | no |

## Outputs

| Name | Description |
|------|-------------|
|  [arn](#output\_arn) | The ARN of the Amazon MWAA Environment |
|  [created\_at](#output\_created\_at) | The Created At date of the Amazon MWAA Environment |
|  [execution\_role\_arn](#output\_execution\_role\_arn) | IAM Role ARN for Amazon MWAA Execution Role |
|  [logging\_configuration](#output\_logging\_configuration) | The Logging Configuration of the Amazon MWAA Environment |
|  [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | ARN of the S3 bucket |
|  [security\_group\_arn](#output\_security\_group\_arn) | The ARN of the created security group |
|  [security\_group\_id](#output\_security\_group\_id) | The ID of the created security group |
|  [security\_group\_name](#output\_security\_group\_name) | The name of the created security group |
|  [service\_role\_arn](#output\_service\_role\_arn) | The Service Role ARN of the Amazon MWAA Environment |
|  [status](#output\_status) | The status of the Amazon MWAA Environment |
|  [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider for the Amazon MWAA Environment |
|  [webserver\_url](#output\_webserver\_url) | The webserver URL of the Amazon MWAA Environment |
