module API
  module Errors
    class BasePresenter
      attr_accessor :error_code, :error_message, :exception, :http_code, :view_name

      def initialize
        self.view_name = 'api/error'
      end
    end
  end
end
