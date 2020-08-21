FactoryBot.define do
    factory :episode do
      name { Faker::Lorem.word }
      episode { Faker::Lorem.word }
      url { Faker::Lorem.word }
      air_date { Time.now }
      created { Time.now }
      trait :with_characters do
        after(:build) do |episode|
          episode.characters << FactoryBot.build(:character)
        end
      end
    end
  end