require 'faker'

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    vat_number { Faker::Code.nric }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    address { FactoryBot.build(:address) }
  end
end
