class Item < ApplicationRecord
  belongs_to :merchant, optional: true

  scope :random, -> {order('random()').limit(1)}
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
