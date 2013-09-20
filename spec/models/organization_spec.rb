require 'spec_helper'

describe 'Organization', :rails do
  subject { Organization.new }

  it_behaves_like 'a classic model'
  expect_it { to have_fields(:name).of_type(String) }
  expect_it { to be_embedded_in(:user) }
  expect_it { to validate_presence_of(:name) }
  expect_it { to validate_presence_of(:user) }
  expect_it { to validate_uniqueness_of(:name) }
end
