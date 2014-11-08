require 'spec_helper'

describe User do
  it { should have_secure_password }
  it { should validate_presence_of :email }
  it { should validate_presence_of :username }
  it { should have_many :reviews }
  it { should have_many :queued_videos }
  it { should have_many :videos }

  context "with user and video" do
    before do
      user = Fabricate(:user)
      video = Fabricate(:video)
    end

    it "find_rating should return an empty string if user has no rating for video" do
      Review.create(user_id: User.first.id,
                    video_id: Video.first.id,
                    review: "Whatever")
      expect(User.first.find_rating(Video.first)).to eq("")
    end

    it "find_rating should return a string like '4 Stars' if user rated video" do
      Review.create(user_id: User.first.id,
                    video_id: Video.first.id,
                    review: "Whatever",
                    rating: 3)
      expect(User.first.find_rating(Video.first)).to eq("3 Stars")
    end

    it "fix_rating returns an integer form for a rating" do
      expect(User.first.fix_rating("3 Stars")).to eq("3")
    end

    it "updates ratings if user has changed them in queue" do
      Review.create(user_id: User.first.id,
                    video_id: Video.first.id,
                    review: "Whatever",
                    rating: 3)
      User.first.update_ratings([{"id"=>"1", "rating"=>"5 Stars"}])
      expect(Review.first.rating).to eq(5)
    end
  end
end
