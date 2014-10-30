Fabricator(:review) do
  review { Faker::Lorem.paragraph }
  rating { rand(5) + 1 }
end
