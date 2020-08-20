FactoryBot.define do
  factory :location do
    name { Faker::Lorem.word }
    location_type { Faker::Lorem.word }
    dimension { Faker::Lorem.word }
    url { Faker::Lorem.word }
  end
end
