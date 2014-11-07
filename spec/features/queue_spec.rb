require 'spec_helper'

feature "Sign in an existing user" do
  scenario "User signs in, selects a video and adds video to queue" do
    # create some videos
    comedies = Fabricate(:category, name: "Comedies")
    monk = Fabricate(:video, title: "Monk")
    monk.categories << comedies
    south_park = Fabricate(:video, title: "South Park")
    south_park.categories << comedies
    pinky_blinders = Fabricate(:video, title: "Pinky Blinders")
    pinky_blinders.categories << comedies

    # sign in a user (see macros)
    sign_in_user

    # tests
    find("a[href='/video/#{monk.id}']").click
    expect(page).to have_content(monk.title)

    # add monk to queue
    find("a[href='/add_to_queue/#{monk.id}']").click
    expect(page).to have_content("Monk")

    # follow link from monk back to show page
    find("a[href='/video/#{monk.id}']").click
    expect(page).to have_content("Monk")

    # verify page doesn't have add_+ My Queue button
    expect(page).to_not have_content("+ My Queue")

    # add two more videos
    visit home_path
    find("a[href='/video/#{south_park.id}']").click
    find("a[href='/add_to_queue/#{south_park.id}']").click
    expect(page).to have_content("South Park")
    visit home_path
    find("a[href='/video/#{pinky_blinders.id}']").click
    find("a[href='/add_to_queue/#{pinky_blinders.id}']").click
    expect(page).to have_content("Pinky Blinders")

    # check order
    expect(find("#video_#{monk.id}").value).to eq("1")
    expect(find("#video_#{south_park.id}").value).to eq("2")
    expect(find("#video_#{pinky_blinders.id}").value).to eq("3")

    # change order
    fill_in "video_#{monk.id}", with: 2
    fill_in "video_#{pinky_blinders.id}", with: 1
    fill_in "video_#{south_park.id}", with: 3
    click_button "Update Instant Queue"
    expect(find("#video_#{monk.id}").value).to eq("2")
    expect(find("#video_#{south_park.id}").value).to eq("3")
    expect(find("#video_#{pinky_blinders.id}").value).to eq("1")

    # check that we can delete a video
    find("a[href='/remove_from_queue/#{monk.id}']").click
    expect(page).to_not have_content("Monk")
  end
end
