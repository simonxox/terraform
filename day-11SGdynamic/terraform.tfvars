port_cidr_map = {
  22   = "203.0.113.10/32"  # SSH from your IP only
  80   = "0.0.0.0/0"        # HTTP public
  443  = "0.0.0.0/0"        # HTTPS public
  3000 = "10.0.0.0/16"      # Internal access only
}