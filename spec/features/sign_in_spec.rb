require 'spec_helper'

feature "Sign in an existing user" do
  background do
    User.create(username: "John", email: "john@john.com", password: "john")
  end
  scenario "User enters email and password and gets access" do
    visit new_login_path
    fill_in "Email", with: "john@john.com"
    fill_in "Password", with: "john"
    click_button "Submit"
    expect(page).to have_text("Welcome, John")
  end
end
