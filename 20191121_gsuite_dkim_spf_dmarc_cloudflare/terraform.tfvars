cloudflare_email = "email@domain.tld"
cloudflare_token = "cloudflareapikey_abcdef"
cloudflare_domain1 = "domain.tld"
dm1_gs_mx00 = "aspmx.l.google.com"
dm1_gs_mx0 = "alt1.aspmx.l.google.com"
dm1_gs_mx1 = "alt2.aspmx.l.google.com"
dm1_gs_mx2 = "alt3.aspmx.l.google.com"
dm1_gs_mx3 = "alt4.aspmx.l.google.com"
default_ttl = "3600"

dm1_email_root_spf = "v=spf1 include:_spf.google.com -all"
dm1_email_root_dkim = "v=DKIM1; k=rsa; p=whatever"
dm1_email_root_dmarc = "v=DMARC1; p=none; rua=mailto:dmarc@domain.tld"
dm1_email_root_dmarc_name = "_dmarc.domain.tld"
dm1_google_gsuite_verification_var = "google-site-verification=string"