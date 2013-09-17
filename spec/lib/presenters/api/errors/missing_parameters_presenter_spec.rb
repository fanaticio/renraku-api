require 'spec_helper'
require 'presenters/api/errors/missing_parameters_presenter'

describe API::Errors::MissingParametersPresenter do
  it_behaves_like 'an error presenter'

  it { should have_attr_accessor :fields }
  it { subject.error_code.should == :missing_parameters }
  it { subject.error_message.should == 'You forgot to send some parameters' }
  it { subject.http_code.should == :bad_request }

  describe '#fields' do
    let(:exception) do
      exception = double
      exception.stub(:param).and_return('a_field_name')

      exception
    end

    before(:each) do
      subject.exception = exception
    end

    it { subject.fields.should == [{ field: 'a_field_name', message: 'is required' }] }
  end
end
