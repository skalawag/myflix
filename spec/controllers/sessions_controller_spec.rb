require 'spec_helper'

describe SessionsController do
  describe "GET new" do

    it "redirects to home_path if current user exists" do
      authenticated_user
      get :new
      expect(response).to redirect_to home_path
    end

    it "renders login form if no current user exists" do
      get :new
      expect(response).to render_template :new
    end
  end

  context "with user" do

    before { test_user }

    describe "POST create" do
      it "redirects to new_login_path if user doesn't exist" do
        post :create, email: "test_email", password: "test"
        expect(response).to redirect_to home_path
      end

      it "redirects to new_login_path if user exists but fails to authenticate" do
        post :create, email: "test_email", password: "notest"
        expect(response).to redirect_to new_login_path
      end

      it "sets session[:user_id] if user exists and authenticates" do
        post :create, email: "test_email", password: "test"
        expect(session[:user_id]).to eq(1)
      end

      it "redirects to home_path if user exists and authenticates" do
        post :create, email: "test_email", password: "test"
        expect(request).to redirect_to home_path
      end
    end
  end
end
