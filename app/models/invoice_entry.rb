class InvoiceEntry < ApplicationRecord
  belongs_to :currency
  belongs_to :period
end
