require 'spec_helper'

feature "Admin adds new video" do
  scenario "Admin successfully adds new video" do
    sign_in_user
    User.first.update_attribute(:admin, true)

    thrillers = Fabricate(:category, name: "Thrillers")
    visit new_admin_video_path

    fill_in "Title", with: "Peaky Blinders"
    select "Thrillers", from: "category"
    fill_in "Description", with: "Period thriller"
    attach_file "Large cover", "spec/support/uploads/blank_large.jpg"
    attach_file "Small cover", "spec/support/uploads/south_park.jpg"
    fill_in "Video url", with: "http://example.com/my_video.mp4"
    click_button "Add Video"
    expect(page).to have_content("Your video has been added")

    sign_out
    sign_in_user
    visit show_path(Video.first)
    expect(page).to have_selector("img[src='/uploads/blank_large.jpg']")
    expect(page).to have_selector("a[href='http://example.com/my_video.mp4']")
  end
end
