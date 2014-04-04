require 'spec_helper'

describe package('php5-fpm') do
  it { should be_installed }
end

describe service('php5-fpm') do
  it { should be_enabled }
end

describe service('php5-fpm') do
  it { should be_running }
end
