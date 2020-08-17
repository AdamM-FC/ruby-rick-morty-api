FactoryBot.define do
  factory :character do
    name { Faker::Lorem.word }
    status { Faker::Lorem.word }
    species { Faker::Lorem.word }
    character_type { Faker::Lorem.word }
    gender { Faker::Lorem.word }
    image { Faker::Lorem.word }
    created { Time.now }
  end
end