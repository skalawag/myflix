require 'spec_helper'

describe VideosController do

  describe "GET show" do
    context "with authenticated user" do

      before do
        User.create(username: "Mark", email: "markscala@gmail.com", password: "hello")
        session[:user_id] = 1
      end
      it "retrieves the correct database entry for a given primary key" do
        result = Video.create(title: "Family Guy", description: "Cartoon for adults.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/blank_large.jpg")
        get :show, id: result.id

        assigns(:video).should eq(result)
      end

      it "renders the video page for a given video"
    end
  end
  describe "GET search_by_title" do
    it "renders search_by_title page for a given search term"
  end
end
