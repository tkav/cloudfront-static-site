
module "aws_static_website" {
  source = "tkav/static-website/aws"

  website_domain_main = var.website_domain_main
}