name              'rackspace_php'
maintainer        'Rackspace, US, Inc.'
maintainer_email  'rackspace-cookbooks@rackspace.com'
license           'Apache 2.0'
description       'Installs and maintains php and php modules'
version           '2.0.0'

depends "build-essential"
depends "xml"
depends "mysql"

%w{ debian ubuntu centos redhat }.each do |os|
	  supports os
end

recipe "rackspace_php", "Installs php"
recipe "rackspace_php::package", "Installs php using packages."
recipe "rackspace_php::source", "Installs php from source."
recipe "rackspace_php::module_apc", "Install the php5-apc package"
recipe "rackspace_php::module_curl", "Install the php5-curl package"
recipe "rackspace_php::module_fileinfo", "Install the php5-fileinfo package"
recipe "rackspace_php::module_fpdf", "Install the php-fpdf package"
recipe "rackspace_php::module_gd", "Install the php5-gd package"
recipe "rackspace_php::module_ldap", "Install the php5-ldap package"
recipe "rackspace_php::module_memcache", "Install the php5-memcache package"
recipe "rackspace_php::module_mysql", "Install the php5-mysql package"
recipe "rackspace_php::module_pgsql", "Install the php5-pgsql packag"
recipe "rackspace_php::module_sqlite3", "Install the php5-sqlite3 package"
