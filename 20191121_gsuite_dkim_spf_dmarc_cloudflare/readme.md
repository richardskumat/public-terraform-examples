# Terraform and Cloudflare

Sample terraform code for setting up DKIM, SPF and DMARC DNS records with Cloudflare for better
email deliverability.

Done with TF 0.12.16 as of 2019-11-21.

Also in this case, I was using the v1.18.x version of the Cloudflare provider.

There's a newer version of 2.1.x CF provider that breaks the actual code I've used,
where these examples are sourced from.

These examples are very basic.

## Referenced links

I have a page about all this on my website:

https://www.richardskumat.com/migrating-ovh-email-gsuite.html

Resources used @Cloudflare:

- https://www.terraform.io/docs/providers/cloudflare/r/zone.html
- https://www.terraform.io/docs/providers/cloudflare/r/record.html
- https://www.terraform.io/docs/providers/cloudflare/index.html

Resources used @Google:

- [https://support.google.com/a/answer/9003945?hl=en](https://support.google.com/a/answer/9003945?hl=en)
- [https://support.google.com/a/answer/33327?hl=en](https://support.google.com/a/answer/33327?hl=en)
- [Setting up SPF](https://support.google.com/a/answer/33786)
- [Setting up DKIM](https://support.google.com/a/answer/174124)
- [Generate the DKIM key and txt DNS record in Gsuite admin console](https://admin.google.com/AdminHome?hl=en#AppDetails:service=email&flyout=authenticate_email)
- [Turn on DMARC](https://support.google.com/a/answer/2466563?hl=en&ref_topic=2759254)