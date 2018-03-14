class Invoice < ApplicationRecord
  scope :random, -> {order('random()').limit(1)}
  belongs_to :customer, optional: true
  belongs_to :merchant, optional: true
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
end
