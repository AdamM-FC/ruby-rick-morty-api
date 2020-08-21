# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times do |index|
  Location.create!(name: Faker::Lorem.word,
                   location_type: Faker::Lorem.word,
                   dimension: Faker::Lorem.word,
                   url: "#{HOST}location/#{index + 1}")
end

50.times do |index|
  Character.create!(name: Faker::Lorem.word,
                    status: Faker::Lorem.word,
                    species: Faker::Lorem.word,
                    gender: Faker::Lorem.word,
                    character_type: Faker::Lorem.word,
                    image: "https://rickandmortyapi.com/api/character/avatar/#{index + 1}.jpeg",
                    location_id: index + 1,
                    origin_id: index + 2)
end

50.times do |index|
  Episode.create!(name: Faker::Lorem.word,
                  episode: Faker::Lorem.word,
                  air_date: Faker::Time.between_dates(from: Date.today - 3000, to: Date.today, period: :all),
                  url: "#{HOST}/episode/#{index+1}")
end

