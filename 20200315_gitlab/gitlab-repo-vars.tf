
resource "gitlab_project_variable" "gitlab_repo_name_var1" {
   project   = "username/gitlab_repo_name"
   key       = "DOCKERHUB_USER"
   value     = "dockerhub_username"
   #variable_type = #env_var, file
   protected = false
   masked = false
   environment_scope = "*"
}

resource "gitlab_project_variable" "gitlab_repo_name_var2" {
   project   = "username/gitlab_repo_name"
   key       = "DOCKERHUB_PROJECT"
   value     = "gitlab_repo_name"
   #variable_type = #env_var, file
   protected = false
   masked = false
   environment_scope = "*"
}

resource "gitlab_project_variable" "gitlab_repo_name_var3" {
   project   = "username/gitlab_repo_name"
   key       = "DOCKERHUB_PASSWORD"
   value     = var.gitlab_dockerhub_token
   #variable_type = #env_var, file
   protected = false
   masked = false
   environment_scope = "*"
}
