# frozen_string_literal: true

FactoryBot.define do
  factory :invoice_entry do
    description { Faker::Lorem.sentence }
    amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    rate { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    currency { association :currency }
    vat { Faker::Number.between(from: 1, to: 21) }
  end
end
