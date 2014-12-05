module StripeWrapper
  class Charge
    def self.create(options={})
      Stripe::Charge.create(
        :amount => options[:amount],
        :card => options[:card],
        :description => options[:description],
        :currency => 'usd')
    end
  end
end
