require 'spec_helper'
require 'services/api/base_service'
require 'services/api/templates/creation_service'

describe API::Templates::CreationService do
  it_behaves_like 'an API service', [
    [nil, { organization_id: 'value', template: { body_html: 'value', body_text: 'value', from: 'value', name: 'value', subject: 'value', variables: [{ name: 'value_1', default_value: 'value' }, { name: 'value_2' }]}}],
    [nil, { organization_id: 'value', template: { body_html: 'value', body_text: 'value', from: 'value', name: 'value', subject: 'value', variables: [{ name: 'value_1', default_value: 'value' }]}}],
    [nil, { organization_id: 'value', template: { body_html: 'value', body_text: 'value', from: 'value', name: 'value', subject: 'value', variables: [{ name: 'value_1' }]}}],
    [nil, { organization_id: 'value', template: { body_html: 'value', body_text: 'value', from: 'value', name: 'value', subject: 'value' }}],
    ['ActionController::ParameterMissing', { template: { body_html: 'value', body_text: 'value', from: 'value', name: 'value', subject: 'value' }}],
    ['ActionController::ParameterMissing', { organization_id: 'value' }],
    ['ActionController::ParameterMissing', { organization_id: 'value', template: { body_text: 'value', from: 'value', name: 'value', subject: 'value' }}],
    ['ActionController::ParameterMissing', { organization_id: 'value', template: { body_html: 'value', from: 'value', name: 'value', subject: 'value' }}],
    ['ActionController::ParameterMissing', { organization_id: 'value', template: { body_html: 'value', body_text: 'value', name: 'value', subject: 'value' }}],
    ['ActionController::ParameterMissing', { organization_id: 'value', template: { body_html: 'value', body_text: 'value', from: 'value', subject: 'value' }}],
    ['ActionController::ParameterMissing', { organization_id: 'value', template: { body_html: 'value', body_text: 'value', from: 'value', name: 'value' }}],
    ['ActionController::UnpermittedParameters', { another: 'value', organization_id: 'value', template: { body_html: 'value', body_text: 'value', from: 'value', subject: 'value' }}],
  ]

  describe '#create' do
    let(:user)       { double }
    let(:parameters) { {} }
    before(:each) do
      subject.stub(:check_parameters).and_return(nil)
    end

    context 'when organization does not exist' do
      before(:each) do
        user.stub_chain(:organizations, :find_by).and_return(nil)
      end

      it 'raises a validation error' do
        exception = Class.new(Exception)
        subject.stub(:validation_error_on).with({organization_name: ['does not exist'] }) { raise exception }

        expect { subject.create(user, parameters) }.to raise_error(exception)
      end
    end

    context 'when organization exists' do
      let(:organization) { double(templates: [], save: true) }
      let(:template)     { double }

      before(:each) do
        stub_const('Template', double)

        parameters[:template] = { key: 'value' }
        user.stub_chain(:organizations, :find_by).and_return(organization)
        allow(Template).to receive(:new).with({ key: 'value' }).and_return(template)
      end

      it 'adds a template to the organization' do
        expect(organization.templates).to receive(:<<).with(template)
        subject.create(user, parameters)
      end

      context 'when the template cannot be added' do
        before(:each) do
          allow(organization).to receive(:save).and_return(false)
        end

        it 'returns validation error' do
          exception = Class.new(Exception)
          errors    = double
          allow(template).to receive(:errors).and_return(errors)
          subject.stub(:validation_error_on).with(errors) { raise exception }

          expect { subject.create(user, parameters) }.to raise_error(exception)
        end
      end

      context 'when the template can be added' do
        it 'returns template' do
          expect(subject.create(user, parameters)).to eql(template)
        end
      end
    end
  end
end
