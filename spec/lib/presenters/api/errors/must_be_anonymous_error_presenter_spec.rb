require 'spec_helper'
require 'presenters/api/errors/must_be_anonymous_error_presenter'

describe API::Errors::MustBeAnonymousErrorPresenter do
  it_behaves_like 'an error presenter'

  it { subject.error_code.should == :authenticated }
  it { subject.error_message.should == 'You have to log out to perform this action' }
  it { subject.http_code.should == :not_allowed }
end
