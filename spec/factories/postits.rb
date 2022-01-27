FactoryBot.define do
    factory :postit do
        title: Faker::Lorem.sentence
        body: Faker::Lorem.paragraph
        level: Faker::Number(1)
    end
end