require 'spec_helper'
require 'presenters/api/organization_presenter'

describe API::OrganizationPresenter do
  let(:organization) { double }
  subject { API::OrganizationPresenter.new(organization) }

  expect_it { to have_attr_accessor :organization}
  expect_it { to delegates(:name).to(:organization) }

  describe '#owner' do
    let(:user) { double }

    before(:each) do
      allow(organization).to receive(:user).and_return(user)
      allow(user).to receive(:login).and_return('jdoe')
    end

    it 'returns the owner login of the organization' do
      expect(subject.owner).to eql('jdoe')
    end
  end

  describe '#templates_count' do
    let(:templates) { [double, double] }

    before(:each) do
      organization.stub(:templates).and_return(templates)
    end

    it 'returns the number of templates associated to the organization' do
      expect(subject.templates_count).to eql(2)
    end
  end

  describe '#templates' do
    let(:templates) { [double(name: 'template-1'), double(name: 'template-2')] }

    before(:each) do
      organization.stub(:templates).and_return(templates)
    end

    it 'returns formatted templates' do
      expect(subject.templates).to eql([{ name: 'template-1' }, { name: 'template-2' }])
    end
  end
end
