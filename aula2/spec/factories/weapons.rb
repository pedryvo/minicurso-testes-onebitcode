FactoryBot.define do
  factory :weapon do
    name { Faker::Name.first_name }
    description { Faker::Lorem.sentence(word_count: 4, supplemental: false) }
    power_base { 3000 }
    power_step { 100 }
    level { 1 }
  end
end
