require 'spec_helper'
require 'presenters/api/errors/must_be_anonymous_error_presenter'

describe API::Errors::MustBeAnonymousErrorPresenter do
  it_behaves_like 'an error presenter'

  it { expect(subject.error_code).to eql(:authenticated) }
  it { expect(subject.error_message).to eql('You have to log out to perform this action') }
  it { expect(subject.http_code).to eql(:not_allowed) }
end
