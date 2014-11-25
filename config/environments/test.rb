Myflix::Application.configure do
  config.cache_classes = true

  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  config.eager_load = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_dispatch.show_exceptions = false

  config.action_controller.allow_forgery_protection    = false

  config.action_mailer.delivery_method = :test

  config.action_mailer.default_url_options = { host: '0.0.0.0', port: 3001 }

  config.active_support.deprecation = :stderr
end
