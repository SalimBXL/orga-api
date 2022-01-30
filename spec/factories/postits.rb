FactoryBot.define do
    factory :postit do
        user
        title { Faker::Lorem.sentence }
        level { Faker::Number.between(from: 0, to: 4) }
        body { Faker::Lorem.paragraph }
    end
end