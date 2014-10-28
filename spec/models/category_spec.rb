require 'spec_helper'

describe Category do
  it { should have_many :video_categories }
  it { should have_many :videos }
  it { should validate_presence_of(:name) }
end

describe "Category.recent_videos" do
  it "should return [] if there are no videos" do
    cat = Category.create(name: "Test")
    expect(cat.recent_videos).to eq([])
  end

  it "should return 3 videos in reverse chronological order" do
    cat = Category.create(name: "Test")
    3.times do |n|
      cat.videos << Video.create(title: "#{n}", created_at: n.days.ago)
    end
    expect(cat.recent_videos.to_a).to eq(Video.all)
  end

  it "should return most recent 6 videos" do
    cat = Category.create(name: "Test")
    10.times do |n|
      cat.videos << Video.create(title: "#{n}", created_at: n.days.ago)
    end
    expect(cat.recent_videos.to_a).to eq(Video.all[0..5])
  end
end
