# Configure the Cloudflare provider
provider "cloudflare" {
  version = "~> 1.0"

  #version = "~> 2.0"
  # https://www.terraform.io/docs/providers/cloudflare/guides/version-2-upgrade.html
  # Version 2 of the Cloudflare Terraform Provider is introducing several breaking changes intended
  # to remove confusion around different ways of specifying zones and Worker resources,
  # and accommodates for API changes around Workers product.
  email = var.cloudflare_email

  # v1
  token = var.cloudflare_token
  # v2
  #api_key = var.cloudflare_token
}

resource "cloudflare_zone" "domain1" {
  zone   = var.cloudflare_domain1
  paused = "true"
  plan   = "free"
  type   = "full"
}

# email records
resource "cloudflare_record" "dm1_emailspf" {
  domain = cloudflare_zone.domain1.zone
  name   = "@"
  value  = var.dm1_email_root_spf
  type   = "TXT"
  ttl    = var.default_ttl
}

resource "cloudflare_record" "dm1_emaildkim" {
  domain = cloudflare_zone.domain1.zone
  name   = "google._domainkey"
  #name   = "@"
  value = var.dm1_email_root_dkim
  type  = "TXT"
  ttl   = var.default_ttl
}

resource "cloudflare_record" "dm1_emaildmarc" {
  domain = cloudflare_zone.domain1.zone
  name   = var.dm1_email_root_dmarc_name
  #name = "@"
  value = var.dm1_email_root_dmarc
  type  = "TXT"
  ttl   = var.default_ttl
}

# google gsuite verification for dm1
resource "cloudflare_record" "dm1_google_gsuite_verification" {
  domain = cloudflare_zone.domain1.zone
  name   = "@"
  value  = var.dm1_google_gsuite_verification_var
  type   = "TXT"
  ttl    = var.default_ttl
}

# Add MX records to the domain

resource "cloudflare_record" "dm1_mx00" {
  domain   = cloudflare_zone.domain1.zone
  name     = "@"
  value    = var.dm1_gs_mx00
  type     = "MX"
  priority = "1"
  ttl      = var.default_ttl
}

resource "cloudflare_record" "dm1_mx0" {
  domain   = cloudflare_zone.domain1.zone
  name     = "@"
  value    = var.dm1_gs_mx0
  type     = "MX"
  priority = "5"
  ttl      = var.default_ttl
}

resource "cloudflare_record" "dm1_mx1" {
  domain   = cloudflare_zone.domain1.zone
  name     = "@"
  value    = var.dm1_gs_mx1
  type     = "MX"
  priority = "5"
  ttl      = var.default_ttl
}

resource "cloudflare_record" "dm1_mx2" {
  domain   = cloudflare_zone.domain1.zone
  name     = "@"
  value    = var.dm1_gs_mx2
  type     = "MX"
  priority = "10"
  ttl      = var.default_ttl
}

resource "cloudflare_record" "dm1_mx3" {
  domain   = cloudflare_zone.domain1.zone
  name     = "@"
  value    = var.dm1_gs_mx3
  type     = "MX"
  priority = "10"
  ttl      = var.default_ttl
}
