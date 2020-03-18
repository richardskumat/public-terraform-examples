
resource "gitlab_pipeline_schedule" "some_repo" {
   project     = "username/some_repo"
   description = "weekly scheduled ci run of some_repo"
   ref         = "master"
   cron        = "0 4 1 * 0"
}
