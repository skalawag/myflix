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

fg = Video.create(title: "Family Guy", description: "Cartoon for adults.", small_cover_url: "/tmp/family_guy.jpg", large_cover_url: "/tmp/blank_large.jpg")

monk = Video.create(title: "Monk", description: "Not really sure what this is.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")

pb = Video.create(title: "Peaky Blinders", description: "Post WWI street gangs in Manchester.", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/blank_large.jpg")

fut = Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/blank_large.jpg")

fg.categories << Category.find_by(name: "Comedies")
fg.categories << Category.find_by(name: "TV Shows")
monk.categories << Category.find_by(name: "TV Shows")
pb.categories << Category.find_by(name: "TV Shows")
pb.categories << Category.find_by(name: "Dramas")
pb.categories << Category.find_by(name: "Foreign")
fut.categories << Category.find_by(name: "Comedies")
fut.categories << Category.find_by(name: "Comedies")

User.create(username:  "Joe", :email "joe@joe.com" , password: "joe")
User.create(username:  "Mary", :email "mary@mary.com" , password: "mary")
