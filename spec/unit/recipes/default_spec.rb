#
# Cookbook:: dotnetframework
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

RSpec.shared_examples 'dotnetframework::default' do |platform, version|
  context "when run on #{platform} #{version}" do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        os: 'windows',
        platform: platform,
        version: version,
        step_into: ['dotnetframework::default']
      ).converge(described_recipe)
    end

    describe 'nothing reboot resouce' do
      it { is_expected.to nothing_reboot('dotnetframework_install') }
    end

    describe 'install .NET Framework' do
      it { is_expected.to install_dotnetframework_version('4.5.51650') }
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end

RSpec.describe 'dotnetframework::default' do
  platforms = {
    'windows' => %w(2012R2 2016 2019),
  }

  platforms.each do |platform, versions|
    versions = versions.is_a?(String) ? [versions] : versions
    versions.each do |version|
      include_examples 'dotnetframework::default', platform, version
    end
  end
end
