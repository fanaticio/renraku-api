require 'active_support/core_ext/module/delegation'

module API
  class UserPresenter
    attr_accessor :user

    delegate :login,      to: :user
    delegate :auth_token, to: :user

    def initialize(user)
      self.user = user
    end

    def organizations
      self.user.organizations.map { |organization| { name: organization.name } }
    end
  end
end
