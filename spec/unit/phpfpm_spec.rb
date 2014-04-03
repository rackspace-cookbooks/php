# encoding: UTF-8

require 'spec_helper'

describe 'rackspace_php::default' do

  context 'platform family - debian' do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
        node.set['platform_family'] = 'debian'
        node.set['rackspace_php']['fpm']['service_name'] = 'php5-fpm'
        node.set['rackspace_php']['fpm']['conf_dir'] = '/etc/php5/fpm'
      end.converge(described_recipe)
    end

    it 'writes the php-fpm template' do
      expect(chef_run).to create_template(:template).with(
        user:   'root',
        group:  'root'
      )
    end
  end


  context 'platform family - rhel' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['platform_family'] = 'rhel'
        node.set['rackspace_php']['fpm']['service_name'] = 'php-fpm'
        node.set['rackspace_php']['fpm']['conf_dir'] = '/etc'
      end.converge(described_recipe)
    end

    it 'writes the php-fpm template' do
      expect(chef_run).to render_file('/etc/php-fpm.conf')
    end

    it 'enables a service when specifying the identity attribute' do
      expect(chef_run).to enable_service('php-fpm')
    end
  end

end
