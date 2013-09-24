require 'active_support/core_ext/module/delegation'

module API
  class OrganizationPresenter
    attr_accessor :organization

    delegate :name, to: :organization

    def initialize(organization)
      self.organization = organization
    end

    def owner
      self.organization.user.login
    end

    def templates_count
      self.organization.templates.count
    end

    def templates
      self.organization.templates.map do |template|
        {
          name: template.name
        }
      end
    end
  end
end
