require 'spec_helper'
require 'presenters/api/errors/must_be_authenticated_error_presenter'

describe API::Errors::MustBeAuthenticatedErrorPresenter do
  it_behaves_like 'an error presenter'

  it { expect(subject.error_code).to eql(:not_authenticated) }
  it { expect(subject.error_message).to eql('You have to log in to perform this action') }
  it { expect(subject.http_code).to eql(:unauthorized) }
end
