name              'rackspace_php'
maintainer        'Rackspace, US, Inc.'
maintainer_email  'rackspace-cookbooks@rackspace.com'
license           'Apache 2.0'
description       'Installs and maintains php and php modules'
version           '2.0.0'

depends 'rackspace_yum', '~> 4.0'
depends 'rackspace_build_essential', '~> 2.0'
depends 'xml', '~> 1.1'
depends 'mysql', '~> 4.0'

%w{ debian ubuntu centos redhat }.each do |os|
  supports os
end
