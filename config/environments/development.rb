Myflix::Application.configure do
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = {host: '192.168.1.2:3001'}
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :user_name => '2651683f91e05b147',
    :password => 'e4f71fce4d3a46',
    :address => 'mailtrap.io',
    :domain => 'mailtrap.io',
    :port => '2525',
    :authentication => :cram_md5
  }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets

  config.assets.debug = true

  config.eager_load = false
end
