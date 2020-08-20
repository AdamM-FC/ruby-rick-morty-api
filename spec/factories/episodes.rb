FactoryBot.define do
    factory :episode do
      name { Faker::Lorem.word }
      episode { Faker::Lorem.word }
      url { Faker::Lorem.word }
      air_date { Time.now }
      created { Time.now }
    end
  end