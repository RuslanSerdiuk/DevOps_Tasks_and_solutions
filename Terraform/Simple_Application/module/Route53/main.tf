#=================================Route53 + SSL Certificate===============================#
  data "aws_route53_zone" "selected" {
    name         = var.my_domain
  }


  resource "aws_route53_record" "www-cname" {
    zone_id = data.aws_route53_zone.selected.zone_id
    name    = "_633970e4831c2720c7369637b068614e"
    type    = "CNAME"
    ttl     = "300"
    records        = ["_b03966fb23d1193c2bb66c1035352a22.yyqgzzsvtj.acm-validations.aws"]
  }


  resource "aws_route53_record" "www" {
    zone_id = data.aws_route53_zone.selected.zone_id
    name    = var.my_domain
    type    = "A"

    alias {
      name                   = var.route_balancer_dns_name
      zone_id                = var.route_balancer_zone_id
      evaluate_target_health = true
    }
  }
