# AWS OIDC Identity provider creator
This project is a simple terraform configuration files to create an Identity Provider under 
AWS Identity and Access Management.
This OIDC provider must be used than to attach on it roles to be used for the dynamic 
provider credential feature on TFC (each workspace can auth to AWS itself to ask for dynamic 
credentials).

## What you need to have
* AWS root credentials
* TFE token (to create variable set)

### Mandatory variables: 
Those are the variable that you must need to configure: aws_region, tfc_org_name

### CLI-drive workflow
Create a backend.tf file in case you would like to follow CLI-driven workflow

terraform {
  cloud {
    organization = ""

    workspaces {
      name = ""
    }
  }
}