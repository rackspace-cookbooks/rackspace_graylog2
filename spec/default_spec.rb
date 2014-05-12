# encoding: UTF-8

require 'spec_helper'

describe 'rackspace_jenkins::server' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

  it 'includes the rackspace_java recipe' do
    expect(chef_run).to include_recipe('rackspace_java::default')
  end
end
