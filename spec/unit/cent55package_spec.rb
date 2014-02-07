# encoding: UTF-8

require 'spec_helper'

describe 'rackspace_php::default' do
  let(:chef_run) do
    ChefSpec::Runner.new(platform: 'centos', version: '6.4') do |node|
      node.set['rackspace_php']['version_number'] = '5.5'
    end.converge(described_recipe)
  end
  it 'installs php55u package' do
    expect(chef_run).to install_package('php55u')
  end

  it 'installs php55u-devel package' do
    expect(chef_run).to install_package('php55u-devel')
  end

  it 'installs php55u-cli package' do
    expect(chef_run).to install_package('php55u-cli')
  end

  it 'installs php55u-pear package' do
    expect(chef_run).to install_package('php55u-pear')
  end
end
