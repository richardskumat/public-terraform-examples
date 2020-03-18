# Gitlab Terraform provider tests

Terraform has a great Gitlab provider with docs available at
[https://www.terraform.io/docs/providers/gitlab/index.html](https://www.terraform.io/docs/providers/gitlab/index.html).

For my own needs, I'll be looking into modifying project/repository details
with terraform itself.

The term 'project' in this readme is used interchangeably
with git repository.

## This will take only such and such time

I thought none of this would take too long, but all this work turned out
to be a lot more than I expected.

There were many issues along the way and lots of doc readings, too.

## Gitlab API

My goal of using the Gitlab provider of terraform is to bring my gitlab
repositories under terraform control, so I can update the repo configs
without the web ui.

To achieve this, I need a list of projects that are owned by my user.

https://docs.gitlab.com/ee/api/projects.html#list-user-projects

There's a link above that details on how to get this list.

The idea is to get a list of repos from the Gitlab API,
then feed this list to terraform import.

I've found no way to do this directly via terraform so I had to
resort to using curl and the gitlab api docs.

The base URL for the Gitlab API is https://my.gitlab.server/api/v4/.

For gitlab.com, this is https://gitlab.com/api/v4/.

We need to add '/users/:user_id/projects' the Gitlab.com url above,
and replace :user_id with our username/id.

https://gitlab.com/api/v4/users/username/projects

If I curl the above url, I only get the public projects for a user.

If we modify a curl request with an extra header, then
we'll get the private projects as well in the response.

```bash
curl --header "PRIVATE-TOKEN: <your_access_token>" https://gitlab.com/api/v4/users/username/projects
```

By using jq, we can filter the json input gitlab provides. The idea is to save
it to a local file, and then use jq to filter locally.

```bash
curl --header "PRIVATE-TOKEN: <your_access_token>" https://gitlab.com/api/v4/users/username/projects | jq '.' > projects
```

Jq makes the json input readable, so by looking at the file,
I know I'm looking for the 'path_with_namespace' key values.

Because I'm not proficient with json and jq, I had to search
for a time how to do the following filtering.

```bash
jq '.[].path_with_namespace' projects
```

'projects' is the local file of the json input.

This gave me a list of my projects, however something looked
weird.

I piped the above jq command to wc -l and found out that
Gitlab by default only returned the first 20 objects.

This is noted on https://docs.gitlab.com/ee/api/projects.html#list-user-projects:

```none
Note: This endpoint supports [keyset pagination](https://docs.gitlab.com/ee/api/README.html#keyset-based-pagination) for selected order_by options.
```

So I had a look at https://docs.gitlab.com/ee/api/README.html#keyset-based-pagination, and
I found that I had to modify my request to the Gitlab API to request a larger page of
my repo list.

So then I ran:

```bash
curl --header "PRIVATE-TOKEN: <your_access_token>" "https://gitlab.com/api/v4/users/username/projects?pagination=keyset&per_page=100&order_by=id&sort=a
sc" | jq '.' > projects
```

and again filtered the projects file with jq, to get my project list
in the namespace format that terraform import can use.

### Importing Gitlab data into Terraform state files

This look way longer that I anticipated.

First of all, I had to fool around with bash code to get
a proper loop to import all 36 of my Gitlab repos into
Terraform.

Then I found another roadblock in my way.

To import data into terraform, a resource block has to exist.
This meant for me, that I had to define 36 resource blocks of gitlab_projects
in my tf file. Surely, there's a better way than this?

I was not about to manually copy-paste and modify the same resource block 36 times,
so I had to come up with a way to template a resource block and replace
the needed values with variables.

It occurred to me right away, I could just turn to Ansible and use the template
module locally and have jinja come up with the resource blocks I needed.

I also wrote a shell script to loop through a list
of my git repos and call terraform import
for each loop.

The file's called terraform-import-project.sh.

### Ansible with the template module

This required some yaml massaging, but I finally got it right after some time.

I gave up first, then came back later to this issue with a clearer mind.

The resulting files can be found in the ansible-templating-for-repos subdirectory.

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

terraform import gitlab_project.example username/repo

This can also be used to enable or disable issues, merge requests and the wiki for
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

### Importing Gitlab project variables

In my case, I've got 10 docker image repos but they share
the same variables needed to push images to dockerhub, except
for the dockerhub image name.

On my part, this also required some fooling around to get the proper
incantation for terraform import.

In the terraform docs, the example import command is the following:

```bash
terraform import gitlab_project_variable.example 12345:project_variable_key
```

So to sum it up, I've got 10 docker repos, each with 3 variables.

So, I had to come up with 30 variations of terraform import.

Plus, I had add 30 resource configuration blocks to
my tf files.

To come up with 30 resource configuration blocks I also copied
yesterday's ansible code and just modified the template to
create what I needed.

This took me a couple of tries to get a valid configuration block
for a gitlab repo variable.

At this point, I foolishly ran a terraform apply, but first I
ensured that my private and public repositories were appropriately
configured.

I also separated the gitlab_repo and gitlab_repo_vars resource
definitions into separate .tf files.

My first error was omitting username from the resource block in tf.j2,
which started as:

```none
project   = "{{ item.name }}"
```

Then I got an error from terraform saying it couldn't find the
appropriate repository.

I modified the template line to:

```none
project   = "username/{{ item.name }}"
```

which turned out to be correct.

Another issue along the way was having:

```none
#environment_scope = "string"
```

commented out, since the docs says it's optional and valid
values are strings.

Then I pushed a few commits to Gitlab and my pipelines were
failing since the gitlab-runners weren't picking up my
terraform defined variables.

I ended up modifying the environment scope to:

```none
environment_scope = "*"
```

as per the [Gitlab project level variables docs](https://docs.gitlab.com/ee/api/project_level_variables.html).

Which let the runners pick up my defined variables.

Using some awk filtering, I managed to get a list of Terraform resource variable names
into repo_var_list file.

But for the terraform import to work, I also had to sort through the key values
found in the gitlab-repo-vars.tf file. I sorted them into the repo_var_key_list file.

Then I had to ensure that the values in
repo_var_list and repo_var_key_list were aligned.
That each terraform gitlab_project_variable resource name had the right
key value.

Now was the time to make a shell script to iterate through these lists,
but I hit a roadblock first because I couldn't get a proper for loop.

Since I was already using awk a lot, I found a format I could use in
a fairly simple while read loop.

The format was the following:

```none
reponame_var1:key1
reponame_var2:key2
reponame_var3:key3
```

as can be seen in repo_vars_sorted.

To merge repo_var_list and repo_var_key_list files together in the following format,
I found a utility called paste.

The following command merged the 2 files together:

```bash
paste -d":" repo_var_list repo_var_key_list > repo_vars_sorted
```

with ':' being the delimiter.

Finally I could use sorted file with terraform-import-repo-vars.sh
 to iterate over 30 terraform imports.

## Pipeline schedules

https://www.terraform.io/docs/providers/gitlab/r/pipeline_schedule.html

I've got many projects here on Gitlab.com and trying to manage the schedules
for all of them is manual and messy.

Sadly, there's no import function for terraform for schedules.

My idea at this time was to create new schedules with terraform.

To create the 30+ resource block I used Ansible with
the template module, just like previously.

This was very simple.

After running terraform apply, I realised that I still had all my previously
manually defined schedules on Gitlab.com repos.

Since TF can't import schedules, I had to resort to manually delete them.

I was OK with manual deletion of old schedules since some of my repos
that needed schedules didn't have any.

However, to do it via the browser would have taken a long time.

I wrote an Ansible task to open firefox-esr at the right urls
with a loop.

The sample ansible code is in the ansible-code-for-pipeline-schedules
directory.