require 'spec_helper'
require 'presenters/api/user_presenter'

describe API::UserPresenter do
  subject { API::UserPresenter.new(double) }

  it { should have_attr_accessor :user }
  it { should delegates(:login).to(:user) }
  it { should delegates(:auth_token).to(:user) }

  describe '#organizations' do
    before(:each) do
      subject.user.stub(:organizations).and_return([double(name: 'github'), double(name: 'bitbucket')])
    end

    it { subject.organizations.should == [{ name: 'github' }, { name: 'bitbucket' }] }
  end
end
