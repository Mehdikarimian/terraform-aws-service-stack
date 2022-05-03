resource "aws_cloudfront_distribution" "default" {
  origin {
    domain_name = var.alb_endpoint
    origin_id   = "default"
    custom_origin_config {
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      http_port              = 80
      https_port             = 443
    }
    custom_header {
      name  = "X-Forwarded-For"
      value = var.app_name
    }
  }

  enabled         = true
  is_ipv6_enabled = true


  aliases = [var.domain]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "default"
    compress         = true
    smooth_streaming = true

    forwarded_values {
      query_string = true

      headers = ["*"]

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["IR"]
    }
  }

  tags = local.tags

  viewer_certificate {
    ssl_support_method             = "sni-only"
    acm_certificate_arn            = var.acm
    cloudfront_default_certificate = false
  }
}
