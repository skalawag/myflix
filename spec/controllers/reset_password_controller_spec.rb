require 'spec_helper'

describe ResetPasswordController do
  describe "POST create" do
    it "should renders :new if user enters incorrect email" do
      post :create, email: "xyz@xyz.com"
      expect(response).to render_template :new
    end

    it "should set the user's token" do
      user = Fabricate(:user, email: "xyz@xyz.com")
      post :create, email: "xyz@xyz.com"
      expect(User.find(user.id).token).to_not eq(nil)
    end

    it "should have display an error message if user's email cannot be found" do
      user = Fabricate(:user, email: "xyz@xyz.com")
      post :create, email: "xzz@xyz.com"
      expect(flash[:error]).to eq("The email you entered is not a valid user's email.")
    end

    it "should render new when email is invalid" do
      user = Fabricate(:user, email: "xyz@xyz.com")
      post :create, email: "xzz@xyz.com"
      expect(response).to render_template :new
    end

    context "with email" do
      after { ActionMailer::Base.deliveries.clear }

      it "should send email to user if user is confirmed" do
        user = Fabricate(:user)
        post :create, email: user.email
        msg = ActionMailer::Base.deliveries.last
        expect(msg.to).to eq([user.email])
      end

      it "redirects to reset_password_confirmation page if user is confirmed" do
        user = Fabricate(:user)
        post :create, email: user.email
        expect(response).to redirect_to reset_password_confirmation_path
      end
    end
  end
end
