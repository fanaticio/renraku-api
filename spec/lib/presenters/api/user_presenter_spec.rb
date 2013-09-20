require 'spec_helper'
require 'presenters/api/user_presenter'

describe API::UserPresenter do
  subject { API::UserPresenter.new(double) }

  expect_it { to have_attr_accessor :user }
  expect_it { to delegates(:login).to(:user) }
  expect_it { to delegates(:auth_token).to(:user) }

  describe '#organizations' do
    before(:each) do
      allow(subject.user).to receive(:organizations).and_return([double(name: 'github'), double(name: 'bitbucket')])
    end

    it { expect(subject.organizations).to eql([{ name: 'github' }, { name: 'bitbucket' }]) }
  end
end
