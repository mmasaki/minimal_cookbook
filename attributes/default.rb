# ubuntu
default[:ubuntu][:archive_url] = "http://ftp.jaist.ac.jp/ubuntu"
default[:ubuntu][:security_url] = "http://ftp.jaist.ac.jp/ubuntu"
default[:ubuntu][:locale] = "ja_JP.UTF-8"

# timezone-ii
default[:tz] = "Asia/Tokyo"

# ntp
default[:ntp][:servers] = [
  "ntp.nict.jp",
  "ntp1.jst.mfeed.ad.jp",
  "ntp2.jst.mfeed.ad.jp",
  "ntp3.jst.mfeed.ad.jp",
  "ats1.e-timing.ne.jp",
  "x.ns.gin.ntt.net",
  "y.ns.gin.ntt.net",
  "ntp-tk01.ocn.ad.jp",
  "ntp-tk02.ocn.ad.jp"
]
