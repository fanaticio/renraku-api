require 'spec_helper'
require 'presenters/api/errors/validation_error_presenter.rb'

describe API::Errors::ValidationErrorPresenter do
  it_behaves_like 'an error presenter'

  it { should have_attr_accessor :fields }
  it { subject.error_code.should == :validation }
  it { subject.error_message.should == 'Some fields cannot be validated' }
  it { subject.http_code.should == :forbidden }

  describe '#fields' do
    let(:exception) do
      exception = double
      exception.stub_chain(:fields, :as_json).and_return([{ field_1: 'is required' }, { field_2: 'is already taken' }])

      exception
    end

    before(:each) do
      subject.exception = exception
    end

    it { subject.fields.should == [{ field_1: 'is required' }, { field_2: 'is already taken' }] }
  end
end
