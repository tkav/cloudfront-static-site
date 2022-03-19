# Cloudfront Static Site

Deploy a static site to AWS using CloudFront and S3 without using Route53.

Deployment is separated into 2 stages as your domain DNS records need to be updated before the Cloudfront distribution can be updated with your domain name. 

This is because the SSL cerfiticate cannot be validated until your there is a domain DNS record pointing to the Cloudfront distribution. 

# Usage

## Requirements
- Terraform (>v1.0.0)

1. Update `variables.sh` and load environmental variables:
```
source variables.sh
```

2. Replace and add your static website contents to src folder. The distribution will look for index.html and 404.html pages. Make sure you have those.

3. Deploy your site:
```
make deploy_site
```
**IMPORTANT**
During this stage you will recieve an email to verify the certificate.
Open the email and approve the validation request. 

This will take several minutes. 

When completed, something like the following will be outputted:

```
Outputs:

cloudfront_domain = "dlimer79nfhej.cloudfront.net"
```

4. Add an `@` CNAME record to your domain using the `cloudfront_domain` above and add a `www` URL Redirect record pointing to your domain:

![DNS Records](docs/images/dns-records.png)

Once complete, your site will soon be available using your domain.


## Updating Site Content

If changes are made in the `src` folder, run the following to upload the changes to your S3 bucket:
```
make upload_site
```
This will also be run when contents are pushed to the repo with changes in the `src` folder.

If using the workflows, ensure you have updated the repository secrets with the following variables:
```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
TF_VAR_REGION
TF_VAR_SITENAME
TF_VAR_TF_STATE_BUCKET
TF_VAR_WEBSITE_DOMAIN_MAIN
```

## Destroying the Site

To destroy EVERYTHING to do with this deployment:
```
make destroy
```
And confirm the steps.
S3 buckets, Cloudfront distributions and certificates will be deleted!