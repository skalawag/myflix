Rails.configuration.stripe = {
  # if Rails.env.development? || Rails.env.test? || Rails.env.staging?
  :publishable_key => ENV['STRIPE_TEST_PUBLISHABLE_KEY'],
  :secret_key      => ENV['STRIPE_TEST_SECRET_KEY']
  # else
  #   # we are not ever going to use _real_ keys in this app, so whether
  #   # we are in production or not, we use TEST keys.
  #   :publishable_key => ENV['STRIPE_TEST_PUBLISHABLE_KEY'],
  #   :secret_key      => ENV['STRIPE_TEST_SECRET_KEY']
  # end
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
