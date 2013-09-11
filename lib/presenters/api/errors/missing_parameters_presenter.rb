module API
  module Errors
    class MissingParametersPresenter < API::Errors::BasePresenter
      attr_accessor :fields

      def initialize
        super
        self.error_code    = :missing_parameters
        self.error_message = 'You forgot to send some parameters'
        self.http_code     = :bad_request
      end

      def fields
        [{ field: self.exception.param, message: 'is required' }]
      end
    end
  end
end
