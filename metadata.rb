name              'rackspace_php'
maintainer        'Rackspace, US, Inc.'
maintainer_email  'rackspace-cookbooks@rackspace.com'
license           'Apache 2.0'
description       'Installs and maintains php and php modules'
version           '2.0.0'

depends 'rackspace_yum'
depends 'rackspace_build_essential'
depends 'xml'
depends 'mysql'

%w{ debian ubuntu centos redhat }.each do |os|
  supports os
end
