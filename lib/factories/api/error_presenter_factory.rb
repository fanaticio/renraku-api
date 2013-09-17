require 'active_support/inflector'

module API
  class ErrorPresenterFactory
    def self.build(exception)
      injection_name         = "error.#{exception.class.to_s.underscore.gsub('/', '.')}"
      injection              = Container.get(injection_name)
      raise exception unless injection
      injection.exception    = exception

      injection
    end
  end
end
