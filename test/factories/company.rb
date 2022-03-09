# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    vat_number { Faker::Code.nric }
    number { Faker::Company.duns_number.delete!('-') }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    user
  end
end
