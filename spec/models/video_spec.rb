require 'spec_helper'

describe Video do
  it "saves itself" do
    v = Video.new(title: "Family Guy", description: "Cartoon for adults.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/blank_large.jpg")
    v.save
    expect(Video.first).to eq(v)
  end
end
