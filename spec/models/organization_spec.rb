require 'spec_helper'

describe 'Organization', :rails do
  subject { Organization.new }

  it_behaves_like 'a classic model'
  it { should have_fields(:name).of_type(String) }
  it { should be_embedded_in(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
  it { should validate_uniqueness_of(:name) }
end
