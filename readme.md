# ACA infrastructure
A terraform porject that show how to deploy a complet azure container app infrastrucutre with terraform

## deployment Workflow :

1- Clone the git repo 

2- initialization

$ cd deployment && terraform init

3- Validation

$ terraform validate

4- Plan and apply

$ terraform plan  -out out.plan

$ terraform apply  out.plan
