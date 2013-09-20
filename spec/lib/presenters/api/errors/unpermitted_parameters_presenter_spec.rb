require 'spec_helper'
require 'presenters/api/errors/unpermitted_parameters_presenter'

describe API::Errors::UnpermittedParametersPresenter do
  it_behaves_like 'an error presenter'

  expect_it { to have_attr_accessor(:fields) }
  it { expect(subject.error_code).to eql(:unpermitted_parameters) }
  it { expect(subject.error_message).to eql('You add some unexpected parameters') }
  it { expect(subject.http_code).to eql(:bad_request) }

  describe '#fields' do
    let(:exception) { double(params: ['param_1', 'param_2']) }

    before(:each) do
      subject.exception = exception
    end

    it { expect(subject.fields).to eql([{ field: 'param_1', message: 'is not permitted' }, { field: 'param_2', message: 'is not permitted' }]) }
  end
end
