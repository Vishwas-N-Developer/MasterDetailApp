FactoryBot.define do
  factory :person do
    sequence(:name) { |n| "Name#{n}" }

    after(:build) do |person|
      person.detail ||= build(:detail, person: person)
    end
  end
end