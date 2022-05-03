resource "aws_route53_record" "example" {
  name    = var.domain
  type    = "A"
  zone_id = var.zone_id
  alias {
    name                   = aws_cloudfront_distribution.default.domain_name
    zone_id                = aws_cloudfront_distribution.default.hosted_zone_id
    evaluate_target_health = false
  }
}
