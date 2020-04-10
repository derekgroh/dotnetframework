# InSpec test for recipe dotnetframework::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

dir = File.join(ENV['WINDIR'], '\\Microsoft.Net\\Framework64\\v4.0.30319')
describe directory(dir) do
  it { should exist }
end

if os['release'] < '10'
  describe registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full') do
    its('Version') { should match '4.5.51650' }
    it { should exist }
  end
end

# Windows 2019 has 4.7 already installed
if os['release'] > '10'
  describe registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full') do
    its('Version') { should include '4.7' }
    it { should exist }
  end
end
