module API
  class ValidationError < Exception
    attr_accessor :fields

    def initialize(fields)
      self.fields = fields
    end
  end
end
