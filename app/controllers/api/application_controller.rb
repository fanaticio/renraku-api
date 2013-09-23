module API
  class ApplicationController < ActionController::Base
    before_filter :ensure_authenticated

    respond_to :json

    rescue_from(Exception) do |exception|
      @error_presenter = ::API::ErrorPresenterFactory.build(exception)

      render @error_presenter.view_name, status: @error_presenter.http_code
    end

  protected

    def current_user
      @current_user ||= authenticate_with_http_token do |token, options|
        Container.get('user.finder').find_by_token(token)
      end
    end

    def current_user?
      !!current_user
    end

    def ensure_anonymous_user
      raise ::API::MustBeAnonymousError if current_user?
    end

    def ensure_authenticated
      raise ::API::MustBeAuthenticatedError unless current_user?
    end
  end
end
