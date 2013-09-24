module API
  module V1
    class OrganizationsController < ApplicationController
      def show
        @organization_presenter = API::OrganizationPresenter.new(Container.get('organization.detail').find(current_user, params))
        render :show
      end
    end
  end
end
