require 'spec_helper'

describe SessionController do
  describe "GET new" do

    it "redirects to home_path if current user exists" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :new
      expect(response).to redirect_to home_path
    end

    it "renders login form if no current user exists" do
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    it "attempts to find an existing user based on post params"
    it "redirects to new_login_path if user doesn't exist"
    it "redirects to home_path if user exists but fails to authenticate"
    it "sets session[:user_id] if user exists and authenticates"
    it "redirects to home_path if user exists and authenticates"
  end
end
