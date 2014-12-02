require 'spec_helper'

feature "Admin adds new video" do
  scenario "Admin successfully adds new video" do
    set_current_admin
    thrillers = Fabricate(:category, name: "Thrillers")
    visit new_admin_video_path

    fill_in "Title", with: "Peaky Blinders"
    select "Thrillers", from: "Category"
    fill_in "Description", with: "Period thriller"
    attach_file "Large Cover", "spec/support/uploads/blank_large.jpg"
    attach_file "Small Cover", "spec/support/uploads/south_park.jpg"
    fill_in
  end
end
