require 'faker'

FactoryBot.define do
  factory :currency do
    name { Faker::Currency.name }
    symbol { Faker::Currency.symbol }
    display_decimals { Faker::Number.number(digits: 1) }
  end
end
