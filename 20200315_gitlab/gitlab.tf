# Configure the Gitlab Provider
# gitlab.com immediately associates the access token in terraform.tfvars
# with our user privileges
provider "gitlab" {
    token = var.gitlab_token
    version = "~> 2.5"
}

# Add a project owned by the user
# import the repo into a tfstate file if it
# already exists
# terraform import gitlab_project.example youruser/reponame
# https://www.terraform.io/docs/providers/gitlab/r/project.html
resource "gitlab_project" "example" {
    name = "sample-project"
    description = "project description"
    visibility_level = "public"
    request_access_enabled = false
    default_branch = "master"
    merge_requests_enabled = false
    issues_enabled = false
    wiki_enabled = false
}