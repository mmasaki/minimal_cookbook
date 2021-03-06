name             'minimal'
maintainer       'NTT Communications'
maintainer_email 'masaki.matsushita@ntt.com'
license          'All rights reserved'
description      'Installs/Configures minimal_cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.16'
depends          'users'
depends          'sudo'
depends          'yum-epel'
depends          'git'
depends          'openssl'
depends          'build-essential'
depends          'ubuntu'
depends          'timezone-ii'
depends          'ntp'
depends          'hostname'
