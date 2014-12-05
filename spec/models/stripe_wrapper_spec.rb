require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe ".create" do
      it "successfully charges user's card", :vcr do
        token = Stripe::Token.create(
          :card => {
            :number => "4242424242424242",
            :exp_month => 12,
            :exp_year => 2015,
            :cvc => "314"
          },
        ).id

        response = StripeWrapper::Charge.create(
          :amount => 999,
          :card => token,
          :description => "Charge for test@example.com"
        )

        expect(response.currency).to eq('usd')
        expect(response.amount).to eq(999)
        expect(response.paid).to eq(true)
      end
    end
  end
end
