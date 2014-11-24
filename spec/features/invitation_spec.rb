require 'spec_helper'

feature "Invite a friend to join" do
  background do
    clear_emails
  end

  scenario "A user visits new invitation page" do
    sign_in_user
    find("a[href='/invitations/new']").click
    expect(page).to have_content("Invite a friend to join MyFlix!")
  end

  scenario "Neither Friend's Name nor Email can be blank" do
    sign_in_user
    find("a[href='/invitations/new']").click
    click_button "Send Invitation"
    expect(page).to have_content("Something was wrong with your invitation.")
  end

  scenario "When a user sends an invitation she gets a success message" do
    sign_in_user
    find("a[href='/invitations/new']").click
    fill_in "Friend's Name", with: "Buddy"
    fill_in "Friend's Email Address", with: "buddy@buddy.com"
    click_button "Send Invitation"
    expect(page).to have_content("Your invitation has been sent.")
  end

  scenario "Upon clicking email link, friend is brought to reg page" do
    sign_in_user
    find("a[href='/invitations/new']").click
    fill_in "Friend's Name", with: "Buddy"
    fill_in "Friend's Email Address", with: "buddy@buddy.com"
    click_button "Send Invitation"
    open_email('buddy@buddy.com')
    current_email.click_link "Myflix Registration"
    expect(page).to have_content "Register"
  end
end
