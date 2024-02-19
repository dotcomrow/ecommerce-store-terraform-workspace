locals {
  project_name = "ecomm"
}

resource "cloudflare_pages_domain" "app" {
  account_id   = var.cloudflare_account_id
  project_name = "${local.project_name}"
  domain       = "${local.project_name}.suncoast.systems"

  depends_on = [ cloudflare_pages_project.app ]
}

resource "cloudflare_record" "app" {
  zone_id = var.cloudflare_zone_id
  name    = "${local.project_name}"
  value   = cloudflare_pages_project.app.domains[0]
  type    = "CNAME"
  ttl     = 3600
  allow_overwrite = true
}

resource "cloudflare_pages_project" "app" {
  account_id        = var.cloudflare_account_id
  name              = "${local.project_name}"
  production_branch = "gh-pages"
  
  
  source {
    type = "github"
    config {
      owner                         = "dotcomrow"
      repo_name                     = "ecommerce-store"
      production_branch             = "gh-pages"
      
      preview_deployment_setting = "custom"
      preview_branch_includes = ["gh-develop-pages"] 
    }
  }

  deployment_configs {
    production {
      compatibility_flags = ["nodejs_compat"]
    }

    preview {
      compatibility_flags = ["nodejs_compat"]
    }
  }
}