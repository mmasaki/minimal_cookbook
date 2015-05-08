%w{
  nova
  cinder
  glance
  neutron
}.each do |service|
  sudo service do
    user service
    nopasswd true
    commands ["/usr/bin/nova-rootwrap /etc/nova/rootwrap.conf *"]
  end
end
