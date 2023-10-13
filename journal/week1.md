# Week1
### Error faced -1 
```
$ terraform plan
╷
│ Error: Variables not allowed
│ 
│   on terraform.tfvars line 1:
│    1: cricket_bucket_name = random_string.cricket_bucket_name.id
│ 
│ Variables may not be used here.
╵
╷
│ Error: No value for required variable
│ 
│   on variables.tf line 1:
│    1: variable "cricket_bucket_name" {
│ 
│ The root module input variable "cricket_bucket_name" is not set, and has no default value. Use a -var or -var-file command line argument to provide a
│ value for this variable.
╵
gitpod /workspace/terraform-beginner-bootcamp-2023 (11-s3-static-website-with-cdn) $ 

```
### Error faced -2
```
$ terraform plan
╷
│ Error: Incorrect attribute value type
│ 
│   on modules/terrahouse_aws/main.tf line 119, in data "aws_iam_policy_document" "allow_access_from_CDN":
│  119:                 identifiers =  "cloudfront.amazonaws.com"
│ 
│ Inappropriate value for attribute "identifiers": set of string required.
╵
╷
│ Error: Incorrect attribute value type
│ 
│   on modules/terrahouse_aws/main.tf line 123, in data "aws_iam_policy_document" "allow_access_from_CDN":
│  123:         resources = "arn:aws:s3:::${aws_s3_bucket.cricket_website_bucket.id}/*"
│ 
│ Inappropriate value for attribute "resources": set of string required.
╵
gitpod /workspace/terraform-beginner-bootcamp-2023 (11-s3-static-website-with-cdn) $ 
```

### Error faced - 3
```
This XML file does not appear to have any style information associated with it. The document tree is shown below.
<Error>
<Code>AccessDenied</Code>
<Message>Access Denied</Message>
<RequestId>W424144DPNDRRRZD</RequestId>
<HostId>EGzFFsg38Fvf0D1LbGTImqE4GiOWI3flOll5NeNjmObMewHXqQoiE+UVg15Q8lKDYciBC1uImXcK9LuoK7ustw==</HostId>
</Error>
```
### Error/issue faced -4 

html file downloading and content not rendered correctly

### Error faced - 5

```
no changes added to commit (use "git add" and/or "git commit -a")
gitpod /workspace/terraform-beginner-bootcamp-2023 (11-s3-static-website-with-cdn) $ terraform plan
╷
│ Error: Reference to undeclared module
│ 
│   on outputs.tf line 6, in output "cricket_domain_name":
│    6:   value = module.terrahouse_aws.aws_cloudfront_distribution.cricket_website_s3_distribution.domain_name
│ 
│ No module call named "terrahouse_aws" is declared in the root module.
╵
gitpod /workspace/terraform-beginner-bootcamp-2023 (11-s3-static-website-with-cdn) $ terraform plan
╷
│ Error: Reference to undeclared module
│ 
│   on outputs.tf line 6, in output "cricket_domain_name":
│    6:   value = module.aws_cloudfront_distribution.cricket_website_s3_distribution.domain_name
│ 
│ No module call named "aws_cloudfront_distribution" is declared in the root module.
╵
gitpod /workspace/terraform-beginner-bootcamp-2023 (11-s3-static-website-with-cdn) $ terraform plan
random_string.cricket_bucket_name: Refreshing state... [id=c5cskvvzhhotu3gex3j88sruc7tpxz7t]
random_string.bucket_name: Refreshing state... [id=8kmcx35qgqombk83vpy379xq21xqpldd]
module.cricket_static_website.data.aws_caller_identity.current: Reading...
aws_s3_bucket.first_bucket: Refreshing state... [id=8kmcx35qgqombk83vpy379xq21xqpldd]
module.cricket_static_website.aws_s3_bucket.cricket_website_bucket: Refreshing state... [id=1bccx35qgqombk83vpy379xq21xqpabc]
module.cricket_static_website.data.aws_caller_identity.current: Read complete after 1s [id=472281877185]
module.cricket_static_website.aws_cloudfront_origin_access_control.cricket_website: Refreshing state... [id=E1ETFK40KDHUME]
module.cricket_static_website.aws_s3_bucket_website_configuration.cricket_website_configuration: Refreshing state... [id=1bccx35qgqombk83vpy379xq21xqpabc]
module.cricket_static_website.aws_s3_object.cricket_website_html_assets["error.html"]: Refreshing state... [id=error.html]
module.cricket_static_website.aws_s3_object.cricket_website_html_assets["index.html"]: Refreshing state... [id=index.html]
module.cricket_static_website.aws_cloudfront_distribution.cricket_website_s3_distribution: Refreshing state... [id=E29OB68YF2E941]
module.cricket_static_website.data.aws_iam_policy_document.allow_access_from_CDN: Reading...
module.cricket_static_website.data.aws_iam_policy_document.allow_access_from_CDN: Read complete after 0s [id=1202461572]
module.cricket_static_website.aws_s3_bucket_policy.allow_access_from_CDN: Refreshing state... [id=1bccx35qgqombk83vpy379xq21xqpabc]

Planning failed. Terraform encountered an error while generating this plan.

╷
│ Error: Self-referential block
│ 
│   on modules/terrahouse_aws/main.tf line 134, in resource "terraform_data" "invalidate_cache":
│  134:   triggers_replace = terraform_data.invalidate_cache.output
│ 
│ Configuration for terraform_data.invalidate_cache may not refer to itself.
╵
╷
│ Error: Self-referential block
│ 
│   on modules/terrahouse_aws/main.tf line 134, in resource "terraform_data" "invalidate_cache":
│  134:   triggers_replace = terraform_data.invalidate_cache.output
│ 
│ Configuration for terraform_data.invalidate_cache may not refer to itself.
```
