require 'spec_helper'

describe Category do
  it { should have_many :video_categories }
  it { should have_many :videos }
  it { should validate_presence_of(:name) }
end

describe "Category.recent_videos" do

  before { new_category }

  it "should return [] if there are no videos" do
    expect(Category.first.recent_videos).to eq([])
  end

  it "should return 3 videos in reverse chronological order" do
    categorize_m_videos(3)
    expect(Category.first.recent_videos.to_a).to eq(Video.all)
  end

  it "should return most recent 6 videos" do
    categorize_m_videos(10)
    expect(Category.first.recent_videos.to_a).to eq(Video.all[0..5])
  end
end
