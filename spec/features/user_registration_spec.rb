require 'spec_helper'

feature "User signs up with credit card:", {js: true, vcr: true} do
  # scenario "valid personal info and valid card" do
  #   visit new_user_path
  #   fill_in "Full Name", with: "Gi Joe"
  #   fill_in "Email Address", with: "gijoe@gmail.com"
  #   fill_in "Password", with: '12344566'
  #   fill_in "Credit Card Number", with: '4242424242424242'
  #   fill_in "Security Code", with: '333'
  #   select "12 - December", from: 'date_month'
  #   select "2016", from: 'date_year'
  #   click_button "Sign Up"
  #   expect(page).to have_content("Thank you for choosing Myflix. Please sign in!")
  # end

  scenario "valid personal info and card declined"
  scenario "invalid personal info and valid card"
  scenario "invalid personal info and card declined"
end
