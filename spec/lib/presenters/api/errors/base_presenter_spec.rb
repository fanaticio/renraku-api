require 'spec_helper'
require 'presenters/api/errors/base_presenter'

describe API::Errors::BasePresenter do
  it_behaves_like 'an error presenter'

  it { expect(subject.view_name).to eql('api/error') }
end
