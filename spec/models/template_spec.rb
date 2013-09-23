require 'spec_helper'

describe 'Template', :rails do
  subject { Template.new }

  it_behaves_like 'a classic model'
  expect_it { to have_fields(:body_html).of_type(String) }
  expect_it { to have_fields(:body_text).of_type(String) }
  expect_it { to have_fields(:from).of_type(String) }
  expect_it { to have_fields(:name).of_type(String) }
  expect_it { to have_fields(:subject).of_type(String) }
  expect_it { to be_embedded_in(:organization) }
  expect_it { to embed_many(:variables) }
  expect_it { to validate_presence_of(:body_html) }
  expect_it { to validate_presence_of(:body_text) }
  expect_it { to validate_presence_of(:from) }
  expect_it { to validate_presence_of(:name) }
  expect_it { to validate_presence_of(:subject) }
  expect_it { to validate_format_of(:from).to_allow('john.doe@mail.com').not_to_allow('johndoe') }
  expect_it { to validate_uniqueness_of(:name).scoped_to(:organization) }
end
