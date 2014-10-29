require 'spec_helper'

describe VideosController do
  let(:result) { Fabricate(:video, title: "Family Guy") }

  context "with authenticated user" do
    before do
      Fabricate(:user)
      session[:user_id] = 1
    end

    describe "GET show" do

      it "sets @video" do
        get :show, id: result.id
        assigns(:video).should eq(result)
      end

      it "renders the video page for a given video" do
        get :show, id: result.id
        response.should render_template :show
      end
    end

    describe "GET search_by_title" do

      it "sets @video variable" do
        get :search_by_title, search_term: result.title
        assigns(:videos).should eq([result])
      end

      it "renders search_by_title page for a given search term" do
        get :search_by_title, search_term: result.title
        response.should render_template :search_by_title
      end
    end
  end
end
