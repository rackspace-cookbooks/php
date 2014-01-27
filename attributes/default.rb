#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Author:: Christopher Coffey (<christopher.coffey@rackspace.com>)
#
# Cookbook Name:: rackspace_php
# Attribute:: default
#
# Copyright 2011, Opscode, Inc.
# Copyright 2014, Rackspace US, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['rackspace_php']['install_method'] = 'package'
default['rackspace_php']['version_number'] = '5.3'
default['rackspace_php']['additional_modules'] = []

case node['platform_family']
when 'rhel'
  lib_dir = node['kernel']['machine'] =~ /x86_64/ ? 'lib64' : 'lib'
  default['rackspace_php']['conf_dir']      = '/etc'
  default['rackspace_php']['ext_conf_dir']  = '/etc/php.d'
  default['rackspace_php']['fpm_user']      = 'nobody'
  default['rackspace_php']['fpm_group']     = 'nobody'
  default['rackspace_php']['ext_dir']       = "/usr/#{lib_dir}/php/modules"
  default['rackspace_php']['packages'] = %w(php php-devel php-cli php-pear)
when 'debian'
  default['rackspace_php']['conf_dir']      = '/etc/php5/cli'
  default['rackspace_php']['ext_conf_dir']  = '/etc/php5/conf.d'
  default['rackspace_php']['fpm_user']      = 'www-data'
  default['rackspace_php']['fpm_group']     = 'www-data'
  default['rackspace_php']['packages']      = %w(php5-cgi php5 php5-dev php5-cli php-pear)
end

lib_dir = 'lib'
default['rackspace_php']['directives'] = {}
default['rackspace_php']['url'] = 'http://php.net/distributions'
default['rackspace_php']['version'] = '5.4.15'
default['rackspace_php']['checksum'] = '94e92973c996cf8deabafe0ba19b23d48a79d6e64592a5bf4ea63036eec77c3c'
default['rackspace_php']['prefix_dir'] = '/usr/local'

default['rackspace_php']['configure_options'] = %W{--prefix=#{rackspace_php['prefix_dir']}
                                                   --with-libdir=#{lib_dir}
                                                   --with-config-file-path=#{rackspace_php['conf_dir']}
                                                   --with-config-file-scan-dir=#{rackspace_php['ext_conf_dir']}
                                                   --with-pear
                                                   --enable-fpm
                                                   --with-fpm-user=#{rackspace_php['fpm_user']}
                                                   --with-fpm-group=#{rackspace_php['fpm_group']}
                                                   --with-zlib
                                                   --with-openssl
                                                   --with-kerberos
                                                   --with-bz2
                                                   --with-curl
                                                   --enable-ftp
                                                   --enable-zip
                                                   --enable-exif
                                                   --with-gd
                                                   --enable-gd-native-ttf
                                                   --with-gettext
                                                   --with-gmp
                                                   --with-mhash
                                                   --with-iconv
                                                   --with-imap
                                                   --with-imap-ssl
                                                   --enable-sockets
                                                   --enable-soap
                                                   --with-xmlrpc
                                                   --with-libevent-dir
                                                   --with-mcrypt
                                                   --enable-mbstring
                                                   --with-t1lib
                                                   --with-mysql
                                                   --with-mysqli=/usr/bin/mysql_config
                                                   --with-mysql-sock
                                                   --with-sqlite3
                                                   --with-pdo-mysql
                                                   --with-pdo-sqlite}
