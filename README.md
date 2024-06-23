# eks-homework

## Introduction 
Homework assignment consisting of:
- Simple python echo service
- Dockerfile and helm chart with python app
- Terraform with VPC/EKS infra + AWS load-balancer-controller and homework helm charts
- Terragrunt environments

Building and deploying docker image and helm chart is automated with GitHub workflow, that pushes images to ECR repositories. Currently docker image is hardcoded to latest and helm chart version to 0.1.0. 
AWS credentials are stored in GitHub secrets.

Terraform deployment is not automated due to lack of time.
Helm chart version and docker image tag are configured in environments/terragrunt.hcl

EKS public endpoint is exposed.

## Prerequisities
- aws cli
- kubectl cli
- terraform cli
- terragrunt cli


## Usage
1. Modify /app code, or index.html in chart/homework-app/templates/configmap.yaml
2. GitHub actions will automatically build docker and push image to ECR repo
3. GitHub actions will automatically build helm and push chart to ECR oci repo
4. Create s3 bucket for terraform backend if does not exist:
```
# aws s3api create-bucket --bucket krzysztof-homework-terraform-backend --region eu-central-1 --create-bucket-configuration LocationConstraint=eu-central-1
# aws s3api put-bucket-versioning --bucket krzysztof-homework-terraform-backend --versioning-configuration Status=Enabled
```
5. Select environment by entering the catalog and start terragrunt:
```
# cd environments/dev
# terragrunt apply 
```
6. Approve plan and wait
7. In web browser use url from terragrunt output url_homework_geolocation

