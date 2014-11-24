Fabricator(:invitation) do
  user_id { rand(3) + 1 }
  new_user_name { Faker::Name.name}
  new_user_email { Faker::Internet.email }
  token { SecureRandom.urlsafe_base64 }
end
