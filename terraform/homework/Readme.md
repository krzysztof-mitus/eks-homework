# homework

Deploy VPC with private and public subnets, NAT gateway, IGW.

Deploy EKS cluster with single NodeGroup.

Deploy helm chart with aws load-balancer-controller.

Deploy helm chart with simple echo geo-location service.



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.55.0 |
| <a name="provider_aws"></a> [kubernetes](#provider\_kubernetes) | >= 2.31.0 |
| <a name="provider_aws"></a> [helm](#provider\_helm_) | >= 2.14.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | Environment name | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS cluster name | `string` | n/a | yes |
| <a name="input_vpc\_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR block  | `string` | `10.0.0.0/16` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `eu-central-1` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply on all resources | `map(string)` | n/a | no |
| <a name="input_homework\_app\_image\_repo"></a> [homework\_app\_image\_repo](#input\_homework\_app\_image\_repo) | Homework app image repository | `string` | `` | yes |
| <a name="input\_homework\_app\_image\_tag"></a> [homework\_app\_image\_tag](#input\_homework\_app\_image\_tag) | Homework app image tag | `string` | `latest` | no |
| <a name="input\_homework\_app\_chart\_name"></a> [homework\_app\_chart\_name](#input\_homework\_app\_chart\_name) | Homework app Helm chart name | `string` | `` | yes |
| <a name="input\_homework\_app\_chart\_version"></a> [homework\_app\_chart\_version](#input\_homework\_app\_chart\_version) | Homework app Helm chart version | `string` | `` | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_url_homework_geolocation"></a> [url\_homework\_geolocation](#outputurl\_homework\_geolocation) | URL to geolocation service exposed by NLB |
| <a name="output_url_homework_index_html"></a> [url\_homework\_index\_html](#outputurl\_homework\_index\_html) | URL to echo service exposed by NLB |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->