require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    before { authenticated_user }
    let(:user) { User.first }

    context "with authenticated user" do
      it "has @video instance variable to a new video" do
        user.update_attribute(:admin, true)
        get :new
        expect(assigns(:video)).to be_a(Video)
      end

      it "redirects ordinary user to home path" do
        get :new
        expect(response).to redirect_to home_path
      end

      it "sets flash[:error] if user is not admin" do
        get :new
        expect(flash[:error]).to eq("You are not authorized to access that page.")
      end
    end

    describe "POST create" do
      before { user.update_attribute(:admin, true) }

      it "should redirect to" do
        get :create
        expect(response).to redirect_to home_path
      end

      it "has @video instance variable set to a new video" do
        user.update_attribute(:admin, true)
        get :create
        expect(assigns(:video)).to be_a(Video)
      end
    end
  end
end
