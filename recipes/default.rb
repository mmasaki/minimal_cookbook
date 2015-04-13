include_recipe "hostname"
include_recipe "users::sysadmins"

sudo "sysadmin" do
  group "sysadmin"
  nopasswd true
end

file "/etc/ssh/sshd_config" do
  _file = Chef::Util::FileEdit.new(path)
  _file.search_file_replace("#PasswordAuthentication yes", "PasswordAuthentication no")
  _file.search_file_replace("PermitRootLogin yes", "PermitRootLogin no")
  _file.search_file_replace("PermitRootLogin without-password", "PermitRootLogin no")
  _file.write_file
end

if platform?("ubuntu")
  include_recipe "ubuntu"

  r = resources(template: "/etc/apt/sources.list")
  r.notifies(:install, "apt_package[language-pack-ja]", :immediately)

  apt_package "language-pack-ja" do
    action :nothing
  end

  apt_package "lvm2"
  apt_package "xfsprogs"
  apt_package "uml-utilities"

  sudo "ubuntu" do
    user "ubuntu"
    nopasswd true
  end
end

package "zsh"

include_recipe "yum-epel" if platform_family?("rhel")
include_recipe "git"
include_recipe "build-essential"
include_recipe "openssl"
include_recipe "timezone-ii"
include_recipe "ntp"

package "traceroute"
package "tcptraceroute" if platform?("mac_os_x")
package "vim"
package "htop"
package "iotop"
package "iftop"
package "jq"
package "curl"
package "unzip"

if platform?("ubuntu")
  package "sysv-rc-conf"
  package "ssh"
end

case node[:platform_family]
when "rhel"
  yum_package "nc"
  yum_package "libcurl-devel"
when "debian"
  apt_package "netcat-traditional"
  apt_package "libcurl4-openssl-dev"
end
