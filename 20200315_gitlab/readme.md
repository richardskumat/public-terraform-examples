# Gitlab Terraform provider tests

Terraform has a great Gitlab provider with docs available at
[https://www.terraform.io/docs/providers/gitlab/index.html](https://www.terraform.io/docs/providers/gitlab/index.html).

For my own needs, I'll be looking into modifying project/repository details
with terraform itself.

## Gitlab provider

Notes for myself:

https://www.terraform.io/docs/providers/gitlab/index.html

- token: - (Optional) This is the GitLab personal access token. It must be provided, but it can also be sourced from the GITLAB_TOKEN environment variable.

- base_url: - (Optional) This is the target GitLab base API endpoint. Providing a value is a requirement when working with GitLab CE or GitLab Enterprise e.g. https://my.gitlab.server/api/v4/. It is optional to provide this value and it can also be sourced from the GITLAB_BASE_URL environment variable. The value must end with a slash.

## Gitlab project

https://www.terraform.io/docs/providers/gitlab/r/project.html

Enables to modify or remove git repos hosted on Gitlab.com.

Terraform can also import existing projects, so it
can modify them.

Eg:

terraform import gitlab_project.example richardskumat/playground

This can also be used to enable issues, merge requests and the wiki for
a repo.

First, I was looking at the Github provider for Terraform and I couldn't
find the equivalent functionality for that provider.

## Gitlab project variable

https://www.terraform.io/docs/providers/gitlab/r/project_variable.html

I've got some projects on Gitlab that build and push docker
images to Dockerhub.

Each of those project require the Dockerhub credentials to push
images there.

This Terraform resource could prove very useful to ensure the consistency
across many Gitlab projects that share the same variables/credentials
for building and pushing docker images.

## Pipeline schedules

https://www.terraform.io/docs/providers/gitlab/r/pipeline_schedule.html

I've got many projects here on Gitlab.com and trying to manage the schedules
for all of them is manual and messy.

Will need to look into this.