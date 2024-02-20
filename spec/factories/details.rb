FactoryBot.define do
  factory :detail do
    email { Faker::Internet.email }
    title { 'Mr.' }
    age {18}
  end
end