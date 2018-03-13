class InvoiceItem < ApplicationRecord
  scope :random, -> {order('random()').limit(1)}
end
