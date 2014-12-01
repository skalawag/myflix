# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["TV Shows", "Action & Adventure", "Anime", "Children & Family", "Classics", "Comedies", "Cult Movies", "Documentaries", "Dramas", "Faith & Spirituality", "Foreign", "Gay & Lesbian", "Horror", "Independent", "Music", "Musicals", "Romance", "Sci-Fi & Fantasy", "Thrillers"].each do |category|
  Category.create(name: category)
end

fg = Video.create(title: "Family Guy", description: "Cartoon for adults.")

10.times do
  fg.reviews << Fabricate(:review, user_id: rand(5) + 1)
end

monk = Video.create(title: "Monk", description: "Not really sure what this is.")

10.times do
  monk.reviews << Fabricate(:review, user_id: rand(5) + 1)
end

pb = Video.create(title: "Peaky Blinders", description: "Post WWI street gangs in Manchester.")

10.times do
  pb.reviews << Fabricate(:review, user_id: rand(5) + 1)
end

fut = Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.")

10.times do
  fut.reviews << Fabricate(:review, user_id: rand(5) + 1)
end

fg.categories << Category.find_by(name: "Comedies")
fg.categories << Category.find_by(name: "TV Shows")
monk.categories << Category.find_by(name: "TV Shows")
pb.categories << Category.find_by(name: "TV Shows")
pb.categories << Category.find_by(name: "Dramas")
pb.categories << Category.find_by(name: "Foreign")
fut.categories << Category.find_by(name: "Comedies")
fut.categories << Category.find_by(name: "Comedies")

5.times do
  Fabricate(:user)
end

User.create(username: "mark", email: "mark@mark.com", password: "markmark", admin: true)
