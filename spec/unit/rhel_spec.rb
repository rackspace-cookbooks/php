require 'spec_helper'

describe 'rackspace_php::default' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.4').converge(described_recipe) }

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

  it 'creates template php.ini' do
    expect(chef_run).to 
  end
end