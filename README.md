rackspace_php Cookbook
============
Installs and configures PHP 5.3 (by default) and the PEAR package management system.  Also includes LWRPs for managing PEAR (and PECL) packages along with PECL channels. Can also install PHP 5.4 and 5.5 on RHEL/Centos systems.


Requirements
------------
### Platforms
- Debian, Ubuntu
- CentOS, Red Hat

### Cookbooks 
- rackspace_yum

Attributes
----------
- `node['rackspace_php']['directives']` = Hash of directives and values to append to `php.ini`, default `{}`.
- `node['rackspace_php']['version_number']` = sets version of PHP to install. This is 5.3 by default but can be changed to 5.4 or 5.5 for RHEL/CentOS installs.
- `node['rackspace_php']['additional_modules']` = is a list of package named to install additional non-default PHP modules. Common usage include php-mysql etc. ensure the names are corrrect the the specific OS.

The file also contains the following attribute types:

* platform specific locations and settings.
* source installation settings

### php-fpm
To enable php-fpm The following is recommended:
* Set `node.default['rackspace_php']['fpm']['enabled'] = true`
* If you need php5.4 or php5.5 and php-fpm, you'll need to populate the package yourself:
 *Add `php-fpm` to the packages hash: `node.set['rackspace_php']['packages'] = %w(php54 php54-devel php54-cli php54-pear php54-fpm)`

Resource/Provider
-----------------
This cookbook includes LWRPs for managing:

- PEAR channels
- PEAR/PECL packages

### `rackspace_php_pear_channel`
[PEAR Channels](http://pear.php.net/manual/en/guide.users.commandline.channels.php) are alternative sources for PEAR packages.  This LWRP provides and easy way to manage these channels.

#### Actions
- :discover: Initialize a channel from its server.
- :add: Add a channel to the channel list, usually only used to add private channels.  Public channels are usually added using the `:discover` action
- :update: Update an existing channel
- :remove: Remove a channel from the List

#### Attribute Parameters
- channel_name: name attribute. The name of the channel to discover
- channel_xml: the channel.xml file of the channel you are adding

#### Examples
```ruby
# discover the horde channel
rackspace_php_pear_channel "pear.horde.org" do
  action :discover
end

# download xml then add the symfony channel
remote_file "#{Chef::Config[:file_cache_path]}/symfony-channel.xml" do
  source "http://pear.symfony-project.com/channel.xml"
  mode 0644
end
rackspace_php_pear_channel "symfony" do
  channel_xml "#{Chef::Config[:file_cache_path]}/symfony-channel.xml"
  action :add
end

# update the main pear channel
rackspace_php_pear_channel 'pear.php.net' do
  action :update
end

# update the main pecl channel
rackspace_php_pear_channel 'pecl.php.net' do
  action :update
end
```

### `rackspace_php_pear`
[PEAR](http://pear.php.net/) is a framework and distribution system for reusable PHP components. [PECL](http://pecl.php.net/) is a repository for PHP Extensions. PECL contains C extensions for compiling into PHP. As C programs, PECL extensions run more efficiently than PEAR packages. PEARs and PECLs use the same packaging and distribution system.  As such this LWRP is clever enough to abstract away the small differences and can be used for managing either.  This LWRP also creates the proper module .ini file for each PECL extension at the correct location for each supported platform.

#### Actions
- :install: Install a pear package - if version is provided, install that specific version
- :upgrade: Upgrade a pear package - if version is provided, upgrade to that specific version
- :remove: Remove a pear package
- :purge: Purge a pear package (this usually entails removing configuration files as well as the package itself).  With pear packages this behaves the same as `:remove`

#### Attribute Parameters
- package_name: name attribute. The name of the pear package to install
- version: the version of the pear package to install/upgrade.  If no version is given latest is assumed.
- preferred_state: PEAR by default installs stable packages only, this allows you to install pear packages in a devel, alpha or beta state
- directives: extra extension directives (settings) for a pecl. on most platforms these usually get rendered into the extension's .ini file
- zend_extensions: extension filenames which should be loaded with zend_extension.
- options: Add additional options to the underlying pear package command

#### Examples
```ruby
# upgrade a pear
rackspace_php_pear "XML_RPC" do
  action :upgrade
end


# install a specific version
rackspace_php_pear "XML_RPC" do
  version "1.5.4"
  action :install
end


# install the mongodb pecl
rackspace_php_pear "mongo" do
  action :install
end

# install the xdebug pecl
rackspace_php_pear "xdebug" do
  # Specify that xdebug.so must be loaded as a zend extension
  zend_extensions ['xdebug.so']
  action :install
end


# install apc pecl with directives
rackspace_php_pear "apc" do
  action :install
  directives(:shm_size => 128, :enable_cli => 1)
end


# install the beta version of Horde_Url
# from the horde channel
hc = rackspace_php_pear_channel "pear.horde.org" do
  action :discover
end
rackspace_php_pear "Horde_Url" do
  preferred_state "beta"
  channel hc.channel_name
  action :install
end


# install the YAML pear from the symfony project
sc = rackspace_php_pear_channel "pear.symfony-project.com" do
  action :discover
end
rackspace_php_pear "YAML" do
  channel sc.channel_name
  action :install
end
```


Recipes
-------
### default
Include the default recipe in a run list, to get PHP.  By default PHP is installed from packages but this can be changed by using the `install_method` attribute (keep in mind the source method is deprecated and no longer supported) . This recipe installs PHP 5.3 on both Redhat and Debian family of OS's.

If `node['rackspace_php']['version_number']` is set to other than 5.3 (such as 5.4 or 5.5) Then it will install these version of PHP but only on RHEL and CentOS servers. Debian and Ubuntu will only instal the default PHP version 5.3

### pear
This package ensure that 'pear.php.net' and 'pecl.php.net' are updated and current on the server.

Usage
-----
Simply include the `rackspace_php` recipe where ever you would like php installed.  To install verison 5.5 vice 5.3 on a CnetOS 6.x server override the `node['rackspace_php']['version_number']` attribute with in a role:

```ruby
name "rackspace_php"
description "Install php 5.5"
override_attributes(
  "rackspace_php" => {
    "version_number" => "5.5"
  }
)
run_list(
  "recipe[rackspace_php]"
)
```

Contributing
------------
* Please see the guide [here](https://github.com/rackspace-cookbooks/contributing/blob/master/CONTRIBUTING.md)

Testing
-------
* Please see the guide [here](https://github.com/rackspace-cookbooks/contributing/blob/master/CONTRIBUTING.md)


License & Authors
-----------------
- Author:: Seth Chisamore (<schisamo@opscode.com>)
- Author:: Joshua Timberman (<joshua@opscode.com>)
- Author:: Christopher Coffey (<christopher.coffey@rackspace.com>)

```text
Copyright:: 2011, Opscode, Inc
Copyright:: 2014, Rackspace US, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
