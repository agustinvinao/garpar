class Client < ApplicationRecord
  belongs_to :company
  has_one :address, dependent: :destroy, as: :addressable
end
