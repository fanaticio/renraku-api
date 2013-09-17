module API
  module Errors
    class UnpermittedParametersPresenter < API::Errors::BasePresenter
      attr_accessor :fields

      def initialize
        super
        self.error_code    = :unpermitted_parameters
        self.error_message = 'You add some unexpected parameters'
        self.http_code     = :bad_request
      end

      def fields
        self.exception.params.map { |param| { field: param, message: 'is not permitted' } }
      end
    end
  end
end
