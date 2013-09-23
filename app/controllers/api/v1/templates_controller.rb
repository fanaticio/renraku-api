module API
  module V1
    class TemplatesController < ::API::ApplicationController
      def create
        @template_presenter = API::TemplatePresenter.new(Container.get('template.creation').create(current_user, params))
        render :create
      end
    end
  end
end
