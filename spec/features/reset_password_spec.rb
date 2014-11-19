require 'spec_helper'

feature 'Reset password:' do
  background do
    clear_emails
  end

  scenario 'user can report forgotten password' do
    visit new_login_path
    find("a[href='/reset_password']").click
    expect(page).to have_content("Forgot Password?")
  end

  scenario 'if user enters bad email, show message' do
    visit reset_password_path
    fill_in "Email", with: "betty@betty.com"
    click_button "Send Email"
    expect(page).to have_text("The email you entered is not a valid user's email.")
  end

  scenario 'user can request email with token, follow the link, and reset password' do
    Fabricate(:user, email: "betty@betty.com", username: "betty")
    visit reset_password_path
    fill_in "Email", with: "betty@betty.com"
    click_button "Send Email"
    expect(page).to have_text("We have sent an email with instruction to reset your password.")
    open_email('betty@betty.com')
    current_email.click_link "reset password here"
    expect(page).to have_text("Reset Your Password")
    fill_in "New Password", with: 'bettysnewpass'
    click_button "Reset Password"
    expect(page).to have_text("Sign in")
    fill_in "Email Address", with: "betty@betty.com"
    fill_in "Password", with: 'bettysnewpass'
    click_button "Submit"
    expect(page).to have_text("Welcome, betty")
  end
end
