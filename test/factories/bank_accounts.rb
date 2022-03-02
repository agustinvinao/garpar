FactoryBot.define do
  factory :bank_account do
    name { "MyString" }
    sort_code { "MyString" }
    account_number { "MyString" }
    iban { "MyString" }
    bic { "MyString" }
    company { nil }
  end
end
