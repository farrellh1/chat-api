FactoryBot.define do
    factory :message do
        body { Faker::Lorem.paragraph }
        user_id { 1 }
        conversation_id { 1 }
    end
end