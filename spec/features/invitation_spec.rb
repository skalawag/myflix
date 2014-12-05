require 'spec_helper'

feature "Invite a friend to join" do
  background do
    clear_emails
    sign_in_user
    find("a[href='/invitations/new']").click
  end

  scenario "A user visits new invitation page" do
    expect(page).to have_content("Invite a friend to join MyFlix!")
  end

  scenario "Neither Friend's Name nor Email can be blank" do
    click_button "Send Invitation"
    expect(page).to have_content("Something was wrong with your invitation.")
  end

  scenario "When a user sends an invitation she gets a success message" do
    fill_in "Friend's Name", with: "Buddy"
    fill_in "Friend's Email Address", with: "buddy@buddy.com"
    click_button "Send Invitation"
    expect(page).to have_content("Your invitation has been sent.")
  end

  scenario "Upon clicking email link, friend is brought to reg page and registers with credit card" do
    fill_in "Friend's Name", with: "Buddy"
    fill_in "Friend's Email Address", with: "buddy@buddy.com"
    click_button "Send Invitation"
    open_email('buddy@buddy.com')
    current_email.click_link "Myflix Registration"
    expect(page).to have_content "Register"

    # fill in form and sign up
    fill_in "Full Name", with: "Buddy"
    fill_in "Email Address", with: "buddy@buddy.com"
    fill_in "Password", with: "somepasswordforbuddy"
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "333"
    select "1 - January", from: 'date_month'
    select "2016", from: 'data_year'
    click_button "Sign Up"
  end
end
