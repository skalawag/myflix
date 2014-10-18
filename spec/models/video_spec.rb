require 'spec_helper'

describe Video do
  it "saves itself" do
    v = Video.new(title: "Family Guy", description: "Cartoon for adults.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/blank_large.jpg")
    v.save
    expect(Video.first).to eq(v)
  end

  it "has a category" do
    v = Video.create(title: "Family Guy", description: "Cartoon for adults.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/blank_large.jpg")
    cat = Category.create(name: "Test Category")
    v.categories << cat
    v.save

    expect(Video.first.categories.first).to eq(cat)
  end

  it "validates title" do
    v = Video.create(description: "Hello")

    expect(v.valid?).to eq(false)
  end

  it "validates description" do
    v = Video.create(title: "Hello")

    expect(v.valid?).to eq(false)
  end

  it "valid when both title and description are present" do
    v = Video.create(title: "Hello", description: "World")

    expect(v.valid?).to eq(true)
  end
end
