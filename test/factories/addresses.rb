FactoryBot.define do
  factory :address do
    line1 { "MyString" }
    line2 { "MyString" }
    line3 { "MyString" }
    postal_code { "MyString" }
    state { "MyString" }
    country { "MyString" }
    addressable { nil }
  end
end
