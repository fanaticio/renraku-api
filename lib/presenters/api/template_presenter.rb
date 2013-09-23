require 'active_support/core_ext/module/delegation'

module API
  class TemplatePresenter
    attr_accessor :template

    delegate :name, to: :template

    def initialize(template)
      self.template = template
    end
  end
end
