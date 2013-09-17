require 'spec_helper'
require 'presenters/api/errors/unpermitted_parameters_presenter'

describe API::Errors::UnpermittedParametersPresenter do
  it_behaves_like 'an error presenter'

  it { should have_attr_accessor(:fields) }
  it { subject.error_code.should == :unpermitted_parameters }
  it { subject.error_message.should == 'You add some unexpected parameters' }
  it { subject.http_code.should == :bad_request }

  describe '#fields' do
    let(:exception) do
      exception = double
      exception.stub(:params).and_return(['param_1', 'param_2'])

      exception
    end

    before(:each) do
      subject.exception = exception
    end

    it { subject.fields.should == [{ field: 'param_1', message: 'is not permitted' }, { field: 'param_2', message: 'is not permitted' }] }
  end
end
