Fabricator(:review) do
  review { Faker::Lorem.paragraph }
  rating { rand(5) + 1 }
  user_id { User.all.sample.id || 1}
  video_id { Video.all.sample.id || 1}
end
