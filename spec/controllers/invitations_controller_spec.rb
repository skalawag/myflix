require 'spec_helper'

describe InvitationsController do
  describe "GET new" do
    it "renders the new invitation page" do
      get :new
      expect(response).to render_template :new
    end
  end

  context "with email" do
    after { ActionMailer::Base.deliveries.clear }

    describe "POST create" do
      it "redirects to home path after successful invitation made" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        get :create, name: "Joey", email: "joey@joey.com", message: "Come join the party"
        expect(response).to redirect_to home_path
      end
    end
  end
end
