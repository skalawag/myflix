require 'spec_helper'

describe VideosController do
  let(:result) { Fabricate(:video, title: "Family Guy") }
  before { authenticated_user }

  describe "GET show" do

    it "sets @video" do
      get :show, id: result.id
      expect(assigns(:video)).to eq(result)
    end

    it "renders the video page for a given video" do
      get :show, id: result.id
      response.should render_template :show
    end

    it "sets @reviews to an empty array if no reviews exist" do
      get :show, id: result.id
      expect(assigns(:reviews)).to eq([])
    end

    it "sets @reviews to an array of all reviews for video" do
      3.times do
        result.reviews << Fabricate(:review)
      end
      get :show, id: result.id
      expect(assigns(:reviews).length).to be == 3
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
