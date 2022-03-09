# frozen_string_literal: true

FactoryBot.define do
  factory :expense_entry do
    description { Faker::Lorem.sentence }
    amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    currency { association :currency }
    claim_percentage { Faker::Number.between(from: 1, to: 100) }
  end
end
