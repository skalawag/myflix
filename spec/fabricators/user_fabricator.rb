Fabricator(:user) do
  username { Faker::Lorem.words(2).join(" ") }
  email { Faker::Internet.email }
  password { Faker::Internet.password(7) }
end
