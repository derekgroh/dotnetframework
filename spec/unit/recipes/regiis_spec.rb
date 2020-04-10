#
# Cookbook:: dotnetframework
# Spec:: regiis
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

RSpec.shared_examples 'dotnetframework::regiis' do |platform, version|
  context "when run on #{platform} #{version}" do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        os: 'windows',
        platform: platform,
        version: version,
        step_into: ['dotnetframework::regiis']
      ).converge(described_recipe)
    end

    describe 'run appcmd.exe' do
      it { is_expected.to run_execute('aspnet_regiis') }
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end

RSpec.describe 'dotnetframework::regiis' do
  platforms = {
    'windows' => %w(2012R2 2016 2019),
  }

  platforms.each do |platform, versions|
    versions = versions.is_a?(String) ? [versions] : versions
    versions.each do |version|
      include_examples 'dotnetframework::regiis', platform, version
    end
  end
end
