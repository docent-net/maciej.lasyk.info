Title: Replacing provider in Terraform
Category: tech
Tags: terraform, tips, provider
Author: Maciej Lasyk
Summary: When and how to use Terraform replace provider feature

## Problem? ##

Lately, during upgrading Terraform code to 0.13.x I spotted an error:

```
Error: Provider configuration not present

To work with vault_kubernetes_auth_backend_role.some_role
its original provider configuration at
provider["registry.terraform.io/-/vault"]
is required, but it has been removed. This occurs when
a provider configuration is removed while objects created
by that provider still exist in the state. Re-add the
provider configuration to destroy
vault_kubernetes_auth_backend_role.some_role, after
which you can remove the provider configuration again.
```

## Why? ##

So, this problem is actually covered in [Upgrading to Terraform v0.13 / Explicit Provider Source Locations](https://www.terraform.io/upgrade-guides/0-13.html#explicit-provider-source-locations) docs:

Basically, URLs for providers changed (imo for better, namespaced providers created by community now will be easier to maintain).

Above error wouldn't happen if I didn't replace the provider declaration in
my main.tf with the following:

```
terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "1.13.3"
    }
  }
}
```

## Solution? ##

We need to replace the provider URL in the state file. So:

1. Download your state file to local drive (e.g. from S3, Azure Blob or where you keep it) and create a backup copy just to be sure
1. Use command (adjust to your provider): `terraform state replace-provider -state=<TFSTATE-FILENAME> registry.terraform.io/-/kubernetes registry.terraform.io/hashicorp/kubernetes`
1. Upload the state file back to your remote storage
1. Run `terraform plan` to just make sure everything works fine now

This should be enough. And remember to keep S3 bucket versioned (if using S3 as backend for state files), because working directly on state files this way might be dangerous.