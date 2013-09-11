require 'errors/api/validation_error'

shared_examples 'an API service' do |parameters_to_check|
  describe '#check_parameters', :rails do
    parameters_to_check.each do |expected_error, parameters|
      context "when parameters are #{parameters}" do
        if expected_error
          it { expect { subject.send(:check_parameters, ActionController::Parameters.new(parameters)) }.to raise_error(expected_error.constantize) }
        else
          it { expect { subject.send(:check_parameters, ActionController::Parameters.new(parameters)) }.to_not raise_error }
        end
      end
    end
  end

  describe '#validation_error_on' do
    [
      [[{ field_1: 'is required', field_2: 'is already taken' }], [{ field_1: 'is required', field_2: 'is already taken' }]],
      [{ field_1: 'is required', field_2: 'is already taken' },   [{ field_1: 'is required', field_2: 'is already taken' }]],
    ].each do |fields, exception_parameter|
      context "when parameter is #{fields.class}" do
        it 'raises a validation error' do
          expect { subject.validation_error_on(fields) }.to raise_error(API::ValidationError)
        end

        it 'passes an array as parameter of the exception' do
          exception = double
          API::ValidationError.stub(:new).with(exception_parameter).and_return(exception)
          subject.should_receive(:raise).with(exception)

          subject.validation_error_on(fields)
        end
      end
    end
  end
end
