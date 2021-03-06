# ubuntu
default[:ubuntu][:archive_url] = "http://ftp.jaist.ac.jp/ubuntu"
default[:ubuntu][:security_url] = "http://ftp.jaist.ac.jp/ubuntu"
default[:ubuntu][:locale] = "ja_JP.UTF-8"

# timezone-ii
default[:tz] = "Asia/Tokyo"

# ntp
default[:ntp][:servers] = [
  "ntp.nict.jp"
]

# hostname
default[:set_fqdn] = node.name
