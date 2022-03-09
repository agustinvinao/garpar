# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { Faker::Company.name }
    contact { Faker::Internet.email }
    company
  end
end
