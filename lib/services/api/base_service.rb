module API
  module BaseService
    module InstanceMethods
      def validation_error_on(fields)
        fields = [fields] unless fields.is_a?(Array)
        raise API::ValidationError.new(fields)
      end
    end

    def self.included(base)
      base.send(:include, InstanceMethods)
    end
  end
end
