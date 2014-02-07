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

default['rackspace_php']['version_number'] = '5.3'
default['rackspace_php']['additional_modules'] = []

lib_dir = 'lib'
default['rackspace_php']['source']['directives'] = {}

case node['platform_family']
when 'rhel'
  lib_dir = node['kernel']['machine'] =~ /x86_64/ ? 'lib64' : 'lib'
  default['rackspace_php']['conf_dir']      = '/etc'
  default['rackspace_php']['ext_conf_dir']  = '/etc/php.d'
  default['rackspace_php']['fpm_user']      = 'nobody'
  default['rackspace_php']['fpm_group']     = 'nobody'
  default['rackspace_php']['ext_dir']       = "/usr/#{lib_dir}/php/modules"
  default['rackspace_php']['packages']      = %w(php php-devel php-cli php-pear)
when 'debian'
  default['rackspace_php']['conf_dir']      = '/etc/php5/cli'
  default['rackspace_php']['ext_conf_dir']  = '/etc/php5/conf.d'
  default['rackspace_php']['fpm_user']      = 'www-data'
  default['rackspace_php']['fpm_group']     = 'www-data'
  default['rackspace_php']['packages']      = %w(php5-cgi php5 php5-dev php5-cli php-pear)
end
