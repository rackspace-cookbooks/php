# encoding: UTF-8

require 'spec_helper'

describe 'rackspace_php::default' do
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
end
