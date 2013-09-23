require 'spec_helper'
require 'services/api/base_service'
require 'services/api/users/creation_service'

describe API::Users::CreationService do
  it_behaves_like 'an API service', [
    [nil, { organization_name: 'value', user: { login: 'value', email: 'value', password: 'value' }}],
    ['ActionController::ParameterMissing', { user: { login: 'value', email: 'value', password: 'value' }}],
    ['ActionController::ParameterMissing', { organization_name: 'value' }],
    ['ActionController::ParameterMissing', { organization_name: 'value', user: { email: 'value', password: 'value' }}],
    ['ActionController::ParameterMissing', { organization_name: 'value', user: { login: 'value', password: 'value' }}],
    ['ActionController::ParameterMissing', { organization_name: 'value', user: { login: 'value', email: 'value' }}],
    ['ActionController::UnpermittedParameters', { another: 'parameter', organization_name: 'value', user: { login: 'value', email: 'value' }}],
  ]

  describe '#create' do
    before(:each) do
      subject.stub(:check_parameters).and_return(nil)
      stub_const('User', double)
      stub_const('Organization', double)
    end

    context 'when organization name already exists' do
      before(:each) do
        User.stub_chain(:where, :exists?).and_return(true)
      end

      it 'raises a validation error' do
        exception = Class.new(Exception)
        subject.stub(:validation_error_on).with(organization_name: ['is already taken']) { raise exception }

        expect { subject.create({ organization_name: 'fanaticio' }) }.to raise_error(exception)
      end
    end

    context 'when organization name does not exist' do
      before(:each) do
        User.stub_chain(:where, :exists?).and_return(false)
      end

      context 'when user cannot be created' do
        before(:each) do
          user = double(save: false, errors: [{ password: ['is too short'] }])
          User.stub(:new).with(login: 'jdoe', email: 'john.doe@fanatic.io', password: '1337').and_return(user)
        end

        it 'raises a validation error' do
          exception = Class.new(Exception)
          subject.stub(:validation_error_on).with([{ password: ['is too short'] }]) { raise exception }

          expect { subject.create({ user: { login: 'jdoe', email: 'john.doe@fanatic.io', password: '1337' }}) }.to raise_error(exception)
        end
      end

      context 'when user can be created' do
        let(:organization) { double }
        let(:user)         { double(save: true, organizations: []) }

        before(:each) do
          allow(User).to receive(:new).with(login: 'jdoe', email: 'john.doe@fanatic.io', password: '1337').and_return(user)
          allow(Organization).to receive(:new).with(name: 'fanaticio').and_return(organization)
        end

        it 'creates the organization too' do
          expect(user.organizations).to receive(:<<).with(organization)
          subject.create({ organization_name: 'fanaticio', user: { login: 'jdoe', email: 'john.doe@fanatic.io', password: '1337' }})
        end

        it 'returns the user' do
          expect(subject.create({ organization_name: 'fanaticio', user: { login: 'jdoe', email: 'john.doe@fanatic.io', password: '1337' }})).to eql(user)
        end
      end
    end
  end
end
