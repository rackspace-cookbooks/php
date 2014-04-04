require 'spec_helper'

describe 'rackspace_php::debian_package' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

  it 'installs php5 package' do
    expect(chef_run).to install_package('php5')
  end

  it 'installs php5-dev package' do
    expect(chef_run).to install_package('php5-dev')
  end

  it 'installs php5-cli package' do
    expect(chef_run).to install_package('php5-cli')
  end

  it 'installs php5-pear package' do
    expect(chef_run).to install_package('php-pear')
  end

  it 'installs php5-cgi package' do
    expect(chef_run).to install_package('php5-cgi')
  end

  it 'creates template php.ini' do
    expect(chef_run).to create_template('/etc/php5/cli/php.ini').with(
      user:   'root',
      group:  'root',
      mode:   '0644'
    )
  end
end
