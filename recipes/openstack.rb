%w{
  nova
  cinder
  glance
  neutron
}.each do |service|
  sudo service do
    user service
    nopasswd true
    commands ["/usr/bin/#{service}-rootwrap /etc/#{service}/rootwrap.conf *"]
  end
end
