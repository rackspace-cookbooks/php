#
# Author:: Christopher Coffey (<christopher.coffey@rackspace.com>)
# Cookbook Name:: rackspace_php
# Recipe:: debian_package
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

php_conf = node['rackspace_php']['conf_dir'] + '/php.ini'

node['rackspace_php']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

template php_conf do
  cookbook node['rackspace_php']['templates']['php.ini']
  source 'php.ini.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    directives: node['rackspace_php']['directives'],
    cookbook_name: cookbook_name
  )
end
