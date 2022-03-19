# cloudfront-static-site
Deploy a static site to AWS using CloudFront and S3

```
source variables.sh
```

```
cd deploy
```

```
terraform init -input=false -backend-config "bucket=$TF_VAR_tf_state_bucket" -backend-config "region=$TF_VAR_region" -backend-config "key=$TF_VAR_sitename"
```

```
terraform plan -out=tfplan -input=false
```

```
terraform apply "tfplan"
```