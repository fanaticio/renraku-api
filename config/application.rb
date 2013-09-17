require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_mailer/railtie'

Bundler.require(:default, Rails.env)

module Renraku
  class Application < Rails::Application
    config.action_controller.action_on_unpermitted_parameters = :raise
    %w(errors factories presenters services tasks).each do |lib_type|
      config.eager_load_paths << Rails.root.join('lib', lib_type)
    end
  end
end
