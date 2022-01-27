FactoryBot.define do
    factory :postit do
        user
        title { Faker::Lorem.sentence }
        body { Faker::Lorem.paragraph }
        level { Faker::Number }
    end
end