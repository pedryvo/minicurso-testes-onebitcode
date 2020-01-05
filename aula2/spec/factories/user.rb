FactoryBot.define do
  factory :user do
    nickname { Faker::Name.first_name }
    level { Faker::Number.between(from: 1, to: 99) }
    kind { %w[ knight wizard ].sample }
  end
end