require 'spec_helper'

describe Video do
  it { should have_many :video_categories }
  it { should have_many :categories }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many :reviews }
  it { should have_many :queued_videos }
  it { should have_many :users }
end

describe "Video.search_by_title" do
  it "should return [] if no match is found" do
    Video.create(title: "Monk", description: "Not really sure what this is.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
    result = Video.search_by_title("Any")
    expect(result).to eq([])
  end

  it "should return a list of 1 video for an exact match" do
    result = Video.create(title: "Monk", description: "Not really sure what this is.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
    expect(result).to eq(Video.first)
  end

  it "should return a list of all videos making a partial match" do
    v1 = Video.create(title: "Family Guy", description: "Cartoon for adults.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/blank_large.jpg")
    v2 = Video.create(title: "Guy in the Middle", description: "Cartoon for adults.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/blank_large.jpg")

    expect(Video.search_by_title("Guy")).to eq([v1,v2])
  end
end
