module API
  module V1
    class UsersController < ::API::ApplicationController
      before_filter :ensure_anonymous_user

      def create
        @user_presenter = API::UserPresenter.new(Container.get('user.creation').create(params))
        render :create
      end
    end
  end
end
