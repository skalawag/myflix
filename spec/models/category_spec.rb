require 'spec_helper'

describe Category do
  it { should have_many :video_categories }
  it { should have_many :videos }
end

describe "Category.recent_videos" do
  it "should return [] if there are no videos" do
    cat = Category.create(name: "Test")
    expect(cat.recent_videos).to eq([])
  end

  it "should return up to 3 videos in reverse chronological order" do
    cat = Category.create(name: "Test")
    3.times do |n|
      cat.videos << Video.create(title: "#{n}", created_at: n.days.ago)
    end
    expect(cat.recent_videos).to eq(Video.all)
  end
end
