require 'spec_helper'

describe User do
  it { should have_secure_password }
  it { should validate_presence_of :email }
  it { should validate_presence_of :username }
  it { should have_many :reviews }
  it { should have_many :queued_videos }
  it { should have_many :videos }

  it "find_rating should return an empty string if user has no rating for video" do
    user = Fabricate(:user)
    video = Fabricate(:video)
    Review.create(user_id: user.id,
                  video_id: video.id,
                  review: "Whatever")
    expect(user.find_rating(video)).to eq("")
  end

  it "find_rating should return a string like '4 Stars' if user rated video" do
    user = Fabricate(:user)
    video = Fabricate(:video)
    Review.create(user_id: user.id,
                  video_id: video.id,
                  review: "Whatever",
                  rating: 3)
    expect(user.find_rating(video)).to eq("3 Stars")
  end

  it "fix_rating returns an integer form for a rating" do
    user = Fabricate(:user)
    expect(user.fix_rating("3 Stars")).to eq("3")
  end

  it "updates ratings if user has changed them in queue" do
    user = Fabricate(:user)
    video = Fabricate(:video)
    Review.create(user_id: user.id,
                  video_id: video.id,
                  review: "Whatever",
                  rating: 3)
    user.update_ratings([{"id"=>"1", "rating"=>"5 Stars"}])
    expect(Review.first.rating).to eq(5)
  end

end
