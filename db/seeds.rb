# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Real Person", email: "realaccountadmin@dummy.com", password: "password", password_confirmation: "password", admin: true, activated: true, activated_at: Time.zone.now)
99.times do |n|
    name = Faker::TvShows::Seinfeld.character
    email = "realaccount-#{n+1}@dummy.com"
    password = "password"
    User.create!(name: name, email: email, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
    content = Faker::TvShows::Seinfeld.quote
    if content.length > 140
        content = content[0..139].gsub(/\s\w+$/, "...")
    end
    users.each { |user| user.microposts.create!(content: content) }
end