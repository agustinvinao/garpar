class Currency < ApplicationRecord
  validates :name, :symbol, :display_decimals, presence: true
  has_many :invoice_entries, dependent: :destroy
  has_many :expense_entries, dependent: :destroy
end
