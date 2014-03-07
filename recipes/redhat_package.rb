#
# Author::  Seth Chisamore (<schisamo@opscode.com>)
# Author:: Christopher Coffey (<christopher.coffey@rackspace.com>)
# Cookbook Name:: rackspace_php
# Recipe:: redhat_package
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

include_recipe 'rackspace_yum'

case node['rackspace_php']['version_number']
when '5.3'
  node['rackspace_php']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
when '5.4'
  rackspace_yum_repository 'IUS' do
    description 'IUS Community Packages for Enterprise Linux/CentOS 6'
    if platform?('centos')
      mirrorlist 'http://dmirr.iuscommunity.org/mirrorlist/?repo=ius-centos6&arch=$basearch'
    end
    if platform?('redhat')
      mirrorlist 'http://dmirr.iuscommunity.org/mirrorlist/?repo=ius-el6&arch=$basearch'
    end
    gpgkey 'http://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY'
    action :create
  end
  node.default['rackspace_php']['packages'] = %w(php54 php54-devel php54-cli php54-pear)
  node['rackspace_php']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
when '5.5'
  rackspace_yum_repository 'IUS' do
    description 'IUS Community Packages for Enterprise Linux/CentOS 6'
    if platform?('centos')
      mirrorlist 'http://dmirr.iuscommunity.org/mirrorlist/?repo=ius-centos6&arch=$basearch'
    end
    if platform?('redhat')
      mirrorlist 'http://dmirr.iuscommunity.org/mirrorlist/?repo=ius-el6&arch=$basearch'
    end
    mirrorlist 'http://dmirr.iuscommunity.org/mirrorlist/?repo=ius-centos6&arch=$basearch'
    gpgkey 'http://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY'
    action :create
  end
  node.default['rackspace_php']['packages'] = %w(php55u php55u-devel php55u-cli php55u-pear)
  node['rackspace_php']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end

template "#{node['rackspace_php']['conf_dir']}/php.ini" do
  source 'php.ini.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(directives: node['rackspace_php']['directives'])
end

#fpm
template "#{node['rackspace_php']['fpm']['conf_dir']}/php-fpm.conf" do
  source 'php-fpm.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(directives: node['rackspace_php']['fpm']['directives']['conf'])
  only_if { node['rackspace_php']['fpm']['enabled'] == true }
end

service 'php5-fpm' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
  only_if { node['rackspace_php']['fpm']['enabled'] == true }
end
