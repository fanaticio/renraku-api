require 'spec_helper'

describe 'Variable', :rails do
  subject { Variable.new }

  it_behaves_like 'a classic model'
  expect_it { to have_fields(:name).of_type(String) }
  expect_it { to have_fields(:default_value).of_type(String) }
  expect_it { to be_embedded_in(:template) }
  expect_it { to validate_presence_of(:name) }
  expect_it { to validate_uniqueness_of(:name).scoped_to(:template) }
end
