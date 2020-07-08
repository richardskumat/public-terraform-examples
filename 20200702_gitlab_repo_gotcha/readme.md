# Gotchas everywhere

To enable shared runners on a new Gitlab
repo created with terraform,
a gitlab resource has to contain:

```
shared_runners_enabled = true
```

Here's an example resource block:

<pre>
resource "gitlab_project" "ansible-role-chrome" {
    name = "ansible-role-chrome"
    description = "this is the ansible-role-chrome repo"
    visibility_level = "public"
    request_access_enabled = false
    default_branch = "master"
    merge_requests_enabled = true
    issues_enabled = true
    wiki_enabled = false
    shared_runners_enabled = true
}
</pre>

Related links:

https://www.terraform.io/docs/providers/gitlab/r/project.html

https://www.richardskumat.com/gitlab-terraform-new-repo-created-gotcha.html