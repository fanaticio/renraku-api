module API
  module Errors
    class MustBeAnonymousErrorPresenter < API::Errors::BasePresenter
      def initialize
        super
        self.error_code    = :authenticated
        self.error_message = 'You have to log out to perform this action'
        self.http_code     = :unauthorized
      end
    end
  end
end
