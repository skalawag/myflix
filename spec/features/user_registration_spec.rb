require 'spec_helper'

feature "User signs up with credit card:", {js: true, vcr: true} do
  scenario "valid personal info and valid card" do
    visit new_user_path
    fill_in "Full Name", with: "Giordano Joe"
    fill_in "Email Address", with: "gijoe@gmail.com"
    fill_in "Password", with: 'funkyP@s$wUrd'
    fill_in_valid_credit_card
    click_button "Sign Up"
    expect(page).to have_content("Thank you for choosing Myflix. Please sign in!")
  end

  scenario "valid personal info and card declined" do
    visit new_user_path
    fill_in "Full Name", with: "Giordano Joe"
    fill_in "Email Address", with: "gijoe@gmail.com"
    fill_in "Password", with: 'funkyP@s$wUrd'
    fill_in "Credit Card Number", with: '4000000000000002'
    fill_in "Security Code", with: '333'
    select "12 - December", from: 'date_month'
    select "2016", from: 'date_year'
    click_button "Sign Up"
    expect(page).to have_content("Your card was declined.")
  end

  scenario "invalid personal info -- missing username -- and valid card" do
    visit new_user_path
    fill_in "Email Address", with: "gijoe@gmail.com"
    fill_in "Password", with: 'funkyP@s$wUrd'
    fill_in_valid_credit_card
    click_button "Sign Up"
    expect(page).to have_content("Full Name can't be blank")
  end

  scenario "invalid personal info -- missing email -- and valid card" do
    visit new_user_path
    fill_in "Full Name", with: "Giordano Joe"
    fill_in "Password", with: 'funkyP@s$wUrd'
    fill_in_valid_credit_card
    click_button "Sign Up"
    expect(page).to have_content("Email Address can't be blank")
  end

  scenario "invalid personal info -- missing password -- and card declined" do
    visit new_user_path
    fill_in "Full Name", with: "Giordano Joe"
    fill_in "Email Address", with: "gijoe@gmail.com"
    fill_in_valid_credit_card
    click_button "Sign Up"
    expect(page).to have_content("Password can't be blank")
  end

  def fill_in_valid_credit_card
    fill_in "Credit Card Number", with: '4242424242424242'
    fill_in "Security Code", with: '333'
    select "12 - December", from: 'date_month'
    select "2016", from: 'date_year'
  end
end
