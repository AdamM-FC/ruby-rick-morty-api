FactoryBot.define do
  factory :location do
    name { Faker::Lorem.word }
    location_type { Faker::Lorem.word }
    dimension { Faker::Lorem.word }
    url { Faker::Lorem.word }
    trait :with_residents do
      after(:build) do |location|
        location.residents << FactoryBot.build(:character)
      end
    end
  end
end
