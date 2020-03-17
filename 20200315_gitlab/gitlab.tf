# Configure the Gitlab Provider
# gitlab.com immediately associates the access token in terraform.tfvars
# with our user privileges
provider "gitlab" {
    token = var.gitlab_token
    version = "~> 2.5"
}
