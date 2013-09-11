module API
  module Errors
    class ValidationErrorPresenter < API::Errors::BasePresenter
      attr_accessor :fields

      def initialize
        super
        self.error_code    = :validation
        self.error_message = 'Some fields cannot be validated'
        self.http_code     = :forbidden
      end

      def fields
        self.exception.fields.as_json
      end
    end
  end
end
