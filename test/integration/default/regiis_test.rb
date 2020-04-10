# InSpec test for recipe dotnetframework::regiis

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe 'install aspnet regiis' do
  its('stdout') { should eq 0 }
end
