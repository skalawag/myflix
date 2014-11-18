require 'spec_helper'

describe NewPasswordController do
  describe "GET show" do
    it "has the user_id of the user changing her password" do
      user = Fabricate(:user)
      user.update_column(:token, 'asdf')
      get :show, id: 'asdf'
      expect(assigns(:user_id)).to eq(user.id)
    end

    it "sets user_token to nil" do
      user = Fabricate(:user)
      user.update_column(:token, 'asdf')
      get :show, id: 'asdf'
      expect(User.find(user.id).token).to eq(nil)
    end
  end

  describe "POST create" do
    it "resets user password" do
      user = Fabricate(:user)
      post :create, user_id: user.id, password: 'whatever'
      expect(user.reload.authenticate('whatever')).to be_truthy
    end

    it "redirects to sign in page" do
      user = Fabricate(:user)
      post :create, user_id: user.id, password: 'whatever'
      expect(response).to redirect_to new_login_path
    end

    it "sets the success message" do
      user = Fabricate(:user)
      post :create, user_id: user.id, password: 'whatever'
      expect(flash[:success]).to eq("Your password has been changed. Please log in.")
    end

    it "redirects to reset_password_path if something goes wrong" do
      user = Fabricate(:user)
      post :create, user_id: user.id, password: ''
      expect(response).to redirect_to reset_password_path
    end

    it "sets the error message if something goes wrong" do
      user = Fabricate(:user)
      post :create, user_id: user.id, password: ''
      expect(flash[:error]).to eq("Something has gone wrong. Please try resetting your password again.")
    end
  end
end
