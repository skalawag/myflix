require 'spec_helper'

feature "A user's video collection and reviews display on user's page" do
  scenario "A signed in user visits her own user's page" do
    sign_in_user
    user = User.first
    create_some_categorized_videos
    add_videos_to_user_queue(user, Video.all)
    fabricate_reviews_for_users_queued_videos(user)
    visit "/users/#{user[:id]}"

    expect(page).to have_content("#{user[:username]}'s video collections")
    expect(page).to have_content("#{user[:username]}'s video collections (#{user.videos.count})")
    expect(page).to have_content("#{user[:username]}'s Reviews")
    expect(page).to have_content("#{user[:username]}'s Reviews (#{user.reviews.count})")
  end
end
