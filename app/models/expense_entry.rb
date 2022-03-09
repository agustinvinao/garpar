class ExpenseEntry < ApplicationRecord
  belongs_to :currency
  belongs_to :period
end
