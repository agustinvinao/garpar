# require 'faker'

# FactoryBot.define do
#   factory :address do
#     line1 { Faker::Address.street_name }
#     postal_code { Faker::Address.postcode }
#     county { Faker::Address.state }
#     country { Faker::Address.country }
#   end

#   factory :addres_with_companies do
#     FactoryBot.create(:address) do |address|
#       address.companies { [FactoryBot.create(:company)] }
#     end
#   end
# end
