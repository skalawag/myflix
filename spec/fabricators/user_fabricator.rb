Fabricator(:user) do
  username { Faker::Lorem.words(2).join(" ") }
  email { Faker::Internet.email }
  password { Faker::Internet.password(7) }
  admin false
end

Fabricator(:admin, from: :user) do
  admin true
end
