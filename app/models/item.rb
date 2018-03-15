class Item < ApplicationRecord
  default_scope {order(:id)}
  scope :random, -> {order('random()').limit(1)}
  belongs_to :merchant, optional: true
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
