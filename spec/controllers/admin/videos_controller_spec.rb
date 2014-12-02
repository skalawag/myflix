require 'spec_helper'

describe Admin::VideosController do

  describe "GET new" do
    it "requires admin priveleges" do
      authenticated_user
      get :new
      expect(response).to redirect_to home_path
    end

    it "sets flash error message" do
      authenticated_user
      get :new
      expect(flash[:error]).to eq("You must be an admin to visit that page.")
    end

    it "sets @video to a new video object" do
      set_current_admin
      get :new
      expect(assigns(:video)).to be_instance_of(Video)
    end
  end

  describe "POST create" do
    context "with authorized admin" do
      before { set_current_admin && Fabricate(:category) }

      it "should have @video set to a new video object" do
        post :create, video: { title: "Hello", description: "World"}, category: ["1"]
        expect(assigns(:video)).to be_instance_of(Video)
      end

      it "should redirect to home_path if video successfully saves" do
        post :create, video: { title: "Hello", description: "World"}, category: ["1"]
        expect(response).to redirect_to new_admin_video_path
      end

      it "should set success message if video successfully saves" do
        post :create, video: { title: "Hello", description: "World"}, category: ["1"]
        expect(flash[:success]).to eq("Your video has been added.")
      end

      it "should redirect to new_admin_video_path if params are missing" do
        post :create , category: ["1"]
        expect(response).to redirect_to new_admin_video_path
      end

      it "should set flash[:error] if video saving fails" do
        post :create, video: { title: "Hello"}, category: ["1"]
        expect(flash[:error]).to eq("Try again!")
      end

      it "should set flash error when there is no category is passed in" do
        post :create, video: {title: "Hello", description: "World"}
        expect(flash[:error]).to eq("Try again!")
      end

      it "should correctly categorize videos" do
        post :create, video: {title: "Hello", description: "World"}, category: ["1"]
        expect(Video.first.categories.first.id).to eq(1)
      end
    end
  end
end
