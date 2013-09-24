require 'spec_helper'
require 'services/api/base_service'
require 'services/api/organizations/detail_service'

describe API::Organizations::DetailService do
  it_behaves_like 'an API service', [
    [nil, { id: 'value' }],
    ['ActionController::ParameterMissing', {}],
    ['ActionController::UnpermittedParameters', { another: 'value', id: 'value' }],
  ]

  describe '#find' do
    let(:organization_finder) { double }
    let(:user)                { double }
    let(:parameters)          { { id: 'fanaticio' } }

    before(:each) do
      stub_const('Container', double)
      allow(Container).to receive(:get).with('organization.finder').and_return(organization_finder)
      subject.stub(:check_parameters).and_return(nil)
    end

    context 'when organization does not exist' do
      before(:each) do
        allow(organization_finder).to receive(:find_by_name).with(user, 'fanaticio').and_return(nil)
      end

      it 'raises a validation error' do
        exception = Class.new(Exception)
        subject.stub(:validation_error_on).with({ organization_name: ['does not exist'] }) { raise exception }
        expect { subject.find(user, parameters) }.to raise_error(exception)
      end
    end

    context 'when organization exists' do
      let(:organization) { double }

      before(:each) do
        allow(organization_finder).to receive(:find_by_name).with(user, 'fanaticio').and_return(organization)
      end

      it 'returns organization' do
        expect(subject.find(user, parameters)).to eql(organization)
      end
    end
  end
end
