require 'spec_helper'

describe Video do
  it { should have_many :video_categories }
  it { should have_many :categories }
end

describe "Video.search_by_title" do
  it "should return [] if no match is found" do
    result = Video.search_by_title("Any")
    expect(result).to eq([])
  end

  it "should return a list of 1 video for an exact match" do
    result = Video.search_by_title("Monk")
    expect(result).to eq(Video.find(2))
  end

  it "should return a list of all videos making a partial match"
end
