# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    apartment { Faker::Address.building_number }
    line1 { Faker::Address.street_name }
    line2 { Faker::Address.community }
    postal_code { Faker::Address.postcode }
    state { Faker::Address.city }
    country { Faker::Address.country }

    factory :company_address, class: 'Address' do
      association :addressable, factory: :company
    end

    factory :client_address, class: 'Address' do
      association :addressable, factory: :client
    end
  end
end

def client_address_with_periods(count: 5)
  FactoryBot.create(:client_address) do |address|
    FactoryBot.create_list(:period, count, client: address.addressable)
  end
end
