FactoryBot.define do
  factory :enemy do
    name { Faker::Lorem.word.capitalize }
    power_base { Faker::Number.between(from: 1, to: 9999) }
    power_step { Faker::Number.between(from: 1, to: 9999) }
    level { Faker::Number.between(from: 1, to: 99) }
    kind { %w[ goblin orc demon dragon ].sample }
  end
end