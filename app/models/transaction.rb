class Transaction < ApplicationRecord
  belongs_to :organisation

  validates :amount, numericality: { greater_than: 0 }
end
