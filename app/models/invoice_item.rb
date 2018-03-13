class InvoiceItem < ApplicationRecord
  scope :random, -> {order('random()').limit(1)}
  belongs_to :invoice, optional: true
  belongs_to :item, optional: true
end
