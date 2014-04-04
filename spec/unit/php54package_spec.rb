# encoding: UTF-8

require 'spec_helper'

describe 'rackspace_php::default' do
  let(:chef_run) do
    ChefSpec::Runner.new(platform: 'centos', version: '6.4') do |node|
      node.set['rackspace_php']['version_number'] = '5.4'
    end.converge(described_recipe)
  end
  it 'installs php54 package' do
    expect(chef_run).to install_package('php54')
  end

  it 'installs php54-devel package' do
    expect(chef_run).to install_package('php54-devel')
  end

  it 'installs php54-cli package' do
    expect(chef_run).to install_package('php54-cli')
  end

  it 'installs php54-pear package' do
    expect(chef_run).to install_package('php54-pear')
  end
end
