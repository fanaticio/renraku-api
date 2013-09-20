require 'spec_helper'
require 'presenters/api/errors/validation_error_presenter.rb'

describe API::Errors::ValidationErrorPresenter do
  it_behaves_like 'an error presenter'

  expect_it { to have_attr_accessor :fields }
  it { expect(subject.error_code).to eql(:validation) }
  it { expect(subject.error_message).to eql('Some fields cannot be validated') }
  it { expect(subject.http_code).to eql(:forbidden) }

  describe '#fields' do
    let(:exception) do
      exception = double
      exception.stub_chain(:fields, :as_json).and_return([{ field_1: 'is required' }, { field_2: 'is already taken' }])

      exception
    end

    before(:each) do
      subject.exception = exception
    end

    it { expect(subject.fields).to eql([{ field_1: 'is required' }, { field_2: 'is already taken' }]) }
  end
end
