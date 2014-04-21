# 
# Author:: Matthew Thode (<matt.thode@rackspace.com>)
#
# Cookbook Name:: rackspace_php
# Recipe:: monitoring
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

case node['platform_family']
when 'rhel'
  package 'fcgi' do
    action :install
  end
when 'debian'
  package 'fcgiwrap' do
    action :install
  end
end

template '/usr/lib/rackspace-monitoring-agent/plugins/php-fpm_status.sh' do
  source 'monitoring.erb'
  cookbook node['rackspace_php']['templates']['php-fpm_status.sh']
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    cookbook_name: cookbook_name
  )
end

template "#{node['rackspace_php']['fpm']['ext_conf_dir']/monitoring.ini}" do
  source 'monitoring-fpm.erb'
  cookbook node['rackspace_php']['templates']['fpm-monitoring.ini']
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    cookbook_name: cookbook_name
  )
  notifies :reload, resources(service: 'php_fpm_service')
end

