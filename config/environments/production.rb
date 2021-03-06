Renraku::Application.configure do
  config.cache_classes = true
  config.eager_load    = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.force_ssl = true

  config.log_level     = :info
  config.log_formatter = ::Logger::Formatter.new

  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
end
