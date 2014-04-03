require 'spec_helper'

describe 'rackspace_php::redhat_package' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.4').converge(described_recipe) }

  it 'installs php package' do
    expect(chef_run).to install_package('php')
  end

  it 'installs php-devel package' do
    expect(chef_run).to install_package('php-devel')
  end

  it 'installs php-cli package' do
    expect(chef_run).to install_package('php-cli')
  end

  it 'installs php-pear package' do
    expect(chef_run).to install_package('php-pear')
  end

  it 'creates template php.ini' do
    expect(chef_run).to create_template('/etc/php.ini').with(
      user:   'root',
      group:  'root',
      mode:   '0644'
    )
  end

  it 'includes the rackspace_yum recipe' do
    expect(chef_run).to include_recipe('rackspace_yum')
  end
end