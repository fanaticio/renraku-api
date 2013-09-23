module API
  module Errors
    class MustBeAuthenticatedErrorPresenter < API::Errors::BasePresenter
      def initialize
        super
        self.error_code    = :not_authenticated
        self.error_message = 'You have to log in to perform this action'
        self.http_code     = :unauthorized
      end
    end
  end
end
