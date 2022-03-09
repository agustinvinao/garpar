# frozen_string_literal: true

FactoryBot.define do
  factory :bank_account do
    name { Faker::Bank.name }
    sort_code { Faker::Number.number(digits: 6) }
    account_number { Faker::Bank.account_numbe }
    iban { Faker::Bank.iban(country_code: 'ie') }
    bic { Faker::Bank.swift_bic }
    company
  end
end
