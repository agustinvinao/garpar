class Company < ApplicationRecord
  belongs_to :user
  has_one :address, dependent: :destroy, as: :addressable
  has_many :clients, dependent: :destroy
end
