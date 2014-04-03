# encoding: UTF-8

require 'spec_helper'

describe 'rackspace_php::default' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

  it 'includes the debian package recipe' do
    expect(chef_run).to include_recipe('rackspace_php::debian_package')
  end
end

describe 'rackspace_php::default' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.5').converge(described_recipe) }

  it 'includes the rhel package recipe' do
    expect(chef_run).to include_recipe('rackspace_php::redhat_package')
  end
end

describe 'rackspace_php::default' do
  let(:chef_run) do
    ChefSpec::Runner.new(platform: 'centos', version: '6.5') do |node|
      node.set['rackspace_php']['fpm']['enabled'] = true
    end.converge(described_recipe)
  end

  it 'includes the fpm recipe' do
    expect(chef_run).to include_recipe('rackspace_php::fpm')
  end
end
