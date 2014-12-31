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
  sudo "ubuntu" do
    user "ubuntu"
    nopasswd true
  end

  apt_package "language-pack-ja"
  include_recipe "ubuntu"
  apt_package "lvm2"
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
package "nc" if platform_family?("rhel")
package "vim"
package "htop"
package "sysv-rc-conf" if platform?("ubuntu")
package "jq"

if platform_family?("debian")
  package("libcurl4-openssl-dev")
elsif platform_family?("rhel")
  package("libcurl-devel")
end
