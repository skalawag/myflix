require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    describe ".create" do
      it "successfully charges user's card", {vcr: true} do
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

        expect(response).to be_successful
      end

      it "handles a declined charge", {vcr: true} do
        token = Stripe::Token.create(
          :card => {
            :number => "4000000000000002",
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

        expect(response).not_to be_successful
      end

      it "returns the error message for declined charges", {vcr: true} do
        token = Stripe::Token.create(
          :card => {
            :number => "4000000000000002",
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

        expect(response.error_message).to eq("Your card was declined.")
      end
    end
  end
end
