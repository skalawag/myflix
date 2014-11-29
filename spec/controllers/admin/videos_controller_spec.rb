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

      it "has set @categories instance variable" do
        user.update_attribute(:admin, true)
        target = Category.all.map { |category| "<option>#{category.name}</option>" }.join()
        get :new
        expect(assigns(:categories)).to eq(target)
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
      it "sets flash[:error] if user is not admin" do
        post :create
        expect(flash[:error]).to eq("You are not authorized to access that page.")
      end
    end

    describe "POST create" do
      before { user.update_attribute(:admin, true) }

      it "should redirect to home_path" do
        post :create, title: "Home", description: "Something"
        expect(response).to redirect_to home_path
      end

      it "has @video instance variable set to a new video" do
        post :create, title: "Home", description: "Something"
        expect(assigns(:video)).to be_a(Video)
      end

      it "sets flash[:error] if video fails to save" do
        post :create, title: "Home"
        expect(flash[:error]).to eq("Something went wrong.")
      end

      it "redirects to new_admin_video_path when it cannot save a video" do
        post :create, title: "Home"
        expect(response).to redirect_to new_admin_video_path
      end
    end
  end
end
