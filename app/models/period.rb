class Period < ApplicationRecord
  belongs_to :client
  has_many :invoice_entries, dependent: :destroy
  has_many :expense_entries, dependent: :destroy
end
