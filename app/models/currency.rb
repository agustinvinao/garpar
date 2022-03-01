class Currency < ApplicationRecord
  validates_presence_of :name, :symbol, :display_decimals
end
