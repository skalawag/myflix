require 'spec_helper'

feature "Users can follow other users" do
  scenario "User adds another user" do
    sign_in_user
    user = User.first
    fab = Fabricate(:user, username: "Fab")
    visit user_path(fab.id)
    find("a[href='/users/#{user.id}/people/new?id=#{fab.id}']").click
    expect(page).to have_content('Fab')
    find("a[href='/users/#{user.id}/people/#{fab.id}']").click
    expect(page).to_not have_content('Fab')
  end
end
