# Provider configuration variables
variable "cloudflare_email" {
  description = "Email account for CF"
}

variable "cloudflare_token" {
  description = "CF API key"
}

# Cluster configuration variables
variable "cloudflare_domain1" {
  description = "The domain I'm using"
}

variable "dm1_gs_mx00" {
  description = "mx00 record for email hosting at Google Gsuite"
}

variable "dm1_gs_mx0" {
  description = "mx0 record for email hosting at Google Gsuite"
}

variable "dm1_gs_mx1" {
  description = "mx1 record for email hosting at Google Gsuite"
}

variable "dm1_gs_mx2" {
  description = "mx2 record for email hosting at Google Gsuite"
}

variable "dm1_gs_mx3" {
  description = "mx3 record for email hosting at Google Gsuite"
}

variable "default_ttl" {
  description = "default ttl value"
}

variable "dm1_email_root_spf" {
  default     = ""
  description = "spf record value for root domain email on dm1"
}

variable "dm1_email_root_dkim" {
  default     = ""
  description = "dkim record value for root domain email on dm1"
}

variable "dm1_email_root_dmarc" {
  default     = ""
  description = "dmarc record value for root domain email on dm1"
}

variable "dm1_email_root_dmarc_name" {
  description = "dmarc name value for root domain email on dm1"
}

variable "dm1_google_gsuite_verification_var" {
  default     = ""
  description = "Google uses this TXT record to verify ownership of domain added in gsuite.google.com"
}

