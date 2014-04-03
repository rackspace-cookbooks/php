#
# Author::  Ryan Richard (<ryan.richard@rackspace.com>)
#
# Cookbook Name:: rackspace_php
# Recipe:: fpm
#
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

php_fpm_conf = node['rackspace_php']['fpm']['conf_dir'] + "/php-fpm.conf"
php_fpm_service = node['rackspace_php']['fpm']['service_name']

case node['platform_family']
when 'rhel'
# fpm
  template php_fpm_conf do
    cookbook node['rackspace_php']['templates']['php-fpm.conf']
    source 'php-fpm.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      directives: node['rackspace_php']['fpm']['directives']['conf'],
      cookbook_name: cookbook_name
    )
  end
  
  service php_fpm_service do
    supports ['status'] => true, ['restart'] => true, ['reload'] => true
    action [:enable, :start]
end
when 'debian'
# fpm
  template php_fpm_conf do
    cookbook node['rackspace_php']['templates']['php-fpm.conf']
    source 'php-fpm.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      directives: node['rackspace_php']['fpm']['directives']['conf'],
      cookbook_name: cookbook_name
    )
  end
  
#  template "#{node['rackspace_php']['fpm']['conf_dir']}/php.ini" do
#    cookbook node['rackspace_php']['templates']['php.ini']
#    source 'php.ini.erb'
#    owner 'root'
#    group 'root'
#    mode '0644'
#    variables(
#      directives: node['rackspace_php']['fpm']['directives']['ini'],
#      cookbook_name: cookbook_name
#    )
#  end
  
  service php_fpm_service do
    supports ['status'] => true, ['restart'] => true, ['reload'] => true
    action [:enable, :start]
  end
end