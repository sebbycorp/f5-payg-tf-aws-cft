# AWS F5 BIGIP-WAF Terraform Environment

The following repo provides the capability to build a fully functional F5-BIGIP Test environment in AWS. We are building the following
* Create AWC VPC network
* Uploading F5 BIGIP CFT to S3
* Deploying F5 BIG-IP 25Mbp Pay as you go (Reduce cost.. no need to run anythign expensive for a demo/test)
* Create a single server for testing 
* Deploy JucieShop
* Deploy Grafana


## Prerequisits

1. Storing our Terrafrom State in S3. So you will be required to configure S3 Bucket and a dynmanodb table/state.
2. I am hosting the f5 bigip CFT tempalte in my own S3 bucket incase I want to do my own customization 

## How to Use it

1. Clone the repo to your machine
2. Make the appropriate changes in the vars.tf to match your environment
3. Create the S3 bucket and edit the 
3. Initiate the terraform init
4. Terraform apply


