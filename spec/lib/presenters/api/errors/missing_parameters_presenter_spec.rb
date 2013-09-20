require 'spec_helper'
require 'presenters/api/errors/missing_parameters_presenter'

describe API::Errors::MissingParametersPresenter do
  it_behaves_like 'an error presenter'

  expect_it { to have_attr_accessor :fields }
  it { expect(subject.error_code).to eql(:missing_parameters) }
  it { expect(subject.error_message).to eql('You forgot to send some parameters') }
  it { expect(subject.http_code).to eql(:bad_request) }

  describe '#fields' do
    let(:exception) { double(param: 'a_field_name') }

    before(:each) do
      subject.exception = exception
    end

    it { expect(subject.fields).to eql([{ field: 'a_field_name', message: 'is required' }]) }
  end
end
