require 'spec_helper'

describe Category do
  it "saves itself" do
    video = Video.new(title: "Family Guy", description: "Cartoon for adults.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/blank_large.jpg")
    video.save

    expect(Video.first).to eq(video)
  end

  it "has many videos" do
    v1 = Video.create(title: "Family Guy", description: "Cartoon for adults.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/blank_large.jpg")
    v2 = Video.create(title: "Monk", description: "Not really sure what this is.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
    cat = Category.new(name: "Test Category")
    v1.categories << cat
    v2.categories << cat
    v1.save
    v2.save

    expect(Category.first.videos).to eq([v1, v2])
  end
end
