# encoding: UTF-8

require 'spec_helper'

describe 'rackspace_php::fpm' do

  context 'platform family - debian' do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
      end.converge(described_recipe)
    end

    it 'writes the php-fpm template' do
      expect(chef_run).to create_template('/etc/php5/fpm/php-fpm.conf').with(
        user:   'root',
        group:  'root',
        mode:   '0644'
      )
    end

    it 'enables a service when specifying the identity attribute' do
      expect(chef_run).to enable_service('php5-fpm')
    end
  end


  context 'platform family - rhel' do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'centos', version: '6.4') do |node|
      end.converge(described_recipe)
    end

    it 'writes the php-fpm template' do
      expect(chef_run).to create_template('/etc/php-fpm.conf').with(
        user:   'root',
        group:  'root',
        mode:   '0644'
      )
    end

    it 'enables a service when specifying the identity attribute' do
      expect(chef_run).to enable_service('php-fpm')
    end
  end

end
