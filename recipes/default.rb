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
  content _file.send(:editor).lines.join
end

if platform_family?("debian")
  if platform?("ubuntu")
    sudo "ubuntu" do
      user "ubuntu"
      nopasswd true
    end

    file "/etc/apt/sources.list" do
      _file = Chef::Util::FileEdit.new(path)
      _file.search_file_replace("us.archive.ubuntu.com", "ftp.jaist.ac.jp")
      _file.search_file_replace("jp.archive.ubuntu.com", "ftp.jaist.ac.jp")
      _file.search_file_replace("archive.ubuntu.com", "ftp.jaist.ac.jp")
      _file.search_file_replace("security.ubuntu.com", "ftp.jaist.ac.jp")
      content _file.send(:editor).lines.join
      notifies :run, 'execute[apt-get update]', :immediately
    end

    execute "apt-get update" do
      action :nothing
    end
  end

  apt_package "language-pack-ja"
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

if platform_family?("debian")
  package("libcurl4-openssl-dev")
elsif platform_family?("rhel")
  package("libcurl-devel")
end

=begin
# update
case node[:platform_family]
when "rhel"
  execute "yum update -y"
when "debian"
  execute "apt-get update && apt-get dist-upgrade -y"
when "mac_os_x"
  execute "brew update"
end
=end
