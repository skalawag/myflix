require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    it "has @video instance variable to a new video" do
      user = authenticated_user
      user.update_attribute(:admin, true)
      get :new
      expect(assigns(:video)).to be_a(Video)
    end

    it "redirects ordinary user to home path" do
      user = authenticated_user
      get :new
      expect(response).to redirect_to home_path
    end

    it "sets flash[:error] if user is not admin"
  end
end
